//
//  TopGamesPresenter.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Network

class TopGamesPresenter: TopGamesPresenterProtocol {
    
    var view: TopGamesViewProtocol
    var router: TopGamesRouterProtocol
    var apiManager: TwitchAPI
    var databaseManager: DatabaseManager
    
    init(view: TopGamesViewProtocol,
         router: TopGamesRouterProtocol,
         databaseManager: DatabaseManager,
         apiManager: TwitchAPI) {
        self.view = view
        self.router = router
        self.databaseManager = databaseManager
        self.apiManager = apiManager
    }
    
    func viewDidLoad() {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.databaseManager.deleteGames()
                }
                self?.apiManager.fetchTopGames(parameters: ["offset": 0]) { response in
                    switch response {
                    case .success(let gameResponse):
                        self?.view.showTopGames(gameResponse: gameResponse.games)
                        for game in gameResponse.games {
                            self?.databaseManager.saveGame(game)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                let games = RealmGame.getGameResponse(self?.databaseManager.getGames() ?? [])
                self?.view.showTopGames(gameResponse: games)
            }
        }
        monitor.start(queue: DispatchQueue(label: "Monitor"))
    }
    
    func fetchMoreGames(offset: Int) {
        self.apiManager.fetchTopGames(parameters: ["offset": offset]) { response in
            switch response {
            case .success(let gameResponse):
                self.view.showMoreTopGames(gameResponse: gameResponse.games)
                for game in gameResponse.games {
                    self.databaseManager.saveGame(game)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showReview() {
        self.router.presentReview(for: self.view)
    }
}
