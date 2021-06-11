//
//  CategoryTableViewCell.swift
//  ITestApp
//
//  Created by Stanislav on 10.06.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryCheckmark: UIImageView!
    
    var isCategorySelected: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
