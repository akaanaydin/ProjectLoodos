//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import UIKit
import SnapKit
import Alamofire

//MARK: - Protocols
protocol MovieOutput {
    func selectedMovies(movieID: String)
}

class MovieController: UIViewController {
    //MARK: - UI Elements
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.rowHeight = 230
        return tv
    }()
    private let searchController: UISearchController = UISearchController()
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Color.appWhite
        label.text = "There were no results."
        return label
    }()

    //MARK: - Properties
    private lazy var searchResult = [Search]()
    private var viewModel: MovieViewModelProtocol = MovieViewModel(service: Services())
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: - Functions
    private func configure() {
        subviews()
        drawDesign()
        configureConstraits()
    }
    
    private func drawDesign() {
        // View
        view.backgroundColor = Color.appBlack
        // View Model
        viewModel.delegate = self
        // Navigation Bar
        configureNavigationBar(largeTitleColor: Color.appWhite, backgoundColor: Color.appBlack, tintColor: Color.appWhite, title: "Search", preferredLargeTitle: false)
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.searchController = searchController
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableCell.self, forCellReuseIdentifier: MovieTableCell.Identifier.custom.rawValue)
        // Search Bar
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
    }
    
    private func subviews() {
        view.addSubview(tableView)
        view.addSubview(noResultLabel)
    }
}
//MARK: - Table View Extension
extension MovieController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableCell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.Identifier.custom.rawValue) as? MovieTableCell else {
            return UITableViewCell()
        }
        cell.saveMovieModel(model: searchResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let movieID = searchResult[indexPath.row].imdbID else { return }
        print("MOVIE", movieID)
        viewModel.delegate?.selectedMovies(movieID: movieID)
    }
}
//MARK: - Snapkit Extension
extension MovieController {
    private func configureConstraits() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

//MARK: - View Model Extension
extension MovieController: MovieOutput {
    func selectedMovies(movieID: String) {
        viewModel.getMovieDetail(movieImdbId: movieID) { movie in
            guard let movie = movie else { return }
            self.navigationController?.pushViewController(MovieDetailController(detailResults: movie), animated: true)
        } onError: { error in
            self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
        }

    }
}

// MARK: - Search Controller Extension
extension MovieController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let writtenText = searchController.searchBar.text else { return }
        let searchMovieName = writtenText.replacingOccurrences(of: " ", with: "%20")
        
        if writtenText == "" {
            noResultLabel.isHidden = false
        }else{
            noResultLabel.isHidden = true
        }
        
        viewModel.searchMovie(searchMovieName: searchMovieName) { movies in
            self.searchResult = movies?.search ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } onError: { error in
            self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
        }
    }
}

// MARK: - Alert
extension MovieController {
    func makeAlert(titleInput:String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            self.searchController.searchBar.text = nil
        }
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
    }
}
