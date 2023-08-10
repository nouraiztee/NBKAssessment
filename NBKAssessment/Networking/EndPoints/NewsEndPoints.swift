//
//  NewsEndPoints.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 09/08/2023.
//

import Foundation

enum NewsEndPoints {
    case topHeadlines(country: String, category: String, pageNumber: String)
}

extension NewsEndPoints: Endpoint {
    var path: String {
        switch self {
        case .topHeadlines(_, _, _):
            return "/v2/top-headlines"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .topHeadlines(let country, let category, let pageNumber):
            var params = [
                "country": country,
                "category": category,
                "page": pageNumber,
                "pageSize": "10"
            ]
            
            params["apiKey"] = "d91313341ac6451fb40110e7750d8c80"
            return params
        }
    }
    
    
}
