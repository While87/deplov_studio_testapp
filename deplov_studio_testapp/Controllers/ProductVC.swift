//
//  ProductVC.swift
//  deplov_studio_testapp
//
//  Created by Vladimir Gorbunov on 05.10.2021.
//

import UIKit

class ProductVC: UIViewController {
    
    var products: [String: [String]] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - TableView delegate methods
extension ProductVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.first?.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = products.first?.value[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsVC
        
        viewController.productCategory = products.first?.key
        viewController.productName = products.first?.value[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
