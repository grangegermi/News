//
//  BlocksModel.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import Foundation

struct Blocks:Codable {
    let results: [ResultBlocks]
}

struct ResultBlocks:Codable {
    let id: Int
    let title: String
    let titleSymbol: String?
    let subTitle: String?
    let buttonTitle: String
    let buttonSymbol: String?
}
