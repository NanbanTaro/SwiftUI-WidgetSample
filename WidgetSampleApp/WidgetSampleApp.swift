//
//  WidgetSampleApp.swift
//  WidgetSampleApp
//
//  Created by NanbanTaro on 2025/05/17.
//  
//

import SwiftUI

@main
struct WidgetSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    handleDeepLink(url)
                }
        }
    }

    /// DeepLinkによって処理分けする
    /// - Parameter url: URL
    private func handleDeepLink(_ url: URL) {
        guard url.scheme == "widgetSample" else { return }
        switch url.host {
        case "detail":
            if let idString = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first(where: { $0.name == "id" })?
                .value {
                print("押されたID", idString)
            }
        default:
            print("failed open DeepLink")
        }
    }
}
