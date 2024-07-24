//
//  ImageView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 19/07/24.
//

import SwiftUI
import UIKit

struct ImageView: View {
    let path: String
    let width: Int
    let height: Int
    let blurhash: String
    
    let cornerRadius: Double?
    
    @State var id: UUID = UUID()
    @Binding var loadedImage: UIImage?
    
    var body: some View {
        AsyncImage(url: URL(string: path)) { path in
            switch path {
            case .empty:
                ZStack (alignment: .topLeading) {
                    ContainerRelativeShape()
                        .fill(.clear)
                        .aspectRatio(CGSize(width: width, height: height), contentMode: .fit)
                        .background(.gray.gradient.opacity(0.2))
                        .cornerRadius(8.0)
                    ProgressView()
                    Image(blurHash: blurhash)?
                        .resizable()
                        .aspectRatio(CGSize(width: width, height: height), contentMode: .fill)
                }
            case .failure:
                ZStack {
                    Image(blurHash: blurhash)?
                        .resizable()
                        .aspectRatio(CGSize(width: width, height: height), contentMode: .fill)
                    Button {
                        id = UUID()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.secondary)
                    }
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .id(id)
                    .onAppear() {
                        loadedImage = image.asUIImage()
                    }
                    .contextMenu {
                        Button("Save Image", systemImage: "square.and.arrow.down") {
                            downloadImage(image: image.asUIImage())
                        }
                    } preview: {
                        image
                            .resizable()
                            .scaledToFit()
                    }
            @unknown default:
                EmptyView()
            }
        }
        .cornerRadius(cornerRadius ?? 8.0)
    }
}

extension Image {
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        controller.view.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        let targetSize = controller.view.intrinsicContentSize
        controller.view.bounds = CGRect(origin: .zero, size: targetSize)
        controller.view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
