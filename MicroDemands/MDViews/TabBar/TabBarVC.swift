
import UIKit

class TabBarVC: UITabBarController {

    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - HideNavigationBar
        self.navigationController?.isNavigationBarHidden = true
    }
   
}
