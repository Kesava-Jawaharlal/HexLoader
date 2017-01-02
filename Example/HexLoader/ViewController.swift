//
//  ViewController.swift
//  ShapesLoader
//
//  Created by Kesavasankar Jawaharlal on 12/29/2016.
//  Copyright (c) 2016 Kesavasankar Jawaharlal. All rights reserved.
//

import UIKit
import HexLoader
import MapKit
import Color_Picker_for_iOS

class ViewController: UIViewController {

    //MARK: - Vars
    @IBOutlet weak var backldropCornerRadiusTextField: UITextField!
    @IBOutlet weak var backdropBGColorButton: UIButton! {
        didSet {
            backdropBGColorButton.layer.cornerRadius = 3
        }
    }
    @IBOutlet weak var displayBackdropOverlaySwitch: UISwitch!
    @IBOutlet weak var animationSpeedTextField: UITextField!
    @IBOutlet weak var HexagonInnerOffsetTextField: UITextField!
    @IBOutlet weak var hexagonBorderColorButton: UIButton! {
        didSet {
            hexagonBorderColorButton.layer.cornerRadius = 3
        }
    }
    @IBOutlet weak var backgroundTypeButton: UIButton!
    @IBOutlet weak var hexagonSideLengthTextField: UITextField!
    @IBOutlet weak var hexagonBGColorButton: UIButton! {
        didSet {
            hexagonBGColorButton.layer.cornerRadius = 3
        }
    }
    var buttonTappedForColorSelection: UIButton?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let colorPickerViewController = segue.destination as? ColorPickerViewController {
            colorPickerViewController.delegate = self
        }
    }
}

//MARK: - Actiosn
extension ViewController {
    @IBAction func showHexLoader() {
        HexagonLoaderConfig.shared.backgroundType = .dark
        stopLoaderInFiveSeconds()
        startLoading()        
    }

    @IBAction func showHexagonBorderColorSelector() {
        buttonTappedForColorSelection = hexagonBorderColorButton
        performSegue(withIdentifier: "showColorPickerSegue", sender: self)
    }
    @IBAction func showHexBGColorSelector() {
        buttonTappedForColorSelection = hexagonBGColorButton
        performSegue(withIdentifier: "showColorPickerSegue", sender: self)
    }
    @IBAction func showBackgroundTypeSelector() {
    }
    @IBAction func showBackdropBGColorSelector() {
        buttonTappedForColorSelection = backdropBGColorButton
        performSegue(withIdentifier: "showColorPickerSegue", sender: self)
    }

    func stopLoaderInFiveSeconds() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
            self.stopLoading()
        }
    }
}

extension ViewController: ColorPickerViewControllerDelegate {
    func colorPickerViewController(_ controller: ColorPickerViewController, didSelectColor color: UIColor) {
        buttonTappedForColorSelection?.backgroundColor = color
    }
}
