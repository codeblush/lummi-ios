//
//  ContentView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import SwiftUI
import MasonryStack
import UnifiedBlurHash

struct ContentView: View {
    @ObservedObject var imageModel: ImageControllerModel
    
    @State var selectedImage: ImageModel?
    @State var page: Int = 1

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Lummi")
                    .font(.system(size: 70.0, weight: .black))
                if (imageModel.state == .loadingFirstBatch) {
                    ZStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    LazyVStack (spacing: 8.0) {
                        ForEach(imageModel.images) { image in
                            let url = "\(lummiURL)\(String(image.path))?w=720"
                            NavigationLink (destination: ImageDetailView(image: image)) {
                                ZStack (alignment: .bottom) {
                                    ImageView(path: url, width: image.width, height: image.height, blurhash: image.blurhash, cornerRadius: 32.0)
                                    
                                    VStack (alignment: .trailing) {
                                        HStack {
                                            HStack (spacing: 8.0) {
                                                AvatarView(size: 30, avatar: image.author.avatar)
                                                Text(image.author.name)
                                                    .font(.system(size: 20.0, weight: .medium))
                                                    .foregroundColor(.primary)
                                            }
                                            .padding(.all, 8.0)
                                            .padding(.trailing, 10.0)
                                            .background(.regularMaterial)
                                            .cornerRadius(.infinity)
                                            Spacer()
                                            Button(action: {}, label: {
                                                Image(systemName: "arrow.down")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                            })
                                            .buttonStyle(.plain)
                                            .padding(.all, 10.0)
                                            .clipShape(Circle())
                                            .background(.black)
                                            .foregroundColor(.white)
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.black)
                                        }
                                    }
                                    .padding(.all, 8.0)
                                }
                            }
                        }
                        ProgressView()
                            .task {
                                if (imageModel.state != .loadingFirstBatch) {
                                    page+=1
                                }
                            }
                    }
                    .padding(.horizontal, 8.0)
                }
            }
            .onChange(of: page) {
                Task {
                    await imageModel.getHomeImages(page:page)
                }
            }
            .onAppear() {
                if (page == 1) {
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
