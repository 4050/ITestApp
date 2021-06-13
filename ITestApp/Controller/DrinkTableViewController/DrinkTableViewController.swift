//
//  ViewController.swift
//  ITestApp
//
//  Created by Stanislav on 08.06.2021.
//

import UIKit

enum RequestData {
    case requestDrinksData, requestCategoriesData
}

class DrinkTableViewController: UITableViewController {
    
    var responseDrinkModel = ResponseDrinkModel()
    var categoryList = [Category]()
    var drinkList = [Drink]()
    var data: [(key: Category, values: [Drink])] = []
    var isLoading: Bool = false
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
        requestData(index: count, dataSwitch: .requestCategoriesData)
    }
    
    @IBAction func didPressFilterButton(_ sender: Any) {
        guard let categoryViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.categoryTableViewController) as? CategoryViewController else { return }
        categoryViewController.delegate = self
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cocktailTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.cocktailTableViewCell)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Drinks"
    }
    
    private func requestData(index: Int, dataSwitch: RequestData) {
        switch dataSwitch {
        case .requestCategoriesData:
            responseDrinkModel.getCategoryDrink(urlString: Constants.url, completion: {[self] (searchResults) in
                self.categoryList = searchResults!.drinks
                requestData(index: index, dataSwitch: .requestDrinksData)
            })
            
        case .requestDrinksData:
            if index != categoryList.count {
                let url: String = StringPicker.searchString(self.categoryList[index].strCategory)
                self.responseDrinkModel.getDrink(urlString: url, completion: {[self] (searchResults) in
                    self.drinkList.append(contentsOf: searchResults!.drinks)
                    self.data.append((Category(strCategory: self.categoryList[index].strCategory), searchResults!.drinks))
                    self.isLoading = true
                    self.tableView.reloadData()
                })
            } else {
                print("Loading stop")
            }
        }
    }
    
    private func setImageToImageView(cell: CocktailTableViewCell, urlString: String) {
        cell.cocktailImageView.isHidden = true
        cell.spinnerAnimation(shouldSpin: true)
        responseDrinkModel.downloadImage(url: urlString) { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    cell.cocktailImageView.image = UIImage(data: data)
                    cell.spinnerAnimation(shouldSpin: false)
                    cell.cocktailImageView.isHidden = false
                }
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if isLoading {
                isLoading = false
                count += 1
                requestData(index: count, dataSwitch: .requestDrinksData)
            }
        }
    }
}

extension DrinkTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].key.strCategory
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cocktailTableViewCell, for: indexPath) as! CocktailTableViewCell
        let drinks = data[indexPath.section].values[indexPath.row]
        cell.cocktailNameLabel.text = drinks.strDrink
        cell.selectionStyle = .none
        setImageToImageView(cell: cell, urlString: drinks.strDrinkThumb)
        return cell
    }
}

extension DrinkTableViewController: CategoryViewControllerDelegate {
    func categoryDidChanged(categories: [Category]) {
        count = 0
        data.removeAll()
        categoryList.removeAll()
        self.categoryList = categories
        requestData(index: count, dataSwitch: .requestDrinksData)
    }
}


