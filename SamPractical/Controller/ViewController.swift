//
//  ViewController.swift
//  SamPractical
//
//  Created by nikunj sareriya on 03/05/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            self.tblView.delegate = self
            self.tblView.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.startAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if Common.networkAvailability() {
            self.setDataIntoDataModel()
        } else {
            Common.showAlert(title: "You're offline", message: "Please turn on your internet")
        }
        // Do any additional setup after loading the view.
    }

    // MARK: - Custom method
    func reloadTableviewData() {
        if let productData = DataModel.sharedInstance.getProductData() as? [ProductDetail] {
            arrProductModel.removeAll()
            for userDatum in productData {
                if let name = userDatum.name, let imgData = userDatum.image, let desc = userDatum.desc {
                    arrProductModel.append(ProductDataModel(name: name, image: imgData, desc: desc))
                }
            }
            self.setDataIntoGivenStrutcure()
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    func setDataIntoGivenStrutcure() {
        var j = 0
        for i in 0..<Int(Double(arrProductModel.count)/1.5) {
            arrArrProductModel.append([])
            if i == 0 || i == 1 {
                arrArrProductModel[i].append(arrProductModel[j])
                j += 1
            }
            if i == 1 {
                arrArrProductModel[i].append(arrProductModel[j])
                j += 1
            }
            if arrArrProductModel[i].isEmpty {
                if (j % 3 == 0){
                    arrArrProductModel[i].append(arrProductModel[j])
                    j += 1
                }
            }
            if arrArrProductModel[i].isEmpty {
                arrArrProductModel[i].append(arrProductModel[j])
                j += 1
                arrArrProductModel[i].append(arrProductModel[j])
                j += 1
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArrProductModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - Homeview call api method
extension ViewController {
    func setDataIntoDataModel() {
        self.activityIndicator.isHidden = false
        if let isDeleted = DataModel.sharedInstance.deleteUserDetails() as? Bool, isDeleted {
            arrProductModel.removeAll()
            arrArrProductModel.removeAll()
            Common.delay(delay: 0.5) {
                self.callAPIForProducts { isSuccess in
                    if isSuccess {
                        print(isSuccess)
                        for product in arrProductModel {
                            DataModel.sharedInstance.setProductData(productData: product)
                        }
                        self.reloadTableviewData()
                        self.activityIndicator.isHidden = true
                    }
                }
            }
        }
    }
    
    func callAPIForProducts(completionHandler: @escaping (Bool) -> Void) {
        if Common.networkAvailability() {
            ApiManager.callRequest(user_api, withParameters: [:], header: [:], requestTimeOut: 60) { result in
                if let data = result as? [[String: Any]] {
                    print(data)
                    if data.count > 0 {
                        for user in data {
                            if let desc = user["ShortDescription"] as? String, let name = user["Name"] as? String {
                                if let dic = user["ProductPictures"] as? [[String: Any]], dic.count > 0 {
                                    if let dicimg = dic[0] as? [String: Any], let imgUrl = dicimg["PictureUrl"] as? String {
                                        arrProductModel.append(ProductDataModel(name: name, image: imgUrl, desc: desc))
                                    }
                                }
                                
                            }
                        }
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                } else {
                    completionHandler(false)
                }
            } failure: { error in
                print(error.localizedDescription)
                completionHandler(false)
            }
        } else {
            Common.showAlert(title: "You're offline", message: "Please turn on your internet")
        }
    }
}

