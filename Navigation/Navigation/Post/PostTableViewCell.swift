//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Илья Дубенский on 16.12.2022.
//xx

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "postTVC"

    private var post: Post!
    private var addLikeButtonDidClick: (() -> Void)!

    lazy var postAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likes: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addLike))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var views: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews(postAuthor, postImageView, descriptionText, likes, views)
        setConstraints()
    }
    
    func setupCell(with post: Post, addLikeButtonDidClick: @escaping () -> Void) {
        self.post = post
        self.addLikeButtonDidClick = addLikeButtonDidClick

        self.postAuthor.text = post.author.fullName
        self.postImageView.image = UIImage(named: post.image)
        self.descriptionText.text = post.description
        self.likes.text = "Likes: \(post.likes)"
        self.views.text = "Views: \(post.views)"
    }

    @objc func addLike() {
        self.post.likes += 1
        self.likes.text = "Likes: \(post.likes)"
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
