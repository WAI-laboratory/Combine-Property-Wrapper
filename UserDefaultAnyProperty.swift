import Foundation
import Combine

@propertyWrapper
class UserDefaultAnyProperty<Element: Hashable & Codable>: SubjectProperty<Element> {
    let userDefaultKey: String
    let defaultValue: Element
    private let userDefaults: UserDefaults
    
    override var wrappedValue: Element {
        get {
            if let data = UserDefaults.standard.value(forKey: userDefaultKey) as? Data {
                return (try? PropertyListDecoder().decode(Element.self, from: data)) ?? defaultValue
            } else {
                return defaultValue
            }
        }
        set {
            let data = try? PropertyListEncoder().encode(newValue)
            if let data = data as? OptionalProtocol, data.isNil {
                userDefaults.removeObject(forKey: userDefaultKey)
            } else {
                userDefaults.set(data, forKey: userDefaultKey)
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
