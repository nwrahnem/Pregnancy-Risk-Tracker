//
//  SecondViewController.swift
//  BIHackathon
//
//  Created by Renee Leung on 2016-11-26.
//  Copyright © 2016 Renee Leung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var monthField: UITextField!
    
    @IBOutlet weak var yearField: UITextField!
    
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var DiabetesField: UITextField!
    
    
    
    @IBAction func bleed4but(_ sender: Any) {
        bleed = 4.0
    }
    
    
    @IBAction func bleed3but(_ sender: Any) {
        bleed = 3.0
    }
    
    @IBAction func bleed2but(_ sender: Any) {
        bleed = 2.0
    }
    
    
    @IBAction func bleed1but(_ sender: Any) {
        bleed = 1.0
    }
    @IBAction func bleed0but(_ sender: Any) {
        bleed = 0.0
    }
    
    @IBOutlet weak var bleeding4: UIButton!
    
    @IBOutlet weak var bleeding3: UIButton!
    
    @IBOutlet weak var bleeding2: UIButton!
    
    @IBOutlet weak var bleeding1: UIButton!
    
    @IBAction func vomit4but(_ sender: Any) {
        vomit = 4.0
    }
    @IBAction func vomi3but(_ sender: Any) {
        vomit = 3.0
    }
    @IBAction func vomit2but(_ sender: Any) {
        vomit = 2.0
    }
    @IBAction func vomit1but(_ sender: Any) {
        vomit = 1.0
    }
    @IBAction func vomit0but(_ sender: Any) {
        vomit = 0.0
    }
    
    
    
    @IBOutlet weak var vomit4: UIButton!
    
    @IBOutlet weak var vomit3: UIButton!
    
    @IBOutlet weak var vomit2: UIButton!
    
    @IBOutlet weak var vomit1: UIButton!
    
    @IBAction func head4but(_ sender: Any) {
        headache = 4.0
    }
    
    @IBAction func head3but(_ sender: Any) {
        headache = 3.0
    }
    @IBAction func head2but(_ sender: Any) {
        headache = 2.0
    }
    
    @IBAction func head1but(_ sender: Any) {
        headache = 1.0
    }
    @IBAction func head0but(_ sender: Any) {
        headache = 0.0
    }
    
    @IBOutlet weak var headache4: UIButton!
    
    @IBOutlet weak var headache3: UIButton!
    
    @IBOutlet weak var headache2: UIButton!
    
    @IBOutlet weak var headache1: UIButton!
    
    @IBAction func kidneyY(_ sender: Any) {
        switch kidneyCont.selectedSegmentIndex
        {
        case 0:
            kidney = true;
        case 1:
            kidney = false;
        default:
            break; 
        }
    }
    
    @IBOutlet weak var kidneyCont: UISegmentedControl!
    
    @IBOutlet weak var thyroidCont: UISegmentedControl!
    @IBOutlet weak var autoimmCont: UISegmentedControl!
    
    @IBOutlet weak var hivaidsCont: UISegmentedControl!
    
    @IBOutlet weak var smokeCont: UISegmentedControl!
    @IBOutlet weak var alcoholCont: UISegmentedControl!
    @IBOutlet weak var drugsCont: UISegmentedControl!
    
    @IBAction func thyroidY(_ sender: Any) {
        switch thyroidCont.selectedSegmentIndex
        {
        case 0:
            thyroid = true;
        case 1:
            thyroid = false;
        default:
            break;
        }
    }
    
    @IBAction func autoimmY(_ sender: Any) {
        switch autoimmCont.selectedSegmentIndex
        {
        case 0:
            autoimm = true;
        case 1:
            autoimm = false;
        default:
            break;
        }
    }
    
    @IBAction func hivaidsY(_ sender: Any) {
        switch hivaidsCont.selectedSegmentIndex
        {
        case 0:
            hivaids = true;
        case 1:
            hivaids = false;
        default:
            break;
        }
    }
    @IBAction func smokeY(_ sender: Any) {
        switch smokeCont.selectedSegmentIndex
        {
        case 0:
            smoke = true;
        case 1:
            smoke = false;
        default:
            break;
        }
    }
    
    
    @IBAction func alcoholY(_ sender: Any) {
        switch alcoholCont.selectedSegmentIndex
        {
        case 0:
            alcohol = true;
        case 1:
            alcohol = false;
        default:
            break;
        }
    }
    
    
    @IBAction func drugsY(_ sender: Any) {
        switch drugsCont.selectedSegmentIndex
        {
        case 0:
            drugs = true;
        case 1:
            drugs = false;
        default:
            break;
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func calculate(_ sender: Any) {
        let currmonth = 11.0
        
        name = nameField.text!
        age = Double(ageField.text!)!
        month = Double(monthField.text!)!
        year = Double(yearField.text!)!
        weight = Double(weightField.text!)!
        height = Double(heightField.text!)!
        diabetes = Int(DiabetesField.text!)!
        
        
        if (age <= 20 && age >= 35){
            agepoint = 5 * 2
        }else{
            agepoint = 0.0
        }
        
        if (currmonth >= month){
            duemonth = (12.0 - currmonth) + month
        }else{
            duemonth = month - currmonth
        }
        monthpoint = pow(2.5, (duemonth / 3))
        obesitypoint = abs(((weight/height) - 0.75) * 20)
        
        
        if(kidney == true){
            kidneypoint = 30.0
        }
        if(thyroid == true){
            thyroidpoint = 20.0
        }
        if(autoimm == true){
            autoimmpoint = 10.0
        }
        if(hivaids == true){
            hivaidspoint = 15.0
        }
        if(smoke == true){
            smokepoint = 15.0
        }
        if(alcohol == true){
            alcoholpoint = 20.0
        }
        if(drugs == true){
            drugspoint = 15.0
        }
        bleedpoint = bleed * 10
        vomitpoint = vomit * 8
        headachepoint = headache * 5
        
    total = agepoint + monthpoint + obesitypoint + kidneypoint + thyroidpoint + autoimmpoint + hivaidspoint + smokepoint + alcoholpoint + drugspoint + bleedpoint + vomitpoint + headachepoint
    risk = Int(total * 0.5)
        
        let patient4 = Patient()
        patient4.id = "4"
        patient4.name = name
        patient4.riskFactor = Int(risk)
        
        patientnamelabel.text = String(name)
        patientrisklabel.text = String(risk) + "%"
        if (risk <= 30){
            patientrisklabel.backgroundColor = UIColor.green
        }else if (risk <= 60){
            patientrisklabel.backgroundColor = UIColor.yellow
        }else{
            patientrisklabel.backgroundColor = UIColor.red
        }
        
        patientnamelabel.isHidden = false
        patientrisklabel.isHidden = false
        
        
    }
    var agepoint = 0.0
    var duemonth = 0.0
    var monthpoint = 0.0
    var obesitypoint = 0.0
    var kidneypoint = 0.0
    var thyroidpoint = 0.0
    var autoimmpoint = 0.0
    var hivaidspoint = 0.0
    var smokepoint = 0.0
    var alcoholpoint = 0.0
    var drugspoint = 0.0
    var name = ""
    var total = 0.0
    var age = 0.0
    var month = 0.0
    var year = 0.0
    var weight = 0.0
    var height = 0.0
    var diabetes = 0
    var kidney = false
    var thyroid = false
    var autoimm = false
    var hivaids = false
    var smoke = false
    var alcohol = false
    var drugs = false
    var risk = 0
    var bleed = 0.0
    var vomit = 0.0
    var headache = 0.0
    var bleedpoint = 0.0
    var vomitpoint = 0.0
    var headachepoint = 0.0
    
    
    @IBOutlet weak var patientnamelabel: UILabel!
    
    @IBOutlet weak var patientrisklabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

