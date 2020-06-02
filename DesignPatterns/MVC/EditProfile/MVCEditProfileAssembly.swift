import UIKit

struct MVCEditProfileAssembly {
    
    static func makeModule() -> UIViewController {
        let viewController = UIStoryboard(name: "MVCEditProfile", bundle: .main).instantiateInitialViewController() as! MVCEditProfileViewController
        viewController.userService = ServiceLocator.getService()
        return viewController
    }
}
