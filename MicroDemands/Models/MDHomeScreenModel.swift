//
//  MDHomeScreenModel.swift
//  MicroDemands
//
//  Created by ldt on 23/09/22.
//

import UIKit

class MDHomeScreenModel: NSObject {
    
    var title : String?
    var main : [MDHomeScreenModel]?
    var section : [MDHomeScreenModel]?
    var image : String?
    var imageTitle : String?
    override init()
    {
        self.title = ""
        self.main = []
        self.section = []
        self.image = ""
        self.imageTitle = ""
        
    }
    
    class func getTableData() -> [MDHomeScreenModel]
    {
        let appDictionary = self.mainData()
        var dataArray : [MDHomeScreenModel] = []
        for index in 0..<appDictionary.count
        {
            let appDict = appDictionary[index]
            let model :MDHomeScreenModel = MDHomeScreenModel()
            model.title = appDict["title"] as? String ?? ""
            let arrayDic = appDict["Array"] as? NSArray ?? []
            model.section = MDHomeScreenModel.getAppsArrayData(arrayDic)
            dataArray.append(model)
        }
        return dataArray
    }
    
    class func getAppsArrayData(_ appsArr : NSArray) -> [MDHomeScreenModel]{
        var dataArray: [MDHomeScreenModel] = []
        appsArr.enumerateObjects { object, indx, pointer in
            let dict = appsArr.object(at: indx) as? NSDictionary ?? [:]
            let model: MDHomeScreenModel = MDHomeScreenModel()
            model.image = dict.value(forKey: "image") as? String ?? ""
            model.imageTitle = dict.value(forKey: "imageTitle")as? String ?? ""
            dataArray.append(model)
        }
        return dataArray
        
        }
    
    
    class func mainData() -> [[String: Any]]
    {
        let appArray : [[String: Any]] =
        [[
          "Array"  : [
                [ "image":"Restaurant"],
                [ "image":"Salon"],
                [ "image":"Taxi"],
                [ "image":"Grocery"]
            ]
         ], [ "title": "All Services",
              "Array"  : [
                [ "image":"RestaurantOne",
                  "imageTitle":"Restaurant"],
                [ "image":"GroceryOne",
                  "imageTitle":"Grocery"],
                [ "image":"FoodDeliveryOne",
                  "imageTitle":"Food Delivery"],
                [ "image":"TaxiOne",
                  "imageTitle":"Taxi"
                ],
                [ "image":"SalonOne",
                  "imageTitle":"Salon"],
                [ "image":"PlumberOne",
                  "imageTitle":"Plumber"
                ]
              ]
            ],
         [
           "Array"  : [
                 [ "image":"FreeDelivery"]
                 ]
           ]
        ]
        return appArray
    }
}
