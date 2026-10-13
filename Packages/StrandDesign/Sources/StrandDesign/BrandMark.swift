import SwiftUI

// MARK: - BrandMark — the Pulse logo mark
//
// A folded blue ribbon tracing one heartbeat: flat lead-in, a sharp rise, a deep fall that folds
// under itself, and a flat lead-out. Drawn natively from the same five polygons as the Pulse web
// logo (viewBox -16 -15.7 132.1 132.1), each with its own vertical gradient so the fold reads as
// depth. Transparent background; everything scales off `size`.
public struct BrandMark: View {
    public var size: CGFloat

    public init(size: CGFloat = 120) {
        self.size = size
    }

    private static let origin = CGPoint(x: -16.0, y: -15.7)
    private static let span: CGFloat = 132.1

    private static let light = Color(hex: "#3D96F4")
    private static let mid = Color(hex: "#3189F0")
    private static let deep = Color(hex: "#1B4F9E")

    private enum Fill { case solid, up, down, up2 }

    private static let parts: [([CGPoint], Fill)] = [
        ([CGPoint(x: 47.61, y: 25.70), CGPoint(x: 57.69, y: 114.38), CGPoint(x: 62.31, y: 73.62), CGPoint(x: 52.39, y: -13.70)], .down),
        ([CGPoint(x: 6.00, y: 64.60), CGPoint(x: 33.20, y: 64.60), CGPoint(x: 26.80, y: 55.40), CGPoint(x: 6.00, y: 55.40)], .solid),
        ([CGPoint(x: 33.20, y: 64.60), CGPoint(x: 47.61, y: 25.70), CGPoint(x: 52.39, y: -13.70), CGPoint(x: 26.80, y: 55.40)], .up),
        ([CGPoint(x: 57.69, y: 114.38), CGPoint(x: 75.25, y: 64.60), CGPoint(x: 68.75, y: 55.40), CGPoint(x: 62.31, y: 73.62)], .up2),
        ([CGPoint(x: 75.25, y: 64.60), CGPoint(x: 94.00, y: 64.60), CGPoint(x: 94.00, y: 55.40), CGPoint(x: 68.75, y: 55.40)], .solid),
    ]

    public var body: some View {
        Canvas { ctx, canvasSize in
            let k = min(canvasSize.width, canvasSize.height) / Self.span
            func map(_ p: CGPoint) -> CGPoint {
                CGPoint(x: (p.x - Self.origin.x) * k, y: (p.y - Self.origin.y) * k)
            }
            for (pts, fill) in Self.parts {
                var path = Path()
                path.addLines(pts.map(map))
                path.closeSubpath()
                let box = path.boundingRect
                let bottom = CGPoint(x: box.midX, y: box.maxY)
                let top = CGPoint(x: box.midX, y: box.minY)
                switch fill {
                case .solid:
                    ctx.fill(path, with: .color(Self.light))
                case .up:
                    ctx.fill(path, with: .linearGradient(Gradient(colors: [Self.light, Self.mid]),
                                                         startPoint: bottom, endPoint: top))
                case .down:
                    ctx.fill(path, with: .linearGradient(
                        Gradient(stops: [.init(color: Self.deep, location: 0),
                                         .init(color: Color(hex: "#2A7CE4"), location: 0.5),
                                         .init(color: Self.light, location: 1)]),
                        startPoint: top, endPoint: bottom))
                case .up2:
                    ctx.fill(path, with: .linearGradient(
                        Gradient(stops: [.init(color: Self.deep, location: 0),
                                         .init(color: Color(hex: "#2E84EA"), location: 0.6),
                                         .init(color: Self.light, location: 1)]),
                        startPoint: bottom, endPoint: top))
                }
            }
        }
        .frame(width: size, height: size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Pulse"))
        .accessibilityAddTraits(.isImage)
    }
}

#if DEBUG
#Preview("BrandMark — sizes") {
    VStack(spacing: 40) {
        BrandMark(size: 120)
        HStack(spacing: 28) {
            BrandMark(size: 72)
            BrandMark(size: 44)
            BrandMark(size: 28)
        }
    }
    .padding(48)
    .frame(width: 420, height: 460)
    .background(StrandPalette.surfaceBase)
}
#endif
