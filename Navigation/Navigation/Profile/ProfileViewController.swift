//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//


import UIKit

class ProfileViewController: UIViewController {

    private var posts = Post.getDefaultPosts()

    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.backgroundColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        view.addSubview(postTableView)
        postTableView.reloadData()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        postTableView.reloadData()
    }
}

extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier)
        return headerView
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return posts.count
        }
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        default:
            let postDetailVC = PostDetailViewController()
            var post = posts[indexPath.row]
            post.views += 1
            postDetailVC.post = post
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(postDetailVC, animated: true)
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
            cell.setupCell(with: post) {
                self.postTableView.reloadData()
            }
            return cell
        }
    }
}
