//
//  SeasonPickerViewController.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 28/03/21.
//

import UIKit

class SeasonPickerViewController: UIViewController {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var viewModel: SeasonPickerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(viewModel.initialRow, inComponent: 0, animated: false)
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        viewModel.shouldFinish()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.didFinish(selectedSeasonIndex: selectedSeason())
    }
    
    private func selectedSeason() -> Int {
        return pickerView.selectedRow(inComponent: 0)
    }
}


extension SeasonPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfSeasons()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.seasonTitle(at: row)
    }
    
}
