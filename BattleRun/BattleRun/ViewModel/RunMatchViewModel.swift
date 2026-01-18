//
//  RunMatchViewModel.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - View Model
class RunMatchViewModel: ObservableObject {
    @Published var currentScreen: Screen = .home
    @Published var matchProgress: Double = 0
    @Published var distance: Double = 0
    @Published var opponentDistance: Double = 0
    @Published var time: Int = 0
    @Published var isPaused: Bool = false
    @Published var userPoints: Int = 2450
    
    let targetDistance: Double = 5.0
    
    private var matchTimer: Timer?
    private var raceTimer: Timer?
    
    enum Screen {
        case home, matching, racing, result, leaderboard
    }
    
    // 랭킹 데이터
    let rankings: [RankingUser] = [
        RankingUser(rank: 1, name: "스피드마스터", winRate: 92, points: 15400, isMe: false),
        RankingUser(rank: 2, name: "번개발자국", winRate: 88, points: 12100, isMe: false),
        RankingUser(rank: 3, name: "러닝머신", winRate: 85, points: 11000, isMe: false),
        RankingUser(rank: 4, name: "러너 #1125", winRate: 68, points: 2450, isMe: true),
        RankingUser(rank: 5, name: "도심추격자", winRate: 65, points: 5600, isMe: false),
        RankingUser(rank: 6, name: "새벽안개", winRate: 62, points: 4200, isMe: false),
        RankingUser(rank: 7, name: "지치지않는심장", winRate: 59, points: 3100, isMe: false),
    ]
    
    init() {}
    
    struct RankingUser {
        let rank: Int
        let name: String
        let winRate: Int
        let points: Int
        let isMe: Bool
    }
    
    func startMatching() {
        currentScreen = .matching
        matchProgress = 0
        
        matchTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.matchProgress += 2
            
            if self.matchProgress >= 100 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.currentScreen = .racing
                    self.startRace()
                }
            }
        }
    }
    
    func startRace() {
        raceTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self, !self.isPaused else { return }
            
            self.time += 1
            
            self.distance += 0.0015 + Double.random(in: 0...0.001)
            self.opponentDistance += 0.0014 + Double.random(in: 0...0.0012)
            
            if self.distance >= self.targetDistance {
                self.distance = self.targetDistance
                timer.invalidate()
                self.currentScreen = .result
            }
            
            if self.opponentDistance >= self.targetDistance {
                self.opponentDistance = self.targetDistance
            }
        }
    }
    
    func cancelMatching() {
        matchTimer?.invalidate()
        currentScreen = .home
    }
    
    func endRace() {
        raceTimer?.invalidate()
        currentScreen = .home
        resetRace()
    }
    
    func claimReward() {
        userPoints += 1000
        currentScreen = .home
        resetRace()
    }
    
    func resetRace() {
        time = 0
        distance = 0
        opponentDistance = 0
        isPaused = false
    }
    
    func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 600
        let secs = (seconds % 600) / 10
        return String(format: "%d:%02d", mins, secs)
    }
    
    func getLeader() -> String {
        return distance >= opponentDistance ? "YOU" : "RIVAL"
    }
    
    func getGap() -> String {
        return String(format: "%.3f", abs(distance - opponentDistance))
    }
}
