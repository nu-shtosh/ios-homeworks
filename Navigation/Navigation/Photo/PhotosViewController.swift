//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Илья Дубенский on 24.12.2022.
//

import UIKit

enum Paddings {
    static let page: CGFloat = 16
    static let photosPreview: CGFloat = 12
    static let photo: CGFloat = 8
}

final class PhotosViewController: UIViewController{
    
    private let photos = DataStorage.shared.photos
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 118, height: 118)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(
            top: 8,
            left: 8,
            bottom: 8,
            right: 8
        )
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private lazy var fullScreenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.0
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubviews(photosCollectionView,
                         backgroundView,
                         fullScreenImage)
        
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
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fullScreenImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            fullScreenImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            fullScreenImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullScreenImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeImg)
        )
        navigationItem.rightBarButtonItem?.isHidden = true
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        photos.count
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

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageFrame = (photosCollectionView.frame.width - 4 * Paddings.photo) / 3
        return CGSize(width: imageFrame, height: imageFrame)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Paddings.photo,
            left: Paddings.photo,
            bottom: Paddings.photo,
            right: Paddings.photo
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Paddings.photo
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Paddings.photo
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        fullScreenImage.image = UIImage(named: photos[indexPath.row])
        navigationItem.rightBarButtonItem?.isHidden = false
        UIView.animate(withDuration: 1) { [self] in
            fullScreenImage.alpha = 1
            backgroundView.alpha = 0.5
        }
    }
    
    @objc func closeImg(){
        navigationItem.rightBarButtonItem?.isHidden = true
        UIView.animate(withDuration: 1) { [self] in
            fullScreenImage.alpha = 0
            backgroundView.alpha = 0
        }
    }
}
