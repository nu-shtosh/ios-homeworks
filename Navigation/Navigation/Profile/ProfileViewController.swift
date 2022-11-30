//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Private Properties
    lazy private var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.frame = view.frame
        profileHeader.backgroundColor = .lightGray
        return profileHeader
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        addSubviews(profileHeader)
    }
}

// MARK: - Setup Settings
extension ProfileViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }

    private func setupNavigationBar() {
        title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .darkGray

        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.tintColor = .white
    }
}
