//
//  RealmGame.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import RealmSwift

class RealmGame: Object {
    
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var posterUrl: String
    @objc dynamic var viewersCount: Int
    @objc dynamic var channelsCount: Int
    
    init(id: Int,
         title: String,
         posterUrl: String,
         viewersCount: Int,
         channelsCount: Int) {
        self.id = id
        self.title = title
        self.posterUrl = posterUrl
        self.viewersCount = viewersCount
        self.channelsCount = channelsCount
    }
    
    required init() {
        self.id = 0
        self.title = ""
        self.posterUrl = ""
        self.viewersCount = 0
        self.channelsCount = 0
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func getGameResponse(_ realmTwitchGames: [RealmGame]) -> [GameResponse] {
        
        var twitchGameResponse: [GameResponse] = []
        
        for realmTwitchGame in realmTwitchGames {
            
            let imageBox = ImageBox(gameUrlPath: realmTwitchGame.posterUrl)
            let game = Game(name: realmTwitchGame.title,
                                  id: realmTwitchGame.id,
                                  imageBox: imageBox)
            
            twitchGameResponse.append(GameResponse(game: game,
                                                   viewersCount: realmTwitchGame.viewersCount,
                                                   channelsCount: realmTwitchGame.channelsCount))
        }
        
        return twitchGameResponse
    }
    
    static func getRealmGame(_ gameResponse: GameResponse) -> RealmGame {
        return RealmGame(id: gameResponse.game.id,
                               title: gameResponse.game.name,
                               posterUrl: gameResponse.game.imageBox.gameUrlPath,
                               viewersCount: gameResponse.viewersCount,
                               channelsCount: gameResponse.channelsCount)
    }
}
