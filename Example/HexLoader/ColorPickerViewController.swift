//
//  ColorPickerViewController.swift
//  HexLoader
//
//  Created by Kesavasankar Jawaharlal on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Color_Picker_for_iOS

protocol ColorPickerViewControllerDelegate: class {
    func colorPickerViewController(_ controller: ColorPickerViewController, didSelectColor color: UIColor)
}
class ColorPickerViewController: UIViewController {
    
    //MARK: - Vars
    @IBOutlet var colorPickerView: HRColorPickerView! {
        didSet {
            colorPickerView.color = .green
        }
    }
    weak var delegate: ColorPickerViewControllerDelegate?
}

//MARK: - Actions
extension ColorPickerViewController {
    @IBAction func selectColor() {
        if let color = colorPickerView.color {
            delegate?.colorPickerViewController(self, didSelectColor: color)
            dismiss(animated: true, completion: nil)
        }
    }
}
