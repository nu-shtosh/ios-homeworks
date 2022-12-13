//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Private Properties
    lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addSubviews(profileHeader)
        setConstraints()
        view.backgroundColor = .systemGray5
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
        navBarAppearance.backgroundColor = .systemGray3
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor") ?? UIColor.systemCyan]
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            profileHeader.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
