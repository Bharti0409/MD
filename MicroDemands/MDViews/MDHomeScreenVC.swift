import UIKit
//MARK: - TableCell
class TableCell : UITableViewCell{
    @IBOutlet weak var collection : UICollectionView?
    //PageController
    @IBOutlet weak var pageControlView : UIPageControl?
    var section : Int? = 0
    var currentPage = 0
    var cCell : [MDHomeScreenModel] = []
    var timer = Timer()
    var counter = 0
    weak var parent: UIViewController?
    //MARK: - OVERRIDE AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        collection?.delegate = self
        collection?.dataSource = self
        //ReloadingData
        DispatchQueue.main.async {
            if(self.section == 0)
            { self.pageController()
                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            else
            {
                self.pageControlView?.isHidden = true
            }
        }
        if section == 1 {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = UICollectionView.ScrollDirection.vertical
            layout.itemSize = CGSize(width: (collection?.frame.width ?? 0)/2, height:150)
            self.collection?.setCollectionViewLayout(layout, animated: true)
        } else {
            let layout = UICollectionViewFlowLayout.init()
            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height:200)
            self.collection?.setCollectionViewLayout(layout, animated: true)
            pageControlView?.currentPage = counter
        }
    }
    //TimerFunction
    @objc func changeImage()
    {
        if counter < cCell.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.collection?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlView?.currentPage = counter
            counter += 1
        }
        else
        {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collection?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    //PageController
    func pageController()
    {
        pageControlView?.numberOfPages = cCell.count
        pageControlView?.currentPage = currentPage
        pageControlView?.pageIndicatorTintColor = #colorLiteral(red: 0.5254901961, green: 0.5254901961, blue: 0.5254901961, alpha: 1)
        pageControlView?.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        pageControlView?.clipsToBounds = false
    }
}
//MARK: - CollectionCell
class ColCell : UICollectionViewCell
{
    @IBOutlet weak var backgroundImageView : UIImageView?
    //Section 1 ColCell2
    @IBOutlet weak var cellView : UIView?
    @IBOutlet weak var itemImage : UIImageView?
    @IBOutlet weak var itemNameLabel : UILabel?
    @IBOutlet weak var itemButton : UIButton?
    weak var parent: UIViewController?
}
//MARK: - MDHomeScreenVC
class MDHomeScreenVC: UIViewController {
    
    var dataArray : [MDHomeScreenModel] = []
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var locationImage : UIImageView?
    @IBOutlet weak var locationTitleLabel : UILabel?
    @IBOutlet weak var searchBarField : UISearchBar?
    @IBOutlet weak var locationButton : UIButton?
    @IBOutlet weak var searchBarStackView : UIStackView?
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - NavigationSetup
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: (UIImage(named: "NotificationBell")) , style: .plain, target: self, action: #selector(rightBar))
        //MARK: - searchBar
        searchBarField?.setUpSearchBar()
        //MARK: - HideNavigationTitle
        hideNavigationTitle()
        //MARK: - HideNavigationButton
        hideNavigationButton()
        //MARK: - Reloading data
        DispatchQueue.main.async {
            self.dataArray = MDHomeScreenModel.getTableData()
            self.tableView?.reloadData()
        }
    }
      @objc func rightBar()
                                                                 {
            
        }
}
// MARK: - TABLEVIEWDELEGATEMETHODS
extension MDHomeScreenVC : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray.count > 0 ) ? self.dataArray.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
           case 0:
               return 0.0
        case 1:
            return 65
        case 2:
            return 0.0
            
           default:
               return UITableView.automaticDimension
           }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 230
        case 1:
            if (self.dataArray.count > 0 ) {
                let model = self.dataArray[indexPath.section]
                if ((model.section?.count ?? 0) > 0) {
                    return CGFloat(((model.section?.count ?? 0) >= 2) ? (model.section?.count ?? 0)*80 : 160)
                } else {
                    return 0
                }
            }
            return 800
        case 2:
            return 280
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.size.width - 20, height: 30))
        headerView.addSubview(titleLabel)
        let model = self.dataArray[section]
        //MARK: - Title
        let title = model.title ?? ""
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)as? TableCell
        if (self.dataArray.count > 0) {
            cell?.parent = self
            switch indexPath.section {
            case 0:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section ?? []
                cell?.section = 0
                cell?.collection?.reloadData()
                break
            case 1:
                let model = self.dataArray[indexPath.section]
                cell?.collection?.isScrollEnabled = true
                cell?.cCell = model.section ?? []
                cell?.section = 1
                cell?.collection?.reloadData()
                break
            case 2:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section ?? []
                cell?.section = 2
                cell?.collection?.reloadData()
            case 3:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section ?? []
                cell?.section = 3
                cell?.collection?.reloadData()
                break
            case 4:
                let model = self.dataArray[indexPath.section]
                cell?.cCell = model.section ?? []
                cell?.section = 4
                cell?.collection?.reloadData()
                break
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
extension TableCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cCell.count > 0 ) ? self.cCell.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (section == 0 || section == 2)  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColCell", for: indexPath)as? ColCell
            let model = self.cCell[indexPath.row]
            cell?.backgroundImageView?.image = UIImage(named: model.image ?? "")
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColCell2", for: indexPath)as? ColCell
            cell?.parent = parent
            let model = self.cCell[indexPath.row]
            cell?.cellView?.layer.cornerRadius = 10
            cell?.itemImage?.image = UIImage(named: model.image ?? "")
            cell?.itemNameLabel?.text = model.imageTitle ?? ""
            cell?.itemButton?.tag = indexPath.row
            cell?.itemButton?.addTarget(self, action: #selector(viewResDetails), for: .touchUpInside)
            return cell ?? UICollectionViewCell()
        }
    }
    @objc func viewResDetails(sender : UIButton)
    {
        //MARK: - Section 1 Button Actions
        switch sender.tag
        {
            //Restaurants
        case 0 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MDRestaurantVC")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
            break
            // Grocery
        case 1 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
            break
            // FoodDelivery
        case 2 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
            break
            //Taxi
        case 3 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
            //Salon
        case 4 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
            break
            //Plumber
        case 5 :
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "")as? MDRestaurantVC
            parent?.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (section == 1) ? CGSize(width: collectionView.frame.width/2, height: 160) : CGSize(width: UIScreen.main.bounds.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0) ? 0 :  10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (section == 0) ? 0 :  10
    }
    //MARK: - DotsChangeWithNo.OfPages
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControlView?.currentPage = currentPage
    }
}

//MARK: - Extension UISEARCHBAR
extension UISearchBar
{
    func setUpSearchBar() {
        self.sizeToFit()
        self.placeholder = "Search Your Services"
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = #colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)
        self.searchTextField.backgroundColor = .clear
    }
}
