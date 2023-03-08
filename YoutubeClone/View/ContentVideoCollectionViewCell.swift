//
//  VideoCollectionViewCell.swift
//  YoutubeClone
//
//  Created by mert can çifter on 27.02.2023.
//

import UIKit
import SDWebImage
import SnapKit
import AVFoundation


protocol ContentVideoCollectionViewCellDelegate: AnyObject {
    func didSelect()
}

class ContentVideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ContentVideoCollectionViewCell.self)
    
    // MARK: - Properties
    
    weak var delegate: ContentVideoCollectionViewCellDelegate?

    var model: ContentModel? {
        didSet {
            updateSubviews()
        }
    }
            
    let playerView: PlayerView = {
        let view = PlayerView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var showModalButton: UIButton = {
        let view = UIButton(type: .system)
        var image = UIImage(systemName: "ellipsis")
        view.setImage(image, for: .normal)
        view.tintColor = .label
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
    }
    
    required init(model: ContentModel?) {
        self.init()
        self.model = model
        configureSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    
    // MARK: - Helpers
    
    @objc
    func volumeAction(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        playerView.isMuted = sender.isSelected
        PlayerView.videoIsMuted = sender.isSelected
    }
    
    func play() {
        if let url = model?.url {
            playerView.prepareToPlay(withUrl: url, shouldPlayImmediately: true)
        }
    }
    
    func pause() {
        playerView.pause()
    }
    
}


extension ContentVideoCollectionViewCell {
        
    func updateSubviews() {
        guard model != nil else {
            return
        }
        
        titleLabel.text = model?.title
        descLabel.text = "\(model!.channelName) - 100 B görüntülenme"
        
        userImageView.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
        playerView.prepareToPlay(withUrl: model!.url!, shouldPlayImmediately: false)
    }
}

private extension ContentVideoCollectionViewCell {
    func configureSubviews() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer:)))
        showModalButton.isUserInteractionEnabled = true
        showModalButton.addGestureRecognizer(tapGestureRecognizer)
        contentView.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(200)
        }
        
        playerView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(200)
        }
        
        contentView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(5)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.height.width.equalTo(40)
        }
        
        contentView.addSubview(showModalButton)
        
        showModalButton.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(5)
            make.height.width.equalTo(20)
        }
        
        
        let infoStackView = UIStackView(arrangedSubviews: [titleLabel,descLabel])
        infoStackView.axis = .vertical
        infoStackView.spacing = 5
        
        contentView.addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(5)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(showModalButton.snp.left)
        }
        
        contentView.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.didSelect()
    }
}

