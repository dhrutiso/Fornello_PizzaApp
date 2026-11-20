//
//  Created by Dhruti Solanki
//  Email: dhrutisolanki90@gmail.com
//  Contact: 9104495050
//  Copyright © 2026 Dhruti Solanki. All rights reserved.
//


import SwiftUI

// MARK: - Theme

enum Theme {
    static let gold = Color(red: 1.00, green: 0.80, blue: 0.30)
    static let goldDeep = Color(red: 0.90, green: 0.62, blue: 0.12)
    static let flameTop = Color(red: 1.00, green: 0.55, blue: 0.10)
    static let flameBottom = Color(red: 0.95, green: 0.18, blue: 0.10)
    static let background = Color(red: 0.035, green: 0.03, blue: 0.03)
    static let surface = Color.white.opacity(0.07)
    static let stroke = Color.white.opacity(0.12)
    static let muted = Color.white.opacity(0.6)
}

extension Double {
    var money: String { String(format: "$%.2f", self) }
}

// MARK: - Models

enum BitKind {
    case basil, olive, mozzarella, mushroom, tomato, onion
    case pepper, chilli, halloumi, pineapple, sweetcorn
}

struct Topping: Identifiable {
    let id: String
    let emoji: String
    let price: Double
    let kind: BitKind
    var name: String { id }

    static let all: [Topping] = [
        Topping(id: "Peppers", emoji: "🫑", price: 0.99, kind: .pepper),
        Topping(id: "Chillies", emoji: "🌶️", price: 0.79, kind: .chilli),
        Topping(id: "Halloumi", emoji: "🧈", price: 1.79, kind: .halloumi),
        Topping(id: "Pineapple", emoji: "🍍", price: 1.09, kind: .pineapple),
        Topping(id: "Sweetcorn", emoji: "🌽", price: 0.89, kind: .sweetcorn),
        Topping(id: "Mozzarella", emoji: "🧀", price: 1.49, kind: .mozzarella),
        Topping(id: "Mushrooms", emoji: "🍄", price: 1.29, kind: .mushroom),
        Topping(id: "Olives", emoji: "🫒", price: 1.19, kind: .olive),
        Topping(id: "Tomatoes", emoji: "🍅", price: 0.99, kind: .tomato),
        Topping(id: "Onions", emoji: "🧅", price: 0.69, kind: .onion)
    ]
}

enum PizzaSize: String, CaseIterable, Identifiable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"

    var id: String { rawValue }

    var inches: String {
        switch self {
        case .small: return "10\""
        case .medium: return "12\""
        case .large: return "14\""
        }
    }

    var price: Double {
        switch self {
        case .small: return 9.29
        case .medium: return 11.49
        case .large: return 14.54
        }
    }

    var artScale: CGFloat {
        switch self {
        case .small: return 0.86
        case .medium: return 0.93
        case .large: return 1.0
        }
    }
}

struct PizzaStyle {
    let name: String
    let subtitle: String
    let rating: String
    let time: String
    let kcal: String
    let baseBits: [(BitKind, Int)]

    static let all: [PizzaStyle] = [
        PizzaStyle(name: "Basilico",
                   subtitle: "Fresh basil, black olives & aged mozzarella",
                   rating: "4.8", time: "20 min", kcal: "720 kcal",
                   baseBits: [(.mozzarella, 8), (.olive, 6), (.basil, 5)]),
        PizzaStyle(name: "Diavola",
                   subtitle: "Spicy salami, chilli oil & smoked mozzarella",
                   rating: "4.7", time: "22 min", kcal: "810 kcal",
                   baseBits: [(.mozzarella, 6), (.tomato, 9), (.chilli, 5)]),
        PizzaStyle(name: "Margherita",
                   subtitle: "San Marzano tomato, fior di latte & basil",
                   rating: "4.9", time: "15 min", kcal: "640 kcal",
                   baseBits: [(.mozzarella, 10), (.tomato, 4), (.basil, 4)]),
        PizzaStyle(name: "Funghi",
                   subtitle: "Wild mushrooms, thyme & truffle cream",
                   rating: "4.6", time: "18 min", kcal: "690 kcal",
                   baseBits: [(.mushroom, 8), (.onion, 4), (.mozzarella, 5)])
    ]
}

// MARK: - Pizza art

struct LeafShape: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: r.midX, y: r.minY))
        p.addQuadCurve(to: CGPoint(x: r.midX, y: r.maxY),
                       control: CGPoint(x: r.maxX + r.width * 0.25, y: r.midY))
        p.addQuadCurve(to: CGPoint(x: r.midX, y: r.minY),
                       control: CGPoint(x: r.minX - r.width * 0.25, y: r.midY))
        return p
    }
}

