//
//  AvatarView.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 19/07/24.
//

import SwiftUI

struct AvatarView: View {
    let size: Int?
    
    let avatar: String
    
    var body: some View {
        AsyncImage(url: URL(string: avatar)) {phase in
            switch phase {
            case .empty:
                ProgressView()
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
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
        .frame(width: CGFloat(size ?? 20), height: CGFloat(size ?? 20))
        .background(.regularMaterial)
        .cornerRadius(.infinity)
        .clipShape(Circle())
    }
}

#Preview {
    AvatarView(size: 20, avatar: "https://assets.lummi.ai/assets/QmUHw1qX6RbQy9cRBBbMrE6HsgbWvDYu5LAAUBjvyyeiH7?w=200?w=200")
}
