//: [Previous](@previous)

import Foundation
import Combine
import SwiftUI

do {
    class Logger {
        var tappedEvent = PassthroughSubject<String, Never>()
    }

    let logger = Logger()
    let subscriber = logger.tappedEvent.sink(receiveValue: { event in
        print("event Name: \(event)")
    })
    logger.tappedEvent.send("LoginButton")
    logger.tappedEvent.send("CameraButton")
    subscriber.cancel()
    logger.tappedEvent.send("LogoutButton")
}

do {
    class Logger {
        var tappedEvent = CurrentValueSubject<String, Never>("")
    }

    let logger = Logger()
    let subscriber = logger.tappedEvent.sink(receiveValue: { event in
        print("event Name: \(event)")
    })
    logger.tappedEvent.send("LoginButton")
    logger.tappedEvent.value = "CameraButton"

    subscriber.cancel()

    logger.tappedEvent.value = "LogoutButton"
}

do {
    class Logger {
        @Published var tappedEventName: String = ""
    }
    let logger = Logger()
    let subscriber = logger.$tappedEventName.sink(receiveValue: { event in
        print("event Name: \(event)")
    })
    logger.tappedEventName = "LoginButton"
    logger.tappedEventName = "CameraButton"
    subscriber.cancel()
    logger.tappedEventName = "LogoutButton"
}

//: [Next](@next)
