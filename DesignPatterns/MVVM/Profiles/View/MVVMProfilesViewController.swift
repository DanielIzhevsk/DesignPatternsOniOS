import UIKit

protocol MVVMProfileView: AnyObject {
    var viewDidLoadAction: (() -> Void)? { get set }
    var viewWillAppearAction: (() -> Void)? { get set }
    var didTapAddButtonAction: (() -> Void)? { get set }
    var didSelectUserAtIndex: ((Int) -> Void)? { get set }
}

final class MVVMProfilesViewController: UIViewController, MVVMProfileView {
    
    var viewModel: MVVMProfilesViewModel!
    
    var viewDidLoadAction: (() -> Void)?
    var viewWillAppearAction: (() -> Void)?
    var didTapAddButtonAction: (() -> Void)?
    var didSelectUserAtIndex: ((Int) -> Void)?
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    private var users: [UserDisplayItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToTitle()
        self.subscribeForUsers()
        
        self.viewDidLoadAction?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearAction?()
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        self.didTapAddButtonAction?()
    }
    
    private func subscribeForUsers() {
        self.viewModel.users = { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    private func subscribeToTitle() {
        self.viewModel.title = { [weak self] title in
            self?.title = title
        }
    }
}

extension MVVMProfilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VIPERProfilesCell", for: indexPath)
        let user = self.users[indexPath.row]
        cell.textLabel?.attributedText = user.name
        cell.detailTextLabel?.attributedText = user.postsInfo
        return cell
    }
}

extension MVVMProfilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didSelectUserAtIndex?(indexPath.row)
    }
}
