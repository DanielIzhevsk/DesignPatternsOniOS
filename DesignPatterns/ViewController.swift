import UIKit

final class MainViewController: UIViewController {
    
    enum Pattern: String, CaseIterable {
        case viper = "VIPER"
        case mvc = "MVC"
        case mvvm = "MVVM"
    }

    private let patterns: [Pattern] = Pattern.allCases
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func navigateToPattern(_ pattern: Pattern) {
        switch pattern {
        case .viper:
            self.navigateToViper()
        case .mvc:
            self.navigateToMVC()
        case .mvvm:
            self.navigateToMVVM()
        }
    }
    
    private func navigateToViper() {
        let viewController = VIPERProfilesAssembly.makeModule()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToMVC() {
        let viewController = MVCProfilesAssembly.makeViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToMVVM() {
        let viewController = MVVMProfilesAssembly.makeModule()
        self.show(viewController, sender: self)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.patterns.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath)
        cell.textLabel?.text = self.patterns[indexPath.row].rawValue
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigateToPattern(self.patterns[indexPath.row])
    }
}

