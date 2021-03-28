//
//  SearchTableViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension SearchTableViewCell {
    func configure(viewModel: SearchTableViewCellViewModel) {
        title.text = viewModel.title
    }
}