struct MushroomShape: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        let w = r.width, h = r.height
        p.move(to: CGPoint(x: r.minX, y: r.minY + h * 0.55))
        p.addCurve(to: CGPoint(x: r.maxX, y: r.minY + h * 0.55),
                   control1: CGPoint(x: r.minX, y: r.minY - h * 0.15),
                   control2: CGPoint(x: r.maxX, y: r.minY - h * 0.15))
        p.addLine(to: CGPoint(x: r.minX + w * 0.65, y: r.minY + h * 0.58))
        p.addLine(to: CGPoint(x: r.minX + w * 0.62, y: r.maxY))
        p.addLine(to: CGPoint(x: r.minX + w * 0.38, y: r.maxY))
        p.addLine(to: CGPoint(x: r.minX + w * 0.35, y: r.minY + h * 0.58))
        p.closeSubpath()
        return p
    }
}

struct BitView: View {
    let kind: BitKind

    private var assetName: String {
        switch kind {
        case .basil: return "bit_basil"
        case .olive: return "bit_olive"
        case .mozzarella: return "bit_mozzarella"
        case .mushroom: return "bit_mushroom"
        case .tomato: return "bit_tomato"
        case .onion: return "bit_onion"
        case .pepper: return "bit_pepper"
        case .chilli: return "bit_chilli"
        case .halloumi: return "bit_halloumi"
        case .pineapple: return "bit_pineapple"
        case .sweetcorn: return "bit_sweetcorn"
        }
    }

    private var assetSize: CGFloat {
        switch kind {
        case .basil: return 30
        case .olive: return 22
        case .mozzarella: return 30
        case .mushroom: return 28
        case .tomato: return 26
        case .onion: return 26
        case .pepper: return 28
        case .chilli: return 20
        case .halloumi: return 26
        case .pineapple: return 26
        case .sweetcorn: return 26
        }
    }

    var body: some View {
        if UIImage(named: assetName) != nil {
            Image(assetName)
                .resizable()
                .scaledToFit()
                .frame(width: assetSize, height: assetSize)
        } else {
            vector
        }
    }

    @ViewBuilder
    private var vector: some View {
        switch kind {
        case .basil: basil
        case .olive: olive
        case .mozzarella: mozzarella
        case .mushroom: mushroom
        case .tomato: tomato
        case .onion: onion
        case .pepper: pepper
        case .chilli: chilli
        case .halloumi: halloumi
        case .pineapple: pineapple
        case .sweetcorn: sweetcorn
        }
    }

    private var basil: some View {
        ZStack {
            LeafShape().fill(LinearGradient(colors: [Color(red: 0.45, green: 0.85, blue: 0.30),
                                                     Color(red: 0.08, green: 0.40, blue: 0.12)],
                                            startPoint: .topLeading, endPoint: .bottomTrailing))
            Capsule().fill(Color.white.opacity(0.35)).frame(width: 1.5, height: 20)
        }
        .frame(width: 20, height: 30)
    }

    private var olive: some View {
        ZStack {
            Circle().fill(RadialGradient(colors: [Color(red: 0.28, green: 0.25, blue: 0.12),
                                                  Color(red: 0.06, green: 0.05, blue: 0.04)],
                                         center: .topLeading, startRadius: 1, endRadius: 14))
            Circle().fill(Color(red: 0.93, green: 0.68, blue: 0.33)).padding(5)
            Circle().strokeBorder(Color.white.opacity(0.25), lineWidth: 1).padding(5)
            Capsule().fill(Color.white.opacity(0.4)).frame(width: 5, height: 2)
                .rotationEffect(.degrees(-40)).offset(x: -4, y: -5)
        }
        .frame(width: 18, height: 18)
    }

    private var mozzarella: some View {
        ZStack {
            Ellipse().fill(RadialGradient(colors: [Color.white, Color(red: 1.0, green: 0.95, blue: 0.78)],
                                          center: .topLeading, startRadius: 1, endRadius: 16))
            Ellipse().strokeBorder(Color(red: 0.95, green: 0.80, blue: 0.45).opacity(0.7), lineWidth: 1)
            Circle().fill(Color(red: 0.95, green: 0.65, blue: 0.25).opacity(0.35))
                .frame(width: 6, height: 6).offset(x: 4, y: 2)
        }
        .frame(width: 24, height: 19)
    }

    private var mushroom: some View {
        MushroomShape()
            .fill(LinearGradient(colors: [Color(red: 0.97, green: 0.93, blue: 0.86),
                                          Color(red: 0.78, green: 0.68, blue: 0.56)],
                                 startPoint: .top, endPoint: .bottom))
            .overlay(MushroomShape().stroke(Color(red: 0.50, green: 0.38, blue: 0.28), lineWidth: 1))
            .frame(width: 22, height: 21)
    }

