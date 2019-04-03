//
//  ViewController.swift
//  0225Project1_PH
//
//  Created by 李沐軒 on 2019/2/25.
//  Copyright © 2019 李沐軒. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    // Initialize empty Dictionary to store view count for each picture
    var viewCount = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        title = "Storm View"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchData), with: nil)

        // Load ViewCount from User Defaults
        // Check if it exists and if so, cast it as a Dictionary
        if let viewCount = UserDefaults.standard.object(forKey: "viewCount") as? [String: Int] {
            // If it exists, overwrite the empty viewCount dictionary
            self.viewCount = viewCount
        }
    }
    
    @objc func fetchData() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictures.sort()
            }
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]

        // Check if the key exists, if it does then display the count
        if let count = viewCount[pictures[indexPath.row]] {
            cell.detailTextLabel?.text = "Views: \(count)"
        } else {
            // Otherwise display this ...
            cell.detailTextLabel?.text = "Views: None"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectImage = pictures[indexPath.row]
            vc.total = pictures.count
            vc.current = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
        
        // Check if the Key Exists
        if viewCount[pictures[indexPath.row]] != nil {
            // Key Exists - Add one to the value
            viewCount[pictures[indexPath.row]]! += 1
        } else {
            // Create the Key - Set the initial value to 1
            viewCount[pictures[indexPath.row]] = 1
        }
        
        // Save the Dictionary to UserDefaults
        UserDefaults.standard.set(viewCount, forKey: "viewCount")
        
        // Reload the tableView row that was selected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}


