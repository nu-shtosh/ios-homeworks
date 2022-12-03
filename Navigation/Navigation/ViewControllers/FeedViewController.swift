//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class FeedViewController: UIViewController {

    lazy private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()

    // MARK: - Properties
    private var post = Post(title: "This is a post title")

    // MARK: - IBElements
    lazy var goToPostButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .systemBlue

        buttonConfiguration.title = "Go To Post"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                goToPost()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()

    lazy var goToPostButtonSecond: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .systemCyan

        buttonConfiguration.title = "Go To Post"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                goToPost()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setSubviews(stackView)
        setStackSubviews(goToPostButton, goToPostButtonSecond)
        setupNavigationBar()
        setConstraints()
    }
}

// MARK: - Setup Settings
extension FeedViewController {
    private func setupNavigationBar() {
        title = "Feed"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .darkGray
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }

    private func setStackSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Private Methods
extension FeedViewController {
    private func goToPost() {
        let postVC = PostViewController()
        postVC.postTitle = post.title
        postVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postVC, animated: true)
    }
}
