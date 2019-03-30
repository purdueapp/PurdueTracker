//
//  LaundryRoomViewController.swift
//  PurdueWash
//
//  Created by Tobi Ola on 3/25/19.
//  Copyright © 2019 Tobi Ola. All rights reserved.
//

import UIKit

class LaundryRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    let searchController = UISearchController(searchResultsController: nil)
    var machines = [Machine]()
    
    
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var machineTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        machineTable.dataSource = self
        machineTable.delegate = self
        
        machineTable.estimatedRowHeight = 150
        machineTable.rowHeight = 80
        
        if #available(iOS 10.0, *) {
            machineTable.refreshControl = refreshControl
        } else {
            machineTable.addSubview(refreshControl)
        }
        navigationItem.searchController = searchController
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Laundry Data ...")
        refreshControl.addTarget(self, action: #selector(refreshLaundryData(_:)), for: .valueChanged)

        
    }
    
    @objc private func refreshLaundryData(_ sender: Any) {
        // Fetch Weather Data
        fetchLaundryData()
    }
    
    private func fetchLaundryData() {
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MachineCell") as! MachineTableViewCell
        let machine = machines[indexPath.row]

        cell.machineNameLabel.text = machine.name
        cell.statusLabel.text = machine.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return machines.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
