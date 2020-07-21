//
//  TwitchAPI.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

class TwitchAPI {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchTopGames(parameters: [String: Any]?, completionHandler: @escaping(Result<TopGamesResponse, HTTPErrors>) -> Void) {
        httpClient.get(url: "https://api.twitch.tv/kraken/games/top",
                       headers: ["Client-ID": "sd4grh0omdj9a31exnpikhrmsu3v46",
                                 "Accept": "application/vnd.twitchtv.v5+json"],
                       parameters: parameters,
                       completionHandler: completionHandler)
    }
}
