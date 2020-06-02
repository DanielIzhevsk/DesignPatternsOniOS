import Foundation
import UIKit

protocol VIPERPostsViewInput: AnyObject {
    var postText: String { get set }
    
    func setUserName(_ userName: String)
    func updatePosts(_ posts: [PostDisplayItem])
}

protocol VIPERPostsViewOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didTapAddPostButton()
}

final class VIPERPostsViewController: UIViewController {
    var output: VIPERPostsViewOutput?
    
    private var posts: [PostDisplayItem] = []
    
    @IBOutlet private var addPostButton: UIButton!
    @IBOutlet private var postTextField: UITextField!
    
    @IBOutlet private var postsTableView: UITableView! {
        didSet {
            postsTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output?.viewWillAppear()
    }
    
    @IBAction private func didTapAddPostButton(_ sender: Any) {
        self.output?.didTapAddPostButton()
    }
}

extension VIPERPostsViewController: VIPERPostsViewInput {
  
    var postText: String {
        get { self.postTextField.text ?? "" }
        set { self.postTextField.text = newValue }
    }
    
    func setUserName(_ userName: String) {
        self.title = userName
    }
    
    func updatePosts(_ posts: [PostDisplayItem]) {
        self.posts = posts
        self.postsTableView.reloadData()
    }
}

extension VIPERPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post = self.posts[indexPath.row]
        cell.textLabel?.attributedText = post.title
        cell.detailTextLabel?.attributedText = post.subtitle
        return cell
    }
}


extension VIPERPostsViewController: UITableViewDelegate {
    
}

extension VIPERPostsViewController: UITextFieldDelegate {
}
