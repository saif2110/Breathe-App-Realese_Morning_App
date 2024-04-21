//
//  heartRateVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 04/06/21.
//

import UIKit
import AVFoundation
import MBCircularProgressBar

class heartRateVC: UIViewController {
    
    @IBOutlet weak var progressbar: MBCircularProgressBarView!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet weak var heartBeatImage: UIImageView!
    
    private var validFrameCounter = 0
    private var heartRateManager: HeartRateManager!
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var timer = Timer()
    
    var count = 30
    var mytimer:Timer?
    var lastPulse:String?
    let coverMessage = "Put back camera module on your wrist"
    let holdMessage = "Now hold camera still on your front wrist. If possible close your eyes until you feel vibration."
    
    
    func countingMessage() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "Monitoring",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35)]);
        
        attrString.append(NSMutableAttributedString(string: "\nBPM",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)]))
        return attrString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVideoCapture()
        initCaptureSession()
        thresholdLabel.text = coverMessage
        mytimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        mytimer?.invalidate()
        mytimer = nil
        timer.invalidate()
    }
    
    
    @objc func update() {
        if(count > 0) {
            progressbar.value = CGFloat(count - 1)
            lastPulse = pulseLabel.text
            count -= 1
        }else{
            
            mytimer?.invalidate()
            mytimer = nil
            timer.invalidate()
                        
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            thresholdLabel.text = "Heart Rate monitoring is done. We recommend monitoring BPM everyday for proper result ❤️"
            
            let attrString = NSMutableAttributedString(string: lastPulse!,
                                                       attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 60)]);
            
            pulseLabel.attributedText = attrString
            
            deinitCaptureSession()
            
            dismiss(animated: false) {
                
                let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                
                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    
                    let story = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(withIdentifier: "hearRateDeatailsVC") as! hearRateDeatailsVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.bpm = self.lastPulse ?? "72"
                    topController.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBOutlet weak var progressbarHeight: NSLayoutConstraint!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        progressbarHeight.constant = progressbar.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        jumpButtonAnimation(sender: heartBeatImage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
    }
    
    // MARK: - Frames Capture Methods
    func initVideoCapture() {
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: UIView().layer)
        heartRateManager.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)
        }
    }
    
    // MARK: - AVCaptureSession Helpers
    func initCaptureSession() {
        heartRateManager.startCapture()
    }
    
    func deinitCaptureSession() {
        heartRateManager.stopCapture()
        toggleTorch(status: false)
    }
    
    func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
    
    // MARK: - Measurement
    func startMeasurement() {
        DispatchQueue.main.async {
            self.toggleTorch(status: true)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
                guard let self = self else { return }
                let average = self.pulseDetector.getAverage()
                let pulse = 60.0/average
                if pulse == -60 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 1.0
                    }) { (finished) in
                        self.pulseLabel.isHidden = false
                        if self.count > 0 {
                            self.pulseLabel.attributedText =
                                self.countingMessage()
                            self.heartBeatImage.isHidden = true
                        }
                    }
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 1.0
                    }) { (_) in
                        self.pulseLabel.isHidden = false
                        self.heartBeatImage.isHidden = false
                        
                        let attrString = NSMutableAttributedString(string: "\(lroundf(pulse))",
                                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 60)]);
                        
                        attrString.append(NSMutableAttributedString(string: "\nBPM",
                                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)]))
                        
                        self.pulseLabel.attributedText =
                            attrString
                    }
                }
            })
        }
    }
    
    func jumpButtonAnimation(sender: UIImageView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 1.15)
        animation.duration = 0.24
        animation.repeatCount = 100000
        animation.autoreverses = true
        sender.layer.add(animation, forKey: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension heartRateVC {
    fileprivate func handle(buffer: CMSampleBuffer) {
        var redmean:CGFloat = 0.0;
        var greenmean:CGFloat = 0.0;
        var bluemean:CGFloat = 0.0;
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
        
        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                                     parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!
        
        let ctx = CIContext(options:nil)
        let cgImage = ctx.createCGImage(outputImage, from:outputImage.extent)!
        
        let rawData:NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start:pixels, count:rawData.length)
        var BGRA_index = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat (pixel)
            case 1:
                greenmean = CGFloat (pixel)
            case 2:
                redmean = CGFloat (pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            DispatchQueue.main.async {
                self.thresholdLabel.text = self.holdMessage
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.0)
            // Filter the hue value - the filter is a simple BAND PASS FILTER that removes any DC component and any high frequency noise
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            if validFrameCounter > 60 {
                self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                self.thresholdLabel.text = self.coverMessage
                self.pulseLabel.attributedText =
                    self.countingMessage()
                self.heartBeatImage.isHidden = true
            }
        }
    }
}
