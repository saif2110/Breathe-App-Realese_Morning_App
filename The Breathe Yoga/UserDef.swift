//
//  UserDef.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 22/06/21.
//

import Foundation


enum UserDefaultsKeys : String {
    case isProMember
    case isFirstTimeOpen
    case numberOftimeAppOpen

}



extension UserDefaults{
    func setisProMember(value: Bool){
        set(value,forKey: UserDefaultsKeys.isProMember.rawValue)
    }
    
    func isProMember() -> Bool{
        return bool(forKey: UserDefaultsKeys.isProMember.rawValue)
    }
    
    func setisFirstTimeOpen(value: Bool){
        set(value,forKey: UserDefaultsKeys.isFirstTimeOpen.rawValue)
    }
    
    func isFirstTimeOpen() -> Bool{
        return bool(forKey: UserDefaultsKeys.isFirstTimeOpen.rawValue)
    }
    
    func setnumberOftimeAppOpen(value: Double){
        set(value,forKey: UserDefaultsKeys.numberOftimeAppOpen.rawValue)
    }
    
    func getnumberOftimeAppOpen() -> Double{
        return double(forKey: UserDefaultsKeys.numberOftimeAppOpen.rawValue)
    }
}
