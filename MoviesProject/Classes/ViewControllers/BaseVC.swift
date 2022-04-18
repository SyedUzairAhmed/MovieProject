//
//  BaseVC.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    @IBOutlet weak var morebtn: UIButton!
    @IBOutlet weak var morelbl: UILabel!
    @IBOutlet weak var dashboardlbl: UILabel!
    @IBOutlet weak var dashboardbtn: UIButton!
    @IBOutlet weak var mdeiabtn: UIButton!
    @IBOutlet weak var mdeialibrarylbl: UILabel!
    @IBOutlet weak var watchlbl: UILabel!
    @IBOutlet weak var watchbtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    var currentControllerName = "WatchVC"
    
    
    //MARK:- ViewControllesa variables
    
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    
    lazy var WatchVC: WatchVC = {
        let vc = storyBoard.instantiateViewController(withIdentifier: "WatchVC") as! WatchVC
        self.addChild(vc)
        return vc
    }()
    
    lazy var GenreVC: GenreVC = {
        let vc = storyBoard.instantiateViewController(withIdentifier: "GenreVC") as! GenreVC
        self.addChild(vc)
        return vc
    }()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        watchbtn.tintColor = .white
        watchlbl.textColor = .white
        mdeiabtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        mdeialibrarylbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dashboardbtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dashboardlbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        morebtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        morelbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        addChildViewController(VC: WatchVC)
        NotificationCenter.default.addObserver(self, selector: #selector(sideMenuSelectedOption(notification:)), name: NSNotification.Name(rawValue: "post"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func sideMenuSelectedOption(notification : NSNotification) {
        
        let selectedController = notification.userInfo!["name"]! as! String
       
        
        print(selectedController)
        
        if selectedController == "LogOut" {
            
        }
        
       
        //========= removing ViewController from Container View
        if currentControllerName == selectedController {
            return
        }else{
            switch currentControllerName {
            case  "WatchVC":                                // Actual VC name (Capital)
                removeVC(VC:WatchVC)                      // local variable (Small)
            case  "GenreVC":                                // Actual VC name (Capital)
                removeVC(VC:GenreVC)
                
            
            
            default:
                print("No Controller Is Removed !!!!!!!!!!!!!")
                return
            }
            currentControllerName = selectedController
        }
        
        
        //======== adding viewController in container view
        if selectedController == "WatchVC"{ addChildViewController(VC: WatchVC) }
         
        else if selectedController == "GenreVC"{ addChildViewController(VC: GenreVC) }
        
        
        
         
 
    }
    @IBAction func watch_action(_ sender: UIButton) {
//        watchbtn.tintColor = .white
//        watchlbl.textColor = .white
//        mdeiabtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        mdeialibrarylbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        addChildViewController(VC: WatchVC)
    }

    @IBAction func medialibrary_Action(_ sender: UIButton) {
//        watchbtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        watchlbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        mdeiabtn.tintColor = .white
//        mdeialibrarylbl.textColor = .white
        addChildViewController(VC: GenreVC)
    }
   
}
extension BaseVC{
   
    public func addChildViewController(VC: UIViewController){
        
        addChild(VC)
        view.addSubview(VC.view)
        VC.view.frame = containerView.bounds
        VC.view.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        containerView.addSubview(VC.view)
    }
    public func removeVC(VC: UIViewController){
        VC.willMove(toParent: nil)
        VC.view.removeFromSuperview()
        VC.removeFromParent()
    }
    
}
