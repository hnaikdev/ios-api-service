# iOS API Service

A lightweight, modular, and extensible Swift networking framework designed to simplify API communication in iOS applications. It promotes clean architecture, protocol-oriented design, and full async/await support using `URLSession` and `Alamofire`.

---

## 🚀 Features

- 🔧 Protocol-oriented `RequestBuilder` for flexible request construction
- 💡 Default implementations with override capability
- 🧩 Modular design, easy to plug into any iOS project
- 🧵 Swift concurrency (`async/await`) support
- ✅ Codable-based deserialization

---

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/hnaikdev/ios-api-service.git", branch: "main")
]
```


# Architecture Overview

## Core Protocols
- RequestBuilder: Builds a URLRequest with all configurable options
- RequestConvertibleProtocol: Allows abstraction over individual API requests
- NetworkServiceProtocol: Handles dispatch and decoding of network responses

### 🧪 Usage
1. Define a Request

```swift
struct MyRequest: RequestConvertibleProtocol {
    var method: HTTPMethod { .get }
    var path: String? { "/users" }
    var parameters: [String: Sendable]? { ["page": "1"] }
}
```

2. Send the Request
```swift
let service = NetworkService()
let response: UserResponse = try await service.send(request: MyRequest())
```

### 🧰 Customization
You can override default behavior by conforming to RequestBuilder and providing your own logic for request construction:

```swift
extension MyCustomService: RequestBuilder {
    func build(parameters: [String: Sendable]?) -> [String: Sendable]? {
        // Custom transformation logic
    }
}
````

# 📌 Requirements
iOS 15+


# 🤝 Contributing
Contributions, issues, and feature requests are welcome!
Feel free to submit a PR or open an issue.
