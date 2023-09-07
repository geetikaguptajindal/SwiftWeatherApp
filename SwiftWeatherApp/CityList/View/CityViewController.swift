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
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Left View
    private let leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    private let leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Button_right")
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Mark:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // TOdo : remove after DB
        cities.append(City(city: "vienna"))
        self.assignbackground()
        self.setupUI()
    }
    
    private func assignbackground(){
        let background = UIImage(named: "Background")

        let imageView: UIImageView = UIImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.image = background
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupUI() {
        setupTableView()
        
        self.view.addSubview(topHeaderView)
        NSLayoutConstraint.activate([
            topHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            topHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topHeaderView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        // Add other top view component
        self.makeNavigationBar()
        
        self.view.addSubview(tableViewCities)
        tableViewCities.backgroundColor = .clear
        tableViewCities.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewCities.topAnchor.constraint(equalTo: topHeaderView.bottomAnchor),
            tableViewCities.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableViewCities.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
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
            mainTitle.font = UIFont.boldSystemFont(ofSize: 20)
            mainTitle.text = StringConstant.city
            mainTitle.textColor = .darkGray
            mainTitle.translatesAutoresizingMaskIntoConstraints = false
            mainTitle.textAlignment = .center
            mainTitle.clipsToBounds = true
            return mainTitle
        }()
     
        topHeaderView.addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 60),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 44),
            label.centerXAnchor.constraint(equalTo: topHeaderView.centerXAnchor)
        ])
        
        topHeaderView.addSubview(leftImage)
        NSLayoutConstraint.activate([
            leftImage.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 44),
            leftImage.heightAnchor.constraint(equalToConstant: 100),
            leftImage.widthAnchor.constraint(equalToConstant: 102),
            leftImage.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0)
        ])
        
        topHeaderView.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(self.addButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 44),
            leftButton.heightAnchor.constraint(equalToConstant: 70),
            leftButton.widthAnchor.constraint(equalToConstant: 102),
            leftButton.trailingAnchor.constraint(equalTo: topHeaderView.trailingAnchor, constant: 0)
        ])        
    }
    
    @objc func addButtonTapped() {
        self.router.navigateToRepoDetails()
    }
}

// Mark- UITableViewDelegate, UITableViewDataSource
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
        cell.tintColor = #colorLiteral(red: 0.1389417946, green: 0.5331383944, blue: 0.7812908888, alpha: 1)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
