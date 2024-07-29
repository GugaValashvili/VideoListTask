//
//  VideoModel.swift
//  Qarva
//
//  Created by Guga Valashvili on 27.07.24.
//

import Foundation

struct VideoModel: Decodable {
    let genre: [String]
    let language: [String]
    let year: [String]
    let country: [String]
    let root: [Root]
}

struct Root: Decodable {
    let id: Int
    let name: String
    let num_children: Int
    let num_videos: Int
    let videos: [Videos]
}

struct Videos: Decodable {
    let type: String
    let id: Int
    let video_id: Int
    let poster: Int
    let title: String
    let alt_title: String
    let genres: [String]
    let audios: [String]
    let countries: [String]
    let year: Int
    let description: String
    let cast: String
    let age: Int
    let imdb: Int
}
