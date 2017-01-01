//
//  HexagonLoaderView.swift
//  HexagonLoader
//
//  Created by Kesavasankar Jawaharlal on 25/12/2016.
//  Copyright © 2016 Small Screen Science Ltd. All rights reserved.
//


/**
 * Glossary: 
    S -> Side length
    R -> Radius of outer circle (ref to image - Forumula.png) --> S/ 2
    N -> Number of sides
    theta -> 2.0*pi/N
 * Formulae used for drawing:
 * Edge points of Hexagon: 
    x[n] = R * cos(2*pi*n/N + theta) + x_centre
    y[n] = R * sin(2*pi*n/N + theta) + y_centre
 * Radius of Inner Circle
    r = (sqrt(3) * S)/4
 *
 */
import UIKit

private let steps = 25
private let backdropViewLength: CGFloat = 250
private let numberOfSides: CGFloat = 6

public enum HexagonLoaderBackground {
    case visualEffectsViewLight
    case visualEffectsViewDark
    case transparentWithBackdrop
}

/**
 * Loader config
 */
public struct HexagonLoaderConfig {
    
    /**
     *  Length of each side
     */
    public let sideLength: CGFloat = 50
    
    /**
     *  Inner offset for each shape
     */
    public let shapesInnerOffset: CGFloat = 0
    
    /**
     *  Color of shapes
     */
    public var shapeColor = UIColor.white
    
    /**
     *  Color of shape border
     */
    public var shapeBorderColor = UIColor.red
    
    /**
     *  Speed of the spinner
     */
    public var speed: Double = 1
    
    /**
     *  Background Type
     */
    public var backgroundType: HexagonLoaderBackground = .transparentWithBackdrop
    
    public var transparentBackdropColor: UIColor = .gray
    
    
    // Singleton
    public static var shared = HexagonLoaderConfig()
    
    private init() {}
}

public class HexagonLoaderView: UIView {

    fileprivate var shapes: [CAShapeLayer]!
    fileprivate var transforms: [CAKeyframeAnimation]!
    fileprivate var pathAnimations: [CAKeyframeAnimation]!
    fileprivate var duration: Double = 5.0
    fileprivate lazy var visualEffectsView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate lazy var loaderBackdropView: UIView = {
        let view = UIView()
        view.backgroundColor = HexagonLoaderConfig.shared.transparentBackdropColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addShapes()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        addShapes()
    }
}

extension HexagonLoaderView {
    fileprivate func addShapes() {
        backgroundColor = .clear
        let sideLength = HexagonLoaderConfig.shared.sideLength
        
        let centerShapeFrame = CGRect(x: bounds.width/2 - sideLength/2, y: bounds.height/2 - sideLength/2, width: sideLength, height: sideLength)
        
        //===============
        // Shapes layer
        //===============
        
        var radiusOfOuterCircle: CGFloat = (sideLength - (HexagonLoaderConfig.shared.shapesInnerOffset * 4)) / 2
        let theta: CGFloat = CGFloat(2.0 * M_PI) / CGFloat(numberOfSides)
        let centerX = sideLength / 2
        let centerY = sideLength / 2
        
        let shapePath = UIBezierPath()
        shapePath.move(to: CGPoint(x: radiusOfOuterCircle * cos(2 * CGFloat.pi * 0/numberOfSides + theta) + centerX, y: radiusOfOuterCircle * sin(2 * CGFloat.pi * 0/numberOfSides + theta) + centerX))
        for i in 1...Int(numberOfSides) {
            shapePath.addLine(to: CGPoint(x: radiusOfOuterCircle * cos(2 * CGFloat.pi * CGFloat(i) / numberOfSides + theta) + centerX, y: radiusOfOuterCircle * sin(2 * CGFloat.pi * CGFloat(i) / numberOfSides + theta) + centerY))
        }
        shapePath.close()
        
        shapes = (0 ..< Int(numberOfSides)).map { i in
            let shape = CAShapeLayer()
            shape.frame = centerShapeFrame
            shape.fillColor = HexagonLoaderConfig.shared.shapeColor.cgColor
            shape.masksToBounds = true
            shape.path = shapePath.cgPath
            shape.strokeColor = HexagonLoaderConfig.shared.shapeBorderColor.cgColor
            
            return shape
        }
        
        shapes.forEach { shape in
            layer.addSublayer(shape)
        }
        
        var counter: Double = 0
        transforms = shapes.map { _ in
            let animation = CAKeyframeAnimation(keyPath: "transform")
            animation.duration = duration * HexagonLoaderConfig.shared.speed
            animation.repeatCount = .infinity
            animation.values = [
                NSValue(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)),
                NSValue(caTransform3D: CATransform3DMakeRotation( CGFloat(30 * Double.pi / 180), 0.0, 0.0, 1.0)),
                NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
            ]
            animation.keyTimes = []
            for _ in 0..<2 {
                animation.keyTimes?.append(NSNumber(value: counter/Double(steps)))
                counter += 1
            }
            return animation
        }
        
