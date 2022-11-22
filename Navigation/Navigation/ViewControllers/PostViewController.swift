//
//  PostViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class PostViewController: UIViewController {

    // MARK: - Properties
    var postTitle: String!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = postTitle
    }
}
