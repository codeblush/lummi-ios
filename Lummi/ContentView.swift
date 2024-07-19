//
//  ContentView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import SwiftUI
import MasonryStack

struct ContentView: View {
    @ObservedObject var imageModel: ImageControllerModel
    
    @State var selectedImage: ImageModel?

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text("Lummi")
                        .font(.system(size: 70.0, weight: .black))
                    if (imageModel.state == .loading) {
                        Text("Loading...")
                    } else {
                        MasonryVStack(columns: 2) {
                            ForEach(imageModel.images) { image in
                                let url = "\(lummiURL)\(String(image.path))"
                                
                                NavigationLink (destination: ImageDetailView(image: image)) {
                                    ZStack (alignment: .bottom) {
                                        VStack {
                                            AsyncImage(url: URL(string: url)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ZStack {
                                                        ContainerRelativeShape()
                                                            .fill(.gray.gradient.opacity(0.2))
                                                        ProgressView()
                                                    }
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .contextMenu {
                                                            Button("Save Image", systemImage: "square.and.arrow.down") {
                                                                print("hello")
                                                            }
                                                        } preview: {
                                                            image
                                                                .resizable()
                                                                .scaledToFit()
                                                        }
                                                case .failure:
                                                    EmptyView()
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            .cornerRadius(8.0)
                                        }
                                        VStack (alignment: .trailing) {
                                            HStack {
                                                AsyncImage(url: URL(string: image.author.avatar)) {phase in
                                                    switch phase {
                                                    case .empty:
                                                        ProgressView()
                                                    case .failure:
                                                        EmptyView()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                    @unknown default:
                                                        EmptyView()
                                                    }
                                                }
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                                Text(image.author.name)
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                            .padding(.all, 8.0)
                                            .background(Gradient(colors: [.clear, .black.opacity(0.7)]))
                                            .cornerRadius(8.0)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 8.0)
                    }
                }
            }
            .onAppear() {
                if (imageModel.images.isEmpty) {
                    Task {
                        await imageModel.getHomeImages()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(imageModel: ImageControllerModel())
}
