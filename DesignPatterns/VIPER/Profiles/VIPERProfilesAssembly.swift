import Foundation
import UIKit

struct VIPERProfilesAssembly {
    
    static func makeModule(externalRouter: VIPERProfilesRouterInput? = nil) -> UIViewController {
        let viewController = UIStoryboard(name: "VIPERProfiles", bundle: .main).instantiateInitialViewController() as! VIPERProfilesViewController
        
        let router: VIPERProfilesRouterInput
        if let externalRouter = externalRouter {
            router = externalRouter
        } else {
            router = VIPERProfilesRouter(transitionHandler: viewController)
        }
        
        let presenter = VIPERProfilesPresenter(userService: ServiceLocator.getService(),
                                               postService: ServiceLocator.getService(),
                                               router: router,
                                               view: viewController)
        viewController.output = presenter
        
        return viewController
    }
}
