//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Илья Дубенский on 29.11.2022.
//

import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {

    static let identifier = "profileTVHFV"

    let user = User.getDefaultUser()

    // MARK: - Private Properties
    private var avatarIsFullScreen = false
    private var statusText: String?
    private var fullNameText: String?
    private var profileAvatarStartPoint = CGPoint()

    lazy var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 66
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: user.image)
        imageGestureSettings(imageView: imageView)
        return imageView
    }()

    private var avatarBackground: UIView = {
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        view.backgroundColor = .darkGray
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.backgroundColor = .clear
        button.contentMode = .scaleToFill
        button.setImage(
            UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 22
                )
            )?.withTintColor(.black, renderingMode: .automatic), for: .normal
        )
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
        return button
    }()


    lazy var profileFullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = user.fullName
        label.textColor = .black
        return label
    }()

    lazy var profileStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = user.status
        label.numberOfLines = 3
        label.textColor = .gray
        return label
    }()
    
    private lazy var profileChangeStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Setup Status", for: .normal)
        button.backgroundColor = UIColor(named: "VKColor")
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(profileChangeStatusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var profileStatusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Input your status"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        setKeyboardSettings(forUITextField: textField)
        textField.addTarget(self, action: #selector(profileStatusTextChanged), for: .editingChanged)
        return textField
    }()


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray3
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        contentView.addSubviews(
            profileFullNameLabel,
            profileStatusLabel,
            profileStatusTextField,
            profileChangeStatusButton,
            avatarBackground,
            profileAvatarImageView,
            backButton
        )
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func profileChangeStatusButtonTapped() {
        print("New profile status \(statusText ?? "")")
        profileStatusLabel.text = statusText ?? ""
        profileStatusTextField.text = .none
        profileStatusTextField.resignFirstResponder()
    }

    @objc private func profileStatusTextChanged(_ textField: UITextField) {
        guard let status = textField.text, status.count <= 90 else {
            while textField.text?.count != 89 {
                textField.text?.removeLast()
            }
            showAlert(withTitle: "Oops!", andMessage:  "You can input maximum 90 symbols!")
            return
        }
        statusText = status
        profileStatusTextField.becomeFirstResponder()
    }
}

extension ProfileHeaderView {
    private func imageGestureSettings(imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarDidTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }

    @objc private func avatarDidTapped() {
        avatarIsFullScreen.toggle()
        profileAvatarImageView.isUserInteractionEnabled = false
        profileAvatarStartPoint = profileAvatarImageView.center
        let scale = UIScreen.main.bounds.width / profileAvatarImageView.bounds.width
        UIView.animate(withDuration: 0.5) {

            self.profileAvatarImageView.center = CGPoint(
                x: UIScreen.main.bounds.midX,
                y: UIScreen.main.bounds.midY - self.profileAvatarStartPoint.y
            )
            self.profileAvatarImageView.transform = CGAffineTransform(
                scaleX: scale, y: scale
            )
            self.profileAvatarImageView.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.9
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.backButton.alpha = 1
            }
        }
    }

    @objc private func backButtonDidTapped() {
        avatarIsFullScreen.toggle()
        UIImageView.animate(withDuration: 0.3) {
            self.backButton.alpha = 0
            self.profileAvatarImageView.center = self.profileAvatarStartPoint
            self.profileAvatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.profileAvatarImageView.layer.cornerRadius = self.profileAvatarImageView.frame.width / 2
            self.avatarBackground.alpha = 0
        }
    }
}

// MARK: - Setup Settings
extension ProfileHeaderView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 132),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 132),

            profileFullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            profileFullNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.trailingAnchor, constant: 16),
            profileFullNameLabel.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -16),

            profileStatusLabel.bottomAnchor.constraint(equalTo: profileChangeStatusButton.topAnchor, constant: -54),
            profileStatusLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.trailingAnchor, constant: 16),
            profileStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            profileStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 10),
            profileStatusTextField.bottomAnchor.constraint(equalTo: profileChangeStatusButton.topAnchor, constant: -10),
            profileStatusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileAvatarImageView.trailingAnchor, constant: 16),

            profileChangeStatusButton.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 16),
            profileChangeStatusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileChangeStatusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileChangeStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: - Keyboard
extension ProfileHeaderView: UITextFieldDelegate {
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

// MARK: - Alert
extension ProfileHeaderView {
    private func showAlert(withTitle title: String, andMessage message: String) {
        guard let rootVC = window?.rootViewController else { return }
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print("This is Ok Action")
        }

        alert.addAction(okAction)
        rootVC.present(alert, animated: true)
    }
}
