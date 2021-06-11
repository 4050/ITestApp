//
//  ViewController.swift
//  ITestApp
//
//  Created by Stanislav on 08.06.2021.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    var responseDrinkModel = ResponseDrinkModel()
    var categoryList = [Category]()
    var drinkList = [Drink]()
    var data:[(key:Category, values:[Drink])] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.topItem?.title = "Drinks"
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        requestFisrtData()
    }
    
    @IBAction func didPressFilterButton(_ sender: Any) {
        guard let categoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else { return }
        categoryViewController.delegate = self
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell", for: indexPath) as! CocktailTableViewCell
        let drinks = data[indexPath.section].values[indexPath.row]
        cell.cocktailNameLabel.text = drinks.strDrink
        setImageToImageView(cell: cell, urlString: drinks.strDrinkThumb)
        return cell
    }
    
    func requestFisrtData() {
        responseDrinkModel.getCategoryDrink(urlString: Constants.url, completion: { (searchResults) in
            self.categoryList = searchResults!.drinks
            DispatchQueue.main.async {
                for category in self.categoryList {
                    let url: String = StringPicker.searchString(category.strCategory)
                    self.responseDrinkModel.getDrink(urlString: url, completion: { [self](searchResults) in
                        self.drinkList.append(contentsOf: searchResults!.drinks)
                        data.append((Category(strCategory:category.strCategory), searchResults!.drinks))
                        self.tableView.reloadData()
                    })
                }
            }
            
        })
    }
    
    func requestFilteringData() {
        print(categoryList)
        DispatchQueue.main.async {
            for category in self.categoryList {
                let url: String = StringPicker.searchString(category.strCategory)
                self.responseDrinkModel.getDrink(urlString: url, completion: {(searchResults) in
                    self.drinkList.append(contentsOf: searchResults!.drinks)
                    self.data.append((Category(strCategory:category.strCategory), searchResults!.drinks))
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func setImageToImageView(cell: CocktailTableViewCell, urlString: String) {
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
}

extension DrinkTableViewController: CategoryViewControllerDelegate {
    func categoryDidChanged(categories: [Category]) {
        data.removeAll()
        categoryList.removeAll()
        self.categoryList = categories
        requestFilteringData()
    }
    
}


