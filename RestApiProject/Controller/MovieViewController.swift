//
//  MovieViewController.swift
//  RestApiProject
//
//  Created by Nadia Mettioui on 06/01/2021.
//  Copyright © 2021 Sirania'Dev. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
      loadDataInTableView()
        // Do any additional setup after loading the view.
    }
    

    private func loadDataInTableView(){
        viewModel.fetchMovies { [weak self] in
          //  self?.tableView.dataSource = self
           
            self?.tableView.reloadData()
        }
    }


}

extension MovieViewController: UITableViewDataSource,UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewModel.nbOfRowsInSection(section: section)
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
           let movie = viewModel.cellForRowAt(indexPath: indexPath)
           cell.setUpCell(movie)
           return cell
       }
    
}
