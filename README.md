# WrappedUserDefaults

<p align="left">
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-Swift_5.1-green" alt="Swift5" /></a>
 <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
 <a href="https://cocoapods.org/pods/tablekit"><img src="https://img.shields.io/badge/pod-1.0.0-blue.svg" alt="CocoaPods compatible" /></a>
 <a href="https://github.com/MobileUpLLC/TableAdapter/blob/develop/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="License: MIT" /></a>
</p>


## Вступление

**WrappedUserDefaults** – это созданный **MobileUp** инструмент для использования при создании мобильных приложений на платформе **iOS**. Эта библиотека ускоряет процесс разработки, позволяя автоматически сохранять необходимые данные в **UserDefaults** без дополнительного кода, и не требует повторения рутинных методов в каждом новом проекте.

Библиотека состоит из двух компонентов: **JSONConverter** для кодирования/декодирования данных различных типов, и **UserDefaultsBackedWrapper** для записи/получения данных из локального хранилища.

**JSONConverter** поддерживает следующие типы конвертации:

1. Энкодинг
    1. Encodable → Data
    2. JSON → Data
    3. [String: Any] → Data
    4. JsonString(строка с валидными json) → Data
2. Декодинг
    1. Data → Decodable
    2. JSON → Decodable
    3. [String: Any] → Decodable
    4. Data → [String: Any]
    5. Data → JsonString

В первой версии property wrapper'а поддерживаются примитивы, совместимые с **UserDefaults**. 

## Использование

### JSONConverter

```swift
let encodedData = try JSONConverter.encode(object: testObject)
let decodedData = try JSONConverter.decode(Double.self, data: encodedData)
```
### UserDefaultsBackedWrapper

```swift
@UserDefaultsBacked<Int>(key: "keyForInteger", defaultValue: 13)
var backedInteger
```

### Удаление всех кастомных полей из UserDefaults

```swift
UserDefaults.standard.clearAll()
```
