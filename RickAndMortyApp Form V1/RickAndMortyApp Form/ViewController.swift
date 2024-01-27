//
//  ViewController.swift
//  RickAndMortyApp Form
//
//  Created by Diplomado on 01/12/23.
//

import UIKit


class ViewController: UIViewController{
    
    @IBOutlet weak var labelPage: UILabel!
    var pageNumber = 1
    let restClient = RESTClient<PaginatedResponse<Character>>(client: Client("https://rickandmortyapi.com"))
    
    var characters: [Character]? {
        didSet {
            tableView.reloadData()
        
        }
    }
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        
        labelPage.text = "Pages: \(pageNumber)"
        //restClient.show("/api/character/", query: ["page": "2"])
        
        restClient.show("/api/character/",page: "\(pageNumber)") { response in
            self.characters = response.results
        }
        
        
    }


    
    
    @IBAction func leftButton(_ sender: Any) {
        if(pageNumber>1){
            pageNumber -= 1
            restClient.show("/api/character/",page: "\(pageNumber)") { response in
                self.characters = response.results
            }
            tableView.reloadData()
            labelPage.text = "Pages: \(pageNumber)"
        }
    }
    
    
    
    @IBAction func rightButton(_ sender: Any) {
        
        
        if(pageNumber<42){
            pageNumber += 1
            restClient.show("/api/character/",page: "\(pageNumber)") { response in
                self.characters = response.results
            }
            tableView.reloadData()
            labelPage.text = "Pages: \(pageNumber)"
        }
    }
    
    
    
    
    
}


extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = characters?[indexPath.row].name
        cell.detailTextLabel?.text = characters?[indexPath.row].species
        
        return cell
    }
    
    
}



