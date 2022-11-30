//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Илья Дубенский on 29.11.2022.
//

import UIKit

final class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private var statusText: String?

    private lazy var profileImageView: UIImageView = {
        let profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 132, height: 132))
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        return profileImage
    }()

    private lazy var profileTitleLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.font = .systemFont(ofSize: 18, weight: .bold)
        profileLabel.text = "Foo Bar"
        profileLabel.textColor = .black
        return profileLabel
    }()

    private lazy var profileStatusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.text = "*args and **kwargs..."
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .gray
        return statusLabel
    }()

    private lazy var profileStatusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.setTitle("Setup Status", for: .normal)
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.addTarget(self, action: #selector(profileStatusButtonTapped), for: .touchUpInside)
        return statusButton
    }()

    private lazy var profileStatusTextField: UITextField = {
        let statusTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.layer.masksToBounds = true
        statusTextField.placeholder = "Input yor status"
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        setKeyboardSettings(forUITextField: statusTextField)
        statusTextField.addTarget(self, action: #selector(profileStatusTextChanged), for: .editingChanged)
        return statusTextField
    }()

    override func draw(_ rect: CGRect) {
        addSubviews(
            profileImageView,
            profileTitleLabel,
            profileStatusLabel,
            profileStatusButton,
            profileStatusTextField
        )
        setConstraints()

    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 132),
            profileImageView.heightAnchor.constraint(equalToConstant: 132),

            profileTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileTitleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            profileStatusButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            profileStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            profileStatusLabel.bottomAnchor.constraint(equalTo: profileStatusButton.topAnchor, constant: -54),
            profileStatusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            profileStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 10),
            profileStatusTextField.bottomAnchor.constraint(equalTo: profileStatusButton.topAnchor, constant: -10),
            profileStatusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
        ])
    }

    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }

    @objc private func profileStatusButtonTapped() {
        guard let status = statusText, !status.isEmpty, status.count < 90 else {
            // как вывести алерт во юивью?
            return
        }
        profileStatusLabel.text = status
        profileStatusTextField.text = .none
        profileStatusTextField.resignFirstResponder()
    }

    @objc private func profileStatusTextChanged(_ textField: UITextField) {
        statusText = textField.text
        profileStatusTextField.becomeFirstResponder()
    }
}


extension ProfileHeaderView {
    private func setKeyboardSettings(forUITextField textfield: UITextField) {
        textfield.delegate = self
        textfield.keyboardAppearance = .dark
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .done
        textfield.enablesReturnKeyAutomatically = true
        textfield.clearButtonMode = .always

        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        addGestureRecognizer(tapOnView)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        profileStatusLabel.text = textField.text
        profileStatusTextField.text = .none
        profileStatusTextField.resignFirstResponder()
        return true
    }
}
