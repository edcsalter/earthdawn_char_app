//
//  Earthdawn_Char_ManagerApp.swift
//  Earthdawn Char Manager
//
//  Created by Ed Salter on 9/8/24.
//

import SwiftUI

@main
struct Earthdawn_Char_ManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
			SplitNavView(viewModel: SplitViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
