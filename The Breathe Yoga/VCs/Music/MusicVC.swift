//
//  MusicVC.swift
//  The Breathe Yoga
//
//  Created by Saif on 23/10/22.
//

import UIKit
import AVFoundation

var SoundPlaying = 0

class MusicVC: UIViewController {

  @IBOutlet weak var firstPlay: UIButton!
  @IBOutlet weak var firstTwo: UIButton!
  @IBOutlet weak var firstThree: UIButton!
  @IBOutlet weak var firstFour: UIButton!
  @IBOutlet weak var firstFive: UIButton!
  @IBOutlet weak var firstSix: UIButton!
  @IBOutlet weak var firstSeven: UIButton!
  
  
  func resetMusic(){
    firstPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstTwo.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstThree.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstFour.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstFive.setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstSix
      .setImage(UIImage(systemName: "play.fill"), for: .normal)
    
    firstSeven.setImage(UIImage(systemName: "play.fill"), for: .normal)
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
  override func viewWillAppear(_ animated: Bool) {
    
    let pause = UIImage(systemName: "pause.fill")
    
    if player2?.isPlaying == true {
      
      switch SoundPlaying {
      
      case 0 :
        
        firstPlay.setImage(pause, for: .normal)
        
        break
        
      case 1 :
        
        firstTwo.setImage(pause, for: .normal)
        
        break
        
      case 2 :
        
        firstThree.setImage(pause, for: .normal)
        
        break
        
      case 3 :
        
        firstThree.setImage(pause, for: .normal)
        
        break
        
      case 4 :
        
        firstFive.setImage(pause, for: .normal)
        
        break
        
      case 5 :
        
        firstSix.setImage(pause, for: .normal)
        
        break
        
      case 6 :
        
        firstSeven.setImage(pause, for: .normal)
        
        break
        
      default:
        
        break
      }
      
    }
 
    
  }
  

  @IBAction func playMusic(_ sender: UIButton) {
    let sendTag = sender.tag
    
    print(sendTag)
    
    
    resetMusic()
    
    let play = "play.fill"
    let pause = "pause.fill"
    
    
    if player2?.isPlaying == true {
      
      player2?.stop()
      resetMusic()
      
   
    }else{
      
      
      if sender.hasImage(named: play, for: .normal) {
        
        sender.setImage(UIImage(systemName: pause), for: .normal)
        player2?.stop()
        playSound(name: String(sendTag))
        SoundPlaying = sendTag
        
      }else{
        
        sender.setImage(UIImage(systemName: play), for: .normal)
        player2?.stop()
       
        
      }
      
    }

 
  
  }
  

 
  @IBAction func close(_ sender: Any) {
    dismiss(animated: true)
  }
  
  func playSound(name:String) {
      guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }

      do {
          try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
          try AVAudioSession.sharedInstance().setActive(true)

          /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player2 = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        player2?.numberOfLoops = 1000000

          /* iOS 10 and earlier require the following line:
          player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

          guard let player2 = player2 else { return }
        
        player2.volume = 0.20
        player2.play()
        

      } catch let error {
          print(error.localizedDescription)
      }
  }

}

extension UIButton {
  func hasImage(named imageName: String, for state: UIControl.State) -> Bool {
        guard let buttonImage = image(for: state), let namedImage = UIImage(systemName: imageName) else {
            return false
        }

    return buttonImage.pngData() == namedImage.pngData()
    }
}
