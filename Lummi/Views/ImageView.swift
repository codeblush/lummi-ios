//
//  ImageView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 19/07/24.
//

import SwiftUI
import CachedAsyncImage

struct ImageView: View {
    let path: String
    let width: Int
    let height: Int
    let blurhash: String
    
    let cornerRadius: Double?
    
    @State var id: UUID = UUID()
    
    var body: some View {
        CachedAsyncImage(url: URL(string: path)) { path in
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
                    .contextMenu {
                        Button("Save Image", systemImage: "square.and.arrow.down") {
                            print("hello")
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

#Preview {
    ImageView(path: "\(lummiURL)/assets/QmYRewDzt7L1kqkHjTiJfvpE1sEqmYhJzbbRwd5a1UKaoM", width: 1856, height: 2464, blurhash: "egNmm8.8_NaeR*?uMxM{tRRPtRV@M{ozxut7tRM{RPozozoLWUM{oL", cornerRadius: 8.0)
}
