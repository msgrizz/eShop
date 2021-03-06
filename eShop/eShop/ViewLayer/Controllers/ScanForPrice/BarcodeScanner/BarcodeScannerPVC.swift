//
//  BarcodeScannerVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import BarcodeScanner

class BarcodeScannerPVC: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    // MARK:- IBOutlet
    @IBOutlet weak var containerVC: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barcodeScannerViewController = BarcodeScannerViewController()
        barcodeScannerViewController.codeDelegate = self
        barcodeScannerViewController.errorDelegate = self
        barcodeScannerViewController.dismissalDelegate = self
        
        addChildViewController(barcodeScannerViewController)
        barcodeScannerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerVC.addSubview(barcodeScannerViewController.view)
        NSLayoutConstraint.activate([
            barcodeScannerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            barcodeScannerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            barcodeScannerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            barcodeScannerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
        
        barcodeScannerViewController.didMove(toParentViewController: self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
// MARK: - BarcodeScannerCodeDelegate

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.resetWithError()
        }
    }

// MARK: - BarcodeScannerErrorDelegate

    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }

// MARK: - BarcodeScannerDismissalDelegate

    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
