//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import Alamofire

//MARK: - Protocols
protocol MovieViewModelProtocol{
    func searchMovie(searchMovieName: String, onSuccess: @escaping (Result?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieImdbId: String, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void)
    var delegate: MovieOutput? { get set }
}


final class MovieViewModel: MovieViewModelProtocol {
    
    //MARK: - Properties
    var delegate: MovieOutput?
    private var service: ServiceProtocol
    //MARK: - Life Cycle
    init(service: ServiceProtocol) {
        self.service = service
    }
}

//MARK: - Extension Protocol Functions
extension MovieViewModel {
    func searchMovie(searchMovieName: String, onSuccess: @escaping (Result?) -> Void, onError: @escaping (AFError) -> Void) {
        service.searchMovie(searchMovieName: searchMovieName) { movie in
            guard let movie = movie else {
                onSuccess(nil)
                return
            }
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
    }
    
    func getMovieDetail(movieImdbId: String, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        service.getMovieDetail(movieImdbId: movieImdbId) { movieDetail in
            guard let movieDetail = movieDetail else {
                onSuccess(nil)
                return
            }
            onSuccess(movieDetail)
        } onError: { error in
            onError(error)
        }
    }
}
