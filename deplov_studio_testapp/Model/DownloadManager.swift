//
//  DownloadManager.swift
//  deplov_studio_testapp
//
//  Created by Vladimir Gorbunov on 05.10.2021.
//

import Foundation
import UIKit

protocol DownloadManagerDelegate {
    func imageDidDownload (result: Result<UIImage, Error>)
}

class DownloadManager {
    
    var delegate: DownloadManagerDelegate?
    
    func getImage() {
        
        let site = "https://loremflickr.com/400/400/food"
        guard let url = URL(string: site) else { return }
        
        let newTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                self?.delegate?.imageDidDownload(result: .failure(error!))
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                self?.delegate?.imageDidDownload(result: .success(image))
            }
        }
        newTask.resume()
    }
}
