import SwiftUI

// MARK: - Pulse theme: a palette ("cloth") and a finish ("texture"), chosen in Settings → Appearance.
//
// Every surface, text and metric colour in StrandDesign reads from here, so changing either choice
// recolours the whole app. The root view re-identifies on change (`pulseTheme(_:_:)`), the same
// mechanism the accent picker uses. Default: Sage + Soft lift.

public enum PulsePalette: String, CaseIterable, Identifiable, Sendable {
    case linen, oxford, charcoal, goldman, sage, nightSport

    public static let storageKey = "pulse.palette"
    public static let defaultValue: PulsePalette = .sage
    public var id: String { rawValue }

    public var label: String {
        switch self {
        case .linen: return "Linen"
        case .oxford: return "Oxford"
        case .charcoal: return "Charcoal"
        case .goldman: return "Goldman"
        case .sage: return "Sage"
        case .nightSport: return "Night sport"
        }
    }

    public var blurb: String {
        switch self {
        case .linen: return "Warm paper, green and gold"
        case .oxford: return "Cool white and navy, logo blue"
        case .charcoal: return "Monochrome with one blue accent"
        case .goldman: return "Sky blue, navy and a little gold"
        case .sage: return "Sage, clay and slate on stone"
        case .nightSport: return "Lime, cyan and violet on black"
        }
    }

    public static func resolve(_ raw: String) -> PulsePalette { PulsePalette(rawValue: raw) ?? defaultValue }

    /// (light, dark) hex pairs.
    struct Spec {
        let page, card, inset, line, ink, sub, ter: (String, String)
        let charge, effort, rest: (String, String)
        let sleepLight, sleepDeep, sleepREM, sleepAwake: (String, String)
    }

    var spec: Spec {
        switch self {
        case .linen:
            return Spec(page: ("#FFFFFF", "#111110"), card: ("#F6F5F2", "#1B1A18"), inset: ("#EBE9E4", "#2A2926"),
                        line: ("#E6E3DD", "#2C2B28"), ink: ("#1D1D1F", "#F3F2EF"), sub: ("#8B877F", "#9B978F"),
                        ter: ("#A9A59D", "#6E6A63"), charge: ("#22C55E", "#4ADE80"), effort: ("#B8913A", "#C9A24C"),
                        rest: ("#15803D", "#16A34A"), sleepLight: ("#A7E9BF", "#1F6B3D"), sleepDeep: ("#15803D", "#16A34A"),
                        sleepREM: ("#22C55E", "#4ADE80"), sleepAwake: ("#B8913A", "#C9A24C"))
        case .oxford:
            return Spec(page: ("#FFFFFF", "#0A101B"), card: ("#F2F5FA", "#131C2B"), inset: ("#E2E8F1", "#1F2A3C"),
                        line: ("#E2E8F1", "#1F2A3C"), ink: ("#0F1B2D", "#EEF3FA"), sub: ("#6B7A90", "#8291A8"),
                        ter: ("#9AA6B8", "#5C6B82"), charge: ("#3189F0", "#4DA3FF"), effort: ("#F2994A", "#F5A65B"),
                        rest: ("#1B4F9E", "#7FB2FF"), sleepLight: ("#BFD9FA", "#24406B"), sleepDeep: ("#1B4F9E", "#4DA3FF"),
                        sleepREM: ("#3189F0", "#7FB2FF"), sleepAwake: ("#F2994A", "#F5A65B"))
        case .charcoal:
            return Spec(page: ("#FFFFFF", "#0B0B0B"), card: ("#F4F4F4", "#171717"), inset: ("#E6E6E6", "#262626"),
                        line: ("#E6E6E6", "#262626"), ink: ("#111111", "#F5F5F5"), sub: ("#7A7A7A", "#8C8C8C"),
                        ter: ("#A3A3A3", "#5C5C5C"), charge: ("#111111", "#F5F5F5"), effort: ("#7A7A7A", "#8C8C8C"),
                        rest: ("#3189F0", "#4DA3FF"), sleepLight: ("#D4D4D4", "#3A3A3A"), sleepDeep: ("#111111", "#F5F5F5"),
                        sleepREM: ("#3189F0", "#4DA3FF"), sleepAwake: ("#A3A3A3", "#5C5C5C"))
        case .goldman:
            return Spec(page: ("#FFFFFF", "#07111F"), card: ("#F3F6FA", "#0F1C2E"), inset: ("#E1E8F0", "#1C2B40"),
                        line: ("#E1E8F0", "#1C2B40"), ink: ("#0A1F3D", "#EDF2F8"), sub: ("#6E7F96", "#8A9AB0"),
                        ter: ("#9AA8BA", "#5A6B82"), charge: ("#7399C6", "#8FB3DE"), effort: ("#C9A227", "#D9B743"),
                        rest: ("#0A1F3D", "#C9D8EA"), sleepLight: ("#C9D8EA", "#2A4466"), sleepDeep: ("#0A1F3D", "#C9D8EA"),
                        sleepREM: ("#7399C6", "#8FB3DE"), sleepAwake: ("#C9A227", "#D9B743"))
        case .sage:
            return Spec(page: ("#F7F6F1", "#141512"), card: ("#EEEDE6", "#1E1F1B"), inset: ("#E1E0D7", "#2C2D28"),
                        line: ("#E1E0D7", "#2C2D28"), ink: ("#23251F", "#EFEEE8"), sub: ("#7D7F74", "#96978C"),
                        ter: ("#A3A498", "#65665D"), charge: ("#5F7F5A", "#8DB086"), effort: ("#B5653A", "#D4865C"),
                        rest: ("#3E5C76", "#7FA0BD"), sleepLight: ("#C9D6C5", "#3A4A37"), sleepDeep: ("#3E5C76", "#7FA0BD"),
                        sleepREM: ("#5F7F5A", "#8DB086"), sleepAwake: ("#B5653A", "#D4865C"))
        case .nightSport:
            return Spec(page: ("#F6F7F8", "#000000"), card: ("#FFFFFF", "#111214"), inset: ("#E7E9EC", "#22252A"),
                        line: ("#E7E9EC", "#22252A"), ink: ("#0B0C0E", "#FFFFFF"), sub: ("#6B7078", "#8A8F98"),
                        ter: ("#9AA0A8", "#5A5F68"), charge: ("#65A30D", "#B6F500"), effort: ("#0891B2", "#22D3EE"),
                        rest: ("#7C3AED", "#A78BFA"), sleepLight: ("#D9F99D", "#3F5212"), sleepDeep: ("#7C3AED", "#A78BFA"),
                        sleepREM: ("#0891B2", "#22D3EE"), sleepAwake: ("#9AA0A8", "#5A5F68"))
        }
    }
}

