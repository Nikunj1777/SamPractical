//
//  CommonFunction.swift
//  SamPractical
//
//  Created by nikunj sareriya on 03/05/22.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
var arrProductModel = [ProductDataModel]()
var arrArrProductModel = [[ProductDataModel]]()

class Common {
    // MARK: - Alert declaration
    class func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        appDelegate.rootViewController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Set image from string url
    class func setImageFromString(imgString: String) -> UIImage {
        if let url = URL(string: imgString), let data = try? Data(contentsOf: url) as? Data, let img = UIImage(data: data) as? UIImage {
            return img
        } else {
            return UIImage()
        }
    }
    
    class func delay(delay: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(Double(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    // MARK: - Reachability
    class func networkAvailability() -> Bool {
        return  Reachabilitys.internetAvaibility()
    }
    
}

// MARK: - Extension Appdelegate
extension AppDelegate {
    func rootViewController() -> UIViewController {
        return appDelegate.window?.rootViewController ?? UIViewController()
    }
}
