import UIKit

class ViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!

    @IBOutlet weak var ledToggleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
            //this service UUID should be the same on the Arduino Scketch 
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self)
    }

    //button action for the DO chord
    @IBAction func ledToggleButtonDown(sender: UIButton) {
        simpleBluetoothIO.writeValue(1)
    }

    @IBAction func ledToggleButtonUp(sender: UIButton) {
        simpleBluetoothIO.writeValue(0)
    }

    
    //button action for the RE chord
    @IBAction func RE(sender: AnyObject) {
        simpleBluetoothIO.writeValue(2)
    }
    

    //button action for the MI chord
    @IBAction func MI(sender: AnyObject) {
        simpleBluetoothIO.writeValue(3)
    }
    
    
    //button action for the FA chord
    @IBAction func FA(sender: AnyObject) {
        simpleBluetoothIO.writeValue(4)
    }
    
    //button action for the SOL chord
    @IBAction func SOL(sender: AnyObject) {
        simpleBluetoothIO.writeValue(5)
    }
    
    
    //button action for the La menor chord
    @IBAction func LAm(sender: AnyObject) {
        simpleBluetoothIO.writeValue(6)
    }
    
 
    
    //button action for the SI chord
    @IBAction func SI(sender: AnyObject) {
        simpleBluetoothIO.writeValue(7)
    }
    
    
}

extension ViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        if value > 0 {
            view.backgroundColor = UIColor.yellowColor()
        } else {
            view.backgroundColor = UIColor.blackColor()
        }
    }
}
