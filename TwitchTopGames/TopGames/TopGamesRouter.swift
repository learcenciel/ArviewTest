//
//  TopGamesRouter.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity
import Foundation

class TopGamesRouter: TopGamesRouterProtocol {
    
    var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func presentReview(for view: TopGamesViewProtocol) {
        let reviewViewController: ReviewViewController = *container
        (view as! UIViewController).present(reviewViewController, animated: true, completion: nil)
    }
}
