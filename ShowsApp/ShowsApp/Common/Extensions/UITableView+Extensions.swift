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
}
