
import UIKit

class MDSearchPageModels: NSObject {

    var title : String?
    var main : [MDSearchPageModels]
    var section : [MDSearchPageModels]
    var image : String?
    var imageTitle : String?
    var imageSubTitle : String?
    
    
    override init() {
        self.title = ""
        self.main = []
        self.section = []
        self.image = ""
        self.imageTitle = ""
        self.imageSubTitle = ""
    }
    class func getSearchData() -> [MDSearchPageModels]
    {
        let dictionary = self.mainSearchData()
        var dataArray : [MDSearchPageModels] = []
        for index in 0..<dictionary.count
        {
            let subDict = dictionary[index]
            let model : MDSearchPageModels = MDSearchPageModels()
            model.title = subDict["title"] as? String ?? ""
            let Array = subDict["Array"] as? NSArray ?? []
            model.section = MDSearchPageModels.getSearchArrayData(Array)
            dataArray.append(model)
        }
        return dataArray
    }
    class func getSearchArrayData(_ appArr : NSArray) -> [MDSearchPageModels]
    {
        var dataArray : [MDSearchPageModels] = []
        appArr.enumerateObjects { object, indx, pointer in
            let dict = appArr.object(at: indx) as? NSDictionary ?? [:]
            let model: MDSearchPageModels = MDSearchPageModels()
            model.image = dict.value(forKey: "image") as? String ?? ""
            model.imageTitle = dict.value(forKey: "imageTitle")as? String ?? ""
            model.imageSubTitle = dict.value(forKey: "imageSubTitle")as? String ?? ""
            dataArray.append(model)
        }
        return dataArray
    }
        class func mainSearchData() -> [[String: Any]]
        {
            let appArray : [[String: Any]] =
            [["title": "Top Restaurants",
                  "Array"  : [
                    [ "image":"TheHalalGuys",
                      "imageTitle":"The Halal Guys",
                      "imageSubTitle": "Chinese"],
                    [ "image":"Popeyes",
                      "imageTitle":"Popeyes 1426 Flmst",
                      "imageSubTitle": "Chinese"],
                    [ "image":"Yerba",
                      "imageTitle":"Yerba Buena",
                      "imageSubTitle": "Chinese"],
                    [ "image":"CookieSandwich",
                      "imageTitle":"Cookie Sandwich",
                      "imageSubTitle": "Chinese"],
                    [ "image":"TheHalalGuys",
                      "imageTitle":"The Halal Guys",
                      "imageSubTitle": "Chinese"],
                    [ "image":"Popeyes",
                      "imageTitle":"Popeyes 1426 Flmst",
                      "imageSubTitle": "Chinese"],
                    [ "image":"Yerba",
                      "imageTitle":"Yerba Buena",
                      "imageSubTitle": "Chinese"],
                    [ "image":"CookieSandwich",
                      "imageTitle":"Cookie Sandwich",
                      "imageSubTitle": "Chinese"],
                    [ "image":"TheHalalGuys",
                      "imageTitle":"The Halal Guys",
                      "imageSubTitle": "Chinese"],
                    [ "image":"Popeyes",
                      "imageTitle":"Popeyes 1426 Flmst",
                      "imageSubTitle": "Chinese"]
                  ]
                ]]
            return appArray
        }
}

