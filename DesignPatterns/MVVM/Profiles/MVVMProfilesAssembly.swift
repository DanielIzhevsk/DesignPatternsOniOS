import Foundation
import UIKit

struct MVVMProfilesAssembly {
    static func makeModule() -> UIViewController {
        let viewController = UIStoryboard(name: "MVVMProfiles", bundle: .main).instantiateInitialViewController() as! MVVMProfilesViewController
        
        let router = MVVMProfilesRouter(transitionHandler: viewController)
        let viewModel = MVVMProfilesViewModelImplementation(view: viewController,
                                                            userService: ServiceLocator.getService(),
                                                            postService: ServiceLocator.getService(),
                                                            router: router)
        viewController.viewModel = viewModel
        return viewController
    }
}
