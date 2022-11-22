//
//  PostViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

final class PostViewController: UIViewController {

    var postTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = postTitle
    }
}
