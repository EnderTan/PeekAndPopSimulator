# PeekAndPopSimulator

One step to test Peek and Pop at device below 6s/6sPlus and Xcode Simulator:

 #import "PeekAndPopSimulator.h"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewer = registerForPreviewingWithDelegate(self, sourceView: view)
        
    }
  
![image](https://github.com/EnderTan/PeekAndPopSimulator/blob/master/3DTouch.gif)
