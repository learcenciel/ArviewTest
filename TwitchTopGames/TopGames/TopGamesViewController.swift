//
//  ViewController.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import SnapKit
import UIKit

class TopGamesViewController: UIViewController {
        
    private lazy var topGamesTableView: UITableView = {
        let topGamesTableView = UITableView()
        topGamesTableView.delegate = self
        topGamesTableView.dataSource = self
        topGamesTableView.register(GameCell.self, forCellReuseIdentifier: GameCell.reuseId)
        topGamesTableView.showsVerticalScrollIndicator = false
        topGamesTableView.showsHorizontalScrollIndicator = false
        topGamesTableView.allowsSelection = false
        topGamesTableView.rowHeight = self.view.bounds.width * 0.4
        topGamesTableView.backgroundColor = .clear
        topGamesTableView.separatorStyle = .none
        return topGamesTableView
    }()
    
    private let ratingButton: UIButton = {
        let ratingButton = UIButton()
        ratingButton.backgroundColor = .purple
        ratingButton.layer.cornerRadius = 4
        ratingButton.setTitle("Review this app", for: .normal)
        return ratingButton
    }()
    
    var presenter: TopGamesPresenterProtocol!

    private var topGames: [GameResponse] = []
    
    private var isDownloading = false
    private var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTopGamesTableView()
        configureRatingButton()
        presenter.viewDidLoad()
    }
    
    private func configureTopGamesTableView() {
        self.view.addSubview(topGamesTableView)
        topGamesTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureRatingButton() {
        self.view.addSubview(ratingButton)
        ratingButton.snp.makeConstraints { make in
            make.top.equalTo(topGamesTableView.snp.bottom).offset(8)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        ratingButton.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func ratingButtonTapped(_ sender: UIButton) {
        self.presenter.showReview()
    }
}

// MARK: TopGamesViewProtocol

extension TopGamesViewController: TopGamesViewProtocol {
    
    func showTopGames(gameResponse: [GameResponse]) {
        self.topGames = gameResponse
        self.topGamesTableView.reloadData()
    }
    
    func showMoreTopGames(gameResponse: [GameResponse]) {
        self.isDownloading = false
        self.topGames.append(contentsOf: gameResponse)
        self.topGamesTableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension TopGamesViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource

extension TopGamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.topGames.count
        if count > 1 && indexPath.row == count - 1 && self.isDownloading == false {
            self.offset += 10
            self.isDownloading = true
            self.presenter.fetchMoreGames(offset: offset)
        }
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseId, for: indexPath) as? GameCell
        else { fatalError() }
        cell.setup(for: self.topGames[indexPath.row])
        return cell
    }
}
