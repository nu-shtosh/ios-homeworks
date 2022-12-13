//
//  LoginView.swift
//  Navigation
//
//  Created by Илья Дубенский on 06.12.2022.
//

import UIKit

final class LogInView: UIView {
    private let VKColor = UIColor(named: "VKColor")

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "VKLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var emailOrPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Email or Phone"
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        setKeyboardSettings(forUITextField: textField)
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        setKeyboardSettings(forUITextField: textField)
        return textField
    }()

    lazy var logInButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.outline()
        buttonConfiguration.title = "Log In"
        buttonConfiguration.background.backgroundColor = VKColor
        buttonConfiguration.baseForegroundColor = VKColor
        var button = OutlineButton(configuration: buttonConfiguration, primaryAction: nil)
        button.isSelected = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            logoImageView,
            emailOrPhoneTextField,
            passwordTextField,
            logInButton
        )
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LogInView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            emailOrPhoneTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            emailOrPhoneTextField.heightAnchor.constraint(equalToConstant: 50),
            emailOrPhoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailOrPhoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            passwordTextField.topAnchor.constraint(equalTo: emailOrPhoneTextField.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}

extension LogInView: UITextFieldDelegate {
    private func setKeyboardSettings(forUITextField textField: UITextField) {
        textField.delegate = self
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.clearButtonMode = .always
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapOnView)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}
