//
//  NewsService.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 09/08/2023.
//

import Foundation

protocol NewsServiceable {
    func getTopHeadlines(country: String, category: String, pageNumber: Int) async -> Result<NewsAPIResponseModel, RequestError>
}

struct NewsService: HTTPClient, NewsServiceable {
    func getTopHeadlines(country: String, category: String, pageNumber: Int) async -> Result<NewsAPIResponseModel, RequestError> {
        return await sendRequest(endpoint: NewsEndPoints.topHeadlines(country: country, category: category, pageNumber: String(pageNumber)), responseModel: NewsAPIResponseModel.self)
    }
}
