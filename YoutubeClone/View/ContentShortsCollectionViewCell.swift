//
//  ShortsCollectionViewCell.swift
//  YoutubeClone
//
//  Created by mert can çifter on 6.03.2023.
//

import UIKit
import SnapKit
import SDWebImage

class ContentShortsCollectionViewCell: UICollectionViewCell  {
    
    // MARK: - Properties

    static let identifier = String(describing: ContentShortsCollectionViewCell.self)
    
    var model: ContentModel? {
        didSet {
            updateSubviews()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        let image = UIImage(named: "shorts")
        view.image = image!
        return view
    }()
        
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Shorts"
        return label
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShortsImageCell.self, forCellWithReuseIdentifier: ShortsImageCell.identifier)

        
        return collectionView
    }()
    
    // MARK: - Properties
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Helpers
        
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}


extension ContentShortsCollectionViewCell {
        
    func updateSubviews() {
        guard model != nil else {
            return
        }
        
        collectionView.reloadData()
    }
}



// MARK: - CollectionView

extension ContentShortsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.shorts?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsImageCell.identifier, for: indexPath) as? ShortsImageCell else {
            return UICollectionViewCell()
        }
        
        cell.model = model!.shorts![indexPath.row]
        return cell

    }
}



private extension ContentShortsCollectionViewCell {
    func configureSubviews() {
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
        
        let headerStackView = UIStackView(arrangedSubviews: [imageView,label])
        headerStackView.axis = .horizontal
        headerStackView.spacing = 5
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        
        contentView.addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left).offset(20)
        }
        
        contentView.addSubview(collectionView)
        
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(20)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 20).isActive = true
    }
}




