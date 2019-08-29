// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let araraVermelha = ImageAsset(name: "Arara-Vermelha")
  internal static let casa = ImageAsset(name: "Casa")
  internal static let dwayne = ImageAsset(name: "Dwayne")
  internal static let logoVermelho = ImageAsset(name: "Logo_vermelho")
  internal static let marcosOliveira = ImageAsset(name: "Marcos-Oliveira")
  internal static let matelaLoveGrande = ImageAsset(name: "MatelaLove grande")
  internal static let matelalove = ImageAsset(name: "Matelalove")
  internal static let navigationBar = ImageAsset(name: "Navigation Bar")
  internal static let theRock = ImageAsset(name: "TheRock")
  internal static let editarPerfil = ImageAsset(name: "editarPerfil")
  internal static let heart = ImageAsset(name: "heart")
  internal static let iconeDeFoto = ImageAsset(name: "icone_de_foto")
  internal static let literalmenteUmaLinha = ImageAsset(name: "literalmente_uma_linha")
  internal static let logoBranco = ImageAsset(name: "logo_branco")
  internal static let lupa = ImageAsset(name: "lupa")
  internal static let papagaioBranco = ImageAsset(name: "papagaio_branco")
  internal static let pastel = ImageAsset(name: "pastel")
  internal static let sininho = ImageAsset(name: "sininho")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
    araraVermelha,
    casa,
    dwayne,
    logoVermelho,
    marcosOliveira,
    matelaLoveGrande,
    matelalove,
    navigationBar,
    theRock,
    editarPerfil,
    heart,
    iconeDeFoto,
    literalmenteUmaLinha,
    logoBranco,
    lupa,
    papagaioBranco,
    pastel,
    sininho,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
