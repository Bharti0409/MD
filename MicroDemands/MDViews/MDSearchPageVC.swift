import UIKit
//MARK: - Table Cell
class SearchTableCell : UITableViewCell
{
    @IBOutlet weak var collection : UICollectionView?
    var cCell : [MDSearchPageModels] = []
    override func awakeFromNib() {
        collection?.dataSource = self
        collection?.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collection?.setCollectionViewLayout(layout, animated: true)
    }
}
//MARK: - Collection Cell
class SearchCollectionCell : UICollectionViewCell
{
    @IBOutlet weak var itemImages : UIImageView?
    @IBOutlet weak var itemTitleLabel : UILabel?
    @IBOutlet weak var itemDescription : UILabel?
    //MARK: - AwakeFromNib
    override func awakeFromNib() {
        self.itemTitleLabel?.propertyLabel()
        self.itemDescription?.propertyLabel()
        self.itemTitleLabel?.textColor = UIColor(red: 0.004, green: 0.059, blue: 0.027, alpha: 1)
        self.itemTitleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.itemDescription?.font = UIFont.systemFont(ofSize: 14)
        self.itemDescription?.textColor = UIColor(red: 0.004, green: 0.059, blue: 0.027, alpha: 0.64)
        self.itemImages?.propertyImage()
    }
}
class MDSearchPageVC: UIViewController {

    var searchActive : Bool = false
    var dataArray : [MDSearchPageModels] = []
    @IBOutlet weak var searchStackView: UIStackView?
    @IBOutlet weak var searchBarField: UISearchBar?
    //Outlet TableView
    @IBOutlet weak var tableView : UITableView?
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        //MARK: - SearchBar
        self.searchStackView?.changeStackProperty()
        //MARK: - CrossButtonNavigationBar
        navigationButton()
        //MARK: - SetUpSearchBar
        searchBarField?.setUpSearchBar()
        //MARK: - PassingModelClass
        self.dataArray = MDSearchPageModels.getSearchData()
        self.tableView?.reloadData()
       
    }
   
    
}
//MARK: - TableViewDelegateMethods
extension MDSearchPageVC : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray.count > 0) ? self.dataArray.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //HeaderSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 30, height: 30))
        headerView.addSubview(titleLabel)
        let model = self.dataArray[section]
        let title = model.title ?? ""
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.dataArray.count > 0 ) {
            let model = self.dataArray[indexPath.section]
            if ((model.section.count) > 0) {
                return CGFloat(((model.section.count) >= 2) ? (model.section.count)*105 : 210)
            } else {
                return 0
            }
        }
        return 800
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath)as? SearchTableCell
        let model = self.dataArray[indexPath.section]
        if(self.dataArray.count>0)
        {
            cell?.cCell = model.section
            cell?.collection?.reloadData()
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
//MARK: - Extension CollectionViewMethods
extension SearchTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cCell.count > 0) ? self.cCell.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath)as? SearchCollectionCell
        let model = self.cCell[indexPath.row]
        cell?.itemImages?.image = UIImage(named: model.image ?? "")
        cell?.itemTitleLabel?.text = model.imageTitle ?? ""
        cell?.itemDescription?.text = model.imageSubTitle ?? ""
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = ((collection?.frame.size.width ?? 0) - space) / 2.0
                return CGSize(width: size, height: 210)
//        return CGSize(width: (collection?.frame.width ?? 0)/2, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
//MARK: - Extension StackView
extension UIStackView
{
    func changeStackProperty()
    {
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
    }
}
//MARK: - Extension UILabel
extension UILabel
{
    func propertyLabel()
    {
        self.numberOfLines = 0
        self.textAlignment = .left
    }
}
//MARK: - Extension UIImageView
extension UIImageView
{
    func propertyImage()
    {
        self.layer.cornerRadius = 8
    }
}

//MARK: - Extension UIViewController
extension UIViewController
{
    func navigationButton()
    {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(systemName: "xmark"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(dismissViewController), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 10)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    @objc func dismissViewController()
    {
        //Dismiss NavigationController View
        self.navigationController?.popViewController(animated: true)
    }
    func hideNavigationTitle()
    {
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    func hideNavigationButton()
    {
        self.navigationItem.hidesBackButton = true
    }
}
