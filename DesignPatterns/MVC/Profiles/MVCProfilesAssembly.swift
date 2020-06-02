import Foundation
import UIKit

struct MVCProfilesAssembly {
    static func makeViewController() -> UIViewController {
        let viewController = UIStoryboard(name: "MVCProfiles", bundle: .main).instantiateInitialViewController() as! MVCProfilesViewController
        viewController.postService = ServiceLocator.getService()
        viewController.userService = ServiceLocator.getService()
        return viewController
    }
}
