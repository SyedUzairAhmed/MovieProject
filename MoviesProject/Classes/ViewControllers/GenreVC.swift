//
//  GenreVC.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit

class GenreVC: UIViewController , UISearchBarDelegate {
    
    
    var moviesarry = [genreMovies]()
    var Action = [genreMovies]()
    var Adventure = [genreMovies]()
    var Animation = [genreMovies]()
    var Comedy = [genreMovies]()
    var Crime = [genreMovies]()
    var Documentary = [genreMovies]()
    var Drama = [genreMovies]()
    var Family = [genreMovies]()
    var Fantasy = [genreMovies]()
    var History = [genreMovies]()
    var Horror = [genreMovies]()
    var Music = [genreMovies]()
    var Mystery = [genreMovies]()
    var Romance = [genreMovies]()
    var ScienceFiction = [genreMovies]()
    var TVMovie = [genreMovies]()
    var War = [genreMovies]()
    var Western = [genreMovies]()
    var Thriller = [genreMovies]()
    var Mainarry = [MaingenreMovies]()
    var searcharry = [MaingenreMovies]()
    @IBOutlet weak var genrecollection: UICollectionView!
    @IBOutlet weak var blurview: UIVisualEffectView!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityindicator.isHidden = false
        activityindicator.startAnimating()
        blurview.isHidden = false
        searchbar.delegate = self
        searchbar.placeholder = "TV Shows Movies and More"
        callFuncToSetData()
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(viewTapRecognizer)
        // Do any additional setup after loading the view.
    }
    func callFuncToSetData() {
        
        
        ServerManager.Get_APi_Call(Movieid : "" ,  APIMethodName: APIMethods.Genre.rawValue) {(Result : Genremodel?) in
            
            
            //== check if api is responding or not
            guard Result != nil else {
                print("something wrong")
                // UtilManager.SCLAlertMessage(message: "Some thing went wrong")
                return
            }
            for i in Result?.genres ?? []{
                GlobalData.genrearry.append(genre(genrename: i.name, genreid: i.id))
            }
            for i in GlobalData.UpcomingMovies?.results ?? []{
                for j in i.genreIDS{
                    for each in GlobalData.genrearry{
                        if(j == each.genreid){
                            
                            let temp = upcomingmoviesCustomClass(moviename: i.title, movieimg: i.posterPath, movieid: i.id)
                            self.moviesarry.append(genreMovies(genrename: each.genrename, movies: temp , backdroppath: i.backdropPath ?? i.posterPath))
                        }
                    }
                    
                    
                }
            }
            //            for each in self.moviesarry{
            //                if()
            //            }
            self.combine()
            self.genrecollection.delegate = self
            self.genrecollection.dataSource = self
            self.genrecollection.reloadData()
        }
    }
    
    func combine(){
        for i in self.moviesarry{
            if(i.genrename == "Action"){ //{
                self.Action.append(i)
            }else if(i.genrename == "Adventure"){
                self.Adventure.append(i)
            }else if(i.genrename == "Animation"){
                self.Animation.append(i)
            }else if(i.genrename == "Comedy"){
                self.Comedy.append(i)
            }else if(i.genrename == "Crime"){
                self.Crime.append(i)
            }else if(i.genrename == "Documentary"){
                self.Documentary.append(i)
            }else if(i.genrename == "Drama"){
                self.Drama.append(i)
            }else if(i.genrename == "Family"){
                self.Family.append(i)
            }else if(i.genrename == "Fantasy"){
                self.Fantasy.append(i)
            }else if(i.genrename == "History"){
                self.History.append(i)
            }else if(i.genrename == "Horror"){
                self.Horror.append(i)
            }else if(i.genrename == "Music"){
                self.Music.append(i)
            }else if(i.genrename == "Mystery"){
                self.Mystery.append(i)
            }else if(i.genrename == "Romance"){
                self.Romance.append(i)
            }else if(i.genrename == "Science Fiction"){
                self.ScienceFiction.append(i)
            }else if(i.genrename == "TV Movie"){
                self.TVMovie.append(i)
            }else if(i.genrename == "War"){
                self.War.append(i)
            }else if(i.genrename == "Western"){
                self.Western.append(i)
            }else if(i.genrename == "Thriller"){
                self.Thriller.append(i)
            }
            
            
        }
        if(self.Action.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Action{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Action[0].genrename, movies: temp, backdroppath: self.Action[0].backdroppath))
        }
        if(self.Adventure.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Adventure{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Adventure[0].genrename, movies: temp, backdroppath: self.Adventure[0].backdroppath))
        }
        if(self.Animation.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Animation{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Animation[0].genrename, movies: temp, backdroppath: self.Animation[0].backdroppath))
        }
        if(self.Comedy.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Comedy{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Comedy[0].genrename, movies: temp, backdroppath: self.Comedy[0].backdroppath))
        }
        if(self.Crime.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Crime{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Crime[0].genrename, movies: temp, backdroppath: self.Crime[0].backdroppath))
        }
        if(self.Documentary.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Documentary{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Documentary[0].genrename, movies: temp, backdroppath: self.Documentary[0].backdroppath))
        }
        if(self.Drama.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Drama{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Drama[0].genrename, movies: temp, backdroppath: self.Drama[0].backdroppath))
        }
        if(self.Family.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Family{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Family[0].genrename, movies: temp, backdroppath: self.Family[0].backdroppath))
        }
        if(self.Fantasy.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Fantasy{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Fantasy[0].genrename, movies: temp, backdroppath: self.Fantasy[0].backdroppath))
        }
        if(self.History.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.History{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.History[0].genrename, movies: temp, backdroppath: self.History[0].backdroppath))
        }
        if(self.Horror.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Horror{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Horror[0].genrename, movies: temp, backdroppath: self.Horror[0].backdroppath))
        }
        if(self.Music.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Music{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Music[0].genrename, movies: temp, backdroppath: self.Music[0].backdroppath))
        }
        if(self.Mystery.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Mystery{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Mystery[0].genrename, movies: temp, backdroppath: self.Mystery[0].backdroppath))
        }
        if(self.Romance.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Romance{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Romance[0].genrename, movies: temp, backdroppath: self.Romance[0].backdroppath))
        }
        if(self.ScienceFiction.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.ScienceFiction{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.ScienceFiction[0].genrename, movies: temp, backdroppath: self.ScienceFiction[0].backdroppath))
        }
        if(self.Music.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Music{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Music[0].genrename, movies: temp, backdroppath: self.Music[0].backdroppath))
        }
        if(self.TVMovie.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.TVMovie{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.TVMovie[0].genrename, movies: temp, backdroppath: self.TVMovie[0].backdroppath))
        }
        if(self.War.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.War{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.War[0].genrename, movies: temp, backdroppath: self.War[0].backdroppath))
        }
        if(self.Western.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Western{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Western[0].genrename, movies: temp, backdroppath: self.Western[0].backdroppath))
        }
        if(self.Thriller.isEmpty == false){
            var temp = [upcomingmoviesCustomClass]()
            for i in self.Thriller{
                temp.append(upcomingmoviesCustomClass(moviename: i.movies.moviename, movieimg: i.movies.movieimg, movieid: i.movies.movieid))
            }
            self.Mainarry.append(MaingenreMovies(genrename: self.Thriller[0].genrename, movies: temp, backdroppath: self.Thriller[0].backdroppath))
        }
        self.searcharry = self.Mainarry
        self.activityindicator.isHidden = true
        self.activityindicator.stopAnimating()
        self.blurview.isHidden = true
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
                    self.searcharry = self.Mainarry
                    print(self.searcharry)
                }
            }
            
            
        }else{
            print(searchText)
            
            self.searcharry = self.Mainarry.filter({ animal -> Bool in
                return animal.genrename.lowercased().contains(searchText.lowercased())
            })
            print(self.searcharry)
            if(searcharry.count == 0){
                if(searchbar.text == ""){
                    searcharry = Mainarry
                }
                // self.nosearchlb.isHidden = false
            }else{
                //self.nosearchlb.isHidden = true
            }
            
        }
        
        
        
        genrecollection.reloadData()
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    
    {
        
        
        searchBar.text = ""
        
        searcharry = Mainarry
        
        searchBar.endEditing(true)
        
        genrecollection.reloadData()
        
        
    }
    @objc  func imgtap(sender : UITapGestureRecognizer){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVc") as! SearchVc
        vc.moviesarry = searcharry[sender.view!.tag].movies
        vc.genre = searcharry[sender.view!.tag].genrename
        self.present(vc, animated: true)
    }
}
extension GenreVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searcharry.count
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = genrecollection.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! genreCell
        
        
        
        
        let Url = "\("https://image.tmdb.org/t/p/original")\(searcharry[indexPath.row].backdroppath)"
        let url = URL(string: Url)
        cell.img.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"))
        cell.lbl.text = searcharry[indexPath.row].genrename
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imgtap))
        cell.img.tag = indexPath.row
        
        tapGestureRecognizer1.numberOfTapsRequired = 1
        tapGestureRecognizer1.numberOfTouchesRequired = 1
        cell.img.isUserInteractionEnabled = true
        cell.img.addGestureRecognizer(tapGestureRecognizer1)
        
        return cell
        
        
    }
}
class genre{
    var genrename : String
    var genreid : Int
    
    init(genrename : String , genreid : Int){
        
        self.genreid = genreid
        self.genrename = genrename
        
        
    }
}
class genreMovies{
    var genrename : String
    var backdroppath : String
    var movies : upcomingmoviesCustomClass
    init(genrename : String , movies : upcomingmoviesCustomClass , backdroppath : String  ){
        
        self.movies = movies
        self.backdroppath = backdroppath
        self.genrename = genrename
        
        
    }
}
class MaingenreMovies{
    var genrename : String
    var backdroppath : String
    var movies : [upcomingmoviesCustomClass]
    init(genrename : String , movies : [upcomingmoviesCustomClass] , backdroppath : String  ){
        
        self.movies = movies
        self.backdroppath = backdroppath
        self.genrename = genrename
        
        
    }
}
