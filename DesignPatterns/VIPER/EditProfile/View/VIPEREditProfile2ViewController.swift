import Foundation
import UIKit

final class VIPEREditProfile2ViewController: UIViewController {
    var output: VIPEREditProfileViewControllerOutput?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func didTapAddButton(_ sender: Any) {
        self.output?.didTapMainButton()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.output?.didTapCloseButton()
    }
}

extension VIPEREditProfile2ViewController: VIPEREditProfileViewControllerInput {
    var name: String {
        self.textField.text ?? ""
    }
}
