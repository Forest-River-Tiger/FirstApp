//
//  ViewController.swift
//  FirstApp
//
//  Created by 森川大雅 on 2022/04/02.
//

import UIKit
import MapKit


// Text Fieldのdelegate機能の宣言
class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text Fieldのdelegate通知先を設定
        inputText.delegate = self
    }
    
    
    @IBOutlet weak var inputText: UITextField!
    
    
    @IBOutlet weak var dispMap: MKMapView!
    
    // 検索ボタン押下時の処理(delegateメソッド)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボード閉じる
        textField.resignFirstResponder()
        
        // 入力された文字を取り出す
        if let searchKey = textField.text {
            // 入力された文字をデバッグエリアに表示
            print(searchKey)
            
            // CLGeocoderインスタンスを取得(緯度経度から住所を検索可能、逆も可能)
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得(クロージャ)
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                // 位置情報が存在する場合はunwrapPlacemarksの取り出す(placemarksはオプショナル)
                if let unwrapPlacemarks = placemarks {
                    
                    // 1件目の情報を取り出す(.firstで先頭の配列を取り出す)
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す(locationには緯度経度、高度などが格納されている)
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに取り出す(coordinateで緯度経度を取り出す)
                            let targetCoordinate = location.coordinate
                            
                            // 緯度経度をデバッグエリアに表示
                            print(targetCoordinate)
                            
                            // MKPointAnnotationインスタンスを取得し、ピンを生成(ピンを置くための機能)
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定
                            pin.title = searchKey
                            
                            // ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            // 緯度経度を中心にして半径500mの範囲を表示(MKCoordinateRegionで中心位置と縦横の表示する幅を指定)
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
        }
        // trueを返す
        return true
    }
    
    
    @IBAction func changeMapButton(_ sender: Any) {
        // mapTypeプロパティー値をトグル
        // 標準 → 航空写真 → 航空写真+標準
        // → 3D Flyover → 3D Flyover+標準
        // → 交通機関
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        } else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid {
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        } else if dispMap.mapType == .hybridFlyover {
            dispMap.mapType = .mutedStandard
        } else {
            dispMap.mapType = .standard
        }
    }
}

