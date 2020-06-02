import Foundation
import UIKit

final class MVCEditProfileViewController: UIViewController {
    var userService: UserServiceInput!
    
    @IBOutlet private var nameTextField: UITextField!
    
    @IBAction private func didTapMainButton(_ sender: Any) {
        guard let userName = self.nameTextField.text else { return }
        let newUser = UserEntity(id: UUID().uuidString,
                                 creationDate: Date(),
                                 name: userName)
        self.userService.saveUser(newUser)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
