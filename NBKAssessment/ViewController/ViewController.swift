//
//  ViewController.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 03/08/2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var newsTableView: UITableView!
    let viewModel = NewsListViewModel(networkService: NewsService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "All News"
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(UINib(nibName: NewsTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseID)
        
        viewModel.viewDelegate = self
        
        Task {
            await getNewsFromAPI()
        }
    }
    
    private func getNewsFromAPI() async {
        await viewModel.getNews(country: "us", category: "business")
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        
        if let newsItem = viewModel.getNewsItemAt(index: indexPath.row) {
            cell.newsTitleLbl.text = newsItem.title
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Int(viewModel.getTotalPages()) < viewModel.getCurrentPageNumber() {
            if indexPath.row == viewModel.getTotalNewsCount() {
                Task {
                    await viewModel.getNews(country: "us", category: "business", pageNumber: viewModel.getCurrentPageNumber() + 1)
                }
            }
        }
    }
}

extension ViewController: NewsListViewDelegate {
    func didGetNewsList(list: [Article]) {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func getNewsListFailed(error: RequestError) {
        print(error)
    }
}

