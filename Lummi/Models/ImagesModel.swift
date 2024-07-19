//
//  ImagesModel.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import Foundation

struct ImageModel: Codable, Identifiable {
    let id: String
    let path: String
    let width: Int
    let height: Int
    let author: AuthorModel
    let name: String
    let description: String
}

struct ColorPaletteModel: Codable {
    let muted: ColorValueModel
    let vibrant: ColorValueModel
    let muted_dark: ColorValueModel
    let muted_light: ColorValueModel
    let vibrant_dark: ColorValueModel
    let vibrant_light: ColorValueModel
}

struct ColorValueModel: Codable {
    let hex: String
}

struct AuthorModel: Codable, Identifiable {
    let id: String
    let username: String
    let name: String
    let avatar: String
}