    private var tomato: some View {
        ZStack {
            Circle().fill(RadialGradient(colors: [Color(red: 0.98, green: 0.30, blue: 0.20),
                                                  Color(red: 0.70, green: 0.06, blue: 0.06)],
                                         center: .topLeading, startRadius: 1, endRadius: 18))
            Circle().strokeBorder(Color(red: 1.0, green: 0.62, blue: 0.50).opacity(0.8), lineWidth: 1.5).padding(3)
            Circle().fill(Color(red: 1.0, green: 0.75, blue: 0.60).opacity(0.5))
                .frame(width: 4, height: 4).offset(x: -3, y: -3)
        }
        .frame(width: 20, height: 20)
    }

    private var onion: some View {
        ZStack {
            Circle().strokeBorder(Color(red: 0.72, green: 0.40, blue: 0.78), lineWidth: 3)
            Circle().strokeBorder(Color(red: 0.95, green: 0.80, blue: 0.95).opacity(0.9), lineWidth: 1.5).padding(5)
        }
        .frame(width: 21, height: 21)
    }

    private var pepper: some View {
        ZStack {
            Circle().trim(from: 0.05, to: 0.6)
                .stroke(LinearGradient(colors: [Color(red: 0.45, green: 0.85, blue: 0.25),
                                                Color(red: 0.12, green: 0.55, blue: 0.15)],
                                       startPoint: .top, endPoint: .bottom),
                        style: StrokeStyle(lineWidth: 6, lineCap: .round))
            Circle().trim(from: 0.08, to: 0.55)
                .stroke(Color.white.opacity(0.35), style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                .padding(1)
        }
        .frame(width: 24, height: 24)
    }

    private var chilli: some View {
        ZStack {
            Circle().fill(Color(red: 0.85, green: 0.10, blue: 0.08))
            Circle().fill(Color(red: 1.0, green: 0.90, blue: 0.65)).padding(3)
            ForEach(0..<4, id: \.self) { i in
                Circle().fill(Color(red: 0.95, green: 0.80, blue: 0.45))
                    .frame(width: 2.5, height: 2.5)
                    .offset(x: cos(Double(i) * 1.57 + 0.5) * 3.2, y: sin(Double(i) * 1.57 + 0.5) * 3.2)
            }
        }
        .frame(width: 16, height: 16)
    }

    private var halloumi: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(LinearGradient(colors: [Color(red: 1.0, green: 0.94, blue: 0.65),
                                              Color(red: 0.92, green: 0.72, blue: 0.32)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
            ForEach(0..<2, id: \.self) { i in
                Capsule().fill(Color(red: 0.55, green: 0.32, blue: 0.12).opacity(0.55))
                    .frame(width: 15, height: 2)
                    .rotationEffect(.degrees(-35))
                    .offset(y: CGFloat(i) * 6 - 3)
            }
        }
        .frame(width: 20, height: 16)
        .clipShape(RoundedRectangle(cornerRadius: 3))
    }

    private var pineapple: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(colors: [Color(red: 1.0, green: 0.90, blue: 0.30),
                                              Color(red: 0.95, green: 0.65, blue: 0.10)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(Color(red: 1.0, green: 0.97, blue: 0.70).opacity(0.7), lineWidth: 1.5)
            Capsule().fill(Color.white.opacity(0.35)).frame(width: 7, height: 2).offset(x: -3, y: -3)
        }
        .frame(width: 20, height: 16)
    }

    private var sweetcorn: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(LinearGradient(colors: [Color(red: 1.0, green: 0.92, blue: 0.35),
                                                  Color(red: 0.95, green: 0.70, blue: 0.12)],
                                         startPoint: .top, endPoint: .bottom))
                    .overlay(Circle().fill(Color.white.opacity(0.5)).frame(width: 3, height: 3).offset(x: -1.5, y: -2))
                    .frame(width: 9, height: 11)
                    .rotationEffect(.degrees(Double(i) * 25 - 20))
                    .offset(x: CGFloat(i) * 7 - 7, y: i == 1 ? 3 : -2)
            }
        }
        .frame(width: 24, height: 18)
    }
}

struct PlacedBit: Identifiable {
    let id: String
    let kind: BitKind
    let x: Double
    let y: Double
    let rot: Double
}

struct PizzaArt: View {
    let style: PizzaStyle
    let selected: [String]
    var showPlate: Bool = true

