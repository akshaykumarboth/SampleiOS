//
//  DummVC.swift
import UIKit

class DummVC: UIViewController {
    
    @IBOutlet var stack: UIStackView!

    @IBOutlet var tlabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let option: TickOptionView = TickOptionView(frame: CGRect.zero)
        option.optionText.text = "thiw is for the pourpose of tetsti g in fi os thiw is for the pourpose of tetsti g in fi os  thiw is for the pourpose of tetsti g in fi os  " 
        option.hideImage()
        stack.addArrangedSubview(option)
        tlabel.text = "bc"
        

        // Do any additional setup after loading the view.
    }

   
}
