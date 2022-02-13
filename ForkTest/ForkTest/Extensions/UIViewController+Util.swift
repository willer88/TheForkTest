//
//  UIViewController+Util.swift
//  ForkTest
//
//  Created by Wilmar on 12/02/22.
//

import UIKit
import AVFoundation

extension UIViewController {
    
    func showErrorMessage(message: String, completion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion.map { $0() }
        }))
        present(alertController, animated: true, completion: nil)
    }
}