    private func layout(kind: BitKind, count: Int, seed: Int, tag: String) -> [PlacedBit] {
        (0..<count).map { i in
            let a = Double(i) * 2.39996 + Double(seed) * 0.9
            let r = (Double(i) + 0.6) / Double(count)
            let radius = r.squareRoot() * 84.0
            let jx = sin(Double(seed * 31 + i * 17)) * 6
            let jy = cos(Double(seed * 13 + i * 11)) * 6
            return PlacedBit(id: "\(tag)-\(i)", kind: kind,
                             x: cos(a) * radius + jx, y: sin(a) * radius + jy,
                             rot: Double((seed * 37 + i * 53) % 360))
        }
    }

    private var placedBits: [PlacedBit] {
        var result: [PlacedBit] = []
        for (index, base) in style.baseBits.enumerated() {
            result += layout(kind: base.0, count: base.1, seed: 3 + index * 5, tag: "base\(index)")
        }
        for id in selected {
            if let index = Topping.all.firstIndex(where: { $0.id == id }) {
                result += layout(kind: Topping.all[index].kind, count: 9, seed: 100 + index * 13, tag: id)
            }
        }
        return result
    }

    var body: some View {
        ZStack {
            if showPlate {
                Circle()
                    .fill(LinearGradient(colors: [Color(red: 0.50, green: 0.30, blue: 0.15),
                                                  Color(red: 0.20, green: 0.11, blue: 0.06)],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle().strokeBorder(Color(red: 0.70, green: 0.45, blue: 0.22).opacity(0.6), lineWidth: 3)
                Circle().fill(Color.black.opacity(0.25)).padding(10)
            }

            ZStack {
                if UIImage(named: "pizza_base") != nil {
                    Image("pizza_base")
                        .resizable()
                        .scaledToFit()
                } else {
                    Circle().fill(LinearGradient(colors: [Color(red: 0.93, green: 0.65, blue: 0.28),
                                                          Color(red: 0.68, green: 0.38, blue: 0.14)],
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                    Circle().fill(Color(red: 0.80, green: 0.22, blue: 0.10)).padding(12)
                    Circle().fill(RadialGradient(colors: [Color(red: 1.0, green: 0.84, blue: 0.45),
                                                          Color(red: 0.96, green: 0.68, blue: 0.30)],
                                                 center: .center, startRadius: 5, endRadius: 100))
                        .padding(16)
                    ForEach(0..<9, id: \.self) { i in
                        Circle().fill(Color(red: 0.78, green: 0.25, blue: 0.10).opacity(0.55))
                            .frame(width: 18, height: 18)
                            .blur(radius: 4)
                            .offset(x: cos(Double(i) * 2.1) * 62, y: sin(Double(i) * 2.1) * 62)
                    }
                }
                ForEach(placedBits) { bit in
                    BitView(kind: bit.kind)
                        .shadow(color: .black.opacity(0.35), radius: 1.5, y: 1.5)
                        .rotationEffect(.degrees(bit.rot))
                        .offset(x: bit.x, y: bit.y)
                        .transition(.scale(scale: 0.2).combined(with: .opacity))
                }
            }
            .padding(showPlate ? 20 : 12)
            .shadow(color: .black.opacity(0.35), radius: 6, y: 3)
        }
        .frame(width: 250, height: 250)
        .animation(.spring(response: 0.45, dampingFraction: 0.7), value: selected)
    }
}

struct FloatingDecor: View {
    @State private var float = false

    var body: some View {
        ZStack {
            LeafShape()
                .fill(Color(red: 0.35, green: 0.75, blue: 0.25))
                .frame(width: 10, height: 16).rotationEffect(.degrees(-20))
                .offset(x: -28, y: -128)
            Circle().trim(from: 0, to: 0.5)
                .fill(Color(red: 0.88, green: 0.12, blue: 0.10))
                .frame(width: 34, height: 34).rotationEffect(.degrees(-30))
                .offset(x: -112, y: -78)
            Circle().fill(Color(red: 0.92, green: 0.90, blue: 0.85))
                .frame(width: 18, height: 18)
                .offset(x: 122, y: -28)
            Capsule().fill(Color(red: 0.95, green: 0.70, blue: 0.25))
                .frame(width: 5, height: 9).offset(x: 94, y: -108)
            Capsule().fill(Color(red: 0.95, green: 0.45, blue: 0.20))
                .frame(width: 5, height: 9).offset(x: -14, y: -142)
            Circle().fill(Color(red: 0.92, green: 0.90, blue: 0.85))
                .frame(width: 8, height: 8).offset(x: -126, y: 54)
            Circle().trim(from: 0, to: 0.5)
                .fill(Color(red: 0.88, green: 0.12, blue: 0.10))
                .frame(width: 20, height: 20).rotationEffect(.degrees(160))
                .offset(x: 92, y: 124)
            Capsule().fill(Color(red: 0.95, green: 0.70, blue: 0.25))
                .frame(width: 5, height: 9).offset(x: 112, y: 96)
        }
        .offset(y: float ? -4 : 4)
        .animation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: float)
        .onAppear { float = true }
    }
}

// MARK: - Small components

struct CircleIconButton: View {
    let systemName: String
    var badge: String? = nil
    var size: CGFloat = 40
    var tint: Color = .white
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(tint)
                .frame(width: size, height: size)
                .background(Theme.surface, in: Circle())
                .overlay(Circle().strokeBorder(Theme.stroke, lineWidth: 1))
                .overlay(alignment: .topTrailing) {
                    if let badge {
                        Text(badge)
                            .font(.system(size: 9, weight: .heavy))
                            .foregroundStyle(.black)
                            .frame(width: 16, height: 16)
                            .background(Theme.gold, in: Circle())
                            .offset(x: 4, y: -4)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

struct InfoChip: View {
    let icon: String
    let text: String
    var tint: Color = Theme.gold

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon).font(.system(size: 9, weight: .bold)).foregroundStyle(tint)
            Text(text).font(.system(size: 11, weight: .semibold)).foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Theme.surface, in: Capsule())
        .overlay(Capsule().strokeBorder(Theme.stroke, lineWidth: 1))
    }
}

struct ToppingChip: View {
    let topping: Topping
    let isOn: Bool
    let action: () -> Void

    private var iconName: String { "icon_" + topping.id.lowercased() }

    @ViewBuilder
    private var iconView: some View {
        if UIImage(named: iconName) != nil {
            Image(iconName).resizable().scaledToFit().padding(8)
        } else {
            Text(topping.emoji).font(.system(size: 28))
        }
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(isOn ? Theme.gold.opacity(0.22) : Theme.surface)
                        .overlay(Circle().strokeBorder(isOn ? Theme.gold : Theme.stroke,
                                                       lineWidth: isOn ? 2 : 1))
                        .overlay(iconView)
                        .frame(width: 58, height: 58)
                    if isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 8, weight: .heavy))
                            .foregroundStyle(.black)
                            .frame(width: 16, height: 16)
                            .background(Theme.gold, in: Circle())
                            .offset(x: 2, y: -2)
                            .transition(.scale)
                    }
                }
                Text(topping.name)
                    .font(.system(size: 11, weight: isOn ? .bold : .medium))
                    .foregroundStyle(.white)
                Text("+\(topping.price.money)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(isOn ? Theme.gold : Theme.muted)
            }
            .frame(width: 68)
        }
        .buttonStyle(.plain)
    }
}

