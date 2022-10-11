import UIKit
//MARK:  - CollectionCell
class FeaturedCollectionCell : UICollectionViewCell
{
    @IBOutlet weak var backgroundImage: UIImageView?
    @IBOutlet weak var timingImage: UIImageView?
    @IBOutlet weak var priceImage: UIImageView?
    @IBOutlet weak var timingLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var imageTitle: UILabel?
    @IBOutlet weak var imageSubTitleOneLbl: UILabel?
    @IBOutlet weak var imageSubTitleTwoLbl: UILabel?
    //MARK: - AWAKEFROMNIB
    override  func awakeFromNib() {
        self.ratingLabel?.deliveryProperty()
        self.priceLabel?.deliveryProperty()
        self.timingLabel?.deliveryProperty()
        self.priceLabel?.detailProperty()
        self.timingLabel?.detailProperty()
        self.ratingLabel?.rating()
        self.imageTitle?.titleProperty()
        self.imageSubTitleOneLbl?.subTitleProperty()
        self.imageSubTitleTwoLbl?.subTitleProperty()
        self.backgroundImage?.backgroundProperty()
    }
}
//MARK:  - TableCell
class FeaturedTableCell: UITableViewCell
{
    @IBOutlet weak var collectionView: UICollectionView?
    var cCell: [FeaturedPartnerModels] = []
}
//MARK:  - ViewController
class MDFeaturedPartnerVC: UIViewController {
    
    //MARK:  - Variables
    var dataArray : [FeaturedPartnerModels] = []
    //MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView?
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Title
        self.title = "Featured Partners"
        //MARK: - HideNavigationTitle
        hideNavigationTitle()
        //MARK: - HideNavigationButton
        hideNavigationButton()
        //MARK: -ReloadTableData
        self.tableView?.reloadData()
        //MARK: - Passing ModelData
        self.dataArray = FeaturedPartnerModels.getSearchData()
    }
}

//MARK:  - Extension ViewController
extension MDFeaturedPartnerVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray.count > 0) ? self.dataArray.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedTableCell", for: indexPath)as? FeaturedTableCell
        let model = self.dataArray[indexPath.section]
        if(dataArray.count > 0)
        {
            cell?.cCell = model.section
            //ReloadCollectionData
            cell?.collectionView?.reloadData()
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if (self.dataArray.count > 0){
            let model = self.dataArray[indexPath.section]
            if((model.section.count) > 0)
            {
                return CGFloat(((model.section.count) >= 2) ? (model.section.count)*190 : 380)
            }
            else
            {
                return 0
            }
        }
        return 800
    }
}

//MARK: - EXTENSION TABLECELL
extension FeaturedTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cCell.count > 0) ? cCell.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionCell", for: indexPath)as? FeaturedCollectionCell
        let model = self.cCell[indexPath.row]
        cell?.backgroundImage?.image = UIImage(named: model.mainImage ?? "")
        cell?.imageTitle?.text = model.imageTitle ?? ""
        cell?.priceImage?.image = UIImage(named: model.priceImage ?? "")
        cell?.timingImage?.image = UIImage(named: model.timingImage ?? "")
        cell?.timingLabel?.text = model.timing ?? ""
        cell?.priceLabel?.text = model.price ?? ""
        cell?.ratingLabel?.text = model.rating ?? ""
        cell?.timingLabel?.text = model.timing ?? ""
        cell?.imageSubTitleOneLbl?.text = model.imageSubTitleOne ?? ""
        cell?.imageSubTitleTwoLbl?.text = model.imageSubTitleTwo ?? ""
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = ((collectionView.frame.size.width) - space) / 2.0
        return CGSize(width: size, height: 380)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UILabel
{
    func deliveryProperty()
    {
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 12.0)
        self.numberOfLines = 0
        
    }
    func detailProperty()
    {
        self.textAlignment = .left
    }
    func rating()
    {
        self.backgroundColor =  #colorLiteral(red: 0, green: 0.5333333333, blue: 1, alpha: 1)
        self.textAlignment = .center
    }
    func titleProperty()
    {
        self.textColor = #colorLiteral(red: 0.003921568627, green: 0.05882352941, blue: 0.02745098039, alpha: 1)
        self.font = UIFont.systemFont(ofSize: 16.0)
    }
    func subTitleProperty()
    {
        self.textColor = #colorLiteral(red: 0.5254901961, green: 0.5254901961, blue: 0.5254901961, alpha: 1)
        self.font = UIFont.systemFont(ofSize: 15.0)
    }
}
extension UIImageView
{
    func backgroundProperty()
    {
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 10
    }
}

