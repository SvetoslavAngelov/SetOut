//
//  DTestData.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation

/*
    Helper function, which loads the test data and stores it in a local array object.
    The function "load" is called when the touristAttractions object is initialised
    at runtime. 
 */
var touristAttractions: [DAttractionOutline] = load("TestData_Attractions.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
          let decoder = JSONDecoder()
          return try decoder.decode(T.self, from: data)
      } catch {
          fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
      }
}
