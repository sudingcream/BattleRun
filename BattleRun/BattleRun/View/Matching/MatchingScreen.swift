//
//  MatchingScreen.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - Matching Screen
struct MatchingScreen: View {
    @ObservedObject var viewModel: RunMatchViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Animated Circle
            ZStack {
                Circle()
                    .stroke(Color(hex: "#D1FF00"), lineWidth: 2)
                    .frame(width: 192, height: 192)
                    .shadow(color: Color(hex: "#D1FF00").opacity(0.1), radius: 50)
                
                Circle()
                    .stroke(Color(hex: "#D1FF00").opacity(0.3), lineWidth: 1)
                    .frame(width: 160, height: 160)
                
                Circle()
                    .stroke(Color(hex: "#D1FF00").opacity(0.1), lineWidth: 1)
                    .frame(width: 128, height: 128)
                
                Image(systemName: "bolt.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Color(hex: "#D1FF00"))
            }
            .padding(.bottom, 48)
            
            Text("라이벌 찾는 중...")
                .font(.system(size: 30, weight: .black))
                .italic()
                .foregroundColor(.white)
                .padding(.bottom, 8)
            
            Text("나와 실력이 비슷한 러너를\n매칭하고 있습니다")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
            
            // Progress Bar
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 8)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(Color(hex: "#D1FF00"))
                    .frame(width: CGFloat(viewModel.matchProgress) * 2.8, height: 8)
                    .cornerRadius(4)
            }
            .frame(width: 280)
            .padding(.bottom, 48)
            
            // Waiting Runners
            VStack(spacing: 16) {
                HStack(spacing: -12) {
                    ForEach(0..<4) { _ in
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color(hex: "#4A4A4A"), Color(hex: "#2A2A2A")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color(hex: "#0F1115"), lineWidth: 2)
                            )
                    }
                }
                
                Text("주변에 32명의 러너 대기 중")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundColor(Color(hex: "#D1FF00"))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#D1FF00").opacity(0.1))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#D1FF00").opacity(0.2), lineWidth: 1)
                    )
            }
            
            Spacer()
            
            Button(action: {
                viewModel.cancelMatching()
            }) {
                Text("매칭 취소하기")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#0F1115"))
    }
}

