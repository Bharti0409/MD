import UIKit
class CollectionCell : UICollectionViewCell
{
    @IBOutlet weak var logoImage : UIImageView?
    @IBOutlet weak var walkthroughIllusImage : UIImageView?
    @IBOutlet weak var mainLabel : UILabel?
    @IBOutlet weak var subLabel : UILabel?
    

    //PassingModels
    func setup(_ slide: WalkthroughModel)
    {
        logoImage?.image = slide.walkthroughLogoImage
        walkthroughIllusImage?.image = slide.walkthroughbackgroundImage
        mainLabel?.text = slide.mainLabel
        subLabel?.text = slide.subLabel
    }

}
class MDWalkthroughVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl : UIPageControl?
    @IBOutlet weak var startButton : UIButton?
    @IBOutlet weak var skipButton : UIButton?
    var slides : [WalkthroughModel] = []
    var currentPage = 0
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        DispatchQueue.main.async {
            self.buttonProperties()
        }
        
        //MARK: - HideBackBar
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //ARRAYDATA
        slides = [WalkthroughModel(walkthroughLogoImage: #imageLiteral(resourceName: "MDLogo"), walkthroughbackgroundImage: #imageLiteral(resourceName: "WalkthroughIllus"), mainLabel: "All your favorites" ,subLabel: "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!") ,
                  WalkthroughModel(walkthroughLogoImage: #imageLiteral(resourceName: "MDLogo"), walkthroughbackgroundImage: #imageLiteral(resourceName: "WalkthroughTwo"), mainLabel: "Free delivery offers" , subLabel: "Free delivery for new customers via google pay and others payment methods."),
                  WalkthroughModel(walkthroughLogoImage: #imageLiteral(resourceName: "MDLogo"), walkthroughbackgroundImage: #imageLiteral(resourceName: "WalkthroughThree") , mainLabel: "Choose your food" , subLabel: "Easily find your type of food craving and you’ll get delivery in wide range.") ]
        pageController()
    }
    //MARK: - GETSTARTBUTTON
    @IBAction func startButtonClick(_ sender: Any) {
        if currentPage == slides.count - 1{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")as? TabBarVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            currentPage += 1
            pageController()
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    //MARK: - SKIPBUTTON
    @IBAction func skipButtonClick(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")as? TabBarVC
        self.navigationController?.pushViewController(vc!, animated: true)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc!)
    }
    func pageController()
    {
        pageControl?.numberOfPages = slides.count
        pageControl?.currentPage = currentPage
        pageControl?.pageIndicatorTintColor = #colorLiteral(red: 0.5254901961, green: 0.5254901961, blue: 0.5254901961, alpha: 1)
        pageControl?.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.5333333333, blue: 1, alpha: 1)
        pageControl?.clipsToBounds = false
    }
   func buttonProperties()
    {
        // GetStarted
        self.startButton?.layer.backgroundColor = #colorLiteral(red: 0, green: 0.6166861057, blue: 1, alpha: 1)
        self.startButton?.setTitle("Get Started", for: .normal)
        self.startButton?.setTitleColor(.white, for: .normal)
        self.startButton?.layer.cornerRadius = 8
        // Skip
        self.skipButton?.layer.backgroundColor = UIColor.clear.cgColor
        self.skipButton?.setTitle("Skip", for: .normal)
        self.skipButton?.setTitleColor(.black, for: .normal)
    }
}
//MARK: - EXTENSION OF CURRENT VC
extension MDWalkthroughVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)as? CollectionCell
        cell?.setup(slides[indexPath.row])
        cell?.labelProperties()
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl?.currentPage = currentPage
    }
}
//MARK: - ExtensionCollectionCell
extension CollectionCell
{
    func labelProperties()
    {
        //MainLabel
        self.mainLabel?.font = UIFont.systemFont(ofSize: 28)
        self.mainLabel?.numberOfLines = 0
        self.mainLabel?.textColor = UIColor(red: 0.004, green: 0.059, blue: 0.027, alpha: 1)
        self.mainLabel?.textAlignment = .center
        //SubLabel
        self.subLabel?.textAlignment = .center
        self.subLabel?.font = UIFont(name: "Inter-Light", size: 16)
        self.subLabel?.numberOfLines = 0
        self.subLabel?.textColor = UIColor(red: 0.227, green: 0.227, blue: 0.227, alpha: 1)
    }
}
