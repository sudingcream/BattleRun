//
//  LeaderboardScreen.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - Leaderboard Screen
struct LeaderboardScreen: View {
    @ObservedObject var viewModel: RunMatchViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 16) {
                Button(action: {
                    viewModel.currentScreen = .home
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(20)
                }
                
                Text("명예의 전당")
                    .font(.system(size: 20, weight: .black))
                    .italic()
                    .tracking(-0.5)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            // Trophy Icon
            VStack(spacing: 24) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#FFD700"), Color(hex: "#FFA500")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 96, height: 96)
                        .rotationEffect(.degrees(12))
                        .shadow(color: Color(hex: "#FFD700").opacity(0.3), radius: 40)
                    
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(-12))
                    
                    Text("TOP 1%")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .offset(x: 40, y: 40)
                }
                
                Text("상위 10등까지만 보여집니다.")
                    .font(.system(size: 12, weight: .bold)) 
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 40)
            
            // Rankings List
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(viewModel.rankings, id: \.rank) { user in
                        RankingCard(user: user)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#0F1115"))
    }
}
