import Foundation
import UIKit

struct PostDisplayItem {
    let title: NSAttributedString
    let subtitle: NSAttributedString
}

extension PostDisplayItem {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    init(post: PostEntity) {
        self.title = NSAttributedString(string: post.text,
                                        attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        
        let isToday = Calendar.current.isDateInToday(post.creationDate)
        let date = Self.dateFormatter.string(from: post.creationDate)
        self.subtitle = NSAttributedString(string: date,
                                           attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                        .foregroundColor: isToday ? UIColor.black : UIColor.lightGray])
    }
}
