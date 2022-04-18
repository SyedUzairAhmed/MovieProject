//
//  SearchVc.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit
import SDWebImage
class SearchVc: UIViewController , UISearchBarDelegate {

    var moviesarry = [upcomingmoviesCustomClass]()
    var genre = ""
    var searcharry = [upcomingmoviesCustomClass]()
    @IBOutlet weak var resultlbl: UILabel!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searcharry = moviesarry
        searchbar.delegate = self
        resultlbl.text = "Top Results"
        searchbar.placeholder = "TV Shows Movies and More"
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(viewTapRecognizer)
        // Do any additional setup after loading the view.
    }
    @objc override func dismissKeyboard() {
        resultlbl.text = "\(searcharry.count)\( " result found")"
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        
        
    {
        self.searcharry.removeAll()
        print("from searchbar")

        guard let searchText = searchbar.text else { return }
        if searchText == ""{
            print(searchText)
           print("searchlist")
            if(self.searcharry.count == 0){
               print("searchlist")
               if(searchbar.text == ""){
                   self.searcharry = self.moviesarry
                print(self.searcharry)
               }
            }
           
        
        }else{
             print(searchText)
          
            self.searcharry = self.moviesarry.filter({ animal -> Bool in
                return animal.moviename.lowercased().contains(searchText.lowercased())
            })
            print(self.searcharry)
            if(searcharry.count == 0){
                if(searchbar.text == ""){
                    searcharry = moviesarry
                }
               // self.nosearchlb.isHidden = false
            }else{
                //self.nosearchlb.isHidden = true
            }
            
        }

        
        
        tableview.reloadData()


    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
        
    {
        
            
            searchBar.text = ""
            
        searcharry = moviesarry
            
            searchBar.endEditing(true)
            
            tableview.reloadData()
            
       
    }
    @objc  func imgtap(sender : UITapGestureRecognizer){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDEtailVc") as! MovieDEtailVc
        vc.movie_id = searcharry[sender.view!.tag].movieid
        self.present(vc, animated: true)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SearchVc: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searcharry.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        let Url = "\("https://image.tmdb.org/t/p/original")\(searcharry[indexPath.row].movieimg)"
        let url = URL(string: Url)
        cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
        cell.lbl.text = searcharry[indexPath.row].moviename
        cell.genrelbl.text = genre
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imgtap))
        cell.cardview.tag = indexPath.row

        tapGestureRecognizer1.numberOfTapsRequired = 1
        tapGestureRecognizer1.numberOfTouchesRequired = 1
        cell.cardview.isUserInteractionEnabled = true
        cell.cardview.addGestureRecognizer(tapGestureRecognizer1)

        return cell
        
        
    }
    
    
}
