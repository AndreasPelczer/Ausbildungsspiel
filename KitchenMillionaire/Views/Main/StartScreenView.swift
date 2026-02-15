//
//  StartScreenView.swift
//  millonen
//
//  Matjes Küchenfachkunde: Lehrjahr-Auswahl
//

import SwiftUI

struct StartScreenView: View {
    @EnvironmentObject var progressManager: ProgressManager

    let allQuestions = QuestionLoader.loadFromJSON()

    @State private var flameGlow = false
    @State private var headerVisible = false
    @State private var buttonsVisible = false
    @State private var footerVisible = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                LinearGradient(
                    colors: [Color.blue.opacity(0.5), Color.black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                            .shadow(color: .orange.opacity(flameGlow ? 0.8 : 0.3), radius: flameGlow ? 20 : 8)
                            .scaleEffect(flameGlow ? 1.08 : 1.0)

                        Text("Matjes")
                            .font(.system(size: 36, weight: .black, design: .rounded))
                            .foregroundColor(.white)

                        Text("Küchenfachkunde")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.orange)

                        Text("Koch / Köchin")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.top, 2)
                    }
                    .padding(.top, 50)
                    .opacity(headerVisible ? 1 : 0)
                    .offset(y: headerVisible ? 0 : -20)

                    Spacer()

                    // Lehrjahr-Auswahl
                    VStack(spacing: 16) {
                        Text("Wähle dein Lehrjahr")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)

                        LehrjahrButton(
                            title: "1. Lehrjahr",
                            subtitle: "Grundlagen",
                            icon: "1.circle.fill",
                            color: .green,
                            destination: LevelGridView(
                                lehrjahr: 1,
                                levelRange: 1...10,
                                allQuestions: allQuestions
                            )
                        )

                        LehrjahrButton(
                            title: "2. Lehrjahr",
                            subtitle: "Aufbau",
                            icon: "2.circle.fill",
                            color: .blue,
                            destination: LevelGridView(
                                lehrjahr: 2,
                                levelRange: 11...20,
                                allQuestions: allQuestions
                            )
                        )

                        LehrjahrButton(
                            title: "3. Lehrjahr",
                            subtitle: "Spezialisierung",
                            icon: "3.circle.fill",
                            color: .purple,
                            destination: LevelGridView(
                                lehrjahr: 3,
                                levelRange: 21...30,
                                allQuestions: allQuestions
                            )
                        )
                    }
                    .padding(.horizontal, 20)
                    .opacity(buttonsVisible ? 1 : 0)
                    .offset(y: buttonsVisible ? 0 : 30)

                    Spacer()

                    // Alle Level Button
                    NavigationLink(destination: LevelGridView(
                        lehrjahr: 0,
                        levelRange: 1...30,
                        allQuestions: allQuestions
                    )) {
                        HStack {
                            Image(systemName: "square.grid.3x3.fill")
                                .font(.title3)
                            Text("Alle Level")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.orange)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 30)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange, lineWidth: 2)
                                .shadow(color: .orange.opacity(0.3), radius: 5)
                        )
                    }
                    .padding(.bottom, 40)
                    .opacity(footerVisible ? 1 : 0)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                // Header einblenden
                withAnimation(.easeOut(duration: 0.5)) {
                    headerVisible = true
                }

                // Flamme pulsieren
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    flameGlow = true
                }

                // Buttons einblenden
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        buttonsVisible = true
                    }
                }

                // Footer einblenden
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        footerVisible = true
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Lehrjahr Button
struct LehrjahrButton<Destination: View>: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(color)
                    .frame(width: 50)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .bold))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }
}
