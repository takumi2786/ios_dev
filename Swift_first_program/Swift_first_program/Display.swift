//
//  Display.swift
//  Swift_first_program
//
//  Created by Takumi  on 2018/11/29.
//  Copyright © 2018 Takumi . All rights reserved.
//

import Foundation
import UIKit


//画面変化関係のオブジェクトをひとまとめにする
class Objects{
    //カードのオブジェクト
    var images=[UIButton]();
    //役表示用のラベルオブジェクト
    var Label:UILabel;
    var Label_m:UILabel;
    var Label_c:UILabel;
    
    
    init(images:[UIButton],Label:UILabel!,Label_m:UILabel!,Label_c:UILabel!){
        self.images=images;
        self.Label=Label;
        self.Label_m=Label_m;
        self.Label_c=Label_c;
        
    }
    
}


