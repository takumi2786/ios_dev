//
//  Poker.swift
//  Swift_first_program
//
//  Created by Takumi  on 2018/11/23.
//  Copyright © 2018 Takumi . All rights reserved.
//
// ポーカークラスつくんぞ
import Foundation
import UIKit
//シャッフル
extension Array {
    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.shuffle()
        return copied
    }
}

class Card{
    var id:Int;
    var suit:Int;
    var suit_str:String;
    var number:Int;
    var name:String;
    var suits_array:[String] = ["heart","dia","spade","clover"];
    init(id:Int,suit:Int,number:Int) {
        self.id=id;
        self.suit=suit;
        self.number=number;
        self.name=suit.description + "-" + number.description;
        self.suit_str=self.suits_array[suit];
    }
}

class Trump{
    var cards=[Card]();

    init(){
        var id=0;
        for i in 0...3 {
            for j in 1...13 {
                self.cards.append( Card(id:id,suit:i,number:j) );
                id+=1;
            }
        }
        // シャッフル
        self.shuffle();
    }
    // カードをシャッフルする
    func shuffle(){
        self.cards.shuffle();
    }
    // カードの山から1枚引く
    //NULLがk入る可能性がある場合は,型名に?をつける
    func drop_top()->Card?{
        return self.cards.popLast();
    }
    
    // 山に1枚戻す
    func return_top(card:Card){
        self.cards.append(card);
    }
    //一番下に戻す
    func return_bottom(card:Card){
        self.cards.insert(card, at: 0);
    }
}

//Trumpクラスの拡張　ポーカー専用
class Trump_p:Trump{
    //役ごとの得点
    var hand_array:Dictionary=["ロイヤルストレートフラッシュ":10,"ストレートフラッシュ":6,"フォーカード":4,"フルハウス":3,"ストレート":2.5,"フラッシュ":2,"スリーカード":1.5,"ツーペア":1.0,"ワンペア":0.5,"ハイカード":0];
    //役をチェック
    func check_hand(deck:[Card?])->String{
        var flush_flg:Bool = self.IsFlush(deck:deck);
        var strate_flg:Bool = self.IsStrate(deck: deck);
        var four_card_flg:Bool=self.IsFourCard( deck:deck );
        var three_card_flg:Bool=self.IsThreeCard( deck:deck );
        var two_pair_flg:Bool=self.IsTwoPair( deck:deck );
        var one_pair_flg:Bool=self.IsOnePair( deck:deck );
        //手札にAが含まれているか調べる（ロイヤルストレートフラッシュ用）
        var ace_flg:Bool=self.AceCheck( deck:deck );
        
        
        if(strate_flg&&flush_flg&&ace_flg){return("ロイヤルストレートフラッシュ");}
        else if(strate_flg&&flush_flg){return("ストレートフラッシュ");}
        else if(four_card_flg){return("フォーカード");}
        else if(three_card_flg&&one_pair_flg){return("フルハウス");}
        else if(strate_flg){return("ストレート");}
        else if(flush_flg){return("フラッシュ");}
        
        else if(three_card_flg){return("スリーカード");}
        else if(two_pair_flg){return("ツーペア");}
        else if(one_pair_flg){return("ワンペア");}
        else {return("ハイカード");}
        
        
        
        
    }
    // デッキにエースを含むかどうかチェック
    func AceCheck(deck:[Card?])->Bool{
        for card in deck{
            if(card?.number==1){return true}
        }
        return false;
    }
    func IsFlush(deck:[Card?])->Bool{
        //マークを数える入れ物を用意
        var suits_counter: Dictionary = ["heart": 0,"dia":0, "spade": 0,"clover":0];
        //デッキのsuitsをカウント
        for card in deck{
            var suits_str=card?.suit_str;
            suits_counter[suits_str!] = suits_counter[suits_str!]!+1 ;
        }
        //dump(suits_counter);
        //カウントし終わったマークを検証していって、5枚同じマークがあったらtrueをリターン
        for (key, value) in suits_counter{
            if(value >= 5){return true};
        }
        return false;
    }
    
    
    func IsStrate(deck:[Card?])->Bool{
        var numbers:Dictionary = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0];
        for key in 0...deck.count-1{
            numbers[(deck[key]?.number)!] = numbers[(deck[key]?.number)!]!+1;
            //1（エース）のみ、14番目の数字としてもカウント
            if(deck[key]?.number==1){numbers[14]=numbers[14]!+1;}
            //dump(deck[key].number)
        }
        //print(deck.count)
        
