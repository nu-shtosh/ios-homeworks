//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 24.12.2022.
//

import UIKit

final class PhotosViewController: UIViewController{

    private let photos = DataStorage.shared.photos

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 118, height: 118)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubviews(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

extension PhotosViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Photo Gallery"
        navBarAppearance.backgroundColor = .systemGray3
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "VKColor")
                                                ?? UIColor.systemCyan]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "VKColor")
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as! PhotoCollectionViewCell

        let photo = UIImage(named: photos[indexPath.item])

        cell.photoImage.image = photo
        return cell
    }
}
