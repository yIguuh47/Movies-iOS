//
//  ViewController.swift
//  MoviesApp
//
//  Created by Virtual Machine on 09/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let service = ApiService()
    let urlBaseImage = "https://image.tmdb.org/t/p/w500"
    var listJson: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        service.getPopularTvData { json, error in
            if let safeJson = json {
                for i in 0 ..< safeJson.count {
                    self.listJson.append("\(self.urlBaseImage)\(safeJson[i].posterImage!)")
                }
                print("\(self.listJson[0]) AAAAAAA")
                self.configTableView()
            } else {
                print(error)
            }
        }
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setupCell(title: "Popular Tv", listImage: listJson)
        return cell
    }


}

