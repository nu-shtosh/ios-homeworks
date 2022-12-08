//
//  LogInViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 06.12.2022.
//

import UIKit


final class LogInViewController: UIViewController {

    let user = User.getDefaultUser()

    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray5
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    lazy private var contentView: LogInUIView = {
        let contentView = LogInUIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.logInButton.addTarget(
            self,
            action: #selector(logInButtonDidTapped),
            for: .touchUpInside
        )
        return contentView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setConstraint()
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: .zero, height: UIScreen.main.bounds.height+300)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        addObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        scrollView.contentSize = CGSize(width: .zero, height: view.bounds.size.height + keyboardFrameSize.height)
    }

    @objc func keyboardDidHide(notification: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

    }

    @objc func logInButtonDidTapped() {
        let profileVC = ProfileViewController()
        guard let logInValue = contentView.emailOrPhoneTextField.text else { return }
        guard let password = contentView.passwordTextField.text else { return }
        if user.password == password &&
            (user.email == logInValue || user.phone == logInValue) {
            profileVC.profileHeader.profileStatusLabel.text = user.status
            profileVC.profileHeader.profileFullNameLabel.text = user.fullName
            profileVC.profileHeader.profileAvatarImageView.image = UIImage(named: user.image)
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            navigationController?.pushViewController(profileVC, animated: true)
            //для дз
            // TODO: потом здес будет шоуалерт
        }
    }


    private func setConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),


            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

