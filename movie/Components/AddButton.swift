//
//  AddButton.swift
//  movie
//
//  Created by Seda Şahin on 6.03.2024.
//

import Foundation
import UIKit

class AddButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setTitleColor(.green, for: .normal)
        setTitle("Add", for: .normal)

        let plusImage = UIImage(systemName: "plus")
        let plusImageView = UIImageView(image: plusImage)
        plusImageView.tintColor = .green
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(plusImageView)

        NSLayoutConstraint.activate([
            plusImageView.trailingAnchor.constraint(equalTo: titleLabel!.leadingAnchor, constant: -4),
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusImageView.widthAnchor.constraint(equalToConstant: 20),
            plusImageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        layer.cornerRadius = 8
        addDashedBorder()
    }

    private func addDashedBorder() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.green.cgColor
        borderLayer.lineDashPattern = [4, 4]
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.addSublayer(borderLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        addDashedBorder()
    }
}

