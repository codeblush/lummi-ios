//
//  DownloadImageController.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 23/07/24.
//

import Foundation
import UIKit

final class DownloadImageController: ObservableObject {
    enum Status {
        case idle
        case loading
        case failed
        case success
    }
    
    @Published private(set) var state = Status.idle
    
    func download(image: UIImage) {
        do {
            downloadImage(image: image)
        } catch {
            
        }
    }
}
