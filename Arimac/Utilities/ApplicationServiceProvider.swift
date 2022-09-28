//
//  ApplicationServiceProvider.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import Foundation

import UIKit

enum Storyboard: String {
    
    case Authentication
    case Main
}

class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    private init() {}
    
    // Push to VieController
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {


        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        if destVc is NewsDetailViewController && data != nil {
            let _vc = storyboard.instantiateViewController(withIdentifier: identifier) as! NewsDetailViewController
            if let _data = data as? Articles {
                _vc.vm.newsData = _data
            }
            vc?.navigationController?.pushViewController(_vc, animated: true)
        }
        
        else {
            vc?.navigationController?.pushViewController(destVc, animated: true)
        }
        
        
    }
    
    // Direct to new Root Window
    public func resetWindow(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("Could not get scene delegate")
        }
        sceneDelegate.window?.rootViewController = topController
    }
}
