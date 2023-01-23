//
//  LogInViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 06.12.2022.
//

import UIKit


final class LogInViewController: UIViewController {
    
    let user = User.getDefaultUser()
    private let VKColor = UIColor(named: "VKColor")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray5
        scrollView.addSubview(contentView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(
            width: .zero,
            height: UIScreen.main.bounds.height + 300
        )
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "VKLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Email or Phone"
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: textField.frame.height)
        )
        textField.leftViewMode = .always
        setKeyboardSettings(forUITextField: textField)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: textField.frame.height)
        )
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        setKeyboardSettings(forUITextField: textField)
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.outline()
        buttonConfiguration.title = "Log In"
        buttonConfiguration.background.backgroundColor = VKColor
        buttonConfiguration.baseForegroundColor = VKColor
        var button = OutlineButton(
            configuration: buttonConfiguration,
            primaryAction: nil
        )
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(logInButtonDidTapped),
            for: .touchUpInside
        )
        button.isSelected = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        scrollView.contentSize = CGSize(
            width: .zero,
            height: UIScreen.main.bounds.height+300
        )
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.height+300,
            height: .zero
        )
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
        let keyboardFrameSize = (
            userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        ).cgRectValue
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        scrollView.contentSize = CGSize(
            width: .zero,
            height: view.bounds.size.height + keyboardFrameSize.height
        )
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func logInButtonDidTapped() {
        let profileVC = ProfileViewController()
        guard let logInValue = emailOrPhoneTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        navigationController?.pushViewController(profileVC, animated: true)
        
        if user.password == password &&
            (user.email == logInValue || user.phone == logInValue) &&
            isValidEmail(logInValue) {
            alertLabel.isHidden = true
            emailOrPhoneTextField.text = ""
            passwordTextField.text = ""
            navigationController?.pushViewController(profileVC, animated: true)
        } else if logInValue.count == 0 {
            showAlertText(withText: "Email/Phone must be not empty!")
            shakeTextField(emailOrPhoneTextField)
        } else if password.count == 0 {
            showAlertText(withText: "Password must be not empty!")
            shakeTextField(passwordTextField)
        } else {
            showAlertText(withText: "Wrong Email/Phone or Password")
            shakeTextField(emailOrPhoneTextField)
            shakeTextField(passwordTextField)
            showAlert(
                withTitle: "Ops!",
                andMessage: "Wrong Email/Phone or Password \n Email: foobar@gmail.com \n Password: password",
                textField: passwordTextField
            )
        }
    }
    
    private func shakeTextField(_ textField: UITextField) {
        textField.shake()
    }
    
    private func showAlertText(withText text: String) {
        alertLabel.isHidden = false
        alertLabel.text = text
    }
    
    private func showAlert(withTitle title: String,
                           andMessage message: String,
                           textField: UITextField?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = ""
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            logoImageView,
            alertLabel,
            loginStackView,
            logInButton
        )
        loginStackView.addArrangedSubview(emailOrPhoneTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 200),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            alertLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            alertLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 10),
            loginStackView.heightAnchor.constraint(equalToConstant: 80),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    private func setKeyboardSettings(forUITextField textField: UITextField) {
        textField.delegate = self
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.clearButtonMode = .always
        let tapOnView = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapOnView)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}

extension UIView {
    func shake(for duration: TimeInterval = 0.5,
               withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }
}
