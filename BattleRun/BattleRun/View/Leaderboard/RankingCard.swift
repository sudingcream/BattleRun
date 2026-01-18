//
//  RankingCard.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI

struct RankingCard: View {
    let user: RunMatchViewModel.RankingUser
    
    var body: some View {
        HStack {
            // Rank Number
            Text("\(user.rank)")
                .font(.system(size: 18, weight: .black))
                .italic()
                .foregroundColor(user.rank <= 3 ? Color(hex: "#D1FF00") : .gray)
                .frame(width: 32)
            
            // User Info
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(user.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(user.isMe ? Color(hex: "#D1FF00") : .white)
                    
                    if user.isMe {
                        Text("(나)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "#D1FF00"))
                    }
                }
                
                Text("Win Rate \(user.winRate)% • \(user.points)P")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Medal for Top 3
            if user.rank <= 3 {
                Image(systemName: "medal.fill")
                    .font(.system(size: 20))
                    .foregroundColor(
                        user.rank == 1 ? Color(hex: "#FFD700") :
                        user.rank == 2 ? Color(hex: "#C0C0C0") :
                        Color(hex: "#CD7F32")
                    )
            }
        }
        .padding(16)
        .background(user.isMe ? Color(hex: "#D1FF00").opacity(0.1) : Color(hex: "#1A1D23"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(user.isMe ? Color(hex: "#D1FF00").opacity(0.3) : Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}
