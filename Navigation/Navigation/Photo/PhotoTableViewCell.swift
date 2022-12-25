//
//  PhotoTableViewCell.swift
//  Navigation
//
//  Created by Илья Дубенский on 24.12.2022.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "photoTVC"
    
    private let photos = DataStorage.shared.photos
    
    private lazy var photoLabel: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.text = "Photos"
        labelView.font = UIFont.boldSystemFont(ofSize: 20)
        labelView.textColor = .black
        return labelView
    }()
    
    private lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var photosStackViewImage: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(photoLabel, rightArrowImage, photosStackViewImage)
        setPhotosStack()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPhotos(index: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: photos[index])
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }
}

extension PhotoTableViewCell {
    private func setPhotosStack() {
        for index in 0..<4 {
            let photo = setPhotos(index: index)
            photosStackViewImage.addArrangedSubview(photo)
            NSLayoutConstraint.activate([
                photo.widthAnchor.constraint(equalToConstant: 120),
                photo.heightAnchor.constraint(equalTo: photo.widthAnchor),
            ])
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoLabel.widthAnchor.constraint(equalToConstant: 70),
            photoLabel.heightAnchor.constraint(equalToConstant: 30),
            
            rightArrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            rightArrowImage.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            rightArrowImage.heightAnchor.constraint(equalToConstant: 30),
            rightArrowImage.widthAnchor.constraint(equalToConstant: 30),
            
            photosStackViewImage.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photosStackViewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosStackViewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosStackViewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}
