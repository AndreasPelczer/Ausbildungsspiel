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

    /// Lehrjahr-Konfiguration mit Level-Ranges
    private struct LehrjahrConfig {
        let number: Int
        let title: String
        let subtitle: String
        let icon: String
        let color: Color
        let levelRange: ClosedRange<Int>
    }

    private let lehrjahre: [LehrjahrConfig] = [
        LehrjahrConfig(number: 1, title: "1. Lehrjahr", subtitle: "Grundlagen", icon: "1.circle.fill", color: .green, levelRange: 1...10),
        LehrjahrConfig(number: 2, title: "2. Lehrjahr", subtitle: "Aufbau", icon: "2.circle.fill", color: .blue, levelRange: 11...20),
        LehrjahrConfig(number: 3, title: "3. Lehrjahr", subtitle: "Spezialisierung", icon: "3.circle.fill", color: .purple, levelRange: 21...30),
    ]

    /// Nur Lehrjahre anzeigen, die mindestens ein Level mit Fragen haben
    private var availableLehrjahre: [LehrjahrConfig] {
        let availableLevels = QuestionLoader.availableLevels(in: allQuestions)
        return lehrjahre.filter { config in
            config.levelRange.contains(where: { availableLevels.contains($0) })
        }
    }

    /// Gesamtbereich aller verfügbaren Level
    private var totalAvailableRange: ClosedRange<Int> {
        let availableLevels = QuestionLoader.availableLevels(in: allQuestions)
        guard let minLevel = availableLevels.min(), let maxLevel = availableLevels.max() else {
            return 1...1
        }
        return minLevel...maxLevel
    }

    var body: some View {
        NavigationStack {
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
                            .accessibilityHidden(true)

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
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Matjes Küchenfachkunde, Koch und Köchin")

                    Spacer()

                    // Lehrjahr-Auswahl (nur Lehrjahre mit Inhalten)
                    VStack(spacing: 16) {
                        Text("Wähle dein Lehrjahr")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)

                        ForEach(availableLehrjahre, id: \.number) { config in
                            LehrjahrButton(
                                title: config.title,
                                subtitle: config.subtitle,
                                icon: config.icon,
                                color: config.color,
                                destination: LevelGridView(
                                    lehrjahr: config.number,
                                    levelRange: config.levelRange,
                                    allQuestions: allQuestions
                                )
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .opacity(buttonsVisible ? 1 : 0)
                    .offset(y: buttonsVisible ? 0 : 30)

                    Spacer()

                    // Alle Level Button (nur wenn mehrere Lehrjahre vorhanden)
                    if availableLehrjahre.count > 1 {
                        NavigationLink(destination: LevelGridView(
                            lehrjahr: 0,
                            levelRange: totalAvailableRange,
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
                        .accessibilityLabel("Alle Level anzeigen")
                        .padding(.bottom, 40)
                        .opacity(footerVisible ? 1 : 0)
                    } else {
                        Spacer().frame(height: 40)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
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
        .accessibilityLabel("\(title), \(subtitle)")
    }
}
