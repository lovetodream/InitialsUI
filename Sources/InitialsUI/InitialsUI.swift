import SwiftUI

public struct InitialsUI<Content: View>: View {
    @Binding var text: String
    var font: Font = Font.body
    
    let background: Content
    
    var initials: String {
        text.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .reduce("") { partialResult, word in
                partialResult + String(word.first!.uppercased())
        }
    }
    
    public init(text: Binding<String>, font: Font? = nil, @ViewBuilder background: @escaping () -> Content) {
        self.background = background()
        self._text = text
        if let ft = font {
            self.font = ft
        }
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                background
                    
                Text(initials)
                    .font(font)
                    .modifier(FitToWidth())
                    .padding(g.size.width > 100 ? 20 : 0)
            }
        }
    }
}

extension InitialsUI {
    public init(initials: String, font: Font? = nil, @ViewBuilder background: @escaping () -> Content) {
        let text = initials.map { "\($0)" }.joined(separator: " ")
        
        self.init(text: .constant(text), font: font, background: background)
    }
}

extension InitialsUI where Content == Color {
    public init(text: Binding<String>, font: Font? = nil) {
        self.init(text: text, font: font) {
            Color.gray
        }
    }
    
    public init(initials: String, font: Font? = nil) {
        self.init(initials: initials, font: font) {
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
            InitialsUI(initials: "TZ", font: .system(size: 100, weight: .semibold, design: .default)).frame(width: 40, height: 40)
        }
    }
}
