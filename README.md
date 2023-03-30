# Combine-Property-Wrapper
🚀 Property Wrapper extended from Combine


## Property Wrpper With Combine 

```swift
@SubjectProperty(wrappedValue: 1)
var subject: Int

// set
/// stream
$subject.send(2)
/// property
subject = 3

// get 
/// stream
_ = self.$subject.sink { subject in
    print(subject)
}
/// property
print(subject)

```
## UserDefaults Property wrapper

```swift
@UserDefaultProperty(userDefaultKey: "someInt", defaultValue: 1)
var someInt: Int

@UserDefaultProperty(userDefaultKey: "someOptionalString", defaultValue: nil)
var someOptionalString: String?
```

## UserDefaults Property wrapper with struct or class which is available when it came to conforming codable and hashable

```swift
class A: Codable, Hashable {
  var a: String
}

class B: Codable, Hashable {
  var b: Int
}

@UserDefaultAnyProperty(userDefaultKey: "someClass", defaultValue: nil)
var someClass: A?

@UserDefaultAnyProperty(userDefaultKey: "someStruct", defaultValue: nil)
var someStruct: B?
```
