//
//  MovieListItem.swift
//  movie
//
//  Created by Seda Şahin on 3.03.2024.
//

import Foundation
import UIKit
import Kingfisher

class MovieListItem: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 10
        return view
    }()

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }()

    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .lightGray
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        let aspectRatioConstraint = NSLayoutConstraint(item: containerView,
                                                               attribute: .width,
                                                               relatedBy: .equal,
                                                               toItem: containerView,
                                                               attribute: .height,
                                                               multiplier: 3.0,
                                                               constant: 0.0)
       aspectRatioConstraint.isActive = true
       let aspectRatioConstraintImage = NSLayoutConstraint(item: movieImageView,
                                                               attribute: .width,
                                                               relatedBy: .equal,
                                                               toItem: movieImageView,
                                                               attribute: .height,
                                                            multiplier: 0.7,
                                                               constant: 0.0)
        aspectRatioConstraintImage.isActive = true
        selectionStyle = .none
        selectedBackgroundView = UIView()
        let starRatingStackView: UIStackView = {
                    let stackView = UIStackView(arrangedSubviews: [starImageView, ratingLabel])
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.axis = .horizontal
                    stackView.spacing = 4
                    return stackView
                }()
        let labelsStackView: UIStackView = {
                    let stackView = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel, starRatingStackView])
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.axis = .vertical
                    stackView.spacing = 4
                    return stackView
                }()
        contentView.addSubview(containerView)
        contentView.backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.addSubview(movieImageView)
        containerView.addSubview(labelsStackView)
        containerView.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            movieImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            labelsStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            labelsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            arrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with movie: Movie) {
        movieImageView.kf.setImage(with: URL(string:"https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"))
        titleLabel.text = movie.title
        if let year = movie.releaseDate?.components(separatedBy: "-").first {
            releaseDateLabel.text = "\(year)"
        }
        ratingLabel.text =  "\(String(format: "%.1f", movie.voteAverage ?? 0.0))/10"
        if movie.voteAverage ?? 0.0 < 7 {
            setStarAndRatingColor(color: .red)
        } else if movie.voteAverage ?? 0.0 >= 7 && movie.voteAverage ?? 0.0 <= 9 {
            setStarAndRatingColor(color: .orange)
        } else {
            setStarAndRatingColor(color: .green)
        }
    }

    private func setStarAndRatingColor(color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            self.starImageView.tintColor = color
            self.ratingLabel.textColor = color
        }
    }
}
