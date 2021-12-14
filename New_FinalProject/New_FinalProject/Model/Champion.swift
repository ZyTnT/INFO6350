//
//  Champion.swift
//  New_FinalProject
//
//  Created by 赵芷涵 on 12/10/21.
//

import Foundation
import RealmSwift

class Champion : Object{
    @objc dynamic var Name: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var hp: String = ""
    @objc dynamic var mp: String = ""
    @objc dynamic var armor: String = ""
    @objc dynamic var moveSpeed: String = ""
    @objc dynamic var spell1: String = ""
    @objc dynamic var spell2: String = ""
    @objc dynamic var spell3: String = ""
    @objc dynamic var spell4: String = ""
    @objc dynamic var picAddress: String = ""
    @objc dynamic var attackrange: String = ""
    @objc dynamic var attackdamage: String = ""
    
    override static func primaryKey() -> String? {
        return "Name"
    }
}
