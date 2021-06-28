//
//  ContentView.swift
//  BetterRest
//
//  Created by Bruce Gilmour on 2021-06-27.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationView {
            VStack {
                enterWakeUpTime

                enterDesiredSleep

                enterCoffeeIntake
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing: displayCalculateButton)
        }
    }

    var enterWakeUpTime: some View {
        Group {
            Text("When do you want to wake up?")
                .font(.headline)

            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }

    var enterDesiredSleep: some View {
        Group {
            Text("Desired amount of sleep")
                .font(.headline)

            Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
        }
    }

    var enterCoffeeIntake: some View {
        Group {
            Text("Daily coffee intake")
                .font(.headline)

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

    func calculateBedtime() {
        // more to come
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
