//
//  SplashViewController.swift
//  DiscourseClient
//
//  Created by Javier Laguna on 24/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: Variables
    lazy var ehLabel: UILabel = {
        let ehLabel = UILabel()
        ehLabel.translatesAutoresizingMaskIntoConstraints = false
        ehLabel.text = "eh"
        ehLabel.font = .logo
        ehLabel.textColor = .white
        return ehLabel
    }()
    
    lazy var ohLabel: UILabel = {
        let ohLabel = UILabel()
        ohLabel.translatesAutoresizingMaskIntoConstraints = false
        ohLabel.text = "oh"
        ohLabel.font = .logo
        ohLabel.textColor = .white
        return ohLabel
    }()
    
    lazy var logoImage: UIImageView = {
        let logoImage = UIImageView(frame: CGRect(x: view.center.x - 50, y: 0, width: 100, height: 85))
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "logoSmall")
        return logoImage
    }()
    
    var animator: UIDynamicAnimator?
    
    typealias SplashDidFinish = () -> Void
    var splashDidFinish: SplashDidFinish?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        addViewItems()
        startAnimation()
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
    
    private func addViewItems() {
        
        view.addSubview(ehLabel)
        NSLayoutConstraint.activate([
            ehLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ehLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
        
        view.addSubview(ohLabel)
        NSLayoutConstraint.activate([
            ohLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ohLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    private func startAnimation() {
        view.addSubview(logoImage)
        
        animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [logoImage])
        animator?.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [logoImage])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        let barrier = UIView(frame: CGRect(x: 16, y: view.frame.midY + 50, width: view.frame.width - 32, height: 8))
        barrier.backgroundColor = .white
        view.addSubview(barrier)
                let rightEdge = CGPoint(x: barrier.frame.maxX, y: barrier.frame.maxY)
                collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, from: barrier.frame.origin, to: rightEdge)
        
        animator?.addBehavior(collisionBehavior)
        animator?.delegate = self
    }
}

extension SplashViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        splashDidFinish?()
    }
}
