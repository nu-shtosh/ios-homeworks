//
//  InfoViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 22.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    lazy var showAlertButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = UIColor(named: "VKColor")
        buttonConfiguration.title = "Show Alert"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                showAlert(withTitle: "Hi!", andMessage: "This is Alert!")
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()

    lazy var cancelButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .systemRed
        buttonConfiguration.title = "Cancel"
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                dismiss(animated: true)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        return button
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        view.addSubviewsIn(view, showAlertButton, cancelButton)
        setConstraints()
    }

}

// MARK: - Setup Settings
extension InfoViewController {

    private func setConstraints() {
        NSLayoutConstraint.activate([
            showAlertButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            showAlertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            showAlertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Alert
extension InfoViewController {
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print("This is Ok Action")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("This is Cancel Action")
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
