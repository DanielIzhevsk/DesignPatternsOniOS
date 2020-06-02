import Foundation
import UIKit

struct VIPERPostsAssembly {
    
    static func makeModule(user: UserEntity) -> UIViewController {
        let viewController = UIStoryboard(name: "VIPERPosts", bundle: .main).instantiateInitialViewController() as! VIPERPostsViewController
        
        let presenter = VIPERPostsPresenter(postsService: ServiceLocator.getService(),
                                            view: viewController,
                                            user: user)
        viewController.output = presenter
        
        return viewController
    }
}
