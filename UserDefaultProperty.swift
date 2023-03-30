import Foundation
import Combine

@propertyWrapper
class UserDefaultProperty<Element: Hashable>: SubjectProperty<Element> {
    let userDefaultKey: String
    let defaultValue: Element
    private let userDefaults: UserDefaults
    
    override var wrappedValue: Element {
        get {
            return userDefaults.object(forKey: userDefaultKey) as? Element ?? defaultValue
        }
        set {
            if let value = newValue as? OptionalProtocol, value.isNil {
                userDefaults.removeObject(forKey: userDefaultKey)
            } else {
                userDefaults.set(newValue, forKey: userDefaultKey)
                userDefaults.synchronize()
            }
            super.wrappedValue = newValue
        }
    }
    
    override var projectedValue: BaseProperty<Element> {
        get {
            return self
        }
    }
    
    init(
        userDefaults: UserDefaults = .standard,
        userDefaultKey: String,
        defaultValue: Element
    ) {
        self.userDefaults = userDefaults
        self.userDefaultKey = userDefaultKey
        self.defaultValue = defaultValue
        
        super.init(wrappedValue: userDefaults.object(forKey: userDefaultKey) as? Element ?? defaultValue)
    }
}
