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

    var newsNotification: Notification {
        didSet {
            guard let news = newsNotification.object as? String else { return }
            print(news)
        }
    }

    init(newsNotification: Notification) {
        self.newsNotification = newsNotification
    }

    func receive(subscription: Subscription) {
        print(subscription)
        subscription.request(.unlimited)
    }

    func receive(_ input: Notification) -> Subscribers.Demand {
        print(input)
        newsNotification = input
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("completion")
    }
}

class NewsSubscription: Subscription {
    func request(_ demand: Subscribers.Demand) {}
    func cancel() {}
}

extension Notification.Name {
    static let News = Notification.Name("com.combine_introduce.news")
}
do {
    let notificationPublisher = NotificationCenter.Publisher(center: .default, name: Notification.Name("SEND_NEWS"), object: nil)
    let newsSubscriber = NewsSubscriber(newsNotification: Notification(name: Notification.Name("SEND_NEWS"), object: News(info: ""), userInfo: nil))
    let ssggg = notificationPublisher.subscribe(newsSubscriber)
    NotificationCenter.default.post(Notification(name: Notification.Name("SEND_NEWS")))
    let sss = notificationPublisher.center.post(Notification(name: Notification.Name("SEND_NEWS"), object: News(info: "ssss"), userInfo: nil))
    //newsSubscriber.receive(subscription: NewsSubscription())
//    let newNotification = Notification(name: Notification.Name("SEND_NEWS"), object: News(info: "it's rain today"), userInfo: nil)
//    newsSubscriber.receive(newNotification)
//    newsSubscriber.receive(completion: .finished)
}

do {
    let news = News(info: "")
    NotificationCenter.default.publisher(for: .News ,object: nil)
        .map { (notification) -> String in
            print("map")
            return (notification.object as? News)?.info ?? ""
    }.sink(receiveCompletion: { (complition) in
        print("complition")
    }, receiveValue: { value in
        news.info = value
        print(news.info)
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

