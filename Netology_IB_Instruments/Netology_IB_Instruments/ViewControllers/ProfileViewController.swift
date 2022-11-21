//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Илья Дубенский on 20.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Private Properties
    private var profileViewXib: ProfileView!
    private var profile = Profile.getProfile()

    // MARK: - App Life Cicle
    override func viewWillLayoutSubviews() {
        setSettings()
        setValue()
    }

}

// MARK: - Private Methods
extension ProfileViewController {
    private func setSettings() {
        profileViewXib = Bundle.main.loadNibNamed(
            "ProfileView",
            owner: nil,
            options: nil
        )?.first as? ProfileView
        view.addSubview(profileViewXib)
        profileViewXib.frame = CGRect(
            x: view.frame.origin.x,
            y: view.frame.origin.y + 40,
            width: view.frame.width,
            height: view.frame.height
        )

        profileViewXib.imageView.layer.cornerRadius = profileViewXib.imageView.frame.width / 2

        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        profileViewXib.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

        profileViewXib.bioLabel.backgroundColor = .clear
        profileViewXib.bioLabel.textColor = .white
        profileViewXib.bioLabel.isEditable = false

        profileViewXib.nameLabel.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        print(profileViewXib.nameLabel.layer.cornerRadius)
        profileViewXib.nameLabel.textColor = .white


        profileViewXib.birthDayLabel.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        profileViewXib.birthDayLabel.textColor = .white

        profileViewXib.currentTownLabel.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        profileViewXib.currentTownLabel.textColor = .white

    }

    private func setValue() {

        profileViewXib.imageView.image = UIImage(named: profile.photo)

        profileViewXib.nameLabel.text = profile.fullName
        profileViewXib.birthDayLabel.text = profile.birthDay
        profileViewXib.currentTownLabel.text = profile.currentTown

        profileViewXib.bioLabel.text = profile.bio

    }
}
