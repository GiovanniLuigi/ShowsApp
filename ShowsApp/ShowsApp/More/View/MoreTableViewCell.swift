//
//  MoreTableViewCell.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    private var viewModel: MoreTableViewCellViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup() {
        guard let viewModel = self.viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        switchView.isOn = viewModel.isSwitchActive()
    }
    
    @IBAction func didTapSwitch(_ sender: Any) {
        viewModel?.didTapSwitch { [weak self] enabled in
            self?.switchView.setOn(enabled, animated: true)
        }
    }
    
}

extension MoreTableViewCell {
    func configure(viewModel: MoreTableViewCellViewModel) {
        self.viewModel = viewModel
        setup()
    }
}
