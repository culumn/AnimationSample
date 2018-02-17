//
//  LogoZoomViewController.swift
//  AnimationSample
//
//  Created by Matsuoka Yoshiteru on 2018/02/17.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

final class LogoZoomViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewFullScreenWidthConstraint: NSLayoutConstraint!

    var isZoomingIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.alpha = 1.0
    }

    @IBAction func didPanLogoImageView(_ sender: UIPanGestureRecognizer) {
        guard isZoomingIn else { return }

        // drag hadling
        let diff = sender.translation(in: view)
        logoImageView.frame.origin.y += diff.y
        sender.setTranslation(.zero, in: view)

        // drop handling
        guard sender.state == .ended else { return }

        if logoImageView.center.y <= view.center.y / 2 {
            UIView.animate(withDuration: 0.3, animations: {
                self.logoImageView.center.y -= self.view.bounds.height
            }, completion: { _ in
                self.logoImageView.alpha = 0.0
                self.logoImageView.center = self.view.center
                self.disableFullScreen()
            })
        } else if logoImageView.center.y >= view.center.y * 1.5 {
            UIView.animate(withDuration: 0.3, animations: {
                self.logoImageView.center.y += self.view.bounds.height
            }, completion: { _ in
                self.logoImageView.alpha = 0.0
                self.logoImageView.center = self.view.center
                self.disableFullScreen()
            })
        } else {
            animateViewToCenter(logoImageView)
        }
    }
}

// MARK: - IBActions
extension LogoZoomViewController {

    @IBAction func didTapLogoImageView(_ sender: UITapGestureRecognizer) {
        if isZoomingIn {
            disableFullScreen()
        } else {
            enableFullScreen()
        }
    }
}

// MARK: - Private functions
extension LogoZoomViewController {

    private func enableFullScreen() {
        logoImageViewWidthConstraint.isActive = false
        logoImageViewFullScreenWidthConstraint.isActive = true
        self.logoImageView.backgroundColor = .white

        UIView.animate(withDuration: 0.5, animations: {
            self.view.backgroundColor = .black
            self.navigationController?.navigationBar.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.isZoomingIn = true
        })
    }

    private func disableFullScreen() {
        logoImageViewWidthConstraint.isActive = true
        logoImageViewFullScreenWidthConstraint.isActive = false

        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            // zoom out
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                self.view.backgroundColor = .white
                self.navigationController?.navigationBar.alpha = 1.0
                self.view.layoutIfNeeded()
            }

            // logo alpha
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.logoImageView.alpha = 1.0
            }
        }) { _ in
            self.isZoomingIn = false
            self.logoImageView.backgroundColor = .clear
        }
    }

    private func animateViewToCenter(_ view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.center = self.view.center
        }
    }
}
