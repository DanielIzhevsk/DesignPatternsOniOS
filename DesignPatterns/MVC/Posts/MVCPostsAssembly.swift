import Foundation
import UIKit

struct MVCPostsAssembly {
    
    static func makeModule(user: UserEntity) -> UIViewController {
        let viewController = UIStoryboard(name: "MVCPosts", bundle: .main).instantiateInitialViewController() as! MVCPostsViewController
        viewController.postsService = ServiceLocator.getService()
        viewController.user = user
        return viewController
    }
}
