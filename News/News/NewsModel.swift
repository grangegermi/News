//
//  NewsModel.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import Foundation

struct News: Codable {
    let results: [Result]?
}

struct Result: Codable, Identifiable {
    var id: Int?
    let url: String?
    let publishedDate: String?
    let section: String?
    let title: String?
    let abstract:String?
    let media: [Media]?
}

struct Media:Codable {
    let mediaMetaData: [MediaMetaData]?
    
    enum CodingKeys: String, CodingKey {
           case mediaMetaData = "media-metadata"
       }
}

struct MediaMetaData: Codable{
    let url: String?
}

extension Result {
    var formattedPublishedDate: String {
        
        guard let dateString = publishedDate else { return "" }

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}
