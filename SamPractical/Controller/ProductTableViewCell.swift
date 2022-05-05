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
    
    func setData(row: Int) {
        if row == 0 {
            if let url = URL(string: arrArrProductModel[row][0].image) {
                self.imgFirst.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
            }
            self.lblFirstTitle.text = arrArrProductModel[row][0].name
            self.lblFirstDesc.text  = arrArrProductModel[row][0].desc
            self.lblFirstDesc.sizeToFit()
            self.imgStackView.isHidden = true
            self.imgFirst.isHidden = false
        } else if (row % 2 == 0) {
            if let url = URL(string: arrArrProductModel[row][0].image) {
                self.imgFirst.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
            }
            self.lblFirstTitle.text = arrArrProductModel[row][0].name
            self.lblFirstDesc.text  = arrArrProductModel[row][0].desc
            self.lblFirstDesc.sizeToFit()
            self.imgStackView.isHidden = true
            self.imgFirst.isHidden = false
            print("First All Time:- \(arrArrProductModel[row][0].image)")
        } else {
            if let url = URL(string: arrArrProductModel[row][0].image) {
                self.imgSecond.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
            }
            if let url = URL(string: arrArrProductModel[row][1].image) {
                self.imgThird.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
            }
            self.lblSecondTitle.text = arrArrProductModel[row][0].name
            self.lblThirdTitle.text = arrArrProductModel[row][1].name
            print(arrArrProductModel[row][0].image)
            print(arrArrProductModel[row][1].image)
            self.imgFirst.isHidden = true
            self.imgStackView.isHidden = false
            self.lblFirstTitle.isHidden = true
            self.lblFirstDesc.isHidden = true
        }
    }
}
