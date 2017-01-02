//
//  LoadingViewPresentable.swift
//  HexagonLoader
//
//  Created by Kesava Jawaharlal on 28/12/2016.
//  Copyright © 2016 Small Screen Science Ltd. All rights reserved.
//

import UIKit

protocol LoadingViewPresentable {
    var mainLoadingView: HexagonLoaderView { get set }
}

private var mainLoadingViewAssociationKey: UInt8 = 0

extension LoadingViewPresentable where Self: UIViewController {
    
    var mainLoadingView:  HexagonLoaderView {
        get {
            if let loadingView = objc_getAssociatedObject(self, &mainLoadingViewAssociationKey) as? HexagonLoaderView {
                return loadingView
            } else {
                let view = HexagonLoaderView(frame: self.view.frame)
                objc_setAssociatedObject(self, &mainLoadingViewAssociationKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return view
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &mainLoadingViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

//MARK: - Public Utility Methods
extension UIViewController: LoadingViewPresentable {
    public func startLoading(with loadingText: String) {
        mainLoadingView.removeSublayersIfNeeded()
        mainLoadingView.setup(with: loadingText)
        
        view.addSubview(mainLoadingView)
        mainLoadingView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.mainLoadingView.alpha = 1
        }) { (success) in
            self.mainLoadingView.startAnimating()
        }
    }
    
    public func startLoading() {
        startLoading(with: "")
    }
    
    public func stopLoading() {
        mainLoadingView.stopAnimating()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.mainLoadingView.alpha = 0
        }) { (success) in
            self.mainLoadingView.isHidden = true
        }
        mainLoadingView.removeFromSuperview()
    }
}
