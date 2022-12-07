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
        view.backgroundColor = .lightGray
        title = postTitle
        setupNavigationBar()
    }
}

// MARK: - Private Methods
extension PostViewController {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .darkGray
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "Info",
                style: .done,
                target: self,
                action: #selector(goToInfo)
            )]
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func goToInfo() {
        let infoVC = InfoViewController()
        infoVC.hidesBottomBarWhenPushed = true
        navigationController?.present(infoVC, animated: true)
    }
}
