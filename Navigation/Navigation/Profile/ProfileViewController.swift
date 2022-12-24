//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//


import UIKit

class ProfileViewController: UIViewController {

    private let posts = Post.getDefaultPosts()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.backgroundColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        view.addSubview(tableView)
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
}

extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupNavigationBar() {
        title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemGray3
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor") ?? UIColor.systemCyan]
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return posts.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotoTableViewCell.identifier,
                for: indexPath
            ) as! PhotoTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.identifier
            ) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.setupCell(with: post)
            return cell
        }
    }
}
