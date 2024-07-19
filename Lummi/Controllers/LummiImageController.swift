//
//  LummiImageController.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import Foundation

final class ImageControllerModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed
        case success
    }
    
    @Published var images: [ImageModel] = []
    @Published private(set) var state = State.idle
    
    func getHomeImages() async {
        do {
            DispatchQueue.main.async {
                self.state = .loading
            }
            
            let result = try await getLummiImages()
            
            DispatchQueue.main.async {
                self.images = result
                self.state = .success
            }
        } catch {
            print("Something went wrong: \(error)")
            DispatchQueue.main.async {
                self.state = .failed
            }
        }
    }
}
