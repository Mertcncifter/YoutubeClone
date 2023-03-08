//
//  FeedCollectionViewCell.swift
//  YoutubeClone
//
//  Created by mert can çifter on 22.02.2023.
//

import UIKit
import SnapKit
import SDWebImage



class FeedCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: FeedCollectionViewCell.self)
    
    var viewModel: DynamicCollectionViewCellViewModel? {
        didSet {
            updateSubviews()
        }
    }
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var messageView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 200.0),
            view.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        
        return view
    }()
    
    private lazy var image2View: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 200.0),
            view.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        
        return view
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel,imageView,messageView,image2View])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.layer.cornerRadius = 24.0
        view.axis = .vertical
        
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
    

        
    // MARK: - Helpers
    
}


extension FeedCollectionViewCell {
    
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


extension FeedCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    private func updateSubviews() {
        guard let vm = viewModel else {
            return
        }
        
        titleLabel.text = vm.title
        messageView.text = vm.message
        image2View.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
        
        if viewModel!.index % 2 == 0 {
            image2View.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
        } else {
            image2View.removeFromSuperview()
        }
    }
}

private extension FeedCollectionViewCell {
    func configureSubviews() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
}
