//
//  PostViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class PostViewController: UIViewController {

    // MARK: - Properties
    var postTitle: String!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = postTitle
        setupNavigationBar()
    }
}

// MARK: - Private Methods
extension PostViewController {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemGray3
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor") ?? UIColor.systemCyan]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "Info",
                style: .plain,
                target: self,
                action: #selector(goToInfo)
            )]
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
    
    @objc private func goToInfo() {
        let infoVC = InfoViewController()
        infoVC.hidesBottomBarWhenPushed = true
        navigationController?.present(infoVC, animated: true)
    }
}
