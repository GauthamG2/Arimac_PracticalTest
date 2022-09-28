//
//  Extension.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImageWithUrl(_ urlString: String, placeholderImage: UIImage = UIImage()) {
        if let url = URL(string: urlString) {
            self.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
    
    // If you need to find the size of an aspect fit image inside its image view
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

// MARK: - UIView
extension UIView {
    func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UIViewController {
    
    func presentAlert(title: String, message: String, buttonTitle: String, action: ((_ alertAction: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: action)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
