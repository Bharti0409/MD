//
//  FeaturedPartnerModels.swift
//  MicroDemands
//
//  Created by ldt on 06/10/22.
//

import UIKit

class FeaturedPartnerModels: NSObject {
    var main : [FeaturedPartnerModels]
    var section : [FeaturedPartnerModels]
    var mainImage : String?
    var imageTitle : String?
    var imageSubTitleOne : String?
    var imageSubTitleTwo : String?
    var timingImage : String?
    var timing : String?
    var priceImage : String?
    var price : String?
    var rating : String?
    
    override init() {
        self.main = []
        self.section = []
        self.mainImage = ""
        self.imageTitle = ""
        self.imageSubTitleOne = ""
        self.imageSubTitleTwo = ""
        self.timingImage = ""
        self.timing = ""
        self.priceImage = ""
        self.price = ""
        self.rating = ""
    }
    class func getSearchData() -> [FeaturedPartnerModels]
    {
        let dictionary = self.mainSearchData()
        var dataArray : [FeaturedPartnerModels] = []
        for index in 0..<dictionary.count
        {
            let subDict = dictionary[index]
            let model : FeaturedPartnerModels = FeaturedPartnerModels()
            let Array = subDict["Array"] as? NSArray ?? []
            model.section = FeaturedPartnerModels.getSearchArrayData(Array)
            dataArray.append(model)
        }
        return dataArray
    }
    class func getSearchArrayData(_ appArr : NSArray) -> [FeaturedPartnerModels]
    {
        var dataArray : [FeaturedPartnerModels] = []
        appArr.enumerateObjects { object, indx, pointer in
            let dict = appArr.object(at: indx) as? NSDictionary ?? [:]
            let model: FeaturedPartnerModels = FeaturedPartnerModels()
            model.mainImage = dict.value(forKey: "mainImage") as? String ?? ""
            model.imageTitle = dict.value(forKey: "imageTitle")as? String ?? ""
            model.imageSubTitleOne = dict.value(forKey: "SubTitleOne")as? String ?? ""
            model.imageSubTitleTwo = dict.value(forKey: "SubTitleTwo")as? String ?? ""
            model.timingImage = dict.value(forKey: "timingImage")as? String ?? ""
            model.timing = dict.value(forKey: "timing")as? String ?? ""
            model.priceImage = dict.value(forKey: "priceImage")as? String ?? ""
            model.price = dict.value(forKey: "price")as? String ?? ""
            model.rating = dict.value(forKey: "rating")as? String ?? ""
            dataArray.append(model)
        }
        return dataArray
    }
    class func mainSearchData() -> [[String: Any]]
    {
        let appArray : [[String: Any]] =
        [[
            "Array"  : [
                [ "mainImage":"FROne",
                 "imageTitle":"Tacos Nanchas",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"25min",
                 "priceImage":"Dollar",
                 "price":"Free",
                 "rating":"4.5"
        ],
                [ "mainImage":"FRFour",
                 "imageTitle":" McDonald’s",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing": "25min",
                 "priceImage":"Dollar",
                 "price":"Free",
                 "rating":"4.0"
                ],
                [ "mainImage":"FRTwo",
                 "imageTitle":"KFC Foods",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"4.0"
         ],
                [ "mainImage":"FRThree",
                 "imageTitle":"Cafe MayField’s",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"4.5"
         ],
                [ "mainImage":"FROne",
                "imageTitle":"Tacos Nanchas",
                "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"4.0"
         ],
                 ["mainImage":"FRFour",
                 "imageTitle":"McDonald’s",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"4.0"
         ],
                [ "mainImage":"FRTwo",
                 "imageTitle":"KFC Foods",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"5.0"
         ],
                [ "mainImage":"FRThree",
                 "imageTitle":"Cafe MayField’s",
                 "SubTitleOne":"Chinese",
                 "SubTitleTwo":"American",
                 "timingImage":"Time",
                 "timing":"Restaurant",
                 "priceImage":"Dollar",
                 "price":"Taxi",
                 "rating":"4.5"]
        ]]]
        return appArray
    }
}
