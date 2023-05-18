//
//  DHttpRequest.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 12/05/2023.
//

import Foundation

func getListOfAttractions() async throws -> [DAttractionOutline] {
    
    let urlString = APIGATEWAY + "/attractions" + "?" + "key=" + APIKEY
    
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.setValue(Bundle.main.bundleIdentifier, forHTTPHeaderField: "x-ios-bundle-identifier")

    let (data, _) = try await URLSession.shared.data(for: request)

    do {
          let decoder = JSONDecoder()
          return try decoder.decode([DAttractionOutline].self, from: data)
      } catch {
          print("Couldn't parse \(data.description) as a tourist attraction object:\n\(error)")
          return [DAttractionOutline()]
      }
}
