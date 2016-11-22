import UIKit

class ViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!

    @IBOutlet weak var ledToggleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self)
    }

    @IBAction func ledToggleButtonDown(sender: UIButton) {
        simpleBluetoothIO.writeValue(1)
    }

    @IBAction func ledToggleButtonUp(sender: UIButton) {
        simpleBluetoothIO.writeValue(0)
    }

    
    
    @IBAction func RE(sender: AnyObject) {
        simpleBluetoothIO.writeValue(2)
    }
    

    
    @IBAction func MI(sender: AnyObject) {
        simpleBluetoothIO.writeValue(3)
    }
    
    
    
    @IBAction func FA(sender: AnyObject) {
        simpleBluetoothIO.writeValue(4)
    }
    
    @IBAction func SOL(sender: AnyObject) {
        simpleBluetoothIO.writeValue(5)
    }
    
    
    @IBAction func LAm(sender: AnyObject) {
        simpleBluetoothIO.writeValue(6)
    }
    
 
    
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
