//
//  LummiApp.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import SwiftUI
import SwiftData

@main
struct LummiApp: App {
    init() {
        configureURLCache()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(imageModel: ImageControllerModel())
        }
        .modelContainer(sharedModelContainer)
    }
    
    private func configureURLCache() {
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "lummiCache")
        URLCache.shared = cache
    }
}
