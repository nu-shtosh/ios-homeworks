//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//


import UIKit

class ProfileViewController: UIViewController {

    private let posts = Post.getDefaultPosts()
    private let user = User.getDefaultUser()


    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.frame
        tableView.backgroundColor = .systemGray3
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .systemGray3
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        view.addSubview(tableView)
        setConstraints()
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
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as! ProfileHeaderView
        header.profileStatusLabel.text = posts[indexPath.item].author.status
        header.profileAvatarImageView.image = UIImage(named: posts[indexPath.item].author.image)
        header.profileFullNameLabel.text = posts[indexPath.item].author.fullName
        cell.postAuthor.text = posts[indexPath.item].author.fullName
        cell.postImageView.image = UIImage(named: posts[indexPath.item].image)
        cell.descriptionText.text = posts[indexPath.item].description
        cell.likes.text = "Likes: \(posts[indexPath.item].likes)"
        cell.views.text = "Views: \(posts[indexPath.item].views)"
        return cell
    }

}
//
//final class ProfileViewController: UIViewController {
//
//    // MARK: - Private Properties

//
//    // MARK: - View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        addSubviews(profileHeader)
//        setConstraints()
//        view.backgroundColor = .systemGray5
//    }
//}
//
//// MARK: - Setup Settings
//extension ProfileViewController {
//    private func addSubviews(_ subviews: UIView...) {
//        subviews.forEach { subview in
//            view.addSubview(subview)
//        }
//    }
//
//    private func setupNavigationBar() {
//        title = "Profile"
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.backgroundColor = .systemGray3
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor") ?? UIColor.systemCyan]
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
//    }
//
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            profileHeader.heightAnchor.constraint(equalToConstant: 250)
//        ])
//    }
//}
