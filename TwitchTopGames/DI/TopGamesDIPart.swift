//
//  TopGamesDIPart.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import UIKit

class TopGamesDIPart: DIPart {
    static func load(container: DIContainer) {
        container.register { TopGamesViewController() }
            .as(TopGamesViewProtocol.self)
            .injection(cycle: true, \.presenter)
            .lifetime(.objectGraph)
        
        container.register(ReviewViewController.init)
            .lifetime(.objectGraph)
        
        container.register(TopGamesPresenter.init)
            .as(TopGamesPresenterProtocol.self)
            .lifetime(.objectGraph)
        
        container.register(TopGamesRouter.init)
            .as(TopGamesRouterProtocol.self)
            .lifetime(.objectGraph)
        
        container.register(DatabaseManager.init)
            .lifetime(.single)
        
        container.register(TwitchAPI.init)
            .lifetime(.objectGraph)
        
        container.register(HTTPClient.init)
            .lifetime(.objectGraph)
    }
}
