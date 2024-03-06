//
//  MovieListViewController.swift
//  movie
//
//  Created by Seda Şahin on 3.03.2024.
//

import Foundation
import UIKit

class MovieListViewController: ViewController<MovieListViewModel> {
    private let movieListTableView = UITableView()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupAddMovieButton()
        let movieListViewModel = MovieListViewModel()
        viewModel = movieListViewModel
        viewModel?.updateUI = { [weak self] in
            self?.isLoading = false
            self?.movieListTableView.reloadData()
        }
    }
    
    func setupUI(){
        view.backgroundColor = .white
        movieListTableView.backgroundColor = .white
        navigationItem.title = "MovieLIST"
        if let title = self.navigationItem.title {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.title = title
        }
    }

    private func setupAddMovieButton() {
        view.addSubview(addMovieButton)
        NSLayoutConstraint.activate([
            addMovieButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            addMovieButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            addMovieButton.heightAnchor.constraint(equalToConstant: 54),
            addMovieButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        addMovieButton.addGestureRecognizer(tapGesture)
    }

    private func setupTableView() {
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.separatorStyle = .none
        movieListTableView.register(MovieListItem.self, forCellReuseIdentifier: "MovieCell")
        movieListTableView.showsVerticalScrollIndicator = false
        view.addSubview(movieListTableView)
        movieListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            movieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            movieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -68)
        ])
    }

    private let addMovieButton: AddButton = {
        let button = AddButton()
        return button
    }()
    
    @objc private func addButtonTapped() {
        alert(title: "", message: "Add button tapped!")
    }
}

extension MovieListViewController:  UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieListItem
        let movie = (viewModel?.movies?[indexPath.row])!
        cell.update(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = (viewModel?.movies?[indexPath.row])!
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.viewModel = MovieDetailViewModel(movieId: movie.id ?? 0)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        if offsetY > contentHeight - screenHeight {
           loadPage()
        }
     }
     func loadPage() {
         guard !isLoading else { return }
         isLoading = true
         if (viewModel?.movies?.count ?? 0) < 100 {
             viewModel?.getMovies(next: (viewModel?.movieList?.page ?? 0) + 1)
         }
    }
}
