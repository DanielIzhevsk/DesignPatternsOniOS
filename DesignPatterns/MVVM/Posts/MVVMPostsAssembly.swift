import Foundation
import UIKit

struct MVVMPostsAssembly {
    
    static func makeModule(user: UserEntity) -> UIViewController {
        let viewController = UIStoryboard(name: "MVVMPosts", bundle: .main).instantiateInitialViewController() as! MVVMPostsViewController
        
        let viewModel = MVVMPostsViewModelImpementation(postService: ServiceLocator.getService(),
                                                        view: viewController,
                                                        user: user)
        viewController.viewModel = viewModel
        return viewController
    }
}
