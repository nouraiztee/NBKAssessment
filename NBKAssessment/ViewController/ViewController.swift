//
//  ViewController.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 03/08/2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "All News"
        
        newsTableView.dataSource = self
//        newsTableView.delegate = self
        newsTableView.register(UINib(nibName: NewsTableViewCell.reuseID, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        
        return cell
    }
}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
//}

