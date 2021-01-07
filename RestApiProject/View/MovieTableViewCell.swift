//
//  MovieTableViewCell.swift
//  RestApiProject
//
//  Created by Nadia Mettioui on 06/01/2021.
//  Copyright © 2021 Sirania'Dev. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movietitle: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    private var urlString: String = ""
    
    //Setup Movie value in the cell
   func setUpCell(_ movie: Movie){
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    private func updateUI(title: String? ,releaseDate: String?, rating: Double?, overview: String?, poster: String?){
        self.movietitle.text = title
        self.movieYear.text = convertData(releaseDate)
        guard let rate = rating else {return}
        self .movieRating.text = String(rate)
        self.movieOverview.text = overview
        guard let posterString = poster else {return}
        urlString = "https://image.tmdp.org/t/p/w300" + posterString
        
        guard let posterImagURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "NoImageAvailable")
            return
            
        }
        //vider image
        self.moviePoster.image = nil
        getImageData(url: posterImagURL)
        
    }
    
    //MARK: GetImage Data
    private func getImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { (data,response, error)in
            //traiter error
            if let error = error {
                print("datatask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                //empty data
                print("empty")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.moviePoster.image = image
                }
            }

        }.resume()
    }
    
    
    func convertData(_ date: String?)-> String {
        var fDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originaleDate = date {
            if let newDate = dateFormatter.date(from: originaleDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fDate = dateFormatter.string(from: newDate)
            }
        }
        return fDate
    }
}
