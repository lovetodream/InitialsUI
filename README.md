![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/lovetodream/InitialsUI?sort=semver)
![GitHub](https://img.shields.io/github/license/lovetodream/InitialsUI)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey)
  
# InitialsUI

A simple SwiftUI View for using initials as profile images.

## 🚩 Features

- Initials are calculated automatically
- Initials text size adjusts automatically
- Fully customizable initials font weight
- Fully customizable foreground color
- Fully customizable background
- Fully customizable corner radius
- Fully customizable border
- Random background colors
- Can be used with a Binding
- Cross platform >= SwiftUI 1 (macOS 10.15, iOS 13, watchOS 6, tvOS 13)
 
## Screenshots

<img src="https://user-images.githubusercontent.com/38291523/126525899-10791422-0d7a-450e-a6d1-cc9da65b27f3.png" alt="Example Screenshot" width="420">
  
## 🔧 Installation

Install with [Swift Package Manager](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app)

```bash
https://github.com/lovetodream/InitialsUI
```
    
## ✨ Usage/Examples

Basic usage

```swift
import SwiftUI
import InitialsUI

struct ContentView: View {
    public var body: some View {
        VStack {
            InitialsUI(initials: "JD")
        }
    }
}
```

Basic usage with full name

```swift
...
struct ContentView: View {
    @State private var name = "John Doe"

    public var body: some View {
        VStack {
            InitialsUI(text: $name)
        }
    }
}
```

Further information [here](#documentation)  

## Documentation

### Initializes a InitialsUI View from the first letter of every word from a string

- Parameter `text`: The text used to create the initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials
- Parameter `background`: Any view as the background

**Returns a view with the initials from provided the string**

```swift
InitialsUI(text: Binding<String>, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil, background: @escaping () -> Content)
```
  
### Initializes a InitialsUI View from the provided initials

- Parameter `initials`: The initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials
- Parameter `background`: Any view as the background

**Returns a view with the provided initials**

```swift
InitialsUI(initials: String, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil, background: @escaping () -> Content)
```

### Initializes a InitialsUI View with a random background color using the first letter of every word from a string

⚠️ If you don't want to use random backgrounds, use a different initializer!

- Parameter `text`: The text used to create the initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials
- Parameter `randomBackground`: Use a random background

**Returns a view with the initials from provided the string**

```swift
InitialsUI(text: Binding<String>, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil, randomBackground: Bool)
```

### Initializes a InitialsUI View with a random background color using the provided initials

⚠️ If you don't want to use random backgrounds, use a different initializer!

- Parameter `initials`: The initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials
- Parameter `randomBackground`: Use a random background

**Returns a view with the initials from provided the initials**

```swift
InitialsUI(initials: String, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil, randomBackground: Bool)
```

### Initializes a InitialsUI View from the first letter of every word from a string with gray background

⚠️ This initializer applies a gray background color by default!

- Parameter `text`: The text used to create the initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials

**Returns a view with the initials from provided the string**

```swift
InitialsUI(text: Binding<String>, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil)
```

### Initializes a InitialsUI View from the provided initials with gray background

⚠️ This initializer applies a gray background color by default!

- Parameter `initials: The initials
- Parameter `useDefaultForegroundColor`: Use the default color white for the initials
- Parameter `fontWeight`: The font weight used on the initials

**Returns a view with the initials from provided the string**

```swift
InitialsUI(initials: String, useDefaultForegroundColor: Bool = true, fontWeight: Font.Weight? = nil)
```
