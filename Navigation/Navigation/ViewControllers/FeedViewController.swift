//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class FeedViewController: UIViewController {

    private var post = Post(title: "Post title")

    lazy var goToPostButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Go To Post"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                goToPost()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setSubviews(goToPostButton)
        setConstraints()
    }
}

// MARK: - Setup Settings
extension FeedViewController {
    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            goToPostButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            goToPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            goToPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Private Methods
extension FeedViewController {
    private func goToPost() {
        let postVC = PostViewController()
        postVC.postTitle = post.title
        postVC.hidesBottomBarWhenPushed = true
        navigationController?.show(postVC, sender: nil)

    }
}
