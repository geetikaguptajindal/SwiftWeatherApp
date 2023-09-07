//
//  SearchViewController.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import UIKit
import Combine

final class SearchViewController: UITableViewController,UISearchBarDelegate {
   
    private var cityList : [City] = [City]()
    private var cancellable = Set<AnyCancellable>()

    let searchViewModel: SearchViewModel = DefaultSearchViewModel(_defaultSearchUseCases: DefaultSearchUseCases(networkManeger: NetworkManager.shared()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindPublisher()
         //getCities(city: "Vienna")
    }
    
    func bindPublisher() {
        
        searchViewModel.output.cityPublisher.sink {[weak self] cities in
            self?.cityList = cities
            self?.tableView.reloadData()
        }.store(in: &cancellable)
        
        searchViewModel.output.errorPublisher.sink {[weak self] errorString in
            print(errorString)
        }.store(in: &cancellable)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            print(searchText)
        searchViewModel.input.getCities(city: searchText)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)

        let array = cityList[indexPath.row].city.components(separatedBy: ",")
        if(array.count>1){
            print(cityList[indexPath.row])
            cell.textLabel?.text = array[0]
            cell.detailTextLabel?.text = array[2]
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let array = cityList[indexPath.row].city.components(separatedBy: ",")
        print(array[0])
        save(city: array[0], country: array[2])
    }
    
    func save(city:String,country:String){
        let alert = UIAlertController.init(title: "Add \(city) ?", message: "Are you sure you want to add \(city)?", preferredStyle: .alert)
               var textField = UITextField()

        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in
            //CoreDataManager.shared.insertCity(city: city,country:country)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }

       alert.addAction(action)
       alert.addAction(cancelAction)
       present(alert, animated: true, completion: nil)
    }
    
}
