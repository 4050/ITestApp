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

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var responseDrinkModel = ResponseDrinkModel()
    private var categoryList = [Category]()
    private var selectCategoryList = [Category]()
    
    var delegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
        getCategories()
    }
    
    @IBAction func didTapApplyButton(_ sender: UIButton) {
        delegate?.categoryDidChanged(categories: selectCategoryList)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.allowsMultipleSelection = true
        tableView.register(UINib(nibName: Constants.categoryTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.categoryTableViewCell)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Filter"
    }
    
    private func getCategories() {
        responseDrinkModel.getCategoryDrink(urlString: Constants.url, completion: {[weak self] (searchResults) in
            self?.categoryList.append(contentsOf: searchResults!.drinks)
            self?.categoryList = searchResults!.drinks
            self?.tableView.reloadData()
            self?.selectCategoryList = self!.categoryList.map {$0}
        })
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
        let category = categoryList[indexPath.row]
        cell.selectionStyle = .none
        cell.categoryNameLabel.text = category.strCategory
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else { return }
        if cell.categoryCheckmark.isHidden {
            cell.categoryCheckmark.isHidden = false
            selectCategoryList.append(categoryList[indexPath.row])
        } else {
            cell.categoryCheckmark.isHidden = true
            selectCategoryList.removeAll { $0 == categoryList[indexPath.row] }
        }
        tableView.reloadData()
    }
}
