//
//  NewsTableViewCell.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgImage      : UIImageView!
    @IBOutlet weak var lblHeading   : UILabel!
    @IBOutlet weak var lblAuthor    : UILabel!
    @IBOutlet weak var lblDate      : UILabel!
    
    // MARK: - Configure Cell
    
    func configCell(with model: Articles) {
        if let url = model.urlToImage {
            bgImage.setImageWithUrl(url)
        }
        lblHeading.text = model.title
        lblAuthor.text = model.author
        lblDate.text = model.publishedAt
        
        containerView.layer.cornerRadius = 10
        bgImage.layer.cornerRadius = 10
    }
}