        let startingVertices = 2
        radiusOfOuterCircle = sideLength / 2
        let middleShapeStartingPoint: CGPoint = CGPoint(x: radiusOfOuterCircle * cos(2 * CGFloat.pi * CGFloat(startingVertices) / numberOfSides + theta) + centerShapeFrame.midX, y: radiusOfOuterCircle * sin(2 * CGFloat.pi * CGFloat(startingVertices) / numberOfSides + theta) + centerShapeFrame.midY)
        let radiusOfInnnerCircle = (sqrt(3) * sideLength)/4
        
        let RMinusr = (radiusOfOuterCircle - radiusOfInnnerCircle)
        
        var xPosition: CGFloat = middleShapeStartingPoint.x + RMinusr
        var yPosition: CGFloat = middleShapeStartingPoint.y - sideLength/4 - radiusOfOuterCircle
        var completedShapesCount: Int = 1
        counter = 1
        pathAnimations = shapes.map { _ in
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.duration = duration * HexagonLoaderConfig.shared.speed
            animation.repeatCount = .infinity
            animation.values = [
                NSValue(cgPoint: CGPoint(x: centerShapeFrame.midX, y: centerShapeFrame.midY)),
                NSValue(cgPoint: CGPoint(x: xPosition, y: yPosition)),
                NSValue(cgPoint: CGPoint(x: xPosition, y: yPosition)),
                NSValue(cgPoint: CGPoint(x: centerShapeFrame.midX, y: centerShapeFrame.midY))
            ]
            if completedShapesCount == 2 {
                xPosition = middleShapeStartingPoint.x + RMinusr - radiusOfInnnerCircle
                yPosition = middleShapeStartingPoint.y
            } else if completedShapesCount == 3 {
                xPosition = xPosition + radiusOfInnnerCircle*4
            } else if completedShapesCount == 4 {
                xPosition = middleShapeStartingPoint.x + RMinusr
                yPosition = yPosition + sideLength - sideLength / 4
            } else if completedShapesCount == 6 {
                xPosition = centerShapeFrame.midX
                yPosition = centerShapeFrame.midY
            } else {
                xPosition = xPosition + radiusOfInnnerCircle*2
            }
            completedShapesCount += 1
            animation.keyTimes = []
            for _ in 0..<2 {
                animation.keyTimes?.append(NSNumber(value: counter/Double(steps)))
                counter += 1
            }
            animation.keyTimes?.append(NSNumber(value: (counter+10)/Double(steps)))
            animation.keyTimes?.append(NSNumber(value: (counter+11)/Double(steps)))
            
            return animation
        }

    }
    
    public func startAnimating() {
        
        switch HexagonLoaderConfig.shared.backgroundType {
        case .visualEffectsViewDark:
            visualEffectsView.frame = frame
            visualEffectsView.effect = UIBlurEffect(style: .dark)
            addSubview(visualEffectsView)
            sendSubview(toBack: visualEffectsView)
        case .visualEffectsViewLight:
            visualEffectsView.frame = frame
            visualEffectsView.effect = UIBlurEffect(style: .light)
            addSubview(visualEffectsView)
            sendSubview(toBack: visualEffectsView)
        case .transparentWithBackdrop:
            loaderBackdropView.frame = CGRect(x: self.bounds.width/2 - backdropViewLength/2, y: self.bounds.height/2 - backdropViewLength/2, width: backdropViewLength, height: backdropViewLength)
            addSubview(loaderBackdropView)
            sendSubview(toBack: loaderBackdropView)
        }
        
        CATransaction.begin()
        
        shapes.enumerated().forEach { (idx, shape) in
            shape.add(transforms[idx], forKey: "transform")
            shape.add(pathAnimations[idx], forKey: "position")
        }
        
        CATransaction.commit()
    }
    
    public func stopAnimating() {
        shapes.forEach {
            $0.removeAllAnimations()
        }
        visualEffectsView.removeFromSuperview()
        loaderBackdropView.removeFromSuperview()
    }
    
}
