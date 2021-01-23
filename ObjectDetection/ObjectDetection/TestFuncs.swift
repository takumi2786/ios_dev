//
//  TestFuncs.swift
//  ObjectDetection
//
//  Created by Takumi  on 2020/09/01.
//  Copyright © 2020 Takumi . All rights reserved.
//

import Foundation


//クラスと構造体の違い
//＞class:参照，struct:値
struct Cat_st{
    //structは，インスタンスを作った後に初期化しても良い．
    var like: String
    //    let like: String="魚"
    let hate: String="水"
    
    init(like: String) {//構造体も関数を持てる．
        self.like = like
    }
}

class Cat_cl{
    //classの場合は，プロパティの初期化が必ず必要．
    var like: String
    //    let like: String="魚"
    let hate: String="水"
    
    init(like: String) {
        self.like = like
    }
    
}

