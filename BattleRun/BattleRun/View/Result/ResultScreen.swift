//
//  ResultScreen.swift
//  BattleRun
//
//  Created by suding on 1/18/26.
//

import SwiftUI
import Combine

// MARK: - Result Screen
struct ResultScreen: View {
    @ObservedObject var viewModel: RunMatchViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Trophy
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#D1FF00"))
                            .frame(width: 112, height: 112)
                            .shadow(color: Color(hex: "#D1FF00").opacity(0.2), radius: 50)
                        
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.black)
                        
                        Text("🏆 MVP")
                            .font(.system(size: 12, weight: .black))
                            .italic()
                            .foregroundColor(Color(hex: "#D1FF00"))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .background(Color.black)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "#D1FF00").opacity(0.3), lineWidth: 1)
                            )
                            .offset(y: 64)
                    }
                    
                    Text("VICTORY!")
                        .font(.system(size: 60, weight: .black))
                        .italic()
                        .foregroundColor(.white)
                        .tracking(-2)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "#D1FF00"))
                        
                        Text("+1,000 P 획득")
                            .font(.system(size: 20, weight: .black))
                            .italic()
                            .tracking(2)
                            .foregroundColor(Color(hex: "#D1FF00"))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(hex: "#D1FF00").opacity(0.1))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(hex: "#D1FF00").opacity(0.2), lineWidth: 1)
                    )
                }
                .padding(.top, 32)
                .padding(.bottom, 32)
                
                // Stats Card
                VStack(spacing: 32) {
                    HStack(spacing: 32) {
                        VStack(spacing: 4) {
                            Text("Total Time")
                                .font(.system(size: 10, weight: .black))
                                .tracking(2)
                                .foregroundColor(.gray)
                            
                            Text(viewModel.formatTime(viewModel.time))
                                .font(.system(size: 40, weight: .black))
                                .italic()
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 4) {
                            Text("Avg. Pace")
                                .font(.system(size: 10, weight: .black))
                                .tracking(2)
                                .foregroundColor(.gray)
                            
                            Text("4'48\"")
                                .font(.system(size: 40, weight: .black))
                                .italic()
                                .foregroundColor(.white)
                        }
                    }
                    
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [Color.clear, Color.white.opacity(0.1), Color.clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(height: 1)
                    
                    HStack {
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(
                                        colors: [Color(hex: "#4A4A4A"), Color(hex: "#2A2A2A")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 64, height: 64)
                                    .overlay(
                                        Circle()
                                            .stroke(Color(hex: "#D1FF00"), lineWidth: 2)
                                    )
                                    .shadow(color: Color(hex: "#D1FF00").opacity(0.13), radius: 15)
                            }
                            
                            Text("YOU")
                                .font(.system(size: 10, weight: .black))
                                .tracking(2)
                                .foregroundColor(.gray)
                            
                            Text(viewModel.formatTime(viewModel.time))
                                .font(.system(size: 18, weight: .black))
                                .italic()
                                .foregroundColor(Color(hex: "#D1FF00"))
                        }
                        
                        Spacer()
                        
                        Text("VS")
                            .font(.system(size: 24, weight: .black))
                            .italic()
                            .foregroundColor(Color(hex: "#2A2A2A"))
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Circle()
                                .fill(LinearGradient(
                                    colors: [Color(hex: "#3A3A3A"), Color(hex: "#1A1A1A")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 64, height: 64)
                                .overlay(
                                    Circle()
                                        .stroke(Color.clear, lineWidth: 2)
                                )
                            
                            Text("RIVAL")
                                .font(.system(size: 10, weight: .black))
                                .tracking(2)
                                .foregroundColor(.gray.opacity(0.6))
                            
                            Text(viewModel.formatTime(viewModel.time + 152))
                                .font(.system(size: 18, weight: .black))
                                .italic()
                                .foregroundColor(Color.red.opacity(0.5))
                        }
                        .opacity(0.5)
                    }
                }
                .padding(32)
                .background(Color(hex: "#1A1D23"))
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
                .shadow(radius: 20)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                
                // Claim Button
                Button(action: {
                    viewModel.claimReward()
                }) {
                    Text("승리 보상 받기")
                        .font(.system(size: 20, weight: .black))
                        .italic()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color(hex: "#D1FF00"))
                        .cornerRadius(24)
                        .shadow(color: Color(hex: "#D1FF00").opacity(0.13), radius: 20)
                }
                .buttonStyle(ScaleButtonStyle())
                .padding(.horizontal, 32)
                .padding(.bottom, 24)
                
                // Share Button
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Text("결과 공유하기")
                            .font(.system(size: 10, weight: .black))
                            .tracking(2)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 48)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#0F1115"))
    }
}
