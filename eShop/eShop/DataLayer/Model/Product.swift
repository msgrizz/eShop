//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

struct Product {

    struct Field {
        static let barcode  = "barcode"
        static let name     = "name"
        static let creation = "creation"
    }

    let key: String
    let barcode: String
    let name: String?
    let creation: Double
    let ref: DatabaseReference?

    init(name: String?, barcode: String, key: String = "") {
        self.key = key
        self.name = name
        self.barcode = barcode
        self.creation = Date().timeIntervalSince1970
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
            let _name = _snapshotValue[Field.name] as? String ,
            let _barcode = _snapshotValue[Field.barcode] as? String,
            let _creation = _snapshotValue[Field.creation] as? Double else { return nil }

        key = snapshot.key
        name = _name.isEmpty ? nil : _name
        barcode = _barcode
        creation = _creation
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            Field.name: name ?? "",
            Field.barcode: barcode,
            Field.creation:  creation
        ]
    }

    // MARK: - Public methods
    func getKey() -> String {
        return barcode
    }
}
