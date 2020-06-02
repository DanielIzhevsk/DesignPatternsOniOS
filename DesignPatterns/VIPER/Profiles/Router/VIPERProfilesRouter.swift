import UIKit

protocol VIPERProfilesRouterInput: AnyObject {
    func showCreateProfile()
    func showPostsOfUser(_ user: UserEntity)
}

final class VIPERProfilesRouter {
    private weak var transitionHandler: UIViewController?
    
    init(transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
}

extension VIPERProfilesRouter: VIPERProfilesRouterInput {
    func showCreateProfile() {
        let viewController = VIPEREditProfileAssembly.makeModule()
        let navigationContoller = UINavigationController(rootViewController: viewController)
        navigationContoller.modalPresentationStyle = .fullScreen
        self.transitionHandler?.present(navigationContoller, animated: true, completion: nil)
    }
    
    func showPostsOfUser(_ user: UserEntity) {
        let viewController = VIPERPostsAssembly.makeModule(user: user)
        self.transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
