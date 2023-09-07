//
//  CityViewController.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 06/09/23.
//

import UIKit

final class CityViewController: UIViewController {
    private var tableViewCities: UITableView!
    private var cities : [City] = [City]()
    var router: CityToSearchRouter!

    // Header View
    private var topHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Left View
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Button_right"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Button_right"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    //Mark:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // TOdo : remove after DB
        cities.append(City(city: "vienna"))
        self.assignbackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func assignbackground(){
        let background = UIImage(named: "Background")

        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = background
        imageView.backgroundColor = #colorLiteral(red: 0.9185258746, green: 0.9135604501, blue: 0.9351554513, alpha: 1)
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0)
        ])
    }
    
    private func setupUI() {
        setupTableView()
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(topHeaderView)
        NSLayoutConstraint.activate([
            topHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topHeaderView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        // Add other top view component
        self.makeNavigationBar()
        
        self.view.addSubview(tableViewCities)
        tableViewCities.backgroundColor = .clear
        tableViewCities.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewCities.topAnchor.constraint(equalTo: topHeaderView.bottomAnchor),
            tableViewCities.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableViewCities.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableViewCities.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupTableView() {
        tableViewCities = UITableView()
        tableViewCities.delegate = self
        tableViewCities.dataSource = self
        tableViewCities.separatorStyle = .singleLine
        tableViewCities.showsVerticalScrollIndicator = false
        tableViewCities.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.mainCityList)
    }
}

//Mark:- To create other componenet of top bar
extension CityViewController {
        
    func makeNavigationBar() {
        let label: UILabel = {
            let mainTitle = UILabel()
            mainTitle.font = UIFont.boldSystemFont(ofSize: 25)
            mainTitle.text = StringConstant.city
            mainTitle.textColor = .darkGray
            mainTitle.translatesAutoresizingMaskIntoConstraints = false
            mainTitle.textAlignment = .center
            mainTitle.clipsToBounds = true
            return mainTitle
        }()
     
        topHeaderView.addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 90),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor)
        ])
        
        topHeaderView.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(self.addButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 0),
            leftButton.heightAnchor.constraint(equalToConstant: 100),
            leftButton.widthAnchor.constraint(equalToConstant: 102),
            leftButton.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0)
        ])
    }
    
    @objc func addButtonTapped() {
        self.router.navigateToRepoView()
    }
}

//Mark- UITableViewDelegate, UITableViewDataSource
extension CityViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.mainCityList, for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.city
        cell.textLabel?.font = .boldSystemFont(ofSize: 30)
        cell.textLabel?.textColor = #colorLiteral(red: 0.1389417946, green: 0.5331383944, blue: 0.7812908888, alpha: 1)
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        self.router.navigateToWeatherView(with: city.city)
    }
}
