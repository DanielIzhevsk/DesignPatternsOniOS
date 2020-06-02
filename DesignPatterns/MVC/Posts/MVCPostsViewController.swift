import Foundation
import UIKit

final class MVCPostsViewController: UIViewController {
    var postsService: PostServiceInput!
    var user: UserEntity!
    
    private var postsDispayItems: [PostDisplayItem] = []
    
    @IBOutlet private var addPostButton: UIButton!
    @IBOutlet private var postTextField: UITextField!
    
    @IBOutlet private var postsTableView: UITableView! {
        didSet {
            postsTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updatePosts()
    }
    
    @IBAction private func didTapAddPostButton(_ sender: Any) {
        self.addNewPostIfPossible()
        self.updatePosts()
        self.postTextField.text = ""
    }
    
    private func updatePosts() {
        self.postsDispayItems = self.postsService
            .getPosts(by: self.user)
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map { PostDisplayItem(post: $0) }
        self.postsTableView.reloadData()
    }
    
    private func addNewPostIfPossible() {
        guard let postText = self.postTextField.text,
            postText.isEmpty == false else { return }
        let post = PostEntity(authorUserId: self.user.id,
                              id: UUID().uuidString,
                              creationDate: Date(),
                              text: postText)
        self.postsService.savePost(post)
    }
}

extension MVCPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.postsDispayItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let post = self.postsDispayItems[indexPath.row]
        cell.textLabel?.attributedText = post.title
        cell.detailTextLabel?.attributedText = post.subtitle
        return cell
    }
}


extension MVCPostsViewController: UITableViewDelegate {
    
}

extension MVCPostsViewController: UITextFieldDelegate {
}