        //1から始まるストレート～10から始まるストレートを判定する
        for i in 1...10{
            if( numbers[i]!>=1 && numbers[i+1]!>=1 && numbers[i+2]!>=1 && numbers[i+3]!>=1 && numbers[i+4]!>=1){
                return true;
            }
        }
        return false;
    }
    
    func IsFourCard(deck:[Card?])->Bool{
        var numbers:Dictionary = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0];
        for key in 0...deck.count-1{
            numbers[(deck[key]?.number)!] = numbers[(deck[key]?.number)!]!+1;
        }
        var sameCount:Dictionary = [0:0,1:0,2:0,3:0,4:0];
        for i in 1...13{
            sameCount[numbers[i]!] = sameCount[numbers[i]!]!+1;
        }
        //「同じ数字が4枚」が1つあったら判定
        if( sameCount[4]! > 0 ){
            return true;
        }
        
        return false;
    }
    func IsThreeCard(deck:[Card?])->Bool{
        var numbers:Dictionary = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0];
        for key in 0...deck.count-1{
            numbers[(deck[key]?.number)!] = numbers[(deck[key]?.number)!]!+1;
        }
        var sameCount:Dictionary = [0:0,1:0,2:0,3:0,4:0];
        for i in 1...13{
            sameCount[numbers[i]!] = sameCount[numbers[i]!]!+1;
        }
        //「同じ数字が3枚」が1つあったら4カード判定
        if( sameCount[3]! > 0 ){
            return true;
        }
        
        return false;
    }
    func IsTwoPair(deck:[Card?])->Bool{
        var numbers:Dictionary = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0];
        for key in 0...deck.count-1{
            numbers[(deck[key]?.number)!] = numbers[(deck[key]?.number)!]!+1;
        }
        var sameCount:Dictionary = [0:0,1:0,2:0,3:0,4:0];
        for i in 1...13{
            sameCount[numbers[i]!] = sameCount[numbers[i]!]!+1;
        }
        //「同じ数字が3枚」が1つあったら4カード判定
        if( sameCount[2] == 2 ){
            return true;
        }
        
        return false;
    }
    func IsOnePair(deck:[Card?])->Bool{
        var numbers:Dictionary = [1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0];
        for key in 0...deck.count-1{
            numbers[(deck[key]?.number)!] = numbers[(deck[key]?.number)!]!+1;
        }
        var sameCount:Dictionary = [0:0,1:0,2:0,3:0,4:0];
        for i in 1...13{
            sameCount[numbers[i]!] = sameCount[numbers[i]!]!+1;
        }
        //「同じ数字が3枚」が1つあったら4カード判定
        if( sameCount[2] == 1 ){
            return true;
        }
        
        return false;
    }
}



//プレーヤー
class Player{
    var click_memory:[Bool]=[false,false,false,false,false];
    var deck=[Card?]();
    
    //  オブジェクト群
    var objects:Objects;
    //    //カードのオブジェクト
    //    var images=[UIButton]();
    //    //役表示用のラベルオブジェクト
    //    var Label=UILabel();
    
    
    //所持金
    var money:Double=0;
    //掛け金
    var chip:Double=0;
    var chip_bf:Double=0;
    //役
    var hand:String="";
    
