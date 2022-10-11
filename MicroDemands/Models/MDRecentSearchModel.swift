import UIKit

class MDRecentSearchModel: NSObject {
    var image : String?
    var imageTitle : String?
    
    override init()
    {
        self.image = ""
        self.imageTitle = ""
    }
    
    class func getRecentSearchData() -> [MDRecentSearchModel]
    {
        let arrayJson:[[String: Any]] = self.RecentSearchData()
        var dataArray:[MDRecentSearchModel] = []
        for index in 0..<arrayJson.count {
            let model = MDRecentSearchModel()
            let dictionary = arrayJson[index]
            model.image                         =     dictionary["image"] as? String ?? ""
            model.imageTitle                    =     dictionary["imageTitle"] as? String ?? ""
            dataArray.append(model)
        }
            return dataArray
    }
    class func RecentSearchData() -> [[String: Any]]
    {
        let jsonData: [[String: Any]] =
        [
            [
                "image": "search",
                "imageTitle": "Subway"
              ],
              [
                "image": "search",
                "imageTitle": "Burger"
              ],
            [
                "image": "search",
                "imageTitle": "Sandwich"
            ],
            [
                "image": "search",
                "imageTitle": "Pizza"
            ],
            [
                "image": "search",
                "imageTitle": "FriedRice"
            ],
            [
                "image": "search",
                "imageTitle": "Bakery"
            ]
            ]
        return jsonData
    }
}
