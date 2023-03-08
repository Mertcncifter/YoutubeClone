//
//  ShortsViewController.swift
//  YoutubeClone
//
//  Created by mert can çifter on 14.02.2023.
//

import UIKit
import SnapKit
import SDWebImage

class ShortsViewController: UIViewController {

    // MARK: - Properties
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Anasayfa"
    }
}


