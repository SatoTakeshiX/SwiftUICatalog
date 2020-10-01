//
//  TodoListStore.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import Foundation
import CoreData

struct TodoListData: Identifiable {
    var startDate: Date
    var note: String
    var priority: Int
    var title: String
    var id: UUID = UUID()
}

enum CoreDataStoreError: Error {
    case failureFetch
}

extension TodoList {
    func convert() -> TodoListData? {
        guard let startDate = startDate,
              let note = note,
              let title = title,
              let id = id else { return nil }
        return TodoListData(startDate: startDate,
                            note: note,
                            priority: Int(priority),
                            title: title,
                            id: id)
    }
}

final class TodoListStore {
    typealias Entity = TodoList
    static var containerName: String = "Todo"
    static var entityName: String = "TodoList"

    func insert(item: TodoListData) throws {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: TodoListStore.entityName, into: persistentContainer.viewContext) as? Entity
        newItem?.startDate = item.startDate
        newItem?.note = item.note
        newItem?.priority = Int32(item.priority)
        newItem?.title = item.title
        newItem?.id = item.id
        try saveContext()
    }

    func fetchAll() throws -> [TodoListData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TodoListStore.entityName)
        do {
            guard let result = try persistentContainer.viewContext.fetch(fetchRequest) as? [Entity] else {
                throw CoreDataStoreError.failureFetch
            }
            let todoList = result.compactMap { $0.convert() }
            return todoList
        } catch let error {
            throw error
        }
    }

    func fetchTodayTodo() throws -> [TodoListData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TodoListStore.entityName)
        fetchRequest.predicate = makeTodayTodoPredicate()
        do {
            guard let result = try persistentContainer.viewContext.fetch(fetchRequest) as? [Entity] else {
                throw CoreDataStoreError.failureFetch
            }
            let todoList = result.compactMap { $0.convert() }
            return todoList
        } catch let error {
            throw error
        }
    }

    private func makeTodayTodoPredicate() -> NSPredicate {
        let now = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar.date(from: components)!
        return NSPredicate(format: "startDate >= %@ AND startDate =< %@", argumentArray: [now, endDate])
    }

    func delete(item: TodoList) throws {
        persistentContainer.viewContext.delete(persistentContainer.viewContext.object(with: item.objectID))
        try saveContext()
    }

    // MARK: - private
    // https://stackoverflow.com/questions/41684256/accessing-core-data-from-both-container-app-and-extension
    //https://developer.apple.com/forums/thread/51803
    // https://qiita.com/YosukeMitsugi/items/75687114775e7251f5dd
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: TodoListStore.containerName)
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.personal-factory.todo-reminder")!.appendingPathComponent("\(TodoListStore.containerName).sqlite"))]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                throw nserror
            }
        }
    }
}

