//
//  NewsAPIResponseModel.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 08/08/2023.
//

import Foundation


// MARK: - NewsAPIResponseModel
struct NewsAPIResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

