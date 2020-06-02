import Foundation
import UIKit

protocol VIPEREditProfileViewControllerInput: AnyObject {
    var name: String { get }
}

protocol VIPEREditProfileViewControllerOutput: AnyObject {
    func didTapCloseButton()
    func didTapMainButton()
}

final class VIPEREditProfileViewController: UIViewController {
    var output: VIPEREditProfileViewControllerOutput?
    
    @IBOutlet private var nameTextField: UITextField!
    
    @IBAction func didTapMainButton(_ sender: Any) {
        self.output?.didTapMainButton()
    }
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
        self.output?.didTapCloseButton()
    }
}
extension VIPEREditProfileViewController: VIPEREditProfileViewControllerInput {
    var name: String { self.nameTextField.text ?? "" }
}
