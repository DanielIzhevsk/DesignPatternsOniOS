import UIKit

final class MVCProfilesViewController: UIViewController {
    var postService: PostServiceInput!
    var userService: UserServiceInput!
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    private var users: [UserEntity] = []
    private var usersDisplayItems: [UserDisplayItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Пользователи"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchAllUsers()
        self.updateUsers()
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        let viewController = MVCEditProfileAssembly.makeModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func fetchAllUsers() {
        self.users = self.userService.getAllUsers()
    }
    
    private func updateUsers() {
        self.usersDisplayItems = self.users
            .map { user -> UserDisplayItem in
                let userPosts = self.postService.getPosts(by: user)
                return UserDisplayItem(user: user,
                                       lastPost: userPosts.max(by: { $0.creationDate < $1.creationDate }),
                                       allPostsCount: userPosts.count) }
        tableView.reloadData()
    }
}

extension MVCProfilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersDisplayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VIPERProfilesCell", for: indexPath)
        let user = self.usersDisplayItems[indexPath.row]
        cell.textLabel?.attributedText = user.name
        cell.detailTextLabel?.attributedText = user.postsInfo
        return cell
    }
}

extension MVCProfilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = self.users[indexPath.row]
        let viewController = MVCPostsAssembly.makeModule(user: user)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
