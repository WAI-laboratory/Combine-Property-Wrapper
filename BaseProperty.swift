import Foundation
import Combine

class BaseProperty<T>: Subject {
    typealias Input = T
    typealias Output = T
    typealias Failure = Never
    
    func send(completion: Subscribers.Completion<Never>) {
        fatalError()
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, T == S.Input {
        fatalError()
    }

    func send(_ value: T) {
        fatalError()
    }
    func send(subscription: Subscription) {
        fatalError()
    }
}
