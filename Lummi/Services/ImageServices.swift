//
//  ImageServices.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 23/07/24.
//

import Foundation
import UIKit
import Photos

func downloadImage(image: UIImage?) {
    guard let image = image else { return }
    
    PHPhotoLibrary.requestAuthorization { status in
        if status == .authorized {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        } else {
            // Handle the case where the user has not authorized access to the photo library
        }
    }
}
