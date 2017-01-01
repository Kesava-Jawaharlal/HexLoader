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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - Actiosn
extension ViewController {
    @IBAction func showDefaultLoader() {
        HexagonLoaderConfig.shared.backgroundType = .visualEffectsViewDark
        stopLoaderInFiveSeconds()
        startLoading()        
    }
    @IBAction func showLoaderWithTransparentbackground() {
        HexagonLoaderConfig.shared.backgroundType = .transparentWithBackdrop
        HexagonLoaderConfig.shared.transparentBackdropColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        startLoading()
        stopLoaderInFiveSeconds()
    }
    
    @IBAction func showDefaultLoaderWithLightEffect() {
        HexagonLoaderConfig.shared.backgroundType = .visualEffectsViewLight
        startLoading()
        stopLoaderInFiveSeconds()
    }
    
    func stopLoaderInFiveSeconds() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(15)) {
            self.stopLoading()
        }
    }
}

