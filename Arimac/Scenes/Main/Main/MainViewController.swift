//
//  MainViewController.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, LoadingIndicatorDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: - Variables
    
    let vm = MainViewModel()
    private let bag = DisposeBag()
    private let cellIdentifier = "NewsTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTF             : UITextField! {
        didSet {
            searchTF.delegate = self
        }
    }
    @IBOutlet weak var topNewsCollectionView: UICollectionView! {
        didSet {
            topNewsCollectionView.delegate = self
            topNewsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var newsTableView        : UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews()
        loadTopNews()
        
        self.setDelegatesForTextEditors(tfs: [searchTF])
    }
    
    func loadNews() {
        self.startLoading()
        vm.getNews(completion: {success, code, message, data in
            self.stopLoading()
            if success {
                self.newsTableView.reloadData()
            } else {
                
            }
        })
    }
    
    func loadTopNews() {
        self.startLoading()
        vm.getTopNews(completion: {success, code, message, data in
            self.stopLoading()
            if success {
                self.topNewsCollectionView.reloadData()
            } else {
                
            }
        })
    }
    
    // MARK: - Text Editor Delegate
    
    func setDelegatesForTextEditors(tfs: [UITextField] = [], tvs: [UITextView] = []) {
        tfs.forEach({ tf in
            tf.delegate = self
        })
        
        tvs.forEach({ tv in
            tv.delegate = self
        })
    }
    
    // MARK: - Search Fuction
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filterText(text+string)
        }
        return true
    }
    
    func filterText(_ query: String) {
        if query.isEmpty {
            vm.filteredData.removeAll()
        } else {
            for string in vm.newsList.value {
                if let _title = string.title {
                    if _title.lowercased().starts(with: query.lowercased()){
                        vm.filteredData.append(string)
                    } else {
                        vm.newsList.value.removeAll()
                    }
                }
            }
        }
        newsTableView.reloadData()
    }
    
    
    @IBAction func didEditingChanged(_ sender: Any) {
        if searchTF.text!.isEmpty {
            vm.filteredData.removeAll()
            loadNews()
            newsTableView.reloadData()
        } else {
            if let text = searchTF.text {
                filterText(text)
            }
        }
    }
    
    
    // MARK: - Observers
    
    func addObservers() {
        searchTF.rx.controlEvent([.editingDidBegin])
            .subscribe(onNext: { _ in
                if self.searchTF.text == "Search" {
                    self.searchTF.text = ""
                    self.searchTF.textColor = .white
                }
            })
            .disposed(by: bag)
        
        searchTF.rx.controlEvent([.editingDidEnd])
            .subscribe(onNext: { _ in
                if self.searchTF.text!.isEmpty {
                    self.searchTF.text = "Search"
                    self.searchTF.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
                }
            })
            .disposed(by: bag)
    }
}

// MARK: - Collection View

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.topNewsList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TopNewsCollectionViewCell = topNewsCollectionView.dequeueReusableCell(withReuseIdentifier: "TopNewsCollectionViewCell", for: indexPath) as! TopNewsCollectionViewCell
        cell.configCell(with: vm.topNewsList.value[indexPath.row])
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = topNewsCollectionView.frame.width - 10
        let height = topNewsCollectionView.frame.height - 10
        return CGSize(width: width, height: height)
    }
}

// MARK: - Table View

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !vm.filteredData.isEmpty {
            return vm.filteredData.count
        } else {
            return vm.newsList.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !vm.filteredData.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            cell.configCell(with: vm.filteredData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            cell.configCell(with: vm.newsList.value[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !vm.filteredData.isEmpty {
            ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .NewsDetailViewController, from: self, data: vm.filteredData[indexPath.row])
        } else {
            ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .NewsDetailViewController, from: self, data: vm.newsList.value[indexPath.row])
        }
        
    }
    
}

