//
//  SQLmodel.swift
//  Blood Oxygen Level App
//  Created by Junaid Mukadam on 14/06/21.
//

import SQLite
import SQLite3
import Foundation


let databaseName = "dbYoga.sqlite3"

func createSQLDataBase() {
  
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  // open database
  
  var db2: OpaquePointer?
  guard sqlite3_open(fileURL.path, &db2) == SQLITE_OK else {
    print("error opening database")
    sqlite3_close(db2)
    db2 = nil
    return
  }
}


enum yogaType:String {
  case kapal = "kapal"
  case sama = "sama"
  case anuloma = "anuloma"
  case ujjayi = "ujjayi"
  case anotherOne = "anotherOne"
  case anotherTwo = "anotherTwo"
}

func insertYogaState(TableName:TableName = .Yoga,Localkapal:Int64,Localsama:Int64,Localanuloma:Int64,Localujjayi:Int64,LocalanotherOne:Int64,LocalanotherTwo:Int64){
  
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  let users = Table(TableName.rawValue)
  let id = Expression<String>("id")
  let kapal = Expression<Int64?>(yogaType.kapal.rawValue)
  let sama = Expression<Int64?>(yogaType.sama.rawValue)
  let anuloma = Expression<Int64?>(yogaType.anuloma.rawValue)
  let ujjayi = Expression<Int64?>(yogaType.ujjayi.rawValue)
  let anotherOne = Expression<Int64?>(yogaType.anotherOne.rawValue)
  let anotherTwo = Expression<Int64?>(yogaType.anotherTwo.rawValue)
  
    print(kapal)
    
    
  try? db?.run(users.create { t in
    t.column(id, primaryKey: true)
    t.column(kapal)
    t.column(sama)
    t.column(anuloma)
    t.column(ujjayi)
    t.column(anotherOne)
    t.column(anotherTwo)
  })
  
  let insert = users.insert(id <- getDate(),kapal <- Localkapal, sama <- Localsama,anuloma <- Localanuloma,ujjayi <- Localujjayi, anotherOne <- LocalanotherOne,anotherTwo <- LocalanotherTwo)
  
  try? db?.run(insert)
  
}

func getDataYoga(TableName:TableName) -> [FechedDataYoga]{
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedDataYoga]()
  
  
  if let squence = try? db?.prepare("SELECT * From \(TableName) ORDER BY id DESC LIMIT 300"){
    for user in squence {
        let date:Expression<String> = Expression<String>(value: user[0]! as! Expression<String>.UnderlyingType)
      let kapal:Expression<Int64?> = Expression<Int64?>(value: user[1]! as! Expression<Int64?>.UnderlyingType)
      let sama:Expression<Int64?> = Expression<Int64?>(value: user[2]! as! Expression<Int64?>.UnderlyingType)
      let anuloma:Expression<Int64?> = Expression<Int64?>(value: user[3]! as! Expression<Int64?>.UnderlyingType)
      let ujjayi:Expression<Int64?> = Expression<Int64?>(value: user[4]! as! Expression<Int64?>.UnderlyingType)
      let anotherOne:Expression<Int64?> = Expression<Int64?>(value: user[5]! as! Expression<Int64?>.UnderlyingType)
      let anotherTwo:Expression<Int64?> = Expression<Int64?>(value: user[6]! as! Expression<Int64?>.UnderlyingType)
      
        data.append(FechedDataYoga(date: date, kapal: kapal, sama: sama, anuloma: anuloma, ujjayi: ujjayi, anotherOne: anotherOne, anotherTwo: anotherTwo))
        
      
        
    }
      
  }
    
    
    return data
}




func updateYogaStates(Type:yogaType,Date:String = getDate()){
  
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  try? db?.scalar("UPDATE \(TableName.Yoga) SET \(Type) = true WHERE id = '\(Date)'")
}


func fetchDataYoga(TableName:TableName) -> [FechedDataYoga]{
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedDataYoga]()
  
  
  if let squence = try? db?.prepare("SELECT * From \(TableName) ORDER BY id DESC LIMIT 300"){
    for user in squence {
      let date:Expression<String> = Expression<String>(value: user[0]! as! Expression<String>.UnderlyingType)
      let kapal:Expression<Int64?> = Expression<Int64?>(value: user[1]! as! Expression<Int64?>.UnderlyingType)
      let sama:Expression<Int64?> = Expression<Int64?>(value: user[2]! as! Expression<Int64?>.UnderlyingType)
      let anuloma:Expression<Int64?> = Expression<Int64?>(value: user[3]! as! Expression<Int64?>.UnderlyingType)
      let ujjayi:Expression<Int64?> = Expression<Int64?>(value: user[4]! as! Expression<Int64?>.UnderlyingType)
      let anotherOne:Expression<Int64?> = Expression<Int64?>(value: user[5]! as! Expression<Int64?>.UnderlyingType)
      let anotherTwo:Expression<Int64?> = Expression<Int64?>(value: user[6]! as! Expression<Int64?>.UnderlyingType)
      
      data.append(FechedDataYoga(date: date, kapal: kapal, sama: sama, anuloma: anuloma, ujjayi: ujjayi, anotherOne: anotherOne, anotherTwo: anotherTwo))
    }
  }
  
  return data
}



func inserInto(TableName:TableName,Value:String,Date:String){
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  let users = Table(TableName.rawValue)
  let id = Expression<Int64>("id")
  let value = Expression<String?>("value")
  let date = Expression<String>("date")
  
  try? db?.run(users.create { t in
    t.column(id, primaryKey: true)
    t.column(value)
    t.column(date)
  })
    
    
  
  let insert = users.insert(value <- Value, date <- Date)
  try! db?.run(insert)
}

