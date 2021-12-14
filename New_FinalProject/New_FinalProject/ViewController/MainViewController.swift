//
//  MainViewController.swift
//  New_FinalProject
//
//  Created by Yutong Zhen on 12/10/21.
//

import UIKit
import RealmSwift
import Realm
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == "champion"{
            return arrChampion.count
        }else{
            return arrItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if flag == "champion"{
        if editingStyle == .delete {

            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(realm.objects(Champion.self).filter("Name=%@",arrChampion[indexPath.row].Name))
            }
            
            // remove the item from the data model
            arrChampion.remove(at: indexPath.row)


            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            


        }
        }else{
            if editingStyle == .delete {

                let realm = try! Realm()
                try! realm.write {
                    realm.delete(realm.objects(Item.self).filter("Name=%@",arrItem[indexPath.row].Name))
                }
                
                // remove the item from the data model
                arrItem.remove(at: indexPath.row)
                


                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
                


            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ChampionTableViewCell", owner: self, options: nil)?.first as! ChampionTableViewCell
        if flag == "champion"{
            let url = URL(string: arrChampion[indexPath.row].picAddress)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.imgChampion.image = UIImage(data: data!)
                }
            }
            cell.lblChampion.text = arrChampion[indexPath.row].Name
        }else{
            cell.imgChampion.image = UIImage(url: URL(string: arrItem[indexPath.row].picAddress))
            cell.lblChampion.text = arrItem[indexPath.row].Name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flag == "champion"{
            chooseChampion = arrChampion[indexPath.row]
            performSegue(withIdentifier: "InformationSegue", sender: self)
        }else{
            chooseItem = arrItem[indexPath.row]
            performSegue(withIdentifier: "InformationSegue", sender: self)
        }    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if  segue.destination is InformationViewController {
                    if let vc = segue.destination as? InformationViewController {
                        vc.receiveChampion = chooseChampion
                        vc.receiveItem = chooseItem
                        vc.receiveFlag = flag
                    }
                }
            }


    @IBOutlet weak var tableView: UITableView!
    var arrChampion : [Champion] = [Champion]()
    var arrItem : [Item] = [Item]()
    var chooseChampion = Champion()
    var chooseItem = Item()

    
    var flag = "champion"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadCurrentConditions()
        
    }
    
    
   func loadCurrentConditions(){
        do{
            arrItem.removeAll()
            arrChampion.removeAll()
            let realm = try Realm()
            let champions = realm.objects(Champion.self)
            let items = realm.objects(Item.self)
            for champion in champions{
                arrChampion.append(champion)
            }
            for item in items{
                arrItem.append(item)
            }
            tableView.reloadData()
       }catch{
           print("Error in reading Database \(error)")
       }
    }

    @IBAction func RefreshAction(_ sender: Any) {
        loadCurrentConditions()
    }
    @IBAction func ChampionAction(_ sender: Any) {
        flag = "champion"
        loadCurrentConditions()
    }
    
    @IBAction func ItemsAction(_ sender: Any) {
        flag = "item"
        loadCurrentConditions()
    }
    
    
}
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