    //drow回数を記録する変数
    var drow_count:Int=0;
//    init(trump:Trump_p,images:[UIButton],label:UILabel!){
    init(trump:Trump_p,objects:Objects){
        self.objects=objects;
        //所持金を代入
        self.money=1000;
        self.disp_money();
        
        //5枚のカードを引く
        self.make_deck(trump: trump);
        
        //引いたカードを表示する
        //self.open_deck();
        //役を表示する
        //self.check_hand(trump:trump);
    }
    //5枚のカードを引く
    func make_deck(trump:Trump_p){
        for i in 0...4{
            self.deck.append(trump.drop_top());
        }
    }
    
    
    //カードを表示する
    func display(id:Int){
        let name:String!=self.deck[id]!.name;
        //self.images[id].image=UIImage(named: name!);
        self.objects.images[id].setImage(UIImage(named: name),for: .normal);
    }
    func undisplay(id:Int){
        let name:String!="bk0";
        self.objects.images[id].setImage(UIImage(named: name),for: .normal);
    }
    func disp_money(){
        self.objects.Label_m.text=self.money.description;
        self.objects.Label_c.text=self.chip.description;
    }
    func disp_money_bef(){
        var money=self.money-self.chip_bf;
        self.objects.Label_m.text=money.description;
        self.objects.Label_c.text=self.chip_bf.description;
    }
    //デッキをオープン
    func open_deck(){
        for i in 0...self.deck.count-1{
            self.display(id: i);
        }
    }
    //デッキを裏返す
    func back_deck(){
        for i in 0...4{
            self.undisplay(id: i);
        }
    }
    
    //指定したカードを交換する
    func drow(id:Int,trump:Trump_p){
        if(self.deck[id] == nil){ return; }
        //手札から引き抜く
        let card:Card!=self.deck.remove(at: id);
        //山札に戻す
        trump.return_bottom(card: card);
        //デッキから一枚引く
        self.deck.insert(trump.drop_top(), at: id);
        self.display(id: id);
    }
    
    func click_card(id:Int,im:UIButton){
        self.click_memory[id] = !self.click_memory[id];
        if(self.click_memory[id]==true){im.backgroundColor=UIColor.gray;}
        else{im.backgroundColor=UIColor.clear}
    }
    
    //選択したカードを交換する
    func drow_multi(trump:Trump_p){
        if(self.drow_count>2){return;}
        var id:Int=0;
        for i in self.click_memory{
            if(i==true){
                self.drow(id: id, trump: trump);
                self.click_card(id: id, im: self.objects.images[id]);
            }
            id+=1;
        }
        self.drow_count+=1;
        //役を表示する
        self.check_hand(trump:trump);
        
    }
    
    func check_hand(trump:Trump_p)->String{
        var hand = trump.check_hand(deck: self.deck);
        self.objects.Label.text = hand;
        //役を記録
        self.hand=hand;
        return hand;
    }
    
    //チップをベット
    func bet(){
        self.money=self.money-self.chip_bf;
        self.chip=self.chip_bf;
        self.disp_money();
    }
    func chip_up(){
        if(self.money-(self.chip_bf+50) >= 0){self.chip_bf+=50;}
        if(chip_bf<0){chip_bf=0;}
        //表示
        self.disp_money_bef();
    }
    func chip_down(){
        self.chip_bf-=50;
        if(chip_bf<0){chip_bf=0;}
        //表示
        self.disp_money_bef();
    }
    
    //役に応じたk金額をフィードバック
    func check(trump:Trump_p){
        //役をチェック
        self.hand=self.check_hand(trump: trump);
        let point=trump.hand_array[self.hand];
        self.money=self.money+point!*self.chip;
        self.chip=0;
        self.chip_bf=0;
        //表示
        self.disp_money();
        
        
    }
    // 初期状態に戻す
    func reset(trump:Trump_p){
        self.drow_count=0;
        
        //山札にカードを戻す
        let length=self.deck.count;
        for i in 0...length-1{
            var card=self.deck.removeLast();
            trump.return_bottom(card:card!);
        }
        //シャッフルする
        trump.shuffle();
        
        
        
        
        
        
        
        
        
    }
}


