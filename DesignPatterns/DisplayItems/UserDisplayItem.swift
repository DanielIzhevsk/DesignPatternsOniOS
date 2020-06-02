import Foundation
import UIKit

struct UserDisplayItem {
    let name: NSAttributedString
    let postsInfo: NSAttributedString?
}

extension UserDisplayItem {
    init(user: UserEntity,
         lastPost: PostEntity? = nil,
         allPostsCount: Int = 0) {
        let isAdmin = user.name == "Admin"
        self.name = NSAttributedString(string: user.name,
                                       attributes: [.foregroundColor: isAdmin ? UIColor.red : UIColor.black,
                                                    .font: UIFont.systemFont(ofSize: 20, weight: .regular)] )
        
        guard let lastPost = lastPost else {
            self.postsInfo = nil
            return
        }
        let postText = "\(lastPost.text)\n\nВсего постов \(allPostsCount)"
        self.postsInfo = NSAttributedString(string: postText,
                                            attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                         .foregroundColor: UIColor.lightGray])
    }
}
