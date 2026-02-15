//
//  KitchenMillionaireApp.swift
//  millonen
//
//  Created by Andreas Pelczer on 27.12.25.
//
import SwiftUI

@main
struct KitchenMillionaireApp: App {
    @StateObject private var progressManager = ProgressManager.shared

    var body: some Scene {
        WindowGroup {
            StartScreenView()
                .environmentObject(progressManager)
        }
    }
}
