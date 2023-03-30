import Foundation
import Combine

@propertyWrapper
class SubjectProperty<T: Hashable>: BaseProperty<T> {
    typealias Failure = Never
  
    var wrappedValue: T {
        didSet {
            if oldValue != wrappedValue {
                subject.send(wrappedValue)
            }
        }
    }
    
    private let subject: CurrentValueSubject<T, Never>
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.subject = .init(wrappedValue)
    }
    
    var projectedValue: BaseProperty<T> {
        return self
    }
    
    override func send(_ value: T) {
        return subject.send(value)
    }
    
    override func send(subscription: Subscription) {
        return subject.send(subscription: subscription)
    }
    
    override func send(completion: Subscribers.Completion<Never>) {
        return subject.send(completion: completion)
    }
    
    override func receive<S>(subscriber: S) where T == S.Input, S : Subscriber, S.Failure == Never {
        return subject.receive(subscriber: subscriber)
    }
}
