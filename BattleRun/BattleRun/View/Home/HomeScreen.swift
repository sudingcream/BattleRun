//
//  HomeScreen.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - Home Screen
struct HomeScreen: View {
    @ObservedObject var viewModel: RunMatchViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("WELCOME BACK")
                            .font(.system(size: 12, weight: .medium))
                            .tracking(2)
                            .foregroundColor(.gray)
                        
                        Text("Runner #1125")
                            .font(.system(size: 24, weight: .black))
                            .italic()
                            .foregroundColor(.white)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#D1FF00"))
                            
                            Text("\(viewModel.userPoints)P")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "#D1FF00"))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.currentScreen = .leaderboard
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(hex: "#D1FF00"))
                                .frame(width: 48, height: 48)
                                .shadow(color: Color(hex: "#D1FF00").opacity(0.2), radius: 20)
                            
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
                
                // Today's Goal Card
                ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TODAY'S GOAL")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(Color(hex: "#D1FF00"))
                                .tracking(2)
                            
                            Text("5KM 쾌속 매치")
                                .font(.system(size: 30, weight: .black))
                                .italic()
                                .foregroundColor(.white)
                                .lineSpacing(-5)
                        }
                        
                        Button(action: {
                            viewModel.startMatching()
                        }) {
                            HStack(spacing: 8) {
                                Text("매칭 시작하기")
                                    .font(.system(size: 16, weight: .black))
                                
                                Image(systemName: "play.fill")
                                    .font(.system(size: 14))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                            .background(Color(hex: "#D1FF00"))
                            .cornerRadius(12)
                            .shadow(color: Color(hex: "#D1FF00").opacity(0.13), radius: 10)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "#1A1D23"), Color(hex: "#0F1115")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color.white.opacity(0.05), lineWidth: 1)
                    )
                    
                    Image(systemName: "flame.fill")
                        .font(.system(size: 160))
                        .foregroundColor(Color(hex: "#D1FF00"))
                        .opacity(0.1)
                        .rotationEffect(.degrees(12))
                        .offset(x: 20, y: 20)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                // Match Button + Stats
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        StatCard(
                            icon: "person.3.fill",
                            label: "현재 접속자",
                            value: "1,284",
                            unit: "명"
                        )
                        StatCard(
                            icon: "chart.line.uptrend.xyaxis",
                            label: "나의 승률",
                            value: "68",
                            unit: "%",
                            isHighlight: true
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                // Live Match Rooms
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("실시간 대결룸")
                            .font(.system(size: 18, weight: .bold))
                            .italic()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 6, height: 6)
                            
                            Text("LIVE")
                                .font(.system(size: 10, weight: .black))
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red.opacity(0.2), lineWidth: 1)
                        )
                    }
                    
                    VStack(spacing: 12) {
                        MatchRoomCard(name: "번개러너", points: 500, distance: "5km", action: { viewModel.startMatching() })
                        MatchRoomCard(name: "도심추격자", points: 1000, distance: "3km", action: { viewModel.startMatching() })
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color(hex: "#0F1115"))
    }
}