struct SizePicker: View {
    @Binding var size: PizzaSize
    @Namespace private var ns

    var body: some View {
        HStack(spacing: 0) {
            ForEach(PizzaSize.allCases) { option in
                let on = option == size
                VStack(spacing: 1) {
                    Text(option.rawValue).font(.system(size: 13, weight: .bold))
                    Text(option.inches).font(.system(size: 9, weight: .medium)).opacity(0.7)
                }
                .foregroundStyle(on ? Color.black : Color.white.opacity(0.85))
                .frame(width: 92, height: 42)
                .background {
                    if on {
                        Capsule()
                            .fill(LinearGradient(colors: [Theme.gold, Theme.goldDeep],
                                                 startPoint: .top, endPoint: .bottom))
                            .matchedGeometryEffect(id: "pill", in: ns)
                    }
                }
                .contentShape(Capsule())
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) { size = option }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
        .padding(4)
        .background(Theme.surface, in: Capsule())
        .overlay(Capsule().strokeBorder(Theme.stroke, lineWidth: 1))
    }
}

// MARK: - Main screen

struct ContentView: View {
    @State private var styleIndex = 0
    @State private var size: PizzaSize = .medium
    @State private var selected: [String] = []
    @State private var liked = false
    @State private var showOven = false
    @State private var deltaText = ""
    @State private var showDelta = false

    private var style: PizzaStyle { PizzaStyle.all[styleIndex] }

    private var toppingsTotal: Double {
        selected.compactMap { id in Topping.all.first(where: { $0.id == id })?.price }
            .reduce(0, +)
    }

    private var total: Double { size.price + toppingsTotal }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            RadialGradient(colors: [Theme.flameTop.opacity(0.16), .clear],
                           center: .center, startRadius: 10, endRadius: 280)
                .offset(y: -80)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                titleBlock
                pizzaStage
                SizePicker(size: $size).padding(.top, 2)
                toppingsSection.padding(.top, 20)
                Spacer(minLength: 8)
                bottomBar
            }

