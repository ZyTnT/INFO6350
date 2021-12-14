//
//  AddViewController.swift
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

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var championList = [Champion]()
    var itemList = [Item]()
    var flag = "champion"
    let championAPI = "https://ddragon.leagueoflegends.com/cdn/11.24.1/data/en_US/champion.json"
    let itemAPI = "https://ddragon.leagueoflegends.com/cdn/11.24.1/data/en_US/item.json"
    let heros = ["Aatrox", "Akali", "Akshan", "Alistar", "Amumu","Anivia","Annie","Braum","Caitlyn","Corki","Darius","Elise","Garen","Irelia","Ivern","Janna","JarvanIV","Jinx","Kayle","Kayn","Lissandra","Nocturne","Pantheon","Senna","Swain","Vayne","Xayah","Yorick","Zoe"]
    let items = ["1001","1004","1006","1011","1018","1026","1027","1029","1031","1033","1035","1036","1040","1056","2051","2065","2140","3046","3057","3068","3074","3802","3863","6670"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == "champion"{
            return championList.count
        }else{
            return itemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
        if flag == "champion"{
            cell.textLabel?.text = "\(championList[indexPath.row].Name), \(championList[indexPath.row].title)"
        }else{
            cell.textLabel?.text = "\(itemList[indexPath.row].Name), \(itemList[indexPath.row].plainttext)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flag == "champion"{
            addChampionToDB(for: indexPath.row)
        }else{
            addItemToDB(for: indexPath.row)
        }
    }
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        
    }
    
    func isChampionAlreadyAdded(for index: Int) -> Bool{
        
        let loc = championList[index]
        
        let realm = try! Realm()
        if realm.object(ofType: Champion.self, forPrimaryKey: loc.Name) != nil {
            return true
        }
        return false
    }
    
    func isItemAlreadyAdded(for index: Int) -> Bool{
        
        let loc = itemList[index]
        
        let realm = try! Realm()
        if realm.object(ofType: Item.self, forPrimaryKey: loc.id) != nil {
            return true
        }
        return false
    }
    
    func addChampion(for index: Int){
        
        if isChampionAlreadyAdded(for: index){
            return
        }
        
        // add champion in DB
        let loc = championList[index]
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(loc, update: Realm.UpdatePolicy.all)
            }
        }catch{
            print("Unable to add champion in the database")
        }
    }
    
    func addItem(for index: Int){
        
        if isItemAlreadyAdded(for: index){
            return
        }
        
        // add item in DB
        let loc = itemList[index]
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(loc, update: Realm.UpdatePolicy.all)
            }
        }catch{
            print("Unable to add champion in the database")
        }
    }
    
    func addChampionToDB(for row: Int){
        let hero = championList[row].Name
        let alert = UIAlertController(title: "Add Champion", message: "Get information for \(hero)", preferredStyle:.alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { action in
            print(row)
            self.addChampion(for: row)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel")
        }
        alert.addAction(OK)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addItemToDB(for row: Int){
        let item = itemList[row].Name
        let alert = UIAlertController(title: "Add Item", message: "Get information for \(item)", preferredStyle:.alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { action in
            print(row)
            self.addItem(for: row)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel")
        }
        alert.addAction(OK)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func championAction(_ sender: Any) {
        flag = "champion"
        championList.removeAll()
        let url = "http://ddragon.leagueoflegends.com/cdn/11.24.1/data/en_US/champion.json"
        AF.request(url).responseJSON { response in
            if response.error != nil {
                print(response.error)
            }
        var json = JSON(response.value)
        }
        
        let path = Bundle.main.path(forResource: "allChampions", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        let json = try? JSON(data: jsonData! as Data)
            for heroName in self.heros{
            let champion = Champion()
            champion.Name = heroName
            champion.title = json!["data"][heroName]["title"].stringValue
            champion.armor = json!["data"][heroName]["stats"]["armor"].stringValue
            champion.hp = json!["data"][heroName]["stats"]["hp"].stringValue
            champion.mp = json!["data"][heroName]["stats"]["mp"].stringValue
            champion.moveSpeed = json!["data"][heroName]["stats"]["movespeed"].stringValue
            champion.attackrange = json!["data"][heroName]["stats"]["attackrange"].stringValue
            champion.attackdamage = json!["data"][heroName]["stats"]["attackdamage"].stringValue
            champion.picAddress = "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/champion/" + json!["data"][heroName]["image"]["full"].stringValue
            championList.append(champion)
        }
            self.tblView.reloadData()
            
        }
    
    @IBAction func ItemsAction(_ sender: Any) {
        flag = "items"
        itemList.removeAll()
        let path = Bundle.main.path(forResource: "allItems", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        let json = try? JSON(data: (jsonData)! as Data)
        for ItemID in items{
            let item = Item()
            item.id = ItemID
            item.Name = json!["data"][ItemID]["name"].stringValue
            item.gold = json!["data"][ItemID]["gold"]["base"].intValue
            item.plainttext = json!["data"][ItemID]["plaintext"].stringValue
            item.sellPrice = json!["data"][ItemID]["gold"]["sell"].intValue
            
            item.picAddress = "https://ddragon.leagueoflegends.com/cdn/11.24.1/img/item/" + json!["data"][ItemID]["image"]["full"].stringValue
            print(item.picAddress)
            itemList.append(item)
        }
            self.tblView.reloadData()
    }
}
    
    
    


    
    

