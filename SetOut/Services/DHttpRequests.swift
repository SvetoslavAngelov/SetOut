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

    let (data, _) = try await URLSession.shared.data(from: url)

    do {
          let decoder = JSONDecoder()
          return try decoder.decode([DAttractionOutline].self, from: data)
      } catch {
          fatalError("Couldn't parse \(data.description) as a tourist attraction object:\n\(error)")
      }
}
