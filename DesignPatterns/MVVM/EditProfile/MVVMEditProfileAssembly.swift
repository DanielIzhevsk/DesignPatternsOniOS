import Foundation
import UIKit

struct MVVMEditProfileAssembly {
    
    static func makeModule() -> UIViewController {
        let viewController = UIStoryboard(name: "MVVMEditProfile", bundle: .main).instantiateInitialViewController() as! MVVMEditProfileViewController
        let router = MVVMEditProfileRouter(transitionHandler: viewController)
        let viewModel = MVVMEditProfileViewModelImpementation(view: viewController,
                                                              userService: ServiceLocator.getService(),
                                                              router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
