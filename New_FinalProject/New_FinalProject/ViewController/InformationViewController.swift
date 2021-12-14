//
//  InformationViewController.swift
//  New_FinalProject
//
//  Created by Yutong Zhen on 12/10/21.
//

import UIKit


class InformationViewController: UIViewController {
    
    var receiveChampion = Champion()
    var receiveItem = Item()
    var receiveFlag = ""
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Do any additional setup after loading the view.
    }
    func loadData(){
        if receiveFlag == "champion" {
            let picAddress = URL(string:receiveChampion.picAddress)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: picAddress!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data!)
                    
                }
            }
            
            lblName.text = receiveChampion.Name
            lbl1.text = receiveChampion.title
            lbl2.text = "HP:  \(receiveChampion.hp)"
            lbl3.text = "MP:  \(receiveChampion.mp)"
            lbl4.text = "Armor:  \(receiveChampion.armor)"
            lbl5.text = "Move Speed:  \(receiveChampion.moveSpeed)"
            lbl6.text = "Attack Damage:  \(receiveChampion.attackdamage)"
            lbl7.text = "Attack Range:  \(receiveChampion.attackrange)"
        }else{
            
            lblName.text = receiveItem.Name
            lbl1.text = receiveItem.plainttext
            lbl2.text = "Gold:  \(receiveItem.gold)"
            lbl3.text = "Sell Price:  \(receiveItem.sellPrice)"
            let picAddress = URL(string:receiveItem.picAddress)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: picAddress!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data!)
                    
                }
            }
        }
        
    }
    

}
