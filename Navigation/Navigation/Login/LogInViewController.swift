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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: .zero, height: UIScreen.main.bounds.height + 300)
        return scrollView
    }()

    lazy private var contentView: LogInView = {
        let contentView = LogInView()
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

        setupScrollView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        scrollView.contentSize = CGSize(width: .zero, height: UIScreen.main.bounds.height+300)
        addObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.height+300, height: .zero)
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

        scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        scrollView.contentSize = CGSize(width: .zero, height: view.bounds.size.height + keyboardFrameSize.height)

    }

    @objc func keyboardDidHide(notification: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

    }

    @objc func logInButtonDidTapped() {
        let profileVC = ProfileViewController()
        let profileHeader = ProfileHeaderView()
        guard let logInValue = contentView.emailOrPhoneTextField.text else { return }
        guard let password = contentView.passwordTextField.text else { return }
        if user.password == password &&
            (user.email == logInValue || user.phone == logInValue) {
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            navigationController?.pushViewController(profileVC, animated: true)
            //для дз
            // TODO: потом здес будет шоуалерт
        }
    }


    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 200).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
