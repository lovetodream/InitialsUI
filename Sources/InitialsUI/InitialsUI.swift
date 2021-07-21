import SwiftUI

public struct InitialsUI<Content: View>: View {
    @Binding var text: String
    
    let background: Content
    
    var initials: String {
        text.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .reduce("") { partialResult, word in
                partialResult + String(word.first!.uppercased())
        }
    }
    
    public init(text: Binding<String>, @ViewBuilder background: @escaping () -> Content) {
        self.background = background()
        self._text = text
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                background
                    
                Text(initials)
                    .modifier(FitToWidth())
                    .padding()
            }
        }
    }
}

extension InitialsUI {
    public init(initials: String, @ViewBuilder background: @escaping () -> Content) {
        let text = initials.map { "\($0)" }.joined(separator: " ")
        
        self.init(text: .constant(text), background: background)
    }
}

extension InitialsUI where Content == Color {
    public init(text: Binding<String>) {
        self.init(text: text) {
            Color.gray
        }
    }
    
    public init(initials: String) {
        self.init(initials: initials) {
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
                    .frame(width: g.size.width*self.fraction)
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
        InitialsUI(initials: "TZ")
    }
}
