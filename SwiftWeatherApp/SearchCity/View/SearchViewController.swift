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
    var searchViewModel: SearchViewModel!
    
    //Mark:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindPublisher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
        
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = StringConstant.enterCityName
        self.view.backgroundColor = #colorLiteral(red: 0.9185258746, green: 0.9135604501, blue: 0.9351554513, alpha: 1)
    }
    
    private func bindPublisher() {
        searchViewModel.output.cityPublisher.sink {[weak self] cities in
            self?.cityList = cities
            self?.tableView.reloadData()
        }.store(in: &cancellable)
        
        searchViewModel.output.errorPublisher.sink { errorString in
            print(errorString)
        }.store(in: &cancellable)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchViewModel.input.getCities(city: searchText)
    }
    
    // show alert while add city ans save in databse
    func save(city:String, country:String){
        let alert = UIAlertController.init(title: StringConstant.add.appending("\(city) ?"), message: StringConstant.cityAddAlertTitle.appending("\(city)?"), preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: StringConstant.add, style: .default) { (action) in
            //CoreDataManager.shared.insertCity(city: city,country:country)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction.init(title: StringConstant.cancel, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }

       alert.addAction(action)
       alert.addAction(cancelAction)
       present(alert, animated: true, completion: nil)
    }
}

//Mark- UITableViewDelegate, UITableViewDataSource
extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchCityList, for: indexPath)
        let cities = cityList[indexPath.row].city.components(separatedBy: ",")
        if !cities.isEmpty {
            cell.textLabel?.text = cities[0]
            cell.detailTextLabel?.text = cities[2]
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cities = cityList[indexPath.row].city.components(separatedBy: ",")
        print(cities[0])
        save(city: cities[0], country: cities[2])
    }
}
