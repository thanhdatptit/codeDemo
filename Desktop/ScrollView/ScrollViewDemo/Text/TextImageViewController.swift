//
//  TextImageViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

class TextImageViewController: UIViewController {

    @IBOutlet weak var textPickerView: UIPickerView!
    let gradePickerValues = ["5. Klasse", "6. Klasse", "7. Klasse","8. Klasse", "9. Klasse", "10. Klasse"]

    override func viewDidLoad() {
        super.viewDidLoad()
        textPickerView.dataSource = self
        textPickerView.delegate = self

//        gradeTextField.inputView = gradePicker
//        gradeTextField.text = gradePickerValues[0]

    }

}

extension TextImageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradePickerValues.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradePickerValues[row]
    }
}

extension TextImageViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(String(row))
    }
}

//    @IBOutlet weak var gradeTextField: UITextField!
