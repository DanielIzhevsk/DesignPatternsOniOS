import Foundation
import UIKit

protocol MVVMEditProfileRouterInput: AnyObject {
    func closeModule()
}

final class MVVMEditProfileRouter {
    private weak var transitionHandler: UIViewController?
    
    init(transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
}

extension MVVMEditProfileRouter: MVVMEditProfileRouterInput {
    func closeModule() {
        self.transitionHandler?.dismiss(animated: true, completion: nil)
    }
}
