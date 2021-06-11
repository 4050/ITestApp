//
//  CoctailTableViewCell.swift
//  ITestApp
//
//  Created by Stanislav on 09.06.2021.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CocktailTableViewCell {
    func spinnerAnimation(shouldSpin status: Bool) {
         if status == true {
             activityIndicator.isHidden = false
             activityIndicator.startAnimating()
         } else {
             activityIndicator.isHidden = true
             activityIndicator.stopAnimating()
         }
     }
}
