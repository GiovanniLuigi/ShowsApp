//
//  MoreViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 30/03/21.
//

import UIKit

class MoreViewController: UIViewController {

    var viewModel: MoreViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MoreTableViewCell.nib, forCellReuseIdentifier: MoreTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(viewModel.prefersLargeTitles)
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles

    }
}

extension MoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MoreTableViewCell.self, indexPath: indexPath)
        
        if let cell = cell as? MoreTableViewCell {
            cell.configure(viewModel: viewModel.cellViewModel(at: indexPath))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
}

extension MoreViewController: UITableViewDelegate {
    
}
