import UIKit

class MDWelcomeVC: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var circleBackgroundImageView : UIImageView?
    @IBOutlet weak var logoImageView : UIImageView?
    @IBOutlet weak var bgImageView : UIImageView?
    @IBOutlet weak var mainLabel : UILabel?
    @IBOutlet weak var subLabel : UILabel?
    @IBOutlet weak var startButton : UIButton?
    @IBOutlet weak var skipButton : UIButton?
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.properties()
        }
    }
    
    //MARK: - GetStartedIBAction
    @IBAction func startButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MDWalkthroughVC")as? MDWalkthroughVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    //MARK: - SkipButtonAction
    @IBAction func skipButtonClick(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")as? TabBarVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //PropertyFunction
    func properties()
    {
        // CircleBackground
        self.circleBackgroundImageView?.image = UIImage(named: "CircleBackground.png")
        self.circleBackgroundImageView?.imageProperty()
        // Logo
        self.logoImageView?.image = UIImage(named: "MDLogo.png")
        self.logoImageView?.imageProperty()
        // Illustration
        self.bgImageView?.image = UIImage(named: "Illustration.png")
        self.bgImageView?.imageProperty()
        // MainLabel
        self.mainLabel?.text = "Welcome"
        self.mainLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 400))
        self.mainLabel?.numberOfLines = 0
        self.mainLabel?.textColor = UIColor(red: 0.227, green: 0.227, blue: 0.227, alpha: 1)
        self.mainLabel?.textAlignment = .center
        // SubLabel
        self.subLabel?.text = "It's a pleasure to meet you. We are excited that you are here so let's get started!"
        self.subLabel?.textAlignment = .center
        self.subLabel?.font = UIFont(name: "Inter-Light", size: 16)
        self.subLabel?.numberOfLines = 0
        self.subLabel?.textColor = UIColor(red: 0.227, green: 0.227, blue: 0.227, alpha: 1)
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
//MARK: - ExtensionImageView
extension UIImageView
{
    func imageProperty()
    {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}



