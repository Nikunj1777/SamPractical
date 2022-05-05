//
//  ProductDataModel.swift
//  SamPractical
//
//  Created by nikunj sareriya on 04/05/22.
//

import Foundation

class ProductDataModel {
    var name: String
    var image: String
    var desc: String
    init(name: String, image: String, desc: String) {
        self.name = name
        self.image = image
        self.desc = desc
    }
}
