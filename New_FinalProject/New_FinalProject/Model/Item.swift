//
//  Item.swift
//  New_FinalProject
//
//  Created by 赵芷涵 on 12/10/21.
//

import Foundation
import RealmSwift
class Item : Object{
    @objc dynamic var id: String = ""
    @objc dynamic var Name: String = ""
    @objc dynamic var plainttext: String = ""
    @objc dynamic var gold: Int = 0
    @objc dynamic var picAddress: String = ""
    @objc dynamic var sellPrice: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
