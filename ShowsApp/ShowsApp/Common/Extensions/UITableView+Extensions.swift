//
//  UITableView+Extensions.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

extension UITableView {
    func dequeue<CellType: UITableViewCell>(_ type: CellType.Type, indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath)
        return cell
    }
    
    func setEmptyMessage(_ message: String) {
        if backgroundView != nil {
            return
        }
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 1
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
}
