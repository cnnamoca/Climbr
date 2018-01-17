

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var blockedUsersButton: UIButton!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    var sourceVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        //        self.navigationController?.navigationBar.titleTextAttributes. = UIColor.white
        blockedUsersButton.layer.cornerRadius = blockedUsersButton.frame.height/4
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
                self.logoutButton.title = "Login"
                self.blockedUsersButton.isEnabled = false
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                self.dismiss(animated: true, completion: nil)
                
                do {
                    try Auth.auth().signOut()
                }
                catch let error as NSError {
                    print (error.localizedDescription)
                }
            } else {
//                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "toLogin", sender: self)
            }
        }
        

        
    }
    
    @IBAction func backToMapView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
