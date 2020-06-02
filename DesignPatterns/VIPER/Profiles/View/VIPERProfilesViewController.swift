import UIKit

final class VIPERProfilesViewController: UIViewController {
    var output: ViperProfilesViewOutput?
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    private var users: [UserDisplayItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output?.viewWillAppear()
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        self.output?.didTapAddButton()
    }
}

extension VIPERProfilesViewController: ViperProfilesViewInput {    
    func showUsers(_ users: [UserDisplayItem]) {
        self.users = users
        tableView.reloadData()
    }
}

extension VIPERProfilesViewController: UITableViewDataSource {
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

extension VIPERProfilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.output?.didSelectProfile(at: indexPath.row)
    }
}
