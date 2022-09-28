//
//  NewsDetailViewController.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import UIKit

class NewsDetailViewController: UIViewController {

    // MARK: - Outlets
    
    var vm = NewsDetailViewModel()
    
    // MARK: - Outlets
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var decsriptionContainer: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    // MARK: Configure UI
    
    func configUI() {
        if let url = vm.newsData?.urlToImage {
            bgImage.setImageWithUrl(url)
        }
        
        lblAuthor.text = "by \(vm.newsData?.author)"
        lblDate.text = vm.newsData?.publishedAt
        lblDescription.text = vm.newsData?.description
        lblTitle.text = vm.newsData?.title
        
        decsriptionContainer.layer.cornerRadius = 20
        bottomView.layer.cornerRadius = 20
    }
}
