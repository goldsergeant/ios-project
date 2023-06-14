//
//  SceneDelegate.swift
//  ch09-hanlim
//
//  Created by 이정연 on 2023/05/01.
//

import UIKit
import Firebase
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure() // 연결을 시작한다

                // 연결을 확인하기 위하여 테스트 데이터를 write해 본다
                Firestore.firestore().collection("hanlim").document("mykey").setData(["name": "Geum Han Lim"])
        
        
        // Storyboard 인스턴스 생성
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Firebase 로그인 상태 확인
          if let currentUser = Auth.auth().currentUser {
              // 사용자가 로그인한 경우
              // root view를 설정하는 코드를 추가합니다. 예를 들어, 메인 화면으로 이동할 수 있는 view controller를 설정합니다.
              // 루트 뷰 컨트롤러 설정
                 let rootViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
              // 윈도우 인스턴스 생성 및 루트 뷰 컨트롤러 설정
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              UIApplication.shared.windows.first?.rootViewController = rootViewController

          }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

