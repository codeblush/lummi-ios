//
//  ImageDetailView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 19/07/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: ImageModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text(image.name)
                    .font(.system(size: 32.0, weight: .black))
                AsyncImage(url: URL(string: "\(lummiURL)\(String(image.path))")) { path in
                    switch path {
                    case .empty:
                        ProgressView()
                    case .failure:
                        EmptyView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(8.0)
                HStack {
                    AsyncImage(url: URL(string: String(image.author.avatar))) { path in
                        switch path {
                        case .empty:
                            ProgressView()
                        case .failure:
                            EmptyView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    Text(image.author.name)
                        .font(.system(size: 20.0, weight: .bold))
                }
                VStack {
                    Text(image.description)
                }
                Spacer()
            }
            .padding(.horizontal, 12.0)
        }
    }
}

#Preview {
    ImageDetailView(image: ImageModel(id: "bcc3f609-c0ac-4f95-973c-51f2e129941e", path: "assets/QmYRewDzt7L1kqkHjTiJfvpE1sEqmYhJzbbRwd5a1UKaoM", width: 1856, height: 2464, author: Lummi.AuthorModel(id: "a9b0fceb-e4a7-4f2f-a83d-ee9b594750b2", username: "pablostanley", name: "Pablo Stanley", avatar: "https://assets.lummi.ai/assets/QmUHw1qX6RbQy9cRBBbMrE6HsgbWvDYu5LAAUBjvyyeiH7?w=200?w=200"), name: "Caca", description: "hola"))
}