            if showOven {
                OvenView(style: style, selected: selected,
                         onClose: { withAnimation(.easeInOut(duration: 0.4)) { showOven = false } },
                         onDone: finishOrder)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: total) { oldValue, newValue in
            let d = newValue - oldValue
            guard abs(d) > 0.001 else { return }
            deltaText = (d > 0 ? "+" : "−") + abs(d).money
            withAnimation(.easeOut(duration: 0.25)) { showDelta = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                withAnimation(.easeIn(duration: 0.3)) { showDelta = false }
            }
        }
    }

    // MARK: Sections

    private var header: some View {
        HStack {
            CircleIconButton(systemName: "chevron.left")
            Spacer()
            Text("CUSTOMIZE")
                .font(.system(size: 11, weight: .bold))
                .tracking(2.4)
                .foregroundStyle(Theme.gold)
            Spacer()
            CircleIconButton(systemName: "bag", badge: "2")
        }
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(style.name)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .foregroundStyle(.white)
                    Text(style.subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Theme.muted)
                }
                Spacer()
                CircleIconButton(systemName: liked ? "heart.fill" : "heart",
                                 tint: liked ? Theme.flameBottom : .white) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) { liked.toggle() }
                }
            }
            HStack(spacing: 8) {
                InfoChip(icon: "star.fill", text: style.rating)
                InfoChip(icon: "clock", text: style.time)
                InfoChip(icon: "flame.fill", text: style.kcal)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
        .animation(.easeInOut(duration: 0.25), value: styleIndex)
    }

    private var pizzaStage: some View {
        ZStack {
            FloatingDecor()
            PizzaArt(style: style, selected: selected)
                .scaleEffect(size.artScale)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: size)
                .shadow(color: Theme.flameTop.opacity(0.25), radius: 24)
            HStack {
                CircleIconButton(systemName: "chevron.left", size: 34) { cycle(-1) }
                Spacer()
                CircleIconButton(systemName: "chevron.right", size: 34) { cycle(1) }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 300)
    }

    private var toppingsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("Toppings")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                Spacer()
                Text("\(selected.count) of \(Topping.all.count) added")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Theme.muted)
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(Topping.all) { topping in
                        ToppingChip(topping: topping, isOn: selected.contains(topping.id)) {
                            toggle(topping)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private var bottomBar: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                ZStack(alignment: .leading) {
                    Text("TOTAL")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(1.6)
                        .foregroundStyle(Theme.muted)
                    if showDelta {
                        Text(deltaText)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(Theme.gold)
                            .offset(x: 44, y: -8)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                Text(total.money)
                    .font(.system(size: 36, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .contentTransition(.numericText(value: total))
                    .animation(.snappy, value: total)
                Text("\(size.rawValue) \(size.price.money) • Toppings \(toppingsTotal.money)")
                    .font(.system(size: 11))
                    .foregroundStyle(Theme.muted)
                    .contentTransition(.numericText())
                    .animation(.snappy, value: toppingsTotal)
            }
            Spacer()
            Button(action: fire) {
                HStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                    Text("Fire").font(.system(size: 20, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(width: 150, height: 58)
                .background(LinearGradient(colors: [Theme.flameTop, Theme.flameBottom],
                                           startPoint: .topLeading, endPoint: .bottomTrailing),
                            in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 1))
                .shadow(color: Theme.flameBottom.opacity(0.5), radius: 16, y: 6)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(LinearGradient(colors: [Color.white.opacity(0.09), Color.white.opacity(0.03)],
                                     startPoint: .top, endPoint: .bottom))
        )
        .overlay(RoundedRectangle(cornerRadius: 28, style: .continuous)
            .strokeBorder(Theme.stroke, lineWidth: 1))
        .padding(.horizontal, 12)
        .padding(.bottom, 4)
    }

    // MARK: Actions

    private func toggle(_ topping: Topping) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            if let i = selected.firstIndex(of: topping.id) {
                selected.remove(at: i)
            } else {
                selected.append(topping.id)
            }
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    private func cycle(_ step: Int) {
        let count = PizzaStyle.all.count
        withAnimation(.easeInOut(duration: 0.25)) {
            styleIndex = (styleIndex + step + count) % count
        }
    }

    private func fire() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        withAnimation(.easeInOut(duration: 0.4)) { showOven = true }
    }

    private func finishOrder() {
        withAnimation(.easeInOut(duration: 0.5)) {
            showOven = false
            selected = []
        }
    }
}

// MARK: - Oven

struct BrickWall: View {
    var body: some View {
        Canvas { ctx, size in
            let bh: CGFloat = 17
            let bw: CGFloat = 40
            var row = 0
            var y: CGFloat = 0
            while y < size.height {
                var x: CGFloat = row % 2 == 0 ? 0 : -bw / 2
                while x < size.width {
                    let seed = Double(abs(row * 31 + Int(x / bw) * 17) % 7) / 7.0
                    let rect = CGRect(x: x + 1.5, y: y + 1.5, width: bw - 3, height: bh - 3)
                    let color = Color(red: 0.62 + 0.22 * seed, green: 0.20 + 0.10 * seed, blue: 0.10)
                    ctx.fill(Path(roundedRect: rect, cornerRadius: 2), with: .color(color))
                    x += bw
                }
                y += bh
                row += 1
            }
        }
    }
}

struct FlameRow: View {
    var intensity: Double

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                let t = timeline.date.timeIntervalSinceReferenceDate
                let n = 16
                for i in 0..<n {
                    let x = size.width * (CGFloat(i) + 0.5) / CGFloat(n)
                    let wobble = 0.5 + 0.5 * sin(t * 7 + Double(i) * 1.7)
                    let h = CGFloat((14 + 26 * wobble) * intensity)
                    let w: CGFloat = 16
                    var p = Path()
                    p.move(to: CGPoint(x: x - w / 2, y: size.height))
                    p.addQuadCurve(to: CGPoint(x: x, y: size.height - h),
                                   control: CGPoint(x: x - w / 2, y: size.height - h * 0.5))
                    p.addQuadCurve(to: CGPoint(x: x + w / 2, y: size.height),
                                   control: CGPoint(x: x + w / 2, y: size.height - h * 0.5))
                    p.closeSubpath()
                    ctx.fill(p, with: .linearGradient(
                        Gradient(colors: [Theme.flameTop.opacity(0.0), Theme.flameTop.opacity(0.9),
                                          Theme.flameBottom.opacity(0.9)]),
                        startPoint: CGPoint(x: x, y: size.height - h),
                        endPoint: CGPoint(x: x, y: size.height)))
                }
            }
        }
    }
}

