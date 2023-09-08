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
        
    //Mark:- Private function
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
    // show alert while add city ans save in databse
    private func save(city: City){
        let alert = UIAlertController.init(title: StringConstant.add.appending("\(city.city) ?"), message: StringConstant.cityAddAlertTitle.appending("\(city.city)?"), preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: StringConstant.add, style: .default) { [weak self] (action) in
            guard let isRecordSave = self?.searchViewModel.saveRecord(cityObj: city) else {
                print("error in saving")
                return
            }
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction.init(title: StringConstant.cancel, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }

       alert.addAction(action)
       alert.addAction(cancelAction)
       present(alert, animated: true, completion: nil)
    }
}

//Mark:- UITableViewDelegate, UITableViewDataSource
extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchCityList, for: indexPath)
        let city = searchViewModel.selectedCity(row: indexPath.row)
        if !city.city.isEmpty {
            cell.textLabel?.text = city.city
            cell.detailTextLabel?.text = city.country
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        save(city: city)
    }
}

//Mark:- UISearchBarDelegate
extension SearchViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count > 2 {
            searchViewModel.input.getCities(city: searchText)
        }
    }
}
