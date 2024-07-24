//
//  ListedImageView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 23/07/24.
//

import SwiftUI
import Photos

struct ListedImageView: View {
    let image: ImageModel
    
    @State private var downloadableImage: UIImage?
    @State var isDownloaded: Bool = false
    
    var body: some View {
        ZStack (alignment: .bottom) {
            let url = "\(lummiURL)\(String(image.path))?w=720&q=0&fm=avif"
            
            ImageView(path: url, width: image.width, height: image.height, blurhash: image.blurhash, cornerRadius: 32.0, loadedImage: $downloadableImage)
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
                    Button(action: {
                        downloadImage(image: downloadableImage)
                        withAnimation(.spring) {
                            isDownloaded = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.spring) {
                                isDownloaded = false
                            }
                        }
                    }, label: {
                        Image(systemName: isDownloaded ? "checkmark" : "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .contentTransition(.symbolEffect(.replace))
                    })
                    .buttonStyle(.plain)
                    .padding(.all, 10.0)
                    .clipShape(Circle())
                    .background(isDownloaded ? .green : Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.systemBackground))
                    .cornerRadius(.infinity)
                    .disabled(downloadableImage == nil)
                }
            }
            .padding(.all, 8.0)
        }
    }
}

#Preview {
    ListedImageView(image: ImageModel(id: "bhncueinwh", path: "fakepath", width: 20, height: 20, author: AuthorModel(id: "jnioewn", username: "mkocemwn", name: "cnjedwn", avatar: "moksdemnowq"), name: "Caca", description: "Caca", blurhash: "ewijnowen"))
}
