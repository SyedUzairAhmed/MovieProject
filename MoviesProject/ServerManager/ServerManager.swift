//
//  ServerManager.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import Foundation
import Alamofire

struct APIPath {
    //api ka path dena hai
    //original ur
 static let BaseURL = "https://api.themoviedb.org/"
  
}

//Mark: - API Methods
enum APIMethods : String{
    //api k method
    case upcoming = "3/movie/upcoming?api_key=ea9a1542a4119b128d22480e38acf446&language=en-US"
    case Genre = "3/genre/movie/list?api_key=ea9a1542a4119b128d22480e38acf446&language=en-US"
    case Moviedetails = "?api_key=ea9a1542a4119b128d22480e38acf446"
    case Getimages = "3/movie/images?api_key=ea9a1542a4119b128d22480e38acf446"
   
}



//Mark: - API Calling
class ServerManager {
    
    static func Get_APi_Call<T: Decodable>(Movieid : String ,  APIMethodName : String, completion: @escaping (T?) -> ()) {
       
        
       
        let url = "\(APIPath.BaseURL)\(Movieid)\(APIMethodName)"
        print(url)
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
           
            
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if response.result.value != nil {
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: response.data!)
                            completion(obj)
                        }
                        catch{
                            print(error.localizedDescription)
                            completion(nil)
                            print("** === ** Error: While Paesing JSON (Invalid Model Object Passed in func Parameret )")
                        }
                        
                    }else {
                        completion(nil)
                        print("***====*** No JSON Data")
                    }
                    
                case 401:
                    completion(nil)
                    print("401: Session Expied")
                    
                default:
                    completion(nil)
                    print("-=-=-=-= Error: in API Path")
                }
                
            } else {
                completion(nil)
                print("=-=-=-=-=-Error:  No Response from API / no internet connection ")
            }
        }
    
        
        
    }
    
    
}
