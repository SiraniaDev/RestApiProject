//
//  APIService.swift
//  RestApiProject
//
//  Created by Nadia Mettioui on 05/01/2021.
//  Copyright © 2021 Sirania'Dev. All rights reserved.
//

import Foundation
class APiService  {
    private var dataTask : URLSessionDataTask?
    
    
    
    func getDataMovie(completion: @escaping (Result<MoviesData, Error>)-> Void) {
        let movieUrl =  "https://api.themoviedb.org/3/movie/popular?api_key=69912bfa48860d2551fc6de1c8ed5c00&language=en-US&page=2"
        
//         let movieUrl =  "https://api.themoviedb.org/3/movie/top_rated?api_key=69912bfa48860d2551fc6de1c8ed5c00&language=fr-FR&page=1"
        guard let url = URL(string: movieUrl) else {return}
        // Creer l' URL Session
        print("kkkk")
        dataTask = URLSession.shared.dataTask(with: url) { (data,response,error) in
            // traiter les errreurs
            print("Les données de l API =>" + String(data: data!, encoding: .utf8)!)
               
            if let error = error {
                completion(.failure(error))
                print("\(error.localizedDescription)")
                return
            }
            //Si pas de response de API
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }

                print("Responsestatus Code: \(response.statusCode)")

            guard let  data = data else {
                print("no Data")
                return

            }
            do //traitement Data
            {
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                print(jsonData)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    print("succes")
                }
            }
            catch let error {
                completion(.failure(error))
                //print("error")
                
            }
            
        }
            
        
            self.dataTask?.resume()

}
}
