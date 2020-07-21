//
//  DatabaseManager.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import RealmSwift

class DatabaseManager {
    
    private let schemaVersion: UInt64 = 1
    
    // MARK: Configuration with migration support
    
    private lazy var realmConfiguration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: runMigrations)
    private lazy var realm = try! Realm(configuration: realmConfiguration)
    
    // MARK: Migration block
    
    private func runMigrations(_ migration: Migration, oldSchemaVersion: UInt64) {
        
    }
    
    // MARK: Fetch, Delete, Add objects to Database
    
    func getGames() -> [RealmGame] {
        return Array(realm.objects(RealmGame.self))
    }
    
    func saveGame(_ gameResponse: GameResponse) {
        try! realm.write {
            let game = RealmGame(id: gameResponse.game.id,
                                       title: gameResponse.game.name,
                                       posterUrl: gameResponse.game.imageBox.gameUrlPath,
                                       viewersCount: gameResponse.viewersCount,
                                       channelsCount: gameResponse.channelsCount)
            realm.create(RealmGame.self, value: game, update: .all)
        }
    }
    
    func deleteGames() {
        try! realm.write {
            let games = getGames()
            realm.delete(games)
        }
    }
}
