//
//  LummiService.swift
//  Lummi
//
//  Created by Alan David Hernández Trujillo on 18/07/24.
//

import Foundation

let lummiURL = "https://assets.lummi.ai/"

func getLummiImages(page: Int = 1) async throws -> [ImageModel] {
    // Define the endpoint URL
    guard let url = URL(string: "https://www.lummi.ai/api/actions/getImages") else { throw ImageErrors.invalidURL }
    
    // Create the request object
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Define the parameters
    let parameters: [String: Any] = [
        "params": [
            [
                "page": page,
                "perPage": 30,
                "filters": [:],
                "orderBy": [
                    ["featuredScore": "desc"],
                    ["randomFieldScore": "desc"]
                ]
            ]
        ]
    ]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageErrors.invalidResponse
        }
    
    
    
    // Decode the JSON response
    do {
        let decoder = JSONDecoder()
        let imageModel = try decoder.decode([ImageModel].self, from: data)
        
        return imageModel
    } catch {
        throw ImageErrors.invalidData
    }
}

enum ImageErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case someError
}
