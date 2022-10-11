import UIKit

//MARK: - TABLECELL
class RecentSearchTableCell: UITableViewCell
{
    @IBOutlet weak var mainImage : UIImageView?
    @IBOutlet weak var imageTitle : UILabel?
}
//MARK: - ViewController
class MDRecentSearchDataVC: UIViewController {
    var dataArray :[MDRecentSearchModel] = []
    @IBOutlet weak var searchBarField : UISearchBar?
    @IBOutlet weak var tableView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        //MARK: - searchBar
        searchBarField?.setUpSearchBar()
        //MARK: - HideNavigationTitle
        hideNavigationTitle()
        //MARK: - HideNavigationButton
        hideNavigationButton()
        //MARK: - CrossButtonNavigationBar
        navigationButton()
        DispatchQueue.main.async{
        self.dataArray = MDRecentSearchModel.getRecentSearchData()
        self.tableView?.reloadData()
        }
    }
}
//MARK: - Extension ViewController
extension MDRecentSearchDataVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray.count > 0) ? self.dataArray.count : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 80))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.size.width - 130, height: 60))
        let clearAllButton = UIButton(frame: CGRect(x:headerView.frame.size.width - 80 , y: 10, width: 70, height: 60))
        headerView.addSubview(titleLabel)
        headerView.addSubview(clearAllButton)
        //Title
        titleLabel.text = "RECENT SEARCHES"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.numberOfLines = 0
        //Button
        clearAllButton.setTitle("Clear All", for: .normal)
        clearAllButton.setTitleColor(#colorLiteral(red: 0.527, green: 0.527, blue: 0.527, alpha: 1), for: .normal)
       // clearAllButton.addTarget(self, action: #selector(featuredPartners), for: .touchUpInside)
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableCell", for: indexPath) as? RecentSearchTableCell
        let model = self.dataArray[indexPath.row]
        cell?.mainImage?.image = UIImage(named: model.image ?? "")
        cell?.imageTitle?.text = model.imageTitle ?? ""
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    // MARK: - VIEW DID DISAPPEAR
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            searchBarField?.becomeFirstResponder()
        }
        
}
