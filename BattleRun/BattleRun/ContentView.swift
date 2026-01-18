import SwiftUI
import Combine

// MARK: - Main App Structure
struct ContentView: View {
    @StateObject private var viewModel = RunMatchViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: "#0F1115").ignoresSafeArea()
            
            switch viewModel.currentScreen {
            case .home:
                HomeScreen(viewModel: viewModel) 
            case .leaderboard:
                LeaderboardScreen(viewModel: viewModel)
            case .matching:
                MatchingScreen(viewModel: viewModel)
            case .racing:
                RacingScreen(viewModel: viewModel)
            case .result:
                ResultScreen(viewModel: viewModel)
            }
        }
    }
}


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

// MARK: - Reusable Components
struct StatCard: View {
    let icon: String
    let label: String
    let value: String
    let unit: String
    var isHighlight: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Text(label)
                    .font(.system(size: 10, weight: .black))
                    .tracking(2)
                    .foregroundColor(.gray)
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .black))
                    .italic()
                    .foregroundColor(isHighlight ? Color(hex: "#D1FF00") : .white)
                
                Text(unit)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(hex: "#1A1D23"))
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

struct MatchRoomCard: View {
    let name: String
    let points: Int
    let distance: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("\(distance) 매치")
                        .font(.system(size: 10, weight: .black))
                        .tracking(1)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#D1FF00"))
                    
                    Text("\(points)P")
                        .font(.system(size: 14, weight: .black))
                        .italic()
                        .foregroundColor(Color(hex: "#D1FF00"))
                }
                
                Button(action: action) {
                    Text("참가")
                        .font(.system(size: 10, weight: .black))
                        .tracking(2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.05), lineWidth: 1)
                        )
                }
            }
        }
        .padding(16)
        .background(Color(hex: "#1A1D23"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
