//
//  CategoryVC.swift
//  deplov_studio_testapp
//
//  Created by Vladimir Gorbunov on 05.10.2021.
//

import UIKit

class CategoryVC: UIViewController {
    
    let testData = [
        Product(category: "Молоко", name: "Парное молоко"),
        Product(category: "Молоко", name: "Сырое молоко"),
        Product(category: "Мясо", name: "Свинина"),
        Product(category: "Мясо", name: "Говядина"),
        Product(category: "Мясо", name: "Баранина"),
        Product(category: "Овощи", name: "Картофель"),
        Product(category: "Овощи", name: "Капуста"),
        Product(category: "Овощи", name: "Морковь"),
        Product(category: "Фрукты", name: "Бананы"),
        Product(category: "Фрукты", name: "Яблоки"),
        Product(category: "Фрукты", name: "Виноград"),
        Product(category: "Вода", name: "Минеральная вода"),
        Product(category: "Вода", name: "Вода без газа"),
        Product(category: "Вода", name: "BonAquaс газированная")]
    
    var categoryList: [String] {
        var list: [String] = []
        for element in testData {
            if !list.contains(element.category) {
                list.append(element.category)
            }
        }
        return Array(list)
    }
    
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
        
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Products") as! ProductVC
        
        var products: [Product] {
            var list: [Product] = []
            for element in testData {
                if element.category == tableView.cellForRow(at: indexPath)?.textLabel?.text {
                    list.append(element)
                }
            }
            return list
        }
        
        viewController.products = products
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