func fetchData(TableName:TableName) -> [FechedData]{
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedData]()
  
  
  if let squence = try? db?.prepare("SELECT * From \(TableName) ORDER BY id DESC LIMIT 300"){
    for user in squence {
      let id:Expression<Int64> = Expression<Int64>(value: user[0]! as! Expression<Int64>.UnderlyingType)
      let value:Expression<String> = Expression<String>(value: user[1]! as! Expression<String>.UnderlyingType)
      let date:Expression<String> = Expression<String>(value: user[2]! as! Expression<String>.UnderlyingType)
      data.append(FechedData(id: id, value: value, date: date))
    }
  }
  
  return data
}




func deleteData(TableName:TableName,id:String){
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  try? db?.scalar("DELETE FROM \(TableName) WHERE id = \(id)")
}


func getAverageBreathe() -> String {
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let WeekinMili = 604800000
  let nowDouble = NSDate().timeIntervalSince1970
  var mili = Int64(nowDouble*1000)
  mili = mili - Int64(WeekinMili)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedData]()
  var onlymili = [Int]()
  
  if let squence = try? db?.prepare("SELECT * From Breath ORDER BY id LIMIT 7"){
    for user in squence {
      let id:Expression<Int64> = Expression<Int64>(value: user[0]! as! Expression<Int64>.UnderlyingType)
      let value:Expression<String> = Expression<String>(value: user[1]! as! Expression<String>.UnderlyingType)
      let date:Expression<String> = Expression<String>(value: user[2]! as! Expression<String>.UnderlyingType)
      data.append(FechedData(id: id, value: value, date: date))
    }
  }
  
  for i in data {
    let mili = i.value
    let miliString = (mili?.asSQL().replacingOccurrences(of: "'", with: ""))!
    onlymili.append(Int(miliString)!)
  }
  
  var totalInWeek = [Int]()
  
  for i in onlymili{
    if i > mili {
      totalInWeek.append(i)
    }
  }
  
  return String(totalInWeek.count)
}

func getAverageBPM() -> String {
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedData]()
  var onlyBPM = [Int]()
  
  if let squence = try? db?.prepare("SELECT * From HeartRate ORDER BY id DESC LIMIT 10"){
    for user in squence {
      let id:Expression<Int64> = Expression<Int64>(value: user[0]! as! Expression<Int64>.UnderlyingType)
      let value:Expression<String> = Expression<String>(value: user[1]! as! Expression<String>.UnderlyingType)
      let date:Expression<String> = Expression<String>(value: user[2]! as! Expression<String>.UnderlyingType)
      data.append(FechedData(id: id, value: value, date: date))
    }
  }
  
  for i in data {
    let BPM = i.value
    let BPMinString = (BPM?.asSQL().replacingOccurrences(of: "\nBPM", with: "").replacingOccurrences(of: "'", with: ""))!
    
    if let bpm = Int(BPMinString) {
      onlyBPM.append(bpm)
    }
    
  }
  
  let total = onlyBPM.reduce(0, +)
  
  if onlyBPM.count > 1 {
    let average = total/onlyBPM.count
    return String(average) + " BPM"
  }else{
    return "00 BPM"
  }
}

func getAverageSPO2() -> String {
  let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent(databaseName)
  
  let db = try? Connection(fileURL.path)
  
  var data = [FechedData]()
  var onlyBPM = [Int]()
  
  if let squence = try? db?.prepare("SELECT * From SPO2 ORDER BY id DESC LIMIT 10"){
    for user in squence {
      let id:Expression<Int64> = Expression<Int64>(value: user[0]! as! Expression<Int64>.UnderlyingType)
      let value:Expression<String> = Expression<String>(value: user[1]! as! Expression<String>.UnderlyingType)
      let date:Expression<String> = Expression<String>(value: user[2]! as! Expression<String>.UnderlyingType)
      data.append(FechedData(id: id, value: value, date: date))
    }
  }
  
  for i in data {
    let BPM = i.value
    let BPMinString = (BPM?.asSQL().replacingOccurrences(of: "'", with: ""))!
    onlyBPM.append(Int(BPMinString)!)
  }
  
  let total = onlyBPM.reduce(0, +)
  
  
  if onlyBPM.count > 1 {
    let average = total/onlyBPM.count
    return "\(getSpO2(time:average))"
  }else{
    return "00-100%"
  }
  
}


class FechedData {
  var id:Expression<Int64>?
  var value:Expression<String>?
  var date:Expression<String>?
  init(id:Expression<Int64>,value:Expression<String>,date:Expression<String>) {
    self.id = id
    self.value = value
    self.date = date
  }
}

class FechedDataYoga {
  
  var date:Expression<String>?
  var kapal:Expression<Int64?>?
  var sama:Expression<Int64?>?
  var anuloma:Expression<Int64?>?
  var ujjayi:Expression<Int64?>?
  var anotherOne:Expression<Int64?>?
  var anotherTwo:Expression<Int64?>?
  
  init(date:Expression<String>,kapal:Expression<Int64?>,sama:Expression<Int64?>,anuloma:Expression<Int64?>,ujjayi:Expression<Int64?>,anotherOne:Expression<Int64?>,anotherTwo:Expression<Int64?>) {
    
    self.date = date
    self.kapal = kapal
    self.sama = sama
    self.anuloma = anuloma
    self.ujjayi = ujjayi
    self.anotherOne = anotherOne
    self.anotherTwo = anotherTwo
  }
}


enum TableName:String {
  case HeartRate = "HeartRate"
  case Yoga = "Yoga"
  case Breathe = "Breath"
}
