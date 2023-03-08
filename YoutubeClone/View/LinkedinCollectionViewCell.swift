//
//  LinkedinViewCell.swift
//  YoutubeClone
//
//  Created by mert can çifter on 24.02.2023.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

class LinkedinCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: LinkedinCollectionViewCell.self)

    
    var viewModel: DynamicCollectionViewCellViewModel? {
        didSet {
            updateSubviews()
        }
    }
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var usernameTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userInfoTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var image2View: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let rightView = UIStackView(arrangedSubviews: [usernameTitle,userInfoTitle,createdDateLabel])
        rightView.axis = .vertical
        
        view.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.height.width.equalTo(40)
        }
        
        view.addSubview(rightView)
        
        rightView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(10)
        }
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(rightView.snp.bottom).offset(10)
            make.width.equalTo(view)
        }
        
        return view
    }()
    
    private lazy var cardWidth: NSLayoutConstraint = {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let cons = containerView.widthAnchor.constraint(equalToConstant: 1000)
        cons.isActive = true
        return cons
    }()
    
        
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
    }
    
    required init(viewModel: DynamicCollectionViewCellViewModel?) {
        self.init()
        self.viewModel = viewModel
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LinkedinCollectionViewCell {
    
    static func expectedCardSize(_ targetSize: CGSize, viewModel: DynamicCollectionViewCellViewModel) -> CGSize {
        
        let view = FeedCollectionViewCell(viewModel: viewModel)
        let acsize = view.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0.0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return acsize
    }
    
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        cardWidth.constant = targetSize.width
        return containerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}


extension LinkedinCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    private func updateSubviews() {
        guard let vm = viewModel else {
            return
        }
        
        usernameTitle.text = "Mert Can Çifter"
        userInfoTitle.text = "Mobile Application Developer"
        createdDateLabel.text = "3 saat"
        userImageView.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))

        if viewModel!.index % 2 == 0 {
            imageView.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
            image2View.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
            containerView.addSubview(image2View)
            image2View.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(10)
            }
        } else {
            imageView.removeFromSuperview()
        }
            
    }
}

private extension LinkedinCollectionViewCell {
    func configureSubviews() {
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
}


