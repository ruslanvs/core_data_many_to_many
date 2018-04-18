//
//  HomeVC.swift
//  core_data_many_to_many
//
//  Created by Ruslan Suvorov on 4/16/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    var persons = [Person]()
    var languages = [Language]()
    var scores = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
//        seedData()
        languages = LanguageModel.shared.getAll()
        scores = ScoreModel.shared.getAll( for: languages[0] )
    }
    
    func seedData(){
        
        let personNames = ["Peter", "Yao", "Maret", "Tony", "Namoto"]
        for name in personNames {
            PersonModel.shared.create( name: name )
        }
        
        let languageNames = ["English", "French", "Russian", "Chechen", "Japanese"]
        for name in languageNames {
            LanguageModel.shared.create( name: name )
        }
        
        var persons = PersonModel.shared.getAll()
        var languages = LanguageModel.shared.getAll()

        ScoreModel.shared.create(person: persons[0], language: languages[0], score: 97)
        ScoreModel.shared.create(person: persons[0], language: languages[1], score: 88)
        ScoreModel.shared.create(person: persons[0], language: languages[2], score: 85)
        
        ScoreModel.shared.create(person: persons[1], language: languages[0], score: 95)
        ScoreModel.shared.create(person: persons[1], language: languages[2], score: 87)
        ScoreModel.shared.create(person: persons[1], language: languages[4], score: 88)
        
        ScoreModel.shared.create(person: persons[2], language: languages[3], score: 98)
        ScoreModel.shared.create(person: persons[2], language: languages[0], score: 87)
        ScoreModel.shared.create(person: persons[2], language: languages[2], score: 93)
        
        ScoreModel.shared.create(person: persons[3], language: languages[0], score: 99)
        ScoreModel.shared.create(person: persons[3], language: languages[1], score: 92)
        ScoreModel.shared.create(person: persons[3], language: languages[2], score: 85)
        
        ScoreModel.shared.create(person: persons[4], language: languages[4], score: 99)
        ScoreModel.shared.create(person: persons[4], language: languages[0], score: 92)
        ScoreModel.shared.create(person: persons[4], language: languages[1], score: 87)
        ScoreModel.shared.create(person: persons[4], language: languages[3], score: 82)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath)
        cell.textLabel?.text = scores[indexPath.row].person?.name
        cell.detailTextLabel?.text = String(scores[indexPath.row].score)
        return cell
    }
}

extension HomeVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scores = ScoreModel.shared.getAll( for: languages[row] )
        tableView.reloadData()
    }
}
