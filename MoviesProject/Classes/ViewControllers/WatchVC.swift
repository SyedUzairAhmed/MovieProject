//
//  WatchVC.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit
import SDWebImage
class WatchVC: UIViewController {
    var moviesarry = [upcomingmoviesCustomClass]()
    @IBOutlet weak var tbleview: UITableView!
    @IBOutlet weak var blurview: UIVisualEffectView!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityindicator.isHidden = false
        activityindicator.startAnimating()
        blurview.isHidden = false
        callFuncToSetData()
        // Do any additional setup after loading the view.
    }
    func callFuncToSetData() {
        
       
        ServerManager.Get_APi_Call(Movieid : "" ,  APIMethodName: APIMethods.upcoming.rawValue) {(Result : UpcomingMovies?) in
           
            
            //== check if api is responding or not
            guard Result != nil else {
                print("some error")
               // UtilManager.SCLAlertMessage(message: "Some thing went wrong")
                return
            }
            GlobalData.UpcomingMovies = Result
            for i in Result?.results ?? []{
                self.moviesarry.append(upcomingmoviesCustomClass(moviename: i.originalTitle, movieimg: i.posterPath, movieid: i.id))
            }
            self.activityindicator.isHidden = true
            self.activityindicator.stopAnimating()
            self.blurview.isHidden = true
            self.tbleview.delegate = self
            self.tbleview.dataSource = self
            self.tbleview.reloadData()
        }
    }
    @objc  func imgtap(sender : UITapGestureRecognizer){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDEtailVc") as! MovieDEtailVc
        vc.movie_id = moviesarry[sender.view!.tag].movieid
        self.present(vc, animated: true)
    }
   
    @IBAction func searchAction(_ sender: Any) {
        let  myDict = [ "name": "GenreVC"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "post"), object: nil, userInfo: myDict)
    }
    
}
extension WatchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesarry.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbleview.dequeueReusableCell(withIdentifier: "WatchCell") as! WatchCell
        let Url = "\("https://image.tmdb.org/t/p/original")\(moviesarry[indexPath.row].movieimg)"
        let url = URL(string: Url)
        cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
        cell.lbl.text = moviesarry[indexPath.row].moviename
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imgtap))
        cell.img.tag = indexPath.row
        
        tapGestureRecognizer1.numberOfTapsRequired = 1
        tapGestureRecognizer1.numberOfTouchesRequired = 1
        cell.img.isUserInteractionEnabled = true
        cell.img.addGestureRecognizer(tapGestureRecognizer1)

        return cell
        
        
    }
    
    
}
