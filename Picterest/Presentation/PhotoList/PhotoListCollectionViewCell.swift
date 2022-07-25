//
//  PhotoListCollectionViewCell.swift
//  Picterest
//
//  Created by yc on 2022/07/25.
//

import UIKit

class PhotoListCollectionViewCell: UICollectionViewCell, CellIdentifiable {
    // MARK: - UI Components
    private lazy var topView = ImageTopView()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Properties
    var viewModel: PhotoListCollectionViewCellViewModel?
    
    // MARK: - Setup
    func setupView(index: Int) {
        configUI()
        bindImage()
        topView.setupView(index: index)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

// MARK: - Bind
private extension PhotoListCollectionViewCell {
    func bindImage() {
        viewModel?.image.bind { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

// MARK: - UI Methods
private extension PhotoListCollectionViewCell {
    func configUI() {
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
        [
            topView,
            imageView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        contentView.bringSubviewToFront(topView)
        
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
}
