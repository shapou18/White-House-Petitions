//
//  ViewController.swift
//  Project 7 - White House Petitions
//
//  Created by Shana Pougatsch on 9/9/20.
//  Copyright © 2020 Shana Pougatsch. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
//MARK:- Properties
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

//MARK:- View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* simple way for nav buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(displayCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions)) */
        
        // decided to look up how to display a reset/clear data
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPetitions))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(displayCredits))
        navigationItem.leftBarButtonItems = [filterButton, resetButton]
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&Limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        /* First way to display JSON downloading
        // try to convert that string into a URL
        if let url = URL(string: urlString) {
            // fetch data from API
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }*/
        
        // Second way to display JSON downloading
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                // filteredPetitions = petitions is for the challenge
                filteredPetitions = petitions
                return
            }
        }
         showError()
    }
    
//MARK:- Methods
    
    @objc func filterPetitions() {
        let ac = UIAlertController(title: nil, message: "What can we help you look for?", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] _ in
            guard let filteredWords = ac?.textFields?[0].text else { return }
            self?.showPetitions(for: filteredWords)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func resetPetitions(action: UIAlertAction) {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    @objc func displayCredits() {
        let ac = UIAlertController(title: nil, message: "The data being displayed on these pages are from \n'We The People API of the White House'", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Thank you", style: .default))
        present(ac, animated: true)
    }
    
    func showPetitions(for filter: String) {
        
        /* non-refactored code:
         for petition in petitions {
            if petition.title.contains(filter) {
                filteredPetitions.append(petition)
            } else {
                continue
            }
        } */
        
        // refactored version for the challenge - this code allows you to filter the articles with multiple words and in lower case
        filteredPetitions = filteredPetitions.filter ({ $0.title.lowercased().range(of: filter.lowercased()) != nil})
        
        tableView.reloadData()
    }
            
    func parse(json: Data) {
        let decoder = JSONDecoder()
    
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an error loading the data", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Exit", style: .default))
        present(ac, animated: true)
    }
    

//MARK:- Table Views
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // let petition = petitions[indexPath.row]
        // code below is for challenge
        let petition = filteredPetitions[indexPath.row]
        
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        }
    }


