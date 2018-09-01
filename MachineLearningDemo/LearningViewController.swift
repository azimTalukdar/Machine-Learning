//
//  LearningViewController.swift
//  MachineLearningDemo
//
//  Created by GENEXT-PC on 12/08/18.
//  Copyright © 2018 Azim. All rights reserved.
//

import UIKit
import CoreML
import Vision

class LearningViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var myImageview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var resultArr = [VNClassificationObservation]()
    
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ListPressed(_ sender: Any) {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        myVC.dataArr = resultArr
        present(myVC, animated: true, completion: nil)
    }
    
    @IBAction func CameraPressed(_ sender: Any) {
        let myActionSheet = UIAlertController(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let galleryBtn = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        myActionSheet.addAction(cameraBtn)
        myActionSheet.addAction(galleryBtn)
        
        present(myActionSheet, animated: true, completion: nil)
        
    }
    
    //MARK: - Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageview.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else{
                fatalError("Converting Image Failed")
            }
            detectImage(image: ciimage)
            
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detectImage(image : CIImage) -> Void {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Loading CoreML Model Failed")
        }
        print("detectImage model \(model)")
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to Process Image")
            }
            
            print(results)
            self.resultArr = results
            if let firstresult = results.first {
                self.lblTitle.text = firstresult.identifier
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch  {
            print(error)
        }
        
      
    }
    

}
