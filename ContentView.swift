import SwiftUI
import Charts

struct MoodEntry: Identifiable {
    let id = UUID()
    let mood: String
    let score: Int
}

struct ContentView: View {
    
    @State private var userFeeling = ""
    @State private var suggestion = "Type your feeling..."
    @State private var moodHistory: [MoodEntry] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("FitMind AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // INPUT
                TextField("How are you feeling?", text: $userFeeling)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Analyze Feeling 🧠") {
                    analyzeFeeling()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // RESULT
                Text("Suggestion:")
                    .font(.headline)
                
                Text(suggestion)
                    .foregroundColor(.blue)
                    .padding()
                
                // GRAPH
                if !moodHistory.isEmpty {
                    Text("Mood History 📊")
                        .font(.headline)
                    
                    Chart(moodHistory) { entry in
                        BarMark(
                            x: .value("Mood", entry.mood),
                            y: .value("Score", entry.score)
                        )
                    }
                    .frame(height: 200)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    // 🧠 AI LOGIC
    func analyzeFeeling() {
        
        let text = userFeeling.lowercased()
        var mood = "Neutral"
        var score = 0
        
        if text.contains("happy") {
            suggestion = "Go for Strength Training 💪"
            mood = "Happy"
            score = 5
        } else if text.contains("sad") {
            suggestion = "Try Light Yoga 🧘"
            mood = "Sad"
            score = 2
        } else if text.contains("tired") {
            suggestion = "Take Rest or Stretch 🛌"
            mood = "Tired"
            score = 1
        } else if text.contains("weak") {
            suggestion = "Eat well & Light Exercise 🍎"
            mood = "Weak"
            score = 2
        } else if text.contains("alone") {
            suggestion = "Go for a Walk 🚶‍♀️"
            mood = "Alone"
            score = 3
        } else {
            suggestion = "Stay Active 🚴"
            mood = "Neutral"
            score = 3
        }
        
        // SAVE TO GRAPH
        moodHistory.append(MoodEntry(mood: mood, score: score))
        
        userFeeling = ""
    }
}

#Preview {
    ContentView()
}