struct EmbersView: View {
    var active: Bool

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                guard active else { return }
                let t = timeline.date.timeIntervalSinceReferenceDate
                for i in 0..<36 {
                    let a = Double((i * 37) % 100) / 100.0
                    let b = Double((i * 53) % 100) / 100.0
                    let speed = 0.18 + 0.25 * b
                    let phase = (t * speed + a).truncatingRemainder(dividingBy: 1.0)
                    let x = size.width * (0.18 + 0.64 * a) + CGFloat(sin(t * 2 + Double(i)) * 8)
                    let y = size.height * 0.72 - CGFloat(phase) * size.height * 0.62
                    let r = CGFloat(1.2 + 1.8 * b)
                    let color = Color(red: 1.0, green: 0.55 + 0.35 * b, blue: 0.15)
                    ctx.fill(Path(ellipseIn: CGRect(x: x, y: y, width: r * 2, height: r * 2)),
                             with: .color(color.opacity(1 - phase)))
                }
            }
        }
        .allowsHitTesting(false)
    }
}

struct OvenArt: View {
    var intensity: Double

    private func arch(_ radius: CGFloat) -> UnevenRoundedRectangle {
        UnevenRoundedRectangle(topLeadingRadius: radius, bottomLeadingRadius: 6,
                               bottomTrailingRadius: 6, topTrailingRadius: radius,
                               style: .continuous)
    }

    var body: some View {
        ZStack {
            BrickWall()
                .frame(width: 300, height: 270)
                .overlay(
                    Rectangle()
                        .fill(
                            RadialGradient(colors: [Theme.flameTop.opacity(0.45), .clear],
                                           center: UnitPoint(x: 0.5, y: 0.62),
                                           startRadius: 10, endRadius: 170)
                        )
                        .blendMode(.plusLighter)
                )
                .clipShape(arch(150))

            ZStack(alignment: .bottom) {
                LinearGradient(colors: [Color.black, Color(red: 0.25, green: 0.05, blue: 0.03)],
                               startPoint: .top, endPoint: .bottom)
                FlameRow(intensity: intensity)
                    .frame(height: 60)
            }
            .frame(width: 206, height: 128)
            .clipShape(arch(60))
            .overlay(arch(60).strokeBorder(Color(red: 0.95, green: 0.50, blue: 0.15), lineWidth: 8))
            .offset(y: 34)

            Capsule()
                .fill(LinearGradient(colors: [Color(red: 0.95, green: 0.85, blue: 0.70),
                                              Color(red: 0.70, green: 0.55, blue: 0.40)],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: 236, height: 10)
                .offset(y: 100)
        }
        .frame(width: 300, height: 270)
        .shadow(color: Theme.flameBottom.opacity(0.35 * intensity), radius: 40)
    }
}

struct OvenView: View {
    let style: PizzaStyle
    let selected: [String]
    var onClose: () -> Void
    var onDone: () -> Void

    enum Phase { case loading, baking, ready }

