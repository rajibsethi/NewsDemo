//
//  ViewController.swift
//  NewsDemo
//
//  Created by Rajib on 3/28/19.
//  Copyright © 2019 mFino. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var listTableview: UITableView!

    let articleArray:NSMutableArray = NSMutableArray()

    var activityIndicator: UIActivityIndicatorView!

    var viewActivityIndicator: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        listTableview.delegate = self
        listTableview.dataSource = self


        self.title="NY Times Most Popular"

        //self.tableView.contentInset = UIEdgeInsets(top: 0, left:5, bottom: 0, right: 5)

        let width: CGFloat = 200.0
        let height: CGFloat = 50.0
        let x = self.view.frame.width/2.0 - width/2.0
        let y = self.view.frame.height/2.0 - height/2.0

        self.viewActivityIndicator = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.viewActivityIndicator.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 51.0/255.0, alpha: 0.5)
        self.viewActivityIndicator.layer.cornerRadius = 10

        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.color = UIColor.black
        self.activityIndicator.hidesWhenStopped = false

        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        titleLabel.text = "Processing..."

        self.viewActivityIndicator.addSubview(self.activityIndicator)
        self.viewActivityIndicator.addSubview(titleLabel)

        self.view.addSubview(self.viewActivityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()



        callWebservice()
    }

    func callWebservice(){
        let url = URL(string:"https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=dAiClZ3PEVRbsIFlVQuNgA7QZnhKzNen")

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in

            guard error == nil else {
                print("returning error")
                return
            }

            guard let content = data else {
                print("not returning data")
                return
            }


            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }



            let listArray = json as NSDictionary

            let array = listArray["results"]
            self.articleArray.addObjects(from: array as! [Any])

//
//
//            self.articleArray.addObjects(from: array as! [Any])
//
//             print(self.articleArray)
//
//            for (key,_) in listArray {
//
//                let contact:NSObject = listArray[key] as! NSObject
//                self.articleArray.add(contact)
//
//
//            }


            DispatchQueue.main.async {
                self.listTableview.reloadData()

                //do something here that will taking time

                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.viewActivityIndicator.removeFromSuperview()


            }

        }

        task.resume()


    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }

     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.articleArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleList", for: indexPath)

        if self.articleArray.count>0
        {

            cell.layer.cornerRadius = 5
            //cell.layer.masksToBounds = true
            cell.backgroundColor=UIColor.white

            // Configure the cell...
            let label1 = cell.viewWithTag(100) as! UILabel

            let last : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
            let lastText = last["title"]
            label1.text = String(format: "%@",(lastText as! String))

            let label2 = cell.viewWithTag(101) as! UILabel
            let lowestAsk : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
            let lowestAskText = lowestAsk["abstract"]
            label2.text = String(format: "%@",(lowestAskText as! String))

            let label3 = cell.viewWithTag(102) as! UILabel
            let highestBid : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
            let highestBidText = highestBid["published_date"]
            label3.text = String(format: "%@",(highestBidText as! String))

            let imageLogo = cell.viewWithTag(103) as! UIImageView
            imageLogo.layer.masksToBounds = false
            imageLogo.layer.cornerRadius = imageLogo.frame.height/2
            imageLogo.clipsToBounds = true

        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        tableView.deselectRow(at: indexPath, animated: true)

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // Create a SecondViewController instance, from the storyboardID of the same.
        let detailsConroller = storyBoard.instantiateViewController(withIdentifier: "DetailID") as! DetailViewController
        let last : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
        let lastText = last["title"]

        // set a variable in the second view controller with the data to pass
        detailsConroller.receivedDataTitle = lastText as! String

        let lowestAsk : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
        let lowestAskText = lowestAsk["abstract"]
        detailsConroller.receivedDataDesc = lowestAskText as! String

        let highestBid : NSDictionary = self.articleArray[indexPath.section] as! NSDictionary
        let highestBidText = highestBid["published_date"]

        detailsConroller.receivedDataDate = highestBidText as! String

        self.navigationController?.pushViewController(detailsConroller, animated: true)



    }


}

