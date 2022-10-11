//
//  MDSingleRestaurantModel.swift
//  MicroDemands
//
//  Created by ldt on 28/09/22.
//

import UIKit

class MDRestaurantModel: NSObject {
    
    var title : String?
    var main : [MDRestaurantModel]
    var section : [MDRestaurantModel]
    //SectionData
    var imageRestaurant : String?
    var restaurantTitleMain : String?
    var imageSubTitle : String?
    var subTitleOne : String?
    var subTitleTwo : String?
    var subTitleThree : String?
    
    
   override init(){
       self.title =  ""
       self.main =  []
       self.section =  []

    //SectionData
       self.imageRestaurant =  ""
       self.restaurantTitleMain =  ""
       self.imageSubTitle =  ""
       self.subTitleOne =  ""
       self.subTitleTwo =  ""
       self.subTitleThree =  ""
       
    }
    class func getTableData() -> [MDRestaurantModel]
    {
        let appDictionary = self.mainData()
        var dataArray : [MDRestaurantModel] = []
        for index in 0..<appDictionary.count
        {
            let appDict = appDictionary[index]
            let model :MDRestaurantModel = MDRestaurantModel()
            model.title = appDict["title"] as? String ?? ""
            let arrayDic = appDict["Array"] as? NSArray ?? []
            model.section = MDRestaurantModel.getAppsArrayData(arrayDic)
            dataArray.append(model)
        }
        return dataArray
    }
    
    class func getAppsArrayData(_ appsArr : NSArray) -> [MDRestaurantModel]{
        var dataArray: [MDRestaurantModel] = []
        appsArr.enumerateObjects { object, index, pointer in
            let dict = appsArr.object(at: index) as? NSDictionary ?? [:]
            let model: MDRestaurantModel = MDRestaurantModel()
            model.imageRestaurant = dict.value(forKey: "imageRestaurant") as? String ?? ""
            model.restaurantTitleMain = dict.value(forKey: "restaurantTitleMain")as? String ?? ""
            model.imageSubTitle = dict.value(forKey: "imageSubTitle")as? String ?? ""
            model.subTitleOne = dict.value(forKey: "subTitleOne")as? String ?? ""
            model.subTitleTwo = dict.value(forKey: "subTitleTwo")as? String ?? ""
            model.subTitleThree = dict.value(forKey: "subTitleThree")as? String ?? ""
            
            dataArray.append(model)
        }
        return dataArray
        }
    
    class func mainData() -> [[String : Any]]
    {
        let appArray : [[String: Any]] =
        [
            [
              "Array"  : [
                    [ "imageRestaurant":"Restaurant"],
                    [ "imageRestaurant":"Salon"],
                    [ "imageRestaurant":"Taxi"],
                    [ "imageRestaurant":"Grocery"]
                ]
             ],
    
          [ "title": "Featured Partners",
              "Array"  : [
                [ "imageRestaurant":"FeaturedPartner",
                  "restaurantTitleMain":"Krispy Creme",
                  "imageSubTitle" : "St Georgece Terrace, Perth",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"
                ],
                [ "imageRestaurant":"FeaturedPartner",
                  "restaurantTitleMain":"Mario Italiano",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"],
                [ "imageRestaurant":"FeaturedPartner",
                  "restaurantTitleMain":"Food Delivery",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"],
                [ "imageRestaurant":"FeaturedPartner",
                  "restaurantTitleMain":"Taxi",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"
                ]
              ]
            ],
            ["title" : "",
              "Array"  : [
                    [ "imageRestaurant":"FreeDelivery"]
                    ]
              ],
         [ "title": "Best Picks Restaurants by Team",
              "Array"  : [
                [ "imageRestaurant":"BestPicksTwo",
                  "restaurantTitleMain" : "Cafe Brichor’s",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"],
                [ "imageRestaurant":"BestPicksTwo",
                  "restaurantTitleMain":"Mario Italiano",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"],
                [ "imageRestaurant":"BestPicksTwo",
                  "restaurantTitleMain" : "Cafe Brichor’s",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"],
                [ "imageRestaurant":"BestPicksTwo",
                  "restaurantTitleMain":"Mario Italiano",
                  "imageSubTitle" : "Hay street , Perth City",
                  "subTitleOne" : "4.5",
                  "subTitleTwo" : "25min",
                  "subTitleThree" : "FreeDelivery"]
              ]
            ],
         [ "title": "All Restaurants",
           "Array"  : [
                 [ "imageRestaurant":"AllRestaurants",
                   "restaurantTitleMain" : "Cafe Brichor’s",
                   "subTitleOne" : ". Chinese",
                   "subTitleTwo" : ". American",
                   "subTitleThree" : ".DesiFood"
                 ]
                 ]
           ]
        ]
        return appArray
    }
}