public enum PulseFinish: String, CaseIterable, Identifiable, Sendable {
    case matte, hairline, lift, frosted

    public static let storageKey = "pulse.finish"
    public static let defaultValue: PulseFinish = .lift
    public var id: String { rawValue }

    public var label: String {
        switch self {
        case .matte: return "Matte"
        case .hairline: return "Hairline"
        case .lift: return "Soft lift"
        case .frosted: return "Frosted"
        }
    }

    public static func resolve(_ raw: String) -> PulseFinish { PulseFinish(rawValue: raw) ?? defaultValue }
}

public enum PulseTheme {
    public static var palette: PulsePalette =
        PulsePalette.resolve(UserDefaults.standard.string(forKey: PulsePalette.storageKey) ?? "")
    public static var finish: PulseFinish =
        PulseFinish.resolve(UserDefaults.standard.string(forKey: PulseFinish.storageKey) ?? "")

    static var spec: PulsePalette.Spec { palette.spec }

    static func c(_ p: (String, String)) -> Color { Color(light: p.0, dark: p.1) }

    /// Blend two hex colours (t = 0 → a, 1 → b), returned as hex.
    static func mixHex(_ a: String, _ b: String, _ t: Double) -> String {
        let x = Color.sRGBComponents(hex: a), y = Color.sRGBComponents(hex: b)
        func ch(_ u: Double, _ v: Double) -> Int { Int(((u + (v - u) * t) * 255).rounded()) }
        return String(format: "#%02X%02X%02X", ch(x.r, y.r), ch(x.g, y.g), ch(x.b, y.b))
    }

    static func mix(_ a: (String, String), _ b: (String, String), _ t: Double) -> Color {
        Color(light: mixHex(a.0, b.0, t), dark: mixHex(a.1, b.1, t))
    }

    // Surfaces, by finish. Soft lift: light cards on a slightly deeper page (light mode); in dark mode
    // the page stays darkest and cards step up. Hairline: cards are page-coloured with an outline.
    public static var canvas: Color {
        finish == .lift ? Color(light: spec.card.0, dark: spec.page.1) : c(spec.page)
    }
    public static var surface: Color {
        switch finish {
        case .lift: return Color(light: spec.page.0, dark: spec.card.1)
        case .hairline: return c(spec.page)
        case .matte, .frosted: return c(spec.card)
        }
    }
    public static var surfaceOpacity: Double { finish == .frosted ? 0.72 : 1 }
    public static var cardStroke: Color? {
        switch finish {
        case .hairline: return c(spec.line)
        case .frosted: return c(spec.ink).opacity(0.08)
        default: return nil
        }
    }
    public static var hasShadow: Bool { finish == .lift }

    public static var inset: Color { c(spec.inset) }
    public static var line: Color { c(spec.line) }
    public static var ink: Color { c(spec.ink) }
    public static var sub: Color { c(spec.sub) }
    public static var ter: Color { c(spec.ter) }

    public static var charge: Color { c(spec.charge) }
    public static var effort: Color { c(spec.effort) }
    public static var rest: Color { c(spec.rest) }
    public static func deep(_ p: (String, String)) -> Color { mix(p, spec.ink, 0.28) }
    public static func bright(_ p: (String, String)) -> Color { mix(p, spec.page, 0.35) }
}

public extension View {
    /// Apply the stored Pulse palette and finish, re-identifying the tree so every colour is re-read.
    func pulseTheme(_ paletteRaw: String, _ finishRaw: String) -> some View {
        PulseTheme.palette = PulsePalette.resolve(paletteRaw)
        PulseTheme.finish = PulseFinish.resolve(finishRaw)
        return self.id("pulse.theme.\(paletteRaw).\(finishRaw)")
    }
}
