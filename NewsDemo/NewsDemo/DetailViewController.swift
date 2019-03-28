//
//  DetailViewController.swift
//  NewsDemo
//
//  Created by Rajib on 3/28/19.
//  Copyright © 2019 mFino. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var receivedDataTitle = ""
     var receivedDataDesc = ""
     var receivedDataDate = ""


        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="Detail"

        let backBarButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(backButtonTapped(sender:))) as UIBarButtonItem
        self.navigationItem.setLeftBarButton(backBarButton, animated: true)

        self.tableView.reloadData()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func backButtonTapped(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        // Configure the cell...

        cell.layer.cornerRadius = 5
        //cell.layer.masksToBounds = true
        cell.backgroundColor=UIColor.white

        let label1 = cell.viewWithTag(100) as! UILabel
        label1.text = String(format: "%@",(receivedDataTitle ))

        let label2 = cell.viewWithTag(101) as! UILabel
        label2.text = String(format: "%@",(receivedDataDesc ))

        let label3 = cell.viewWithTag(102) as! UILabel
        label3.text = String(format: "%@",(receivedDataDate ))

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
