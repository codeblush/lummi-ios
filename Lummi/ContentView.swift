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
            ZStack {
                if (imageModel.state == .loading && imageModel.images.isEmpty) {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                
                ScrollView {
                    if (!imageModel.images.isEmpty) {
                        VStack (spacing: 8.0) {
                            ForEach(imageModel.images) { image in
                                NavigationLink (destination: ImageDetailView(image: image).navigationTitle(image.name)) {
                                    ListedImageView(image: image)
                                }
                            }
                        }
                        .padding(.horizontal, 8.0)
                        LazyVStack {
                            ProgressView()
                                .onAppear() {
                                    page += 1
                                }
                        }
                        .padding(.vertical, 16.0)
                    }
                }
                .navigationTitle("Gallery")
                .refreshable {
                    Task {
                        await imageModel.getImages()
                    }
                }
                .onChange(of: page) {
                    Task {
                        await imageModel.loadMoreImages(page:page)
                    }
                }
                .onAppear() {
                    if (page == 1 && imageModel.images.isEmpty) {
                        Task {
                            await imageModel.getImages()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(imageModel: ImageControllerModel())
}
