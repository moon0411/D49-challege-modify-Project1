//
//  DetailViewController.swift
//  0225Project1_PH
//
//  Created by 李沐軒 on 2019/2/26.
//  Copyright © 2019 李沐軒. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var selectImage: String?
    var total: Int?
    var current: Int?
    var selectNow: Int?
    
    @IBOutlet var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.largeTitleDisplayMode = .never

        if let selectImage = selectImage, let current = current {
          
            myImage.image = UIImage(named: selectImage)
            selectNow = current + 1
        }
        
        title = "Picture \(String(describing: selectNow!)) of \(total!)"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
