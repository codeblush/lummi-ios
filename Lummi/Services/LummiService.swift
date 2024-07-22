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
    
    // Check for a cached response
    if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
        let data = cachedResponse.data
        // Decode the JSON response
        do {
            let decoder = JSONDecoder()
            let imageModel = try decoder.decode([ImageModel].self, from: data)
            return imageModel
        } catch {
            throw ImageErrors.invalidData
        }
    }

    // Make the network request
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // Cache the response
    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
        let cachedData = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedData, for: request)
    } else {
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
