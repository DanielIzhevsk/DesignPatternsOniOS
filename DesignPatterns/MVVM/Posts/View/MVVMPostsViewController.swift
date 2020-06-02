import Foundation
import UIKit

protocol MVVMPostsView: AnyObject {
    var postText: ((String) -> Void)? { get set }
    var viewDidLoadAciton: (() -> Void)? { get set }
    var viewWillAppearAciton: (() -> Void)? { get set }
    var didTapAddPostButtonAction: (() -> Void)? { get set }
}

final class MVVMPostsViewController: UIViewController, MVVMPostsView {
    var viewModel: MVVMPostsViewModel!
    
    var postText: ((String) -> Void)?
    var viewDidLoadAciton: (() -> Void)?
    var viewWillAppearAciton: (() -> Void)?
    var didTapAddPostButtonAction: (() -> Void)?
    
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
        self.postTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.subscribeViewModel()
        self.viewDidLoadAciton?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearAciton?()
    }
    
    @IBAction private func didTapAddPostButton(_ sender: Any) {
        self.didTapAddPostButtonAction?()
    }
    
    private func subscribeViewModel() {
        self.subscribeToPostText()
        self.subscribeToUserName()
        self.subscribeToPosts()
    }
    
    private func subscribeToPostText() {
        self.viewModel.postText = { [weak self] postText in
            self?.postTextField.text = postText
        }
    }
    
    private func subscribeToUserName() {
        self.viewModel.userName = { [weak self] userName in
            self?.title = userName
        }
    }
    
    private func subscribeToPosts() {
        self.viewModel.posts = { [weak self] posts in
            self?.posts = posts
            self?.postsTableView.reloadData()
        }
    }
    
    @objc private func textFieldDidChangeText() {
        self.postText?(postTextField.text ?? "")
    }
}

extension MVVMPostsViewController: UITableViewDataSource {
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

extension MVVMPostsViewController: UITableViewDelegate {
}
