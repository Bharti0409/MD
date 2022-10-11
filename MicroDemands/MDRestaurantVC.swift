import UIKit
//MARK: - ResTableCell
class ResTableCell : UITableViewCell
{
    @IBOutlet weak var collectionView : UICollectionView?
    @IBOutlet weak var pageSlider : UIPageControl?
    var cCell : [MDRestaurantModel] = []
    var section : Int? = 0
    var currentPage = 0
    var timer = Timer()
    var counter = 0
    //MARK: - OVERRIDE AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        pageSlider?.numberOfPages = cCell.count
        pageSlider?.currentPage = 0
        //ReloadingData
        DispatchQueue.main.async {
            if(self.section == 0)
            { self.pageController()
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            else
            {
                self.pageSlider?.isHidden = true
            }
        }
    }
    //TimerFunction
    @objc func changeImage()
    {
        if counter < cCell.count{
            let index = IndexPath.init(item: counter, section: 0)
            collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            //To move the dots automatically
            pageSlider?.currentPage = counter
            counter += 1
        }
        else
        {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    //PageController
    func pageController()
    {
        pageSlider?.numberOfPages = cCell.count
        pageSlider?.currentPage = currentPage
        pageSlider?.pageIndicatorTintColor = #colorLiteral(red: 0.5254901961, green: 0.5254901961, blue: 0.5254901961, alpha: 1)
        pageSlider?.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        pageSlider?.clipsToBounds = false
    }
}
//MARK: - ResCollectionCell
class ResCollectionCell : UICollectionViewCell
{
    //ResCollectionCell
    @IBOutlet weak var backgroundImage : UIImageView?
    @IBOutlet weak var mainCellView : UIView?
    @IBOutlet weak var mainImageLabel : UILabel?
    @IBOutlet weak var mainImageSubLabel : UILabel?
    @IBOutlet weak var mainImageSubLabelOne : UILabel?
    @IBOutlet weak var mainImageSubLabelTwo : UILabel?
    @IBOutlet weak var mainImageSubLabelThree : UILabel?
    @IBOutlet weak var mainStackView : UIStackView?
    //NSLayoutConstraints
    @IBOutlet var mainImageLabelConstraint : NSLayoutConstraint?
    @IBOutlet var mainImageSubLblConstraint : NSLayoutConstraint?
    @IBOutlet var mainStackConstraint : NSLayoutConstraint?
    //ResCollectionCell2
    @IBOutlet weak var cellView : UIView?
    @IBOutlet weak var itemImages : UIImageView?
    @IBOutlet weak var itemMainLabel : UILabel?
    @IBOutlet weak var itemSubLabel : UILabel?
    @IBOutlet weak var itemSubLabelOne : UILabel?
    @IBOutlet weak var itemSubLabelTwo : UILabel?
    @IBOutlet weak var itemSubLabelThree : UILabel?
    
}
//MARK: - ViewController
class MDRestaurantVC: UIViewController {
    var dataArray : [MDRestaurantModel] = []
    
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var locationImage : UIImageView?
    @IBOutlet weak var locationTitleLabel : UILabel?
    @IBOutlet weak var searchBarField : UISearchBar?
    @IBOutlet weak var locationResButton : UIButton?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Delivery To"
        //MARK: - SetUpSearchBar
        searchBarField?.setUpSearchBar()
        //MARK: - HideNavigationTitle
        hideNavigationTitle()
        //Reloading
        DispatchQueue.main.async {
            self.dataArray = MDRestaurantModel.getTableData()
            self.tableView?.reloadData()
        }
    }
    @objc func featuredPartners()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MDFeaturedPartnerVC")as? MDFeaturedPartnerVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension MDRestaurantVC : UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray.count > 0) ? self.dataArray.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 50
        case 2:
            return 0
        case 3:
            return 80
        case 4:
            return 80
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return 330
        case 2:
            return 240
        case 3:
            return 330
        case 4:
            return 400
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 80))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.size.width - 130, height: 60))
        
        headerView.addSubview(titleLabel)
        let seeAllButton = UIButton(frame: CGRect(x:headerView.frame.size.width - 80 , y: 10, width: 70, height: 60))
        headerView.addSubview(seeAllButton)
        let model = self.dataArray[section]
        //Title
        let title = model.title ?? ""
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.numberOfLines = 0
        
        //Button
        if (section == 1 || section == 3 || section == 4)
        {
            seeAllButton.setTitle("See All", for: .normal)
            seeAllButton.setTitleColor(#colorLiteral(red: 0, green: 0.5333333333, blue: 1, alpha: 1), for: .normal)
            if(section == 1)
            {
                seeAllButton.addTarget(self, action: #selector(featuredPartners), for: .touchUpInside)
            }
        }
        else
        {
            seeAllButton.isHidden = true
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResTableCell", for: indexPath)as? ResTableCell
        if (self.dataArray.count > 0) {
            switch indexPath.section {
            case 0:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section
                cell?.section = 0
                cell?.collectionView?.reloadData()
                break
            case 1:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section
                cell?.section = 1
                cell?.collectionView?.reloadData()
                cell?.collectionView?.layoutSubviews()
                break
            case 2:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section
                cell?.section = 2
                cell?.collectionView?.reloadData()
            case 3:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section
                cell?.section = 3
                cell?.collectionView?.reloadData()
            case 4:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section
                cell?.section = 4
                cell?.collectionView?.reloadData()
            default:
                break
            }
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    // MARK: - searchBarBeginEditing
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MDRecentSearchDataVC")as? MDRecentSearchDataVC
        self.navigationController?.pushViewController(vc!, animated: true)
        return false
    }
}
// MARK: - CollectionViewDelegateMethods
extension ResTableCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cCell.count > 0 ) ? self.cCell.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (section == 0 || section == 2)  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCollectionCell", for: indexPath)as? ResCollectionCell
            let model = self.cCell[indexPath.row]
            cell?.backgroundImage?.image = UIImage(named: model.imageRestaurant ?? "")
            //HidingLabels
            cell?.mainImageLabel?.isHidden = true
            cell?.mainImageSubLabel?.isHidden = true
            cell?.mainStackView?.isHidden = true
            //RemoveSpaceOfHidingLabels
            cell?.mainImageLabelConstraint?.isActive = false
            cell?.mainImageSubLblConstraint?.isActive = false
            cell?.mainStackConstraint?.isActive = false
            return cell ?? UICollectionViewCell()
        }
        else if(section == 1 || section == 3)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCollectionCell2", for: indexPath)as? ResCollectionCell
            let model = self.cCell[indexPath.row]
            cell?.cellView?.layer.cornerRadius = 10
            cell?.itemImages?.image = UIImage(named: model.imageRestaurant ?? "")
            cell?.itemMainLabel?.text = model.restaurantTitleMain ?? ""
            cell?.itemSubLabel?.text = model.imageSubTitle ?? ""
            cell?.itemSubLabelOne?.text = model.subTitleOne ?? ""
            cell?.itemSubLabelTwo?.text = model.subTitleTwo ?? ""
            cell?.itemSubLabelThree?.text = model.subTitleThree ?? ""
            return cell ?? UICollectionViewCell()
        }
        else if (section == 4)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCollectionCell", for: indexPath)as? ResCollectionCell
            let model = self.cCell[indexPath.row]
            cell?.mainCellView?.layer.cornerRadius = 10
            cell?.backgroundImage?.image = UIImage(named: model.imageRestaurant ?? "")
            cell?.mainImageLabel?.text = model.restaurantTitleMain ?? ""
            cell?.mainImageSubLabel?.text = model.imageSubTitle ?? ""
            cell?.mainImageSubLabelOne?.text = model.subTitleOne ?? ""
            cell?.mainImageSubLabelTwo?.text = model.subTitleTwo ?? ""
            cell?.mainImageSubLabelThree?.text = model.subTitleThree ?? ""
            return cell ?? UICollectionViewCell()
        }
        
        return  UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.size.width , height: 210)
        case 1:
            return CGSize(width: collectionView.frame.width/1.7 , height: 320)
        case 2:
            return CGSize(width: UIScreen.main.bounds.size.width , height: 235)
        case 3:
            return CGSize(width: collectionView.frame.width/1.7, height: 320)
        case 4:
            return CGSize(width: UIScreen.main.bounds.size.width , height: 400)
        default:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 280)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0 || section == 2 || section == 4) ? 0 :  2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0 || section == 2 || section == 4) ? 0 :  2
    }
    //MARK: - DotsChangeWithNo.OfPages
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageSlider?.currentPage = currentPage
    }
}
