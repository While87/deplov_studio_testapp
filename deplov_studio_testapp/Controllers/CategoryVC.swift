//
//  CategoryVC.swift
//  deplov_studio_testapp
//
//  Created by Vladimir Gorbunov on 05.10.2021.
//

import UIKit

class CategoryVC: UIViewController {
      
    let testData = ["Молоко": ["Парное молоко", "Сырое молоко"],
                    "Мясо": ["Свинина", "Говядина", "Баранина"],
                    "Овощи": ["Картофель", "Капуста", "Морковь"],
                    "Фрукты": ["Бананы", "Яблоки", "Виноград"],
                    "Вода": ["Минеральная вода", "Вода без газа", "BonAquaс газированная"]]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - TableView delegate methods
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        cell.textLabel?.text = [String](testData.keys)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Products") as! ProductVC
        
        for (key, value) in testData where key == tableView.cellForRow(at: indexPath)?.textLabel?.text {
            viewController.products = [key: value]
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
