//
//  ImageDetailView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 19/07/24.
//

import SwiftUI
import UnifiedBlurHash

struct ImageDetailView: View {
    let image: ImageModel
    
    @State var showMore: Bool = false
    @State private var downloadableImage: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    let url = "\(lummiURL)\(String(image.path))?w=1080&q=0&fm=avif"
                     
                    ImageView(path: url, width: image.width, height: image.height, blurhash: image.blurhash, cornerRadius: 8.0, loadedImage: $downloadableImage)
                    .cornerRadius(8.0)
                    VStack (alignment: .leading) {
                        HStack {
                            AvatarView(size: 30, avatar: image.author.avatar)
                            Text(image.author.name)
                                .font(.system(size: 20.0, weight: .bold))
                        }
                        VStack (alignment: .leading) {
                            Text(image.description)
                                .lineLimit(showMore ? 10000 : 3)
                                .truncationMode(.tail)
                            Button(showMore ? "Show less" : "Show more") {
                                showMore = !showMore
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding(.horizontal, 12.0)
            }
        }
    }
}

#Preview {
    ImageDetailView(image: ImageModel(id: "bcc3f609-c0ac-4f95-973c-51f2e129941e", path: "assets/QmYRewDzt7L1kqkHjTiJfvpE1sEqmYhJzbbRwd5a1UKaoM", width: 1856, height: 2464, author: Lummi.AuthorModel(id: "a9b0fceb-e4a7-4f2f-a83d-ee9b594750b2", username: "pablostanley", name: "Pablo Stanley", avatar: "https://assets.lummi.ai/assets/QmUHw1qX6RbQy9cRBBbMrE6HsgbWvDYu5LAAUBjvyyeiH7?w=200?w=200"), name: "Caca", description: "The image captures a close-up of a red fox against a wintry backdrop. The fox has rich, warm tones of red and orange fur that contrast beautifully with the cool whites and blues of the surrounding snow. Delicate snowflakes have settled on the fox's face and back, enhancing the wintery ambiance. The animal's sharp, attentive gaze and poised ears suggest alertness, possibly to the presence of the photographer or other stimuli in its environment. The blurred background suggests a snowy woodland setting, focusing the viewer's attention on the fine detail of the fox's thick winter coat and striking features. The visual contrast between the fox's vibrant fur and the soft snowscape creates a vivid and evocative portrait of wildlife in winter.", blurhash: "egNmm8.8_NaeR*?uMxM{tRRPtRV@M{ozxut7tRM{RPozozoLWUM{oL"))
}
