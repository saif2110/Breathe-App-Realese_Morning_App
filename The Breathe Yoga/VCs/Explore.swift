//
//  Explore.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 18/06/21.
//

import UIKit

class Explore: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let label = ["Why Breathing Exercises is Important ?","What are the benefits of breathe yoga ?","Does Yoga increase blood oxygen level ?","How old breathe yoga is ?"]
    let labelImage:[UIImage] = [#imageLiteral(resourceName: "ex1"),#imageLiteral(resourceName: "pulse"),#imageLiteral(resourceName: "oxymeter"),#imageLiteral(resourceName: "bloodOxygenLevel")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        label.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageViewCell", for: indexPath) as! imageViewCell
        cell.myImageView.image = labelImage[indexPath.row]
        cell.label.text = label[indexPath.row]
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
    
    let name = ["zero","one","three","four"]
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = main.instantiateViewController(identifier: "ExploreWebview") as! ExploreWebview
        vc.image = labelImage[indexPath.row]
        vc.htmlName = name[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBOutlet weak var myView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
