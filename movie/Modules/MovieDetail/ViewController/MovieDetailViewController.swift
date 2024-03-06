//
//  MovieDetailViewController.swift
//  movie
//
//  Created by Seda Şahin on 4.03.2024.
//

import Foundation
import UIKit

class  MovieDetailViewController: ViewController<MovieDetailViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.updateUI = { [weak self] in
            self?.stopLoading()
            self?.setupLabel()
        }
        startLoading()
        viewModel?.getMovieDetail()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "MovieDETAIL"
        if let title = self.navigationItem.title {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.title = title
        }
    }
    
    func setupLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel?.movieDetail?.title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
