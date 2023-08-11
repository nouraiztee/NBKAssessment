//
//  NewsListViewModel.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 09/08/2023.
//

import Foundation

protocol NewsListViewDelegate {
    func didGetNewsList(list: [Article])
    func getNewsListFailed(error: RequestError)
    func didSearchedNewsList()
}

protocol NewsListViewModelDelegate {
    func getNews(country: String, category: String, pageNumber: Int) async
    func searchNews(term: String)
}

class NewsListViewModel {
    var networkService: NewsServiceable
    var viewDelegate: NewsListViewDelegate?
    var newsRespModel: NewsAPIResponseModel?
    var totalResults: Int?
    var articles: [Article]?
    var searchedArticles: [Article]?
    
    var pageSize = 10.0
    var pageNumber = 1
    
    var isShowingSearchedNews = false
    
    init(networkService: NewsServiceable) {
        self.networkService = networkService
    }
    
    func getTotalNewsCount() -> Int {
        isShowingSearchedNews == false ? newsRespModel?.totalResults ?? 0 : searchedArticles?.count ?? 0
    }
    
    func getTotalPages() -> Double {
        ceil(Double((newsRespModel?.totalResults ?? 0)) / pageSize)
    }
    
    func getRowCount() -> Int {
        isShowingSearchedNews == false ? articles?.count ?? 0 : searchedArticles?.count ?? 0
    }
    
    func getCurrentPageNumber() -> Int {
        pageNumber
    }
    
    func getNewsItemAt(index: Int) -> Article? {
        isShowingSearchedNews == false ? articles?[index] ?? nil : searchedArticles?[index] ?? nil
    }
}

extension NewsListViewModel: NewsListViewModelDelegate {
    func getNews(country: String, category: String, pageNumber: Int = 1) async {
        Task(priority: .background) {
            let result = await networkService.getTopHeadlines(country: country, category: category, pageNumber: pageNumber)
            
            switch result {
            case .success(let newsModel):
                newsRespModel = newsModel
                totalResults = newsModel.totalResults
                self.pageNumber = pageNumber
                
                if articles == nil {
                    articles = newsModel.articles
                }else {
                    articles?.append(contentsOf: newsModel.articles)
                }
                
                viewDelegate?.didGetNewsList(list: newsModel.articles)
                break
            case .failure(let error):
                viewDelegate?.getNewsListFailed(error: error)
                break
            }
        }
    }
    
    func searchNews(term: String) {
        if term.isEmpty {
            isShowingSearchedNews = false
            searchedArticles?.removeAll()
            
            viewDelegate?.didSearchedNewsList()
        }else {
            isShowingSearchedNews = true
            searchedArticles?.removeAll()
            
            let filteredNewsItems = articles?.filter({$0.title?.lowercased().contains(term.lowercased()) ?? false})
            
            searchedArticles = filteredNewsItems
            
            viewDelegate?.didSearchedNewsList()
        }
    }
}
