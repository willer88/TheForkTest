//
//  UIImageView+URL.swift
//  ForkTest
//
//  Created by Wilmar on 12/02/22.
//

import UIKit

extension UIImageView {

    func image(fromURL url: String) {
        self.image = nil
        
        let resourceURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: resourceURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.image = nil
                    return
                }
                
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
