//
//  AppFramework.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import DITranquillity

public class AppFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: TopGamesDIPart.self)
    }
}
