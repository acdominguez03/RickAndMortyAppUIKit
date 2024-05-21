//
//  ViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 20/5/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let names = [
        CharacterModel(name: "Rick", image: "rick", status: "Live"),
        CharacterModel(name: "Anne", image: "character", status: "Dead"),
        CharacterModel(name: "Morty", image: "morty", status: "Unknown"),
        CharacterModel(name: "Andrew", image: "character", status: "Live"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    
    func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CharacterCell.nibName, bundle: nil), forCellReuseIdentifier: CharacterCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You touch me")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.height
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = names[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier) as? CharacterCell else {
            return CharacterCell()
        }
        
        cell.lbName.text = element.name
        cell.ivCharacter.image = UIImage(named: element.image)
        cell.lbStatus.text = "Status: " + element.status
        
        return cell
    }
    
}

