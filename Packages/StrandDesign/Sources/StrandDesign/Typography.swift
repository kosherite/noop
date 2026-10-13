import SwiftUI
import CoreText
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Pulse type system: Inter throughout (bundled, SIL Open Font License, see Resources/Fonts).
/// Sizes follow the system text styles so Dynamic Type still scales them. Labels are sentence case,
/// medium weight and secondary colour; large numbers are extra bold with tight tracking.
public enum StrandFont {
    /// Registers the bundled Inter files once. Font.custom falls back to the system font if this fails.
    private static let registered: Bool = {
        let names = ["Inter-Regular", "Inter-Medium", "Inter-SemiBold", "Inter-Bold", "Inter-ExtraBold"]
        for n in names {
            if let url = Bundle.module.url(forResource: n, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
        return true
    }()

    static func face(_ weight: Font.Weight) -> String {
        switch weight {
        case .black, .heavy: return "Inter-ExtraBold"
        case .bold: return "Inter-Bold"
        case .semibold: return "Inter-SemiBold"
        case .medium: return "Inter-Medium"
        default: return "Inter-Regular"
        }
    }

    /// Inter at a fixed size.
    public static func inter(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        _ = registered
        return .custom(face(weight), fixedSize: size)
    }

    /// Inter that scales with Dynamic Type relative to a system text style.
    public static func inter(_ size: CGFloat, _ weight: Font.Weight, relativeTo style: Font.TextStyle) -> Font {
        _ = registered
        return .custom(face(weight), size: size, relativeTo: style)
    }

    public static func display(_ size: CGFloat = 72) -> Font {
        inter(size, .heavy).monospacedDigit()
    }

    public static func displayTracking(_ size: CGFloat = 72) -> CGFloat {
        -size * 0.045
    }

    public static func rounded(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        inter(size, weight).monospacedDigit()
    }

    public static var title1: Font { inter(28, .bold, relativeTo: .title) }
    public static var title2: Font { inter(22, .semibold, relativeTo: .title2) }
    public static var headline: Font { inter(17, .semibold, relativeTo: .headline) }
    public static var body: Font { inter(15, .regular, relativeTo: .body) }
    public static var subhead: Font { inter(13, .regular, relativeTo: .subheadline) }
    public static var caption: Font { inter(12, .regular, relativeTo: .caption) }
    public static var footnote: Font { inter(12, .regular, relativeTo: .footnote) }
    public static var overline: Font { inter(13, .medium, relativeTo: .caption) }

    public static func overlineScaled(_ size: CGFloat) -> Font {
        inter(size, .medium, relativeTo: .caption2)
    }

    public static let mono = Font.system(size: 13, weight: .regular, design: .monospaced)

    public static func number(_ size: CGFloat, weight: Font.Weight = .semibold) -> Font {
        inter(size, weight).monospacedDigit()
    }

    public static var bodyNumber: Font { inter(15, .medium, relativeTo: .body).monospacedDigit() }
    public static var captionNumber: Font { inter(12, .medium, relativeTo: .caption).monospacedDigit() }

    public static func mono(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    /// Pulse labels are sentence case with no added tracking.
    public static let overlineTracking: CGFloat = 0
}

public extension Text {
    /// Section and card label: sentence case, medium, secondary colour (Pulse `.label`).
    func strandOverline() -> some View {
        self.font(StrandFont.overline)
            .tracking(StrandFont.overlineTracking)
            .foregroundStyle(StrandPalette.textSecondary)
    }
}

public extension View {
    static func strandOverline(_ string: String) -> some View {
        Text(string).strandOverline()
    }
}

#if DEBUG
#Preview("Typography") {
    ScrollView {
        VStack(alignment: .leading, spacing: 18) {
            Text("88").font(StrandFont.display(72)).tracking(StrandFont.displayTracking(72)).foregroundStyle(StrandPalette.textPrimary)
            Text("Title 1 / Bold 28").font(StrandFont.title1).foregroundStyle(StrandPalette.textPrimary)
            Text("Title 2 / Semibold 22").font(StrandFont.title2).foregroundStyle(StrandPalette.textPrimary)
            Text("Headline / Semibold 17").font(StrandFont.headline).foregroundStyle(StrandPalette.textPrimary)
            Text("Body / Regular 15 — the thread of you, read in full.")
                .font(StrandFont.body).foregroundStyle(StrandPalette.textPrimary)
            Text("Subhead 13").font(StrandFont.subhead).foregroundStyle(StrandPalette.textSecondary)
            Text("Caption 12").font(StrandFont.caption).foregroundStyle(StrandPalette.textSecondary)
            Text("Footnote 11").font(StrandFont.footnote).foregroundStyle(StrandPalette.textTertiary)
            Text("Overline").strandOverline()
            Text("0xAA 41 00 1c crc32=f3a1  mono 13").font(StrandFont.mono).foregroundStyle(StrandPalette.textSecondary)
            HStack(spacing: 4) {
                Text("HRV").font(StrandFont.caption).foregroundStyle(StrandPalette.textSecondary)
                Text("62").font(StrandFont.bodyNumber).foregroundStyle(StrandPalette.textPrimary)
                Text("ms").font(StrandFont.caption).foregroundStyle(StrandPalette.textTertiary)
            }
        }
        .padding(28)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(width: 520, height: 620)
    .background(StrandPalette.surfaceBase)
    .preferredColorScheme(.dark)
}
#endif
