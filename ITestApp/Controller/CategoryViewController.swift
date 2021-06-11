//
//  CategoryTableViewController.swift
//  ITestApp
//
//  Created by Stanislav on 10.06.2021.
//

import UIKit


protocol CategoryViewControllerDelegate {
    func categoryDidChanged(categories: [Category])
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var responseDrinkModel = ResponseDrinkModel()
    var categoryList = [Category]()
    var selectCategoryList = [Category]()
    
    var delegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.allowsMultipleSelection = true
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        navigationItem.title = "Filter"
        getCategory()
        
    }
    
    @IBAction func didTapApplyButton(_ sender: UIButton) {
        delegate?.categoryDidChanged(categories: selectCategoryList)
        print(selectCategoryList)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        let category = categoryList[indexPath.row]
        cell.categoryCheckmark.isHidden = true
        cell.selectionStyle = .none
        cell.categoryNameLabel.text = category.strCategory
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else { return }
        selectCategoryList.append(categoryList[indexPath.row])
        cell.categoryCheckmark.isHidden = false
        
    }
    
    func getCategory() {
        responseDrinkModel.getCategoryDrink(urlString: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list", completion: {[weak self] (searchResults) in
            self?.categoryList.append(contentsOf: searchResults!.drinks)
            self?.categoryList = searchResults!.drinks
            self?.tableView.reloadData()
        })
    }
}
