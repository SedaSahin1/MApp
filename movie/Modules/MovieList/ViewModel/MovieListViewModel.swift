//
//  MovieListViewModel.swift
//  movie
//
//  Created by Seda Şahin on 3.03.2024.
//

import Foundation
import Alamofire

class MovieListViewModel: ViewModel {
    var movieList: MovieList?
    var movies: [Movie]? = []
    var imageData: MovieImage?
    var movieEntity: [MovieEntity]? = []
    let cache = NSCache<NSString, AnyObject>()
}

extension MovieListViewModel {

    func getMovies(next: Int) {
        let url = "\(baseURL)popular"
        let method: HTTPMethod = .get
        let parameters: [String: Any] = ["api_key" : "\(apiKey)","language" : "en-US", "page" : next]
        
        MovieService.shared.getMovies(url: url, method: method, parameters: parameters, responseType: MovieList.self) { result in
            switch result {
            case .success(let movies):
                print(movies)
                  self.movieList = movies
                  self.movies?.append(contentsOf: movies.results!)
                  self.updateUI?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
