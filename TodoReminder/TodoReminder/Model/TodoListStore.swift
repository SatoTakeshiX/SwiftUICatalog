//
//  TodoListStore.swift
//  TodoReminder
//
//  Created by satoutakeshi on 2020/08/11.
//

import Foundation
import CoreData

struct TodoListData: Identifiable {
    var deadline: Date?
    var note: String?
    var priority: Int32
    var title: String?
    var id: UUID = UUID()
}

enum CoreDataStoreError: Error {
    case failureFetch
}

extension TodoList {
    func convert() -> TodoListData {
        return TodoListData(deadline: deadline,
                            note: note,
                            priority: priority,
                            title: title)
    }
}

final class TodoListStore {
    typealias Entity = TodoList
    static var containerName: String = "Todo"
    static var entityName: String = "TodoList"

    func insert(item: TodoListData) throws {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: TodoListStore.entityName, into: persistentContainer.viewContext) as? Entity
        newItem?.deadline = item.deadline
        newItem?.note = item.note
        newItem?.priority = item.priority
        newItem?.title = item.title
        try saveContext()
    }

    func fetchAll() throws -> [TodoList] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TodoListStore.entityName)
        do {
            guard let result = try persistentContainer.viewContext.fetch(fetchRequest) as? [Entity] else {
                throw CoreDataStoreError.failureFetch
            }
            print("result count: \(result.count)")
            return result
        } catch let error {
            throw error
        }
    }

    func delete(item: TodoList) throws {
        persistentContainer.viewContext.delete(persistentContainer.viewContext.object(with: item.objectID))
        try saveContext()
    }

    // MARK: - private
    // https://stackoverflow.com/questions/41684256/accessing-core-data-from-both-container-app-and-extension
    //https://developer.apple.com/forums/thread/51803
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         let container = NSPersistentContainer(name: "Data")
         container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: try FileManager.default.containerURLForSecurityApplicationGroupIdentifier("your.group.identifier")!.appendingPathComponent("Data.sqlite"))]
         container.loadPersistentStores { (persistentStoreDescription, error) in
            // do things!
         }
         */
        let container = NSPersistentContainer(name: TodoListStore.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext() throws {
        let context = persistentContainer.viewContext
        //let ii = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context) as? Entity
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

