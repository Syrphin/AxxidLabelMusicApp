//
//  Tracks.swift
//  Axxid Label
//
//  Created by Syrphin on 16.03.22.
//

import Foundation

struct Response: Decodable {
    var resultCount: Int
    var results: [Track]?
    
}
struct Track:Decodable  {
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let primaryGenreName: String?
    let country: String?
    let copyright: String?
    
}
 

