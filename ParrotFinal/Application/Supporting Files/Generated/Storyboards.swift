// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Main.self)

    internal static let cadastroViewController = SceneType<ParrotFinal.CadastroViewController>(storyboard: Main.self, identifier: "CadastroViewController")

    internal static let editarPerfilViewController = SceneType<ParrotFinal.EditarPerfilViewController>(storyboard: Main.self, identifier: "EditarPerfilViewController")

    internal static let tabBarViewController = SceneType<ParrotFinal.TabBarViewController>(storyboard: Main.self, identifier: "TabBarViewController")

    internal static let viewController = SceneType<ParrotFinal.ViewController>(storyboard: Main.self, identifier: "ViewController")
  }
  internal enum Perfil: StoryboardType {
    internal static let storyboardName = "Perfil"

    internal static let notificacoesViewController = SceneType<ParrotFinal.NotificacoesViewController>(storyboard: Perfil.self, identifier: "NotificacoesViewController")

    internal static let pesquisarPerfilViewController = SceneType<ParrotFinal.PesquisarPerfilViewController>(storyboard: Perfil.self, identifier: "PesquisarPerfilViewController")
  }
  internal enum Postagem: StoryboardType {
    internal static let storyboardName = "Postagem"

    internal static let editarPostagemViewController = SceneType<ParrotFinal.EditarPostagemViewController>(storyboard: Postagem.self, identifier: "EditarPostagemViewController")

    internal static let perfilViewController = SceneType<ParrotFinal.PerfilViewController>(storyboard: Postagem.self, identifier: "PerfilViewController")

    internal static let principalViewController = SceneType<ParrotFinal.PrincipalViewController>(storyboard: Postagem.self, identifier: "PrincipalViewController")
  }
}

internal enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
