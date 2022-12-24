//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Илья Дубенский on 16.12.2022.
//xx

import UIKit

class PostTableViewCell: UITableViewCell {

    static let identifier = "postCell"

    lazy var postAuthor: UILabel = {
        let author = UILabel()
        author.text = ""
        author.font = UIFont.boldSystemFont(ofSize: 20)
        author.textColor = .black
        author.numberOfLines = 2
        author.translatesAutoresizingMaskIntoConstraints = false
        return author
    }()

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var descriptionText: UILabel = {
        let descriptionText = UILabel()
        descriptionText.text = ""
        descriptionText.textColor = .systemGray
        descriptionText.font = UIFont.systemFont(ofSize: 14)
        descriptionText.numberOfLines = 0
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        return descriptionText
    }()

    lazy var likes: UILabel = {
        let likes = UILabel()
        likes.textColor = .black
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.text = ""
        likes.numberOfLines = 0
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    lazy var views: UILabel = {
        let views = UILabel()
        views.textColor = .black
        views.text = ""
        views.font = UIFont.systemFont(ofSize: 16)
        views.numberOfLines = 0
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews(postAuthor, postImageView, descriptionText, likes, views)
        setConstraints()
    }

    func setupCell(with post: Post) {
        postAuthor.text = post.author.fullName
        postImageView.image = UIImage(named: post.image)
        descriptionText.text = post.description
        likes.text = "Views: \(post.views)"
        views.text = "Likes: \(post.likes)"
        }

}

extension PostTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            postAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),

            descriptionText.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            postImageView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 10),
            postImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            likes.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likes.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            views.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            views.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }


}
