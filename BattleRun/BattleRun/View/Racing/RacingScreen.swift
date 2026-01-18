//
//  RacingScreen.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - Racing Screen
struct RacingScreen: View {
    @ObservedObject var viewModel: RunMatchViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 6, height: 6)
                    
                    Text("실시간 경합 중")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.red)
                .cornerRadius(20)
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: {
                        viewModel.isPaused.toggle()
                    }) {
                        Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        viewModel.endRace()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 40)
            
            // Timer
            VStack(spacing: 8) {
                Text("ELAPSED TIME")
                    .font(.system(size: 10, weight: .black))
                    .tracking(2)
                    .foregroundColor(.gray)
                
                Text(viewModel.formatTime(viewModel.time))
                    .font(.system(size: 70, weight: .black, design: .monospaced))
                    .italic()
                    .foregroundColor(.white)
            }
            .padding(.bottom, 40)
            
            // Race Progress
            VStack(spacing: 24) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("YOU")
                            .font(.system(size: 10, weight: .black))
                            .tracking(2)
                            .foregroundColor(viewModel.getLeader() == "YOU" ? Color(hex: "#D1FF00") : .white)
                        
                        Text(String(format: "%.2f", viewModel.distance) + "km")
                            .font(.system(size: 30, weight: .black))
                            .foregroundColor(viewModel.getLeader() == "YOU" ? Color(hex: "#D1FF00") : .white)
                    }
                    
                    Spacer()
                    
                    Text(viewModel.getLeader() == "YOU" ? "\(viewModel.getGap())KM 리드" : "\(viewModel.getGap())KM 추격")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(viewModel.getLeader() == "YOU" ? .black : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(viewModel.getLeader() == "YOU" ? Color(hex: "#D1FF00") : Color.red)
                        .cornerRadius(12)
                        .shadow(color: (viewModel.getLeader() == "YOU" ? Color(hex: "#D1FF00") : Color.red).opacity(0.3), radius: 10)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("RIVAL")
                            .font(.system(size: 10, weight: .black))
                            .tracking(2)
                            .foregroundColor(viewModel.getLeader() == "RIVAL" ? Color.red : .white)
                        
                        Text(String(format: "%.2f", viewModel.opponentDistance) + "km")
                            .font(.system(size: 30, weight: .black))
                            .foregroundColor(viewModel.getLeader() == "RIVAL" ? Color.red : .white)
                    }
                }
                
                // Track
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .frame(height: 56)
                        .cornerRadius(16)
                    
                    // Rival position
                    Circle()
                        .fill(Color.red)
                        .frame(width: 4, height: 36)
                        .shadow(color: Color.red.opacity(0.8), radius: 15)
                        .position(x: CGFloat(viewModel.opponentDistance / viewModel.targetDistance) * 296 + 40, y: 28)
                    
                    // User position
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "#D1FF00"))
                        .frame(width: 10, height: 44)
                        .shadow(color: Color(hex: "#D1FF00"), radius: 25)
                        .position(x: CGFloat(viewModel.distance / viewModel.targetDistance) * 296 + 40, y: 28)
                }
                .frame(width: 336, height: 56)
            }
            .padding(24)
            .background(Color(hex: "#1A1D23"))
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            
            // Stats
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Pace")
                        .font(.system(size: 10, weight: .black))
                        .tracking(2)
                        .foregroundColor(.gray)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("4'52\"")
                            .font(.system(size: 24, weight: .black))
                            .italic()
                        Text("/km")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(hex: "#1A1D23"))
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Heart Rate")
                        .font(.system(size: 10, weight: .black))
                        .tracking(2)
                        .foregroundColor(.gray)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("164")
                            .font(.system(size: 24, weight: .black))
                            .italic()
                            .foregroundColor(.red)
                        Text("BPM")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(1)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(hex: "#1A1D23"))
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Pro Tip
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#D1FF00").opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "#D1FF00"))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(hex: "#D1FF00").opacity(0.1), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("PRO TIP:")
                        .font(.system(size: 11, weight: .black))
                        .italic()
                        .tracking(2)
                        .foregroundColor(Color(hex: "#D1FF00"))
                    
                    Text("라이벌의 체력이 떨어지고 있습니다! 지금 200m 스퍼트를 내세요.")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
            }
            .padding(20)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#D1FF00").opacity(0.05), Color.clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(hex: "#D1FF00").opacity(0.1), lineWidth: 1)
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#0F1115"))
    }
}
