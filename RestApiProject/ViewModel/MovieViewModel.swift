//
//  MovieViewModel.swift
//  RestApiProject
//
//  Created by Nadia Mettioui on 06/01/2021.
//  Copyright © 2021 Sirania'Dev. All rights reserved.
//

import Foundation
class MovieViewModel {
    private var apiService = APiService()
    private var popularMovies = [Movie]()
    
    func fetchMovies(completion: @escaping () -> ()) {
        apiService.getDataMovie { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                print(listOf.movies.count)
                completion()
            case .failure(let error):
                print("erreur process in jsdonData \(error)")
            }
        }
    }
    func nbOfRowsInSection(section: Int)-> Int {
        if popularMovies.count != 0 {
            print("ddfdfd  \(popularMovies.count)")
            return popularMovies.count
        }
         return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        
        return popularMovies[indexPath.row]
        
    }
}
