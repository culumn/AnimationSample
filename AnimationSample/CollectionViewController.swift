//
//  CollectionViewController.swift
//  AnimationSample
//
//  Created by Matsuoka Yoshiteru on 2018/04/02.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.5176470588, green: 0.6392156863, blue: 0.6588235294, alpha: 1)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = min(cell.bounds.width, cell.bounds.height) / 6
        cell.layer.masksToBounds = true
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        cell.alpha = 0

        var delay = 0.0
        if indexPath.row % 3 == 1 {
            delay = 0.1
        } else if indexPath.row % 3 == 2 {
            delay = 0.2
        }

        UIView.animate(withDuration: 0.2,
                       delay: delay,
                       options: [.preferredFramesPerSecond60,
                                 .curveEaseOut],
                       animations: {
                        cell.alpha = 1.0
                        cell.transform = .identity
        })
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 20
        return CGSize(width: width, height: width)
    }
}
