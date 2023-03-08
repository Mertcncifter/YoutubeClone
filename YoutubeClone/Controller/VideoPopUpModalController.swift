//
//  VideoModalController.swift
//  YoutubeClone
//
//  Created by mert can çifter on 1.03.2023.
//

import UIKit
import SnapKit

public protocol VideoPopUpModalDelegate: AnyObject {
    func didTapCancel()
    func didTapAccept()
}

class VideoPopUpModalViewController: UIViewController {
    
    // MARK: - Properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var models: [String] = [
        "saveWatchLater".localized(),
        "savePlayList".localized(),
        "dowloandVideo".localized(),
        "share".localized(),
        "notInterested".localized(),
        "suggestChannel".localized(),
        "report".localized()
    ]

    
    // MARK: - Lifecycle
    
    private static func create(
        delegate: VideoPopUpModalDelegate
    ) -> VideoPopUpModalViewController {
        let view = VideoPopUpModalViewController(delegate: delegate)
        return view
    }
    
    @discardableResult
    static public func present(
        initialView: UIViewController,
        delegate: VideoPopUpModalDelegate
    ) -> VideoPopUpModalViewController {
        let view = VideoPopUpModalViewController.create(delegate: delegate)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .coverVertical
        initialView.present(view, animated: true)
        return view
    }
    
    public init(delegate: VideoPopUpModalDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public weak var delegate: VideoPopUpModalDelegate?
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTapCancel()
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.view.addSubview(canvas)
        
        canvas.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(view.bounds.height * 0.5)
            make.width.equalTo(view.bounds.width * 0.8)
        }
        
        canvas.addSubview(tableView)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(canvas.snp.height)
            make.width.equalTo(canvas.snp.width)
        }
    }
}


extension VideoPopUpModalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapAccept()
    }
}
