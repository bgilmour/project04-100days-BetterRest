//
//  ContentView.swift
//  BetterRest
//
//  Created by Bruce Gilmour on 2021-06-27.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false

    var body: some View {
        NavigationView {
            Form {
                enterWakeUpTime

                enterDesiredSleep

                enterCoffeeIntake
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing: displayCalculateButton)
            .alert(isPresented: $alertShowing) {
                displayAlert
            }
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var enterWakeUpTime: some View {
        Section(header: Text("When do you want to wake up?")) {
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
        }
    }

    var enterDesiredSleep: some View {
        Section(header: Text("Desired amount of sleep")) {
            Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
        }
    }

    var enterCoffeeIntake: some View {
        Section(header: Text("Daily coffee intake")) {
            Stepper(value: $coffeeAmount, in: 1 ... 20) {
                if coffeeAmount == 1 {
                    Text("1 cup")
                } else {
                    Text("\(coffeeAmount) cups")
                }
            }
        }
    }

    var displayCalculateButton: some View {
        Button(action: calculateBedtime) {
            Text("Calculate")
        }
    }

    var displayAlert: Alert {
        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }

    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong and we can't predict your bedtime."
        }
        alertShowing = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
