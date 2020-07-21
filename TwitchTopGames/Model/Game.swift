//
//  Game.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct TopGamesResponse: Decodable {
    var games: [GameResponse]
    
    private enum CodingKeys: String, CodingKey {
        case games = "top"
    }
}

struct GameResponse: Decodable {
    let game: Game
    let viewersCount: Int
    let channelsCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case game = "game"
        case viewersCount = "viewers"
        case channelsCount = "channels"
    }
}

struct Game: Decodable {
    let name: String
    let id: Int
    let imageBox: ImageBox
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "_id"
        case imageBox = "box"
    }
}

struct ImageBox: Decodable {
    let gameUrlPath: String
    
    private enum CodingKeys: String, CodingKey {
        case gameUrlPath = "template"
    }
}
