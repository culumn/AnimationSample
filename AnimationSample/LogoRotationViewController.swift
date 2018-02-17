//
//  LogoViewController.swift
//  AnimationSample
//
//  Created by Matsuoka Yoshiteru on 2018/02/17.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

final class LogoRotationViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapButton(_ sender: UIButton, forEvent event: UIEvent) {
        guard logoImageView.layer.animation(forKey: "animation") == nil else {
            logoImageView.layer.removeAnimation(forKey: "animation")
            button.setTitle("Start", for: .normal)
            return
        }

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .greatestFiniteMagnitude
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat.pi * 2.0

        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.2
        scaleAnimation.damping = 6.0
        scaleAnimation.initialVelocity = 40.0
        scaleAnimation.stiffness = 80.0

        animationGroup.animations = [rotationAnimation, scaleAnimation]
        logoImageView.layer.add(animationGroup, forKey: "animation")
        button.setTitle("Finish", for: .normal)
    }
}
