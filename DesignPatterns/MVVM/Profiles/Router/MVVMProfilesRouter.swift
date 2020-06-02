import UIKit

protocol MVVMProfilesRouterInput: AnyObject {
    func showCreateProfile()
    func showPostsOfUser(_ user: UserEntity)
}

final class MVVMProfilesRouter {
    private weak var transitionHandler: UIViewController?
    
    init(transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
}

extension MVVMProfilesRouter: MVVMProfilesRouterInput {
    func showCreateProfile() {
        let viewController = MVVMEditProfileAssembly.makeModule()
        let navigationContoller = UINavigationController(rootViewController: viewController)
        navigationContoller.modalPresentationStyle = .fullScreen
        self.transitionHandler?.present(navigationContoller, animated: true, completion: nil)
    }
    
    func showPostsOfUser(_ user: UserEntity) {
        let viewController = MVVMPostsAssembly.makeModule(user: user)
        self.transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
