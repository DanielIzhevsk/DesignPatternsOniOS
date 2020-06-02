import Foundation

protocol ViperProfilesViewInput: AnyObject {
    var title: String? { get set }
    
    func showUsers(_ users: [UserDisplayItem])
}

protocol ViperProfilesViewOutput: AnyObject {
    func viewWillAppear()
    func didSelectProfile(at index: Int)
    func didTapAddButton()
}
