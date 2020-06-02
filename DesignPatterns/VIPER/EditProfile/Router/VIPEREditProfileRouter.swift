import Foundation
import UIKit

protocol VIPEREditProfileRouterInput: AnyObject {
    func closeModule()
}

final class VIPEREditProfileRouter {
    private weak var transitionHandler: UIViewController?
    
    init(transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
}

extension VIPEREditProfileRouter: VIPEREditProfileRouterInput {
    func closeModule() {
        self.transitionHandler?.dismiss(animated: true, completion: nil)
    }
}
