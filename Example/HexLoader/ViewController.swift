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
    @IBOutlet weak var hexagonBGColorButton: UIButton! {
        didSet {
            hexagonBGColorButton.layer.cornerRadius = 5
            hexagonBGColorButton.layer.borderWidth = 1
            hexagonBGColorButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var hexagonBorderColorButton: UIButton! {
        didSet {
            hexagonBorderColorButton.layer.cornerRadius = 5
            hexagonBorderColorButton.layer.borderWidth = 1
            hexagonBorderColorButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var HexagonInnerOffsetTextField: UITextField!
    @IBOutlet weak var hexagonSideLengthTextField: UITextField!
    @IBOutlet weak var backgroundTypeButton: UIButton!
    @IBOutlet weak var displayBackdropOverlaySwitch: UISwitch!
    @IBOutlet weak var backldropCornerRadiusTextField: UITextField!
    @IBOutlet weak var backdropBGColorButton: UIButton! {
        didSet {
            backdropBGColorButton.layer.cornerRadius = 5
            backdropBGColorButton.layer.borderWidth = 1
            backdropBGColorButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var loadingTextlabel: UITextField!
    @IBOutlet weak var loadingTextColorButton: UIButton! {
        didSet {
            loadingTextColorButton.layer.cornerRadius = 5
            loadingTextColorButton.layer.borderWidth = 1
            loadingTextColorButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var animationSpeedTextField: UITextField!
    
    var buttonTappedForColorSelection: UIButton?
    var selectedBackgroundType: HexagonLoaderBackground?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let colorPickerViewController = segue.destination as? ColorPickerViewController {
            colorPickerViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Base values
        displayBackdropOverlaySwitch.setOn(true, animated: false)
        selectedBackgroundType = .dark
        hexagonBGColorButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backdropBGColorButton.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.7176470588, blue: 0.968627451, alpha: 1)
        hexagonBorderColorButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loadingTextColorButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

//MARK: - Actiosn
extension ViewController {
    @IBAction func showHexLoader() {
        
        HexagonLoaderConfig.shared.hexagonBackgroundColor = hexagonBGColorButton.backgroundColor!
        HexagonLoaderConfig.shared.hexagonBorderColor = hexagonBorderColorButton.backgroundColor!
        HexagonLoaderConfig.shared.backdropOverlayColor = backdropBGColorButton.backgroundColor!
        HexagonLoaderConfig.shared.loadingTextColor = loadingTextColorButton.backgroundColor!
        HexagonLoaderConfig.shared.displayBackdropOverlay = displayBackdropOverlaySwitch.isOn
    
        if let backgroundType = selectedBackgroundType {
            HexagonLoaderConfig.shared.backgroundType = backgroundType
        }
        if let animationSpeedString = animationSpeedTextField.text,
            let speed = Double(animationSpeedString) {
            HexagonLoaderConfig.shared.animationSpeed = speed
        }
        if let cornerRadiusString = backldropCornerRadiusTextField.text,
            let cornerRadius = Float(cornerRadiusString) {
            HexagonLoaderConfig.shared.backdropOverlayCornerRadius = CGFloat(cornerRadius)
        }
        if let innerOffsetString = HexagonInnerOffsetTextField.text,
            let innerOffset = Float(innerOffsetString) {
            HexagonLoaderConfig.shared.hexagonInnerOffset = CGFloat(innerOffset)
        }
        if let sideLengthString = hexagonSideLengthTextField.text,
            let sideLength = Float(sideLengthString) {
            HexagonLoaderConfig.shared.hexagonSideLength = CGFloat(sideLength)
        }
        
        if let loadingText = loadingTextlabel.text {
            startLoading(with: loadingText)
        } else {
            startLoading()
        }
        
        stopLoaderInFiveSeconds()
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
        let alertVC = UIAlertController(title: "Select a background Type", message: nil, preferredStyle: .actionSheet)
        
        HexagonLoaderBackground.all.forEach { (backgroundType) in
            alertVC.addAction(UIAlertAction(title: backgroundType.description(), style: .default, handler: { [weak self] (action) in
                guard let `self` = self else { return }
                
                self.backgroundTypeButton.setTitle(backgroundType.description(), for: .normal)
                self.selectedBackgroundType = backgroundType
            }))
        }
        
        present(alertVC, animated: true, completion: nil)

    }
    @IBAction func showBackdropBGColorSelector() {
        buttonTappedForColorSelection = backdropBGColorButton
        performSegue(withIdentifier: "showColorPickerSegue", sender: self)
    }
    @IBAction func showColorPickerForLoadingText() {
        buttonTappedForColorSelection = loadingTextColorButton
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
