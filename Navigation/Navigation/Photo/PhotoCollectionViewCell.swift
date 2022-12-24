//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Илья Дубенский on 24.12.2022.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "photoCVC"

    lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(photoImage)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
