import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class News {
    var info: String
    init(info: String) {
        self.info = info
    }
}

class NewsSubscriber: Subscriber {
    typealias Input = Notification
    typealias Failure = Never
    var publisher: NotificationCenter.Publisher
    var subscription: Subscription?

    init(notificationPublisher: NotificationCenter.Publisher) {
        self.publisher = notificationPublisher
        self.publisher.subscribe(self)
    }

    func receive(subscription: Subscription) {
        print(subscription)
        self.subscription = subscription
        subscription.request(.unlimited)
    }

    func receive(_ input: Notification) -> Subscribers.Demand {
        let news = input.object as? News
        print(news?.info ?? "")
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("completion")
    }
}

extension Notification.Name {
    static let News = Notification.Name("com.combine_introduce.news")
}
do {
    let notificationPublisher = NotificationCenter.Publisher(center: .default, name: .News, object: nil)
    let _ = NewsSubscriber(notificationPublisher: notificationPublisher)
    notificationPublisher.center.post(name: .News, object: News(info: "you got a news!"))
}

do {
    NotificationCenter.default.publisher(for: .News ,object: nil)
        .map { (notification) -> String in
            print("map")
            return (notification.object as? News)?.info ?? ""
    }.sink(receiveCompletion: { (complition) in
        print("complition")
    }, receiveValue: { newsString in
        print(newsString)
    })
    NotificationCenter.default.post(name: .News, object: News(info: "it's rain today"))
}


do {
    let news = News(info: "")
    NotificationCenter.default.publisher(for: .News ,object: nil)
        .map { (notification) -> String in
            print("map")
            return (notification.object as? News)?.info ?? ""
    }.assign(to: \.info, on: news)
    NotificationCenter.default.post(name: .News, object: News(info: "it's rain sunny"))
    print(news.info)
}

