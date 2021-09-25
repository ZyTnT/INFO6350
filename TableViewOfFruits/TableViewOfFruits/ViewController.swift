//
//  ViewController.swift
//  TableViewOfFruits
//
//  Created by 赵芷涵 on 9/24/21.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fruit = ["pineapple", "strawberry", "papaya", "cherry", "tangerinr"]

    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.imgFruit.image = UIImage(named: fruit[indexPath.row])
        cell.lblFruit.text = fruit[indexPath.row]
        
        return cell
    }


}

