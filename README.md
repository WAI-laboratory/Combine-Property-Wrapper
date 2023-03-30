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
