import SwiftUI

public struct InitialsUI<Content: View>: View {
    @Binding var text: String
    var fontWeight: Font.Weight = .regular
    var foregroundColor: Color?
    
    let background: Content
    
    var initials: String {
        text.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .reduce("") { partialResult, word in
                partialResult + String(word.first!.uppercased())
        }
    }
    
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                @ViewBuilder background: @escaping () -> Content) {
        self.background = background()
        self._text = text
        self.foregroundColor = useDefaultForegroundColor ? .white : .none
        if let weight = fontWeight {
            self.fontWeight = weight
        }
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                background
                    
                Text(initials)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: g.size.width * 0.8))
                    .fontWeight(fontWeight)
                    .modifier(FitToWidth())
                    .padding(g.size.width > 100 ? 20 : 0)
            }
        }
    }
}

extension InitialsUI {
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                @ViewBuilder background: @escaping () -> Content) {
        let text = initials.map { "\($0)" }.joined(separator: " ")
        
        self.init(text: .constant(text),
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight,
                  background: background)
    }
}

extension InitialsUI where Content == Color {
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                randomBackground: Bool) {
        self.init(text: text,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            if randomBackground {
                return randomColor(for: text.wrappedValue)
            } else {
                return Color.gray
            }
        }
    }
    
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil,
                randomBackground: Bool) {
        self.init(initials: initials,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            if randomBackground {
                return randomColor(for: initials)
            } else {
                return Color.gray
            }
        }
    }
}

extension InitialsUI where Content == Color {
    public init(text: Binding<String>,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil) {
        self.init(text: text,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            Color.gray
        }
    }
    
    public init(initials: String,
                useDefaultForegroundColor: Bool = true,
                fontWeight: Font.Weight? = nil) {
        self.init(initials: initials,
                  useDefaultForegroundColor: useDefaultForegroundColor,
                  fontWeight: fontWeight) {
            Color.gray
        }
    }
}

struct FitToWidth: ViewModifier {
    var fraction: CGFloat = 1.0
    func body(content: Content) -> some View {
        GeometryReader { g in
            VStack {
                Spacer()
                content
                    .font(.system(size: 1000))
                    .minimumScaleFactor(0.005)
                    .lineLimit(1)
                    .frame(width: g.size.width * self.fraction)
                Spacer()
            }
        }
    }
}



// MARK: Color randomization methods

func randomColorComponent() -> Int {
    let limit = 30 - 214
    return 30 + Int(drand48() * Double(limit))
}

func randomColor(for string: String) -> Color {
    srand48(string.hashValue)

    let red = CGFloat(randomColorComponent()) / 255.0
    let green = CGFloat(randomColorComponent()) / 255.0
    let blue = CGFloat(randomColorComponent()) / 255.0
    
    return Color(red: red, green: green, blue: blue)
}


// MARK: - Development only

struct InitialsUIWrapper: View {
    @State var name = ""

    public var body: some View {
        VStack {
            TextField("Name", text: $name)
        
            InitialsUI(text: $name)
        }
    }
}

struct InitialsUI_Previews: PreviewProvider {
    static var previews: some View {
        InitialsUIWrapper()
        InitialsUI(text: .constant("Timo Zacherl")) {
            RadialGradient(colors: [.gray, .blue], center: .trailing, startRadius: 40, endRadius: 180)
        }
        InitialsUI(initials: "TZ") {
            Color.yellow
        }.foregroundColor(.white)
        VStack(spacing: 20) {
            InitialsUI(initials: "TZ").frame(width: 200, height: 200)
            InitialsUI(initials: "TZ").frame(width: 100, height: 100)
            InitialsUI(initials: "TZ", fontWeight: .semibold).frame(width: 40, height: 40)
            InitialsUI(initials: "TZ", fontWeight: .bold, randomBackground: true).frame(width: 40, height: 40)
        }
    }
}
