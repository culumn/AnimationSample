//
//  TableViewController.swift
//  AnimationSample
//
//  Created by Matsuoka Yoshiteru on 2018/04/02.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell",
                                                 for: indexPath)
        cell.textLabel?.text = String(describing: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let firstCell = tableView.visibleCells.first,
            let firstIndex = tableView.indexPath(for: firstCell),
            let lastCell = tableView.visibleCells.last,
            let lastIndex = tableView.indexPath(for: lastCell)
            else { return }

        let translationX = cell.bounds.width / 6
        let translationY: CGFloat = {
            if indexPath.row > lastIndex.row {
                return cell.bounds.height / 2
            } else if indexPath.row < firstIndex.row {
                return cell.bounds.height / -2
            }
            return 0
        }()

        cell.transform = CGAffineTransform(translationX: translationX,
                                           y: translationY)
        cell.alpha = 0.0

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: [.preferredFramesPerSecond60,
                                 .curveEaseOut],
                       animations: {
                        cell.transform = CGAffineTransform.identity
                        cell.alpha = 1.0
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) else { preconditionFailure() }
        UIView.animate(withDuration: 0.15) {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        return true
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { preconditionFailure() }
        UIView.animate(withDuration: 0.15) {
            cell.transform = CGAffineTransform.identity
        }
    }
}
