import Foundation
import UIKit

struct VIPEREditProfileAssembly {
    
    static func makeModule(externalRouter: VIPEREditProfileRouterInput? = nil) -> UIViewController {
        let viewController = UIStoryboard(name: "VIPEREditProfile", bundle: .main).instantiateInitialViewController() as! VIPEREditProfileViewController
        
//        let viewController = UIStoryboard(name: "VIPEREditProfileV2", bundle: .main).instantiateInitialViewController() as! VIPEREditProfile2ViewController
        let router: VIPEREditProfileRouterInput
        if let externalRouter = externalRouter {
            router = externalRouter
        } else {
            router = VIPEREditProfileRouter(transitionHandler: viewController)
        }
        
        let presenter = VIPEREditProfilePresenter(userService: ServiceLocator.getService(),
                                                  router: router,
                                                  view: viewController)
        viewController.output = presenter
        
        return viewController
    }
}
