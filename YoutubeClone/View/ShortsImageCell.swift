//
//  ShortImageCell.swift
//  YoutubeClone
//
//  Created by mert can çifter on 7.03.2023.
//

import UIKit
import SDWebImage
import SnapKit

class ShortsImageCell: UICollectionViewCell {
    
    static let identifier = String(describing: ShortsImageCell.self)

    var model: ShortsModel? {
        didSet {
            updateSubviews()
        }
    }
    
    
    // MARK: - Properties
        
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
        
}


extension ShortsImageCell {
    func configureSubviews() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(300)
            make.width.equalTo(200)
        }
    
        contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
    }
}

extension ShortsImageCell {
    func updateSubviews() {
        
        guard model != nil else {
            return
        }
        
        imageView.sd_setImage(with: URL(string: model!.image))
    }
}

