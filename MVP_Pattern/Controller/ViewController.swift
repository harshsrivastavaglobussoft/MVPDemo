//
//  ViewController.swift
//  MVP_Pattern
//
//  Created by Sumit Ghosh on 19/01/19.
//  Copyright © 2019 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var countryTableView: UITableView!
    
    //intitialzing the presneter
    fileprivate let countryPresenter = CountryPresenter.init(apiHelper: APIHelper())
    var countryArray = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting activityindicator
        self.activityIndicator.isHidden = true
        self.activityIndicator.hidesWhenStopped = true
        
        //Calling tableview delegate and datasource
        self.countryTableView.delegate = self
        self.countryTableView.dataSource = self
        
        //Setting the presenter
        countryPresenter.attachViewToPresenter(self)
        countryPresenter.getCountryList()


    }
}

//Tableview delegates
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        let data = self.countryArray[indexPath.row]
        cell.textLabel?.text = data.name ?? ""
        cell.detailTextLabel?.text = data.capital ?? ""
        
        return cell
    }
}

//presenter delegates 
extension ViewController: presenterDelegate {
    func startLoading() {
        self.activityIndicator.isHidden = false
    }
    
    func dataReceived(countryArray: [Country]) {
        self.countryArray = countryArray
        self.countryTableView.reloadData()
    }
    
    func finishLoading() {
        self.activityIndicator.isHidden = true
    }
    
    func dataEmpty() {
        let alert = UIAlertController.init(title: "Sorry", message: "Data not received", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

