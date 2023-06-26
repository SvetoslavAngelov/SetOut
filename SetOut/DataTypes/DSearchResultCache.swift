//
//  DSearchResultCache.swift
//  SetOut
//
//  Created by Svetoslav Angelov on 17/06/2023.
//

import Foundation

class DSearchResultCache {
    
    private var searchResults: [String: [DAttractionOutline]]
    private var capacity: Int

    init(searchResults: [String : [DAttractionOutline]] = [:], capacity: Int = 3) {
        self.searchResults = searchResults
        self.capacity = capacity
    }
    
    func Get(key: String) -> [DAttractionOutline]? {
        guard let value = self.searchResults[key] else { return nil }
        
        return value
    }
    
    func Add(key: String, value: [DAttractionOutline]) -> Void {
        if self.searchResults.capacity == capacity {
            
            // Remove a random element from the cache
            self.searchResults.removeValue(forKey: self.searchResults.randomElement().unsafelyUnwrapped.key)
        }
        
        self.searchResults[key] = value
    }
}
