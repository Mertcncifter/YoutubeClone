//
//  HomeViewController.swift
//  YoutubeClone
//
//  Created by mert can çifter on 14.02.2023.
//

import UIKit
import SnapKit


class ContentViewController: UIViewController {
    
    // MARK: - Properties
    
    var contentModels: [ContentModel] = ContentModel.exampleDatas
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        layout.estimatedItemSize = CGSize(width: self.view.bounds.size.width * 0.95, height: 10)
        
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        view.dataSource = self
        view.delegate = self
        
        view.register(ContentVideoCollectionViewCell.self, forCellWithReuseIdentifier: ContentVideoCollectionViewCell.identifier)
        view.register(ContentShortsCollectionViewCell.self, forCellWithReuseIdentifier: ContentShortsCollectionViewCell.identifier)

        view.reloadData()
        
        return view

    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.playFirstVisibleVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.transform = .init(translationX: 0, y: 0)
        self.playFirstVisibleVideo(false)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Anasayfa"
    }
    
}

extension ContentViewController:  UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let item = contentModels[indexPath.row]

        if item.contentType == .video {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentVideoCollectionViewCell.identifier, for: indexPath) as? ContentVideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.model = item
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentShortsCollectionViewCell.identifier, for: indexPath) as? ContentShortsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.model = item
            return cell
        }
    }
}


extension ContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
        playFirstVisibleVideo()
    }
}

extension ContentViewController {
    
    func playFirstVisibleVideo(_ shouldPlay:Bool = true) {
        let cells = collectionView.visibleCells.sorted {
            collectionView.indexPath(for: $0)?.item ?? 0 < collectionView.indexPath(for: $1)?.item ?? 0
        }
        let videoCells = cells.compactMap({ $0 as? ContentVideoCollectionViewCell })
        if videoCells.count > 0 {
            let firstVisibileCell = videoCells.first(where: { checkVideoFrameVisibility(ofCell: $0) })
            for videoCell in videoCells {
                if shouldPlay && firstVisibileCell == videoCell {
                    videoCell.play()
                }
                else {
                    videoCell.pause()
                }
            }
        }
    }
    
    func checkVideoFrameVisibility(ofCell cell: ContentVideoCollectionViewCell) -> Bool {
        var cellRect = cell.bounds
        cellRect = cell.convert(cell.bounds, to: collectionView.superview)
        return collectionView.frame.contains(cellRect)
    }
}

extension ContentViewController: ContentVideoCollectionViewCellDelegate {
    func didSelect() {
        VideoPopUpModalViewController.present(
                    initialView: self,
                    delegate: self)
    }
}

extension ContentViewController: VideoPopUpModalDelegate {
    func didTapAccept(){
        self.dismiss(animated: true)
    }
    
    func didTapCancel() {
        self.dismiss(animated: true)
    }
}
