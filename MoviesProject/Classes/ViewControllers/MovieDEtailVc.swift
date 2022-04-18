//
//  MovieDEtailVc.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
class MovieDEtailVc: UIViewController {
    var playerController = AVPlayerViewController()
    @IBOutlet weak var tbleview: UITableView!
    @IBOutlet weak var genrecv: UICollectionView!
    @IBOutlet weak var bging: UIImageView!
    @IBOutlet weak var tagline: UILabel!
    var movie_id = 0
    var overview = [String]()
    var genre = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        callFuncToSetData()
        // Do any additional setup after loading the view.
    }
    func callFuncToSetData() {
        
       let id = "\("3/movie/")\(movie_id)"
        ServerManager.Get_APi_Call(Movieid : id ,  APIMethodName: APIMethods.Moviedetails.rawValue) {(Result : MovieDetails?) in
           
            
            //== check if api is responding or not
            guard Result != nil else {
                print("error")
               // UtilManager.SCLAlertMessage(message: "Some thing went wrong")
                return
            }
            GlobalData.MovieDetails = Result
            self.set()
        }
    }

    func set(){
        let Url = "\("https://image.tmdb.org/t/p/original")\(GlobalData.MovieDetails.backdropPath ?? "")"
        print(Url)
        let url = URL(string: Url)
        bging.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
        tagline.text = GlobalData.MovieDetails.tagline 
        overview.append(GlobalData.MovieDetails.overview ?? "")
        for i in GlobalData.MovieDetails.genres{
            genre.append(i.name ?? "")
        }
        self.tbleview.delegate = self
        self.tbleview.dataSource = self
        self.tbleview.reloadData()
        self.genrecv.delegate = self
        self.genrecv.dataSource = self
        self.genrecv.reloadData()
    }
    
    @IBAction func watchtrailer(_ sender: Any) {
        if(GlobalData.MovieDetails.video!){
            let video_url = NSURL(string: (GlobalData.MovieDetails.homepage ?? ""))
            print (video_url)
            let player = AVPlayer(url: (video_url as URL?)!)
            
            playerController.player = player
         //   self.messageInputBar.isHidden = true
            present(playerController, animated: true) {
                print("video play")
                player.play()
                self.playerController.addObserver(self, forKeyPath:#keyPath(UIViewController.view.frame), options: [.old, .new], context: nil)
                
                
            }
            
        }else{
            let alertController = UIAlertController(title: "Ooops", message: "No trailer available", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
       
    }
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        
        if (self.playerController.isBeingDismissed) {
           
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension MovieDEtailVc : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return genre.count
            
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = genrecv.dequeueReusableCell(withReuseIdentifier: "detailGenreCell", for: indexPath) as! detailGenreCell
        
        
        
        
        cell.btn.backgroundColor = .random()
        cell.btn.setTitle(genre[indexPath.row], for: .normal)
        return cell
        
        
    }
    
}
extension MovieDEtailVc: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return overview.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbleview.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        cell.titlee.text = "Overview"
        cell.desc.text = overview[indexPath.row]
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableView.automaticDimension
        
        
    }
    
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 0.9)
    }
    static func random1() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 0.5)
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
