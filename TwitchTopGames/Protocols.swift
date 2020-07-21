//
//  Protocols.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

protocol TopGamesViewProtocol: class {
    var presenter: TopGamesPresenterProtocol! { get set }
    
    func showTopGames(gameResponse: [GameResponse])
    func showMoreTopGames(gameResponse: [GameResponse])
}

protocol TopGamesPresenterProtocol: class {
    var view: TopGamesViewProtocol { get set }
    var router: TopGamesRouterProtocol { get set }
    
    func viewDidLoad()
    func fetchMoreGames(offset: Int)
    func showReview()
}

protocol TopGamesRouterProtocol: class {
    func presentReview(for view: TopGamesViewProtocol)
}
