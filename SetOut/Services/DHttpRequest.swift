//
//  DHttpRequest.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 12/05/2023.
//

import Foundation

class DHttpRequest: ObservableObject {
    
    var searchResultCache = DSearchResultCache()
    @Published var serverResult = [DAttractionOutline()]
    @Published var isFinishedLoading = false
    
    func loadAttractions(startLocation: String) {
        
        if let cachedResult = self.searchResultCache.Get(key: startLocation) {
            self.serverResult = cachedResult
            return
        }
        
        fetchFromServer(startLocation: startLocation)
    }
    
    func fetchFromServer(startLocation: String) {
        
        let urlString = APIGATEWAY + "/attractions" + "?" + "key=" + APIKEY
        guard let url = URL(string: urlString) else { fatalError(URLError(.badURL).localizedDescription) }
            
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(Bundle.main.bundleIdentifier, forHTTPHeaderField: "x-ios-bundle-identifier")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedResult = try JSONDecoder().decode([DAttractionOutline].self, from: data)
                        self.serverResult = decodedResult
                        self.searchResultCache.Add(key: startLocation, value: decodedResult)
                        self.isFinishedLoading = true
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func updateSearchResultCache(key: String, value: [DAttractionOutline]) {
        self.searchResultCache.Add(key: key, value: value)
    }
}


