//
//  LummiImageController.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import Foundation
import SwiftUI

final class ImageControllerModel: ObservableObject {
    enum Status {
        case idle
        case loadingFirstBatch
        case loading
        case failed
        case success
    }
    
    
    @Published var images: [ImageModel] = []
    @Published private(set) var state = Status.idle
    
    func loadMoreImages(page: Int = 1) async {
        do {
            DispatchQueue.main.async {
                self.state = .loading
            }
            
            let result = try await getLummiImages(page: page)
            
            DispatchQueue.main.async {
                self.images.append(contentsOf: result)
                self.state = .success
            }
        } catch {
            print("Something went wrong \(error)")
            
            DispatchQueue.main.async {
                self.state = .failed
            }
        }
    }
    
    func getImages() async {
        do {
            DispatchQueue.main.async {
                self.state = .loadingFirstBatch
            }
                
            let result = try await getLummiImages()
            
            DispatchQueue.main.async {
                self.images = []
                self.images.append(contentsOf: result)
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
