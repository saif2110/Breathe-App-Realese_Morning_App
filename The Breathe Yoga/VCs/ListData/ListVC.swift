//
//  ListVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 13/06/21.
//

import UIKit

class ListVC: UIViewController {
    var ListData:[FechedDataYoga]?
    
    @IBOutlet weak var customSegmentView: UIView!
    @IBOutlet weak var heartRate: CustomButton!
    @IBOutlet weak var spo2: CustomButton!
    @IBOutlet weak var myView: UITableView!
    
    @IBOutlet weak var background: UIView!{
        didSet{
            background.clipsToBounds = true
            background.layer.cornerRadius = background.bounds.height/2
        }
    }
    
    @IBOutlet weak var background2:UIView!
    
    @IBOutlet weak var background2iconBG: UIView!{
        didSet{
            background2iconBG.layer.cornerRadius = background2iconBG.bounds.width/2
            background2iconBG.shadow3()
        }
    }
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var selected = "spo2"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSegmentView.layer.cornerRadius = customSegmentView.bounds.height/2
        customSegmentView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9843137255, alpha: 1)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refresh),
                                               name: NSNotification.Name("refresh"),
                                               object: nil)
        
        spo2.select()
        data.removeAll()
        dataYoga.removeAll()
        dataYoga = fetchDataYoga(TableName: .Yoga)
        myView.tableFooterView = UIView()
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        
    }
    
    @objc func refresh() {
        
        viewwillApprearMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewwillApprearMethod()
       
    }
    
    
    func viewwillApprearMethod(){
        ListData = getDataYoga(TableName: .Yoga)
        
        if selected == "heart rate" {
            data = fetchData(TableName: .HeartRate)
        }else{
            dataYoga = fetchDataYoga(TableName: .Yoga)
        }
        
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
        
    }
    
    
    var data = [FechedData]()
    var dataYoga = [FechedDataYoga]()
    
    @IBAction func selected(_ sender: UIButton) {
        self.heartRate.DeSelect()
        self.spo2.DeSelect()
        
        if sender.tag == 0 {
            heartRate.select()
            selected = "heart rate"
            data.removeAll()
            data = fetchData(TableName: .HeartRate)
            headerImage.image = #imageLiteral(resourceName: "small")
            headerLabel.text = "Your Beats Per Minute (BPM) records will display here."
            myView.delegate = self
            myView.dataSource = self
            myView.reloadData()
            
        }else{
            spo2.select()
            selected = "spo2"
            data.removeAll()
            dataYoga = fetchDataYoga(TableName: .Yoga)
            headerImage.image = #imageLiteral(resourceName: "UjjayiWithNose")
            headerLabel.text = "Your Daily Yoga States will display here. (If Available)"
            myView.delegate = self
            myView.dataSource = self
            myView.reloadData()
        }
    }
    
    @IBAction func exportButton(_ sender:UIButton) {
        
        if UserDefaults.standard.isProMember() {
            openExport()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                RevenuCatPaywall.shared.showpayWall()
            }
        }
        
    }
    
    
    private func openExport(){
        self.tableViewDeleteButton(show: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.005) {
            
            let pdfFilePath = self.myView.exportAsPdfFromTable()
            let main = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = main.instantiateViewController(withIdentifier: "PDFReaderVC") as! PDFReaderVC
            vc.url = pdfFilePath
            self.present(vc, animated: true, completion: nil)
            self.tableViewDeleteButton(show: true)
            
        }
    }
    
    var show:Bool = false
    func tableViewDeleteButton(show:Bool){
        
        let show = (show == true) ? false : true
        self.show = show
        
        if show {
            
            let HeaderView = Bundle.main.loadNibNamed("Header", owner: self, options: nil)?.first as! UIView
            HeaderView.frame.size.height = 185
            self.myView.tableHeaderView = HeaderView
            
        }else{
            
            myView.tableHeaderView = UIView()
        }
        
        myView.reloadData()
        
    }
    
    
}

extension ListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if data.count == 0 {
            
            background.isHidden = false
            background2.isHidden = true
            
            
        }
        
        if dataYoga.count == 0 {
            
            background.isHidden = true
            background2.isHidden = false
            
            
        }
        
        
        if selected == "heart rate"  {
            
            return data.count
            
        }else{
            
            return dataYoga.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var complted = 0
        
        if selected == "heart rate" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! mainCell
            cell.type = .HeartRate
            cell.Feched = data[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellYoga", for: indexPath) as! mainCellYoga
           
            
            
            cell.dateText.text = ListData?[indexPath.row].date?.asSQL().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "-", with: " ").replacingOccurrences(of: "-2022", with: "").replacingOccurrences(of: "-2023", with: "")
        
            
            
            if let yogaCompare = ListData?[indexPath.row].kapal?.bindings.first?.debugDescription{
                
                cell.yoga1.image = yogaCompare == "Optional(1)" ? #imageLiteral(resourceName: "kapalforListVC") : #imageLiteral(resourceName: "yoga 1")
                
                complted = yogaCompare == "Optional(1)" ? complted+25 : complted
                
            }
            
            
            if let yogaCompare = ListData?[indexPath.row].sama?.bindings.first?.debugDescription{
                
                cell.yoga2.image = yogaCompare == "Optional(1)" ? #imageLiteral(resourceName: "UjjayiWithNose") : #imageLiteral(resourceName: "yoga 1")
                
                complted = yogaCompare == "Optional(1)" ? complted+25 : complted
                
            }
            
            if let yogaCompare = ListData?[indexPath.row].anuloma?.bindings.first?.debugDescription{
                
                cell.yoga3.image = yogaCompare == "Optional(1)" ? #imageLiteral(resourceName: "Ujjayi_DP") : #imageLiteral(resourceName: "yoga 1")
                
                complted = yogaCompare == "Optional(1)" ? complted+25 : complted
                
            }
            
            
            if let yogaCompare = ListData?[indexPath.row].ujjayi?.bindings.first?.debugDescription{
                
                cell.yoga4.image = yogaCompare == "Optional(1)" ? #imageLiteral(resourceName: "sama_icon") : #imageLiteral(resourceName: "yoga 1")
                
                complted = yogaCompare == "Optional(1)" ? complted+25 : complted
                
            }
            
        
            print(complted)
            
            if  complted == 100 {
                
                
                cell.allDoneImage.setBackgroundImage(#imageLiteral(resourceName: "wellDone"), for: .normal)
                
            }else {
                
                cell.allDoneImage.setBackgroundImage(#imageLiteral(resourceName: "pending"), for: .normal)
                cell.allDoneImage.setTitle( " " + String(complted) + "%", for: .normal)
                
                
            }
            
            
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
}
