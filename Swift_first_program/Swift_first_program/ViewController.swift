//
//  ViewController.swift
//  Swift_first_program
//
//  Created by Takumi  on 2018/11/22.
//  Copyright © 2018 Takumi . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Label/ButtonオブジェクトをMain.storyboardと対応付けるための定義します。
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label_m: UILabel!
    @IBOutlet weak var Label_c: UILabel!
    @IBOutlet weak var start_button: UIButton!
    @IBOutlet weak var bet_button: UIButton!
    @IBOutlet weak var drow_button: UIButton!
    @IBOutlet weak var check_button: UIButton!
    @IBOutlet weak var up_button: UIButton!
    @IBOutlet weak var down_button: UIButton!
    @IBOutlet weak var img0: UIButton!
    @IBOutlet weak var img1: UIButton!
    @IBOutlet weak var img2: UIButton!
    @IBOutlet weak var img3: UIButton!
    @IBOutlet weak var img4: UIButton!

    
    //オブジェクトファイルをまとめるクラス
    var objects:Objects!;
    var images = [UIButton]();
    var trump:Trump_p!;
    var player:Player!;
    var click_flg:Bool = false;


    
    func click(){
        self.click_flg = !self.click_flg;
    }
    //viewがロードされた時に実行される関数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期表示時のLabelオブジェクトの文字列を「Hello!!」に設定しています。
        Label.text = "play poker!!";
        Label.textColor = .blue;
        //クラス読み込み
        self.images.append(img0);
        self.images.append(img1);
        self.images.append(img2);
        self.images.append(img3);
        self.images.append(img4);
        //オブジェクト群
        self.objects=Objects(images:images,Label:Label,Label_m:Label_m,Label_c:Label_c);
        
    }
    
    
    // ポーカーの画面操作関係
    // start
    @IBAction func start_button(sender: AnyObject) {
        if(!self.click_flg){
            Label.text = "playing now!!";
            Label.textColor = .red;
            self.trump=Trump_p();
            self.player=Player(trump:trump,objects:objects);
            
            //スタートボタンを消す
            self.start_button.isHidden=true;
            self.bet_button.isHidden=false;
            self.up_button.isHidden=false;
            self.down_button.isHidden=false;
            self.click();
        }
    }
    //チップをベットする処理
    @IBAction func up_button(sender: AnyObject){
        player.chip_up();
    }
    @IBAction func down_button(sender: AnyObject){
        player.chip_down();
    }
    @IBAction func bet_button(sender: AnyObject){
        player.bet();
        //ボタンを表示
        self.bet_button.isHidden=true;
        self.up_button.isHidden=true;
        self.down_button.isHidden=true;
        self.drow_button.isHidden=false;
        self.check_button.isHidden=false;
        
        //デッキオープン
        player.open_deck();
        //役を表示
        player.check_hand(trump: trump);
    }
    
    //カード選択時の処理
    @IBAction func click_button0(sender: AnyObject){
        if(!self.click_flg){return;}
        self.player.click_card(id: 0,im:img0);
    }
    @IBAction func click_button1(sender: AnyObject){
        if(!self.click_flg){return;}
        self.player.click_card(id: 1,im:img1);
    }
    @IBAction func click_button2(sender: AnyObject){
        if(!self.click_flg){return;}
        self.player.click_card(id: 2,im:img2);
    }
    @IBAction func click_button3(sender: AnyObject){
        if(!self.click_flg){return;}
        self.player.click_card(id: 3,im:img3);
    }
    @IBAction func click_button4(sender: AnyObject){
        if(!self.click_flg){return;}
        self.player.click_card(id: 4,im:img4);
    }
    
    //Drow
    @IBAction func drow_button(sender: AnyObject){
        self.player.drow_multi(trump: trump);
    }
    //Check
    @IBAction func check_button(sender: AnyObject){
        self.player.check(trump: trump);
        //初期状態に戻す
        self.player.reset(trump: trump);
        //配り直す
        self.player.make_deck(trump: trump);
        //裏返す
        self.player.back_deck();
        //ボタンを表示
        self.bet_button.isHidden=false;
        self.up_button.isHidden=false;
        self.down_button.isHidden=false;
        self.drow_button.isHidden=true;
        self.check_button.isHidden=true;
        
        
        
        
        
    }
    
    
    
    
    

}





// Do any additional setup after loading the view, typically from a nib.
// viewの間呼ばれているクラス
//        self.view.backgroundColor = UIColor.blue
//        print("Hellow World");
//        let myBoundSize: CGSize = UIScreen.main.bounds.size
//        let width = myBoundSize.width;
//        let height = myBoundSize.height;
//        let view1 = UIView(frame:CGRect(x:width/2-50,y:0,width:100,height:height))
//        view1.backgroundColor = UIColor.blue;
//        self.view.addSubview(view1)
//ボタンタグの生成
//        let button = UIButton(frame:CGRect(x:90,y:100,width:100,height:30));
//        button.backgroundColor = UIColor.blue;
//        button.setTitle("Button",for:UIControl.State.normal)
//        self.view.addSubview(button);
//story bord からbutton要素を取得
//story bord をインスタンス化
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//initialのboardの場合
//let viewController = storyboard.instantiateInitialViewController()
// StorybaordID を指定して ViewController を取得する
//let vc = storyboard.instantiateViewController(withIdentifier: "main")
//let button = storyboard.instantiateViewController(withIdentifier: "btn1")



// story board上ボタンをクリックした時に文字を変えるコード
//class ViewController: UIViewController {
//    // Label/ButtonオブジェクトをMain.storyboardと対応付けるための定義します。
//    @IBOutlet weak var myLabel: UILabel!
//    @IBOutlet weak var myButton: UIButton!
//
//    var click_flg = false;
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // 初期表示時のLabelオブジェクトの文字列を「Hello!!」に設定しています。
//        myLabel.text = "Hello!!";
//        myLabel.textColor = .red;
//    }
//    // ボタン押下時に実行される関数
//    // 押下したらLabelオブジェクトのテキスト情報を「Touch」に変更します。
//    @IBAction func myButton(sender: AnyObject) {
//        if(self.click_flg){
//            myLabel.text = "Touch!!";
//            self.click();
//        }else{
//            myLabel.text = "hahaha!!";
//            self.click();
//        }
//
//    }
//
//    func click(){
//        self.click_flg = !self.click_flg;
//    }
//
//
//}
