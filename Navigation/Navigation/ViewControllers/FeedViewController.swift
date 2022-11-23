//
//  FeedViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - Properties
    private var post = Post(title: "This is a post title")

    // MARK: - IBElements
    lazy var goToPostButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .gray

        buttonConfiguration.title = "Go To Post"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                goToPost()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setSubviews(goToPostButton)
        setupNavigationBar()
        setConstraints()
    }

    // ВОПРОС: нужно ли прятать навбар? выглядит не очень эстетично)
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    */
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

        navigationController?.pushViewController(postVC, animated: true)
    }
}
