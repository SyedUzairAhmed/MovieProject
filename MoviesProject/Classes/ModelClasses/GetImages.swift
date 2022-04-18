//
//  GetImages.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getImages = try? newJSONDecoder().decode(GetImages.self, from: jsonData)

import Foundation

// MARK: - GetImages
struct GetImages: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let logos, posters: [Backdrop]
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

