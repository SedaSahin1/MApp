//
//  MovieDetailViewModel.swift
//  movie
//
//  Created by Seda Şahin on 4.03.2024.
//

import Foundation
import Alamofire


class MovieDetailViewModel: ViewModel {
    var movieDetail: MovieDetail?
    var movieId: Int?
    init(movieId: Int) {
        self.movieId = movieId
    }
}

extension MovieDetailViewModel {
    func getMovieDetail() {
        
        let url = "\(baseURL)\(self.movieId ?? 0)"
        let parameters: [String: Any] = ["api_key" : "\(apiKey)","language" : "en-US"]
        let method: HTTPMethod = .get
        
        MovieService.shared.getMovies(url: url, method: method, parameters: parameters, responseType: MovieDetail.self) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                print(data)
                strongSelf.movieDetail = data
                strongSelf.updateUI?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

