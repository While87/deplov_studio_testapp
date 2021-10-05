//
//  DetailsVC.swift
//  deplov_studio_testapp
//
//  Created by Vladimir Gorbunov on 05.10.2021.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var product: Product?
    let downloadManager = DownloadManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadManager.delegate = self
        downloadManager.getImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryTitle.text = product?.category
        productTitle.text = product?.name
    }
}

//MARK: - DownloadManager delegate methods
extension DetailsVC: DownloadManagerDelegate {
    func imageDidDownload(result: Result<UIImage, Error>) {
        activityIndicator.stopAnimating()
        
        switch result {
        case .success(let image):
            imageView.image = image
        case .failure(let error): showAlert(message: error.localizedDescription)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Печалька", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