    @State private var phase: Phase = .loading
    @State private var inside = false
    @State private var elapsed = 0
    @State private var steam = false

    private var intensity: Double {
        switch phase {
        case .loading: return 0.5
        case .baking: return 1.0
        case .ready: return 0.7
        }
    }

    private var timeText: String {
        "\(elapsed / 60):" + String(format: "%02d", elapsed % 60)
    }

    var body: some View {
        ZStack(alignment: .top) {
            Theme.background.ignoresSafeArea()
            RadialGradient(colors: [Theme.flameBottom.opacity(phase == .loading ? 0.10 : 0.30), .clear],
                           center: .center, startRadius: 10, endRadius: 360)
                .offset(y: 80)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.8), value: phase)

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    CircleIconButton(systemName: "xmark", size: 34, action: onClose)
                }
                .padding(.horizontal, 20)

                titleBlock.padding(.top, 10)

                ZStack {
                    OvenArt(intensity: intensity)
                    EmbersView(active: phase == .baking)
                        .frame(width: 300, height: 270)
                    peeledPizza
                    if phase == .ready { steamClouds }
                }
                .frame(width: 320, height: 330)
                .padding(.top, 30)

                Spacer()
            }
        }
        .task { await run() }
    }

    // MARK: Pieces

    private var titleBlock: some View {
        VStack(spacing: 8) {
            Text(eyebrow)
                .font(.system(size: 11, weight: .bold))
                .tracking(2.4)
                .foregroundStyle(Theme.gold)

            switch phase {
            case .loading:
                Text("Into the oven")
                    .font(.system(size: 34, weight: .semibold, design: .serif))
                    .foregroundStyle(.white)
            case .baking:
                VStack(spacing: 6) {
                    HStack(alignment: .lastTextBaseline, spacing: 8) {
                        Text("Baking")
                            .font(.system(size: 34, weight: .semibold, design: .serif))
                            .foregroundStyle(.white)
                        Text(timeText)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .monospacedDigit()
                            .foregroundStyle(Theme.gold)
                    }
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.white.opacity(0.15)).frame(width: 90, height: 3)
                        Capsule().fill(Theme.gold)
                            .frame(width: 90 * CGFloat(elapsed) / 90.0, height: 3)
                    }
                }
            case .ready:
                Text("Ready!")
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .foregroundStyle(Theme.gold)
                    .shadow(color: Theme.gold.opacity(0.6), radius: 14)
            }

            Text(style.name)
                .font(.system(size: 12))
                .foregroundStyle(Theme.muted)
        }
        .animation(.easeInOut(duration: 0.35), value: phase)
    }

    private var eyebrow: String {
        switch phase {
        case .loading: return "ORDER FIRED"
        case .baking: return "WOOD-FIRED · 450°C"
        case .ready: return "FRESH OUT THE OVEN"
        }
    }

    private var peeledPizza: some View {
        let isOut = (phase == .loading && !inside) || phase == .ready
        let scale: CGFloat = isOut ? (phase == .ready ? 1.0 : 0.95) : 0.42
        let offsetY: CGFloat = isOut ? 235 : 46
        return ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [Theme.gold, Theme.goldDeep],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: 28, height: 130)
                .offset(y: 190)
            Circle()
                .fill(LinearGradient(colors: [Theme.gold, Theme.goldDeep],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 270, height: 270)
            PizzaArt(style: style, selected: selected, showPlate: false)
        }
        .scaleEffect(scale)
        .offset(y: offsetY)
        .shadow(color: .black.opacity(0.4), radius: 10, y: 6)
    }

    private var steamClouds: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .fill(Color.white.opacity(0.35))
                    .frame(width: 110, height: 110)
                    .blur(radius: 24)
                    .offset(x: CGFloat(i - 2) * 46 + 20, y: steam ? -170 : -110)
                    .opacity(steam ? 0.2 : 0.6)
                    .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true).delay(Double(i) * 0.25),
                               value: steam)
            }
        }
        .onAppear { steam = true }
        .allowsHitTesting(false)
    }

    // MARK: Timeline

    private func run() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        withAnimation(.easeInOut(duration: 1.8)) { inside = true }

        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation(.easeInOut(duration: 0.4)) { phase = .baking }

        for s in 0...90 {
            if Task.isCancelled { return }
            elapsed = s
            try? await Task.sleep(nanoseconds: 60_000_000)
        }

        UINotificationFeedbackGenerator().notificationOccurred(.success)
        withAnimation(.spring(response: 1.0, dampingFraction: 0.8)) { phase = .ready }

        try? await Task.sleep(nanoseconds: 3_200_000_000)
        if Task.isCancelled { return }
        onDone()
    }
}

#Preview {
    ContentView()
}

