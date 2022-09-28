//
//  TopNewsCollectionViewCell.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import UIKit

class TopNewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    
    // MARK: - Configure Cell
    
    func configCell(with model: TopNewsArticles) {
        
        containerView.layer.cornerRadius = 10
        bgImage.layer.cornerRadius = 10
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            if let url = model.urlToImage {
                self.bgImage.setImageWithUrl(url)
            }
            self.lblAuthor.text = model.author
            self.lblHeading.text = model.title
        }
    }
}
