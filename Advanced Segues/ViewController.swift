//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Vinay Reddy Polati on 9/17/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import CoreLocation;

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    private var address:String = String();
    @IBOutlet weak var locationsTable: UITableView!
    private let locationManager = CLLocationManager();
    private var locations:[String] = [String]();
    private var filePath:String {
        let fileManager = FileManager.default;
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!;
        return url.appendingPathComponent("data").path  ;
    }
    
    private func saveData(){
        NSKeyedArchiver.archiveRootObject(locations, toFile: filePath);
    }
    
    /* This method returns address as a String for a given Latitude and Longitude.*/
    private func addressOf(latitude lat:CLLocationDegrees, longitude long:CLLocationDegrees) /*-> String*/ {
        /* Getting Address*/
        let userLocation = CLLocation(latitude: lat, longitude: long);
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if let err = error {
                print(" Error information: \(err)");
            } else {
                if let placemark = placemarks?[0] {
                    let country = placemark.country ?? String();
                    let zipcode = placemark.postalCode ?? String();
                    let subThroughfare = placemark.subThoroughfare ?? String();
                    let throughfare = placemark.subThoroughfare ?? String();
                    let subLocality = placemark.subLocality ?? String();
                    let subAdminArea = placemark.subAdministrativeArea ?? String();
                    let adminArea = placemark.administrativeArea ?? String();
                    print("subThroughfare: \(subThroughfare), throughfare: \(throughfare), subLocality: \(subLocality), subAdminArea: \(subAdminArea), AdminArea: \(adminArea), zipcode: \(zipcode), country: \(country)");
                    self.locations.append("\(throughfare) \(subAdminArea)  \(adminArea),  \(zipcode)   \(country)   )") ;
                    self.locationsTable.reloadData();
                    self.saveData();
                }
            }
        }
       /* print("\n ------------------- address \(address)");
           return self.address;*/
    }
    
    @IBAction func addThisPlaceButtonAction(_ sender: Any) {
        if let lat = latitudeTextField.text {
            if let long = longitudeTextField.text {
                if let latDouble = Double(lat) {
                    if let longDouble = Double(long) {
                        let latitude:CLLocationDegrees = CLLocationDegrees(floatLiteral: latDouble);
                        let longitude:CLLocationDegrees = CLLocationDegrees(floatLiteral: longDouble);
                       addressOf(latitude: latitude, longitude: longitude);
                        /*print("saved locations: \(locations)");
                           locationsTable.reloadData();
                           saveData(); */
                    }
                }
            }
        }
        
    }
    
    
// Mark: navigation [ cell --> screen2, button --> screen2]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToMap" {
            if let screen2 = segue.destination as? Screen2ViewController {
                if let indexPath = self.locationsTable.indexPathForSelectedRow {
                    print("segueing From cell to map screen \(locations[indexPath.row] )");
                    screen2.address = locations[indexPath.row];
                }
            }
        } else if(segue.identifier == "toMap" ) {
            if let screen2 = segue.destination as? Screen2ViewController {
                screen2.address = " United States of America. (USA)";
            }
        }
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0];
//        print(userLocation);
//    }
    
    //Mark: TableViewDelegate protocol methods.
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.address = locations[indexPath.row];
//        performSegue(withIdentifier: "cellToMap", sender: self);
//    }
    
     /*-----------------------------------------------------------------------------------------------------------------------------*/
    // MARK: TableViewDataSource protoclol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count;
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationsTableViewCellController
        locationCell.addressLabel.text = locations[indexPath.row];
        return locationCell;
    }
    
    /*-----------------------------------------------------------------------------------------------------------------------------*/
    //Mark: UIViewController overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        locationManager.delegate = self;
//        locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
//        locationManager.requestWhenInUseAuthorization();
//        locationManager.startUpdatingLocation();
        // Do any additional setup after loading the view, typically from a nib.
        if let savedLocations = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String] {
            self.locations = savedLocations;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

