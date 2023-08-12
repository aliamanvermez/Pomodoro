//
//  UIViewController+Extension.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.08.2023.
//

import Foundation
import UIKit
extension UIViewController {
    func addBackgroundImageView(to view: UIView, imageName: String) {
        let backgroundImageView = UIImageView(image: UIImage(named: imageName))
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
}
