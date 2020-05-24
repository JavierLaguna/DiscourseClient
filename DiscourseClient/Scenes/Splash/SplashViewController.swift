//
//  SplashViewController.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 24/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackground()
    }
    
    private func configureBackground() {
        view.backgroundColor = .blackKC
        
        let customShapeView = createBackgroundShapeView(frame: view.frame)
              view.addSubview(customShapeView)
    }
    
    private func createBackgroundShapeView(frame: CGRect) -> UIView {
        let customShapeView = UIView(frame: frame)
        let customShapeLayer = CAShapeLayer()

        customShapeView.layer.addSublayer(customShapeLayer)

        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.addLine(to: CGPoint(x: frame.width, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: frame.height))
        bezierPath.close()
        
        customShapeLayer.path = bezierPath.cgPath

        customShapeLayer.fillColor = UIColor.grayKC.cgColor
        
        return customShapeView
    }
}
