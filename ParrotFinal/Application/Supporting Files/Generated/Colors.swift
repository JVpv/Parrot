// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0276be"></span>
  /// Alpha: 100% <br/> (0x0276beff)
  internal static let primaryBlue = ColorName(rgbaValue: 0x0276beff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#343c45"></span>
  /// Alpha: 100% <br/> (0x343c45ff)
  internal static let primaryText = ColorName(rgbaValue: 0x343c45ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8e959f"></span>
  /// Alpha: 100% <br/> (0x8e959fff)
  internal static let secondaryText = ColorName(rgbaValue: 0x8e959fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#004e7f"></span>
  /// Alpha: 100% <br/> (0x004e7fff)
  internal static let secundaryBlue = ColorName(rgbaValue: 0x004e7fff)
}
// swiftlint:enable identifier_name line_length type_body_length

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
