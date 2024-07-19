//
//  ContentView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var imageModel: ImageControllerModel
    
    let lummiURL = "https://assets.lummi.ai/"

    var body: some View {
        VStack {
            Text("Lummi")
                .font(.system(size: 70.0, weight: .black))
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(imageModel.images) { image in
                        let url = "\(lummiURL)\(String(image.path))"
                        
                        AsyncImage(url: URL(string: url)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure:
                                Image(systemName: "xmark.octagon")
                                    .resizable()
                                    .scaledToFit()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: .infinity)
                    }
                }
                
            }
        }
        .onAppear() {
            Task {
                await imageModel.getHomeImages()
            }
        }
    }
}

#Preview {
    ContentView(imageModel: ImageControllerModel())
}
