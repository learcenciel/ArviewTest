//
//  GameCell.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import SnapKit
import Nuke
import UIKit

class GameCell: UITableViewCell {
    
    static var reuseId = "GameCellId"
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private let viewersCountLabel: UILabel = {
        let viewersCountLabel = UILabel()
        viewersCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        viewersCountLabel.numberOfLines = 1
        viewersCountLabel.textAlignment = .left
        viewersCountLabel.textColor = .white
        viewersCountLabel.text = "91,5k viewers"
        return viewersCountLabel
    }()
    
    private let channelsCountLabel: UILabel = {
        let channelsCountLabel = UILabel()
        channelsCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        channelsCountLabel.numberOfLines = 1
        channelsCountLabel.textAlignment = .left
        channelsCountLabel.textColor = .white
        channelsCountLabel.text = "91,5k channels"
        return channelsCountLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = nil
        self.titleLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
    }
    
    func setup(for game: GameResponse) {
        let prepString = game.game.imageBox.gameUrlPath.replacingOccurrences(of: "{width}x{height}", with: "720x1136")
        guard let url = URL(string: prepString) else { return }
        Nuke.loadImage(with: url, into: posterImageView)
        titleLabel.text = game.game.name
        viewersCountLabel.text = "\(game.viewersCount) viewers"
    }
    
    private func configureViews() {
        backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(viewersCountLabel)
        containerView.addSubview(channelsCountLabel)
        containerView.layer.cornerRadius = 18
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(red: 85/255, green: 26/255, blue: 173/255, alpha: 1.0)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 14, bottom: 14, right: 14))
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(posterImageView.snp.height).multipliedBy(Float(3)/Float(4))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).offset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(14)
            make.trailing.lessThanOrEqualTo(containerView.snp.trailing).offset(-14)
        }

        viewersCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(containerView.snp.trailing).offset(-14)
        }
        
        channelsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(viewersCountLabel.snp.bottom).offset(14)
            make.leading.equalTo(viewersCountLabel.snp.leading)
            make.trailing.lessThanOrEqualTo(containerView.snp.trailing).offset(-14)
        }
    }
}
