//
//  ProductTableViewCell.swift
//  SamPractical
//
//  Created by nikunj sareriya on 03/05/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var lblFirstTitle: UILabel!
    @IBOutlet weak var lblFirstDesc: UILabel!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var lblSecondTitle: UILabel!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var lblThirdTitle: UILabel!
    @IBOutlet weak var imgStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
