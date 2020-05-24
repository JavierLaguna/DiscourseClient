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
        configureLabels()
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
    
    private func configureLabels() {
        let ehLabel = UILabel()
        ehLabel.translatesAutoresizingMaskIntoConstraints = false
        ehLabel.text = "eh"
        ehLabel.font = .logo
        ehLabel.textColor = .white
        
        view.addSubview(ehLabel)
        NSLayoutConstraint.activate([
            ehLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ehLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
        
        let ohLabel = UILabel()
        ohLabel.translatesAutoresizingMaskIntoConstraints = false
        ohLabel.text = "oh"
        ohLabel.font = .logo
        ohLabel.textColor = .white
        
        view.addSubview(ohLabel)
        NSLayoutConstraint.activate([
            ohLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ohLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        let separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .white
        
        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: ehLabel.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            separatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 8)

        ])
    }
}
