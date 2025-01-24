//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by admin_user on 04/12/24.
//
 
import SwiftUI
import UserNotifications

class CounterViewModel: ObservableObject {
    @Published var count = 0
}

struct ParentView: View {
    @StateObject private var viewModel = CounterViewModel()

    func askPermissionsNotifications(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted: \(granted)")
        }
    }
    
    func setNotifications(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted: \(granted)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Parent Count: \(viewModel.count)")
            ChildView(viewModel: viewModel)
        }
    }
}

struct ChildView: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        Button("Increment") {
            viewModel.count += 1
        }
    }
}


@Observable
class UserSettings {
    var username = "Anonymous"
    var isLoggedIn = false
}

class UserSettings2: ObservableObject {
    @Published var username = "Anonymous"
}
 
struct ContentView2: View {
    @StateObject private var settings = UserSettings2()
    
    var body: some View {
        Text("Hello, \(settings.username)!")
    }
}




struct ContentView: View {
    @ObservedObject var settings2 = UserSettings2()

    @State private var settings = UserSettings()
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("user") var username: String = ""
    @State var userEditedName : String = ""
    
    var body: some View {
        VStack {
            
            Text("Welcome" + (username.isEmpty ? "!":  ", \(username)!"))
                .foregroundColor(colorScheme == .dark ? .red : .green)
            TextField("Enter your name", text: $userEditedName)
                .cornerRadius(10)
                .padding()
            
            Button("Log in") {
                username = userEditedName
                settings.username = userEditedName
            }
            Toggle("Logged In", isOn: $settings.isLoggedIn)
        }
        .padding(24)
    }
}
 
//struct ContentView: View {
//    @AppStorage("user") var username: String = ""
//    @State var userEditedName : String = ""
//    @Environment(\.sizeCategory) var sizeCategory
//
//    
//    @Environment(\.colorScheme) var colorScheme
//
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .font(.title)
//                .foregroundColor(colorScheme == .dark ? .white : .black)
//            
//            Text("Current size category: \(sizeCategory)")
//                .font(.body)
//            
//            Button("Toggle Theme") {
//                // Note: You can't directly modify system environment values
//                // This is just for illustration
//            }
//            .padding()
//            .background(colorScheme == .dark ? Color.white : Color.black)
//            .foregroundColor(colorScheme == .dark ? .black : .white)
//            .cornerRadius(10)
//            
//            Text("Welcome" + (username.isEmpty ? "!":  ", \(username)!"))
//
//            TextField("Enter your name", text: $userEditedName)
//                .cornerRadius(10)
//                .padding()
//            
//            Button("Log in") {
//                username = userEditedName
//            }
//        }
//        .padding()
//    }
//     
//}


//
//struct Title: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.largeTitle)
//            .foregroundStyle(.white)
//            .padding()
//            .background(.blue)
//            .clipShape(.rect(cornerRadius: 10))
//    }
//}
//
//extension View {
//    func titleStyle() -> some View {
//        modifier(Title())
//    }
//}
// 
//
//struct ContentView1: View {
//    
//    @State private var counter = 0
//    @State private var name = ""
//    
//    var body: some View {
//        VStack {
//    
//            Text("Title")
//                .titleStyle()
//            List {
//                Section(header: Text("UIKit"), footer: Text("We will miss you")) {
//                    Text("UITableView")
//                    Text("UITableView")
//                    Text("UITableView")
//
//                }
//
//                Section(header: Text("SwiftUI"), footer: Text("A lot to learn")) {
//                    Text("List")
//                }
//            } //.listStyle(GroupedListStyle())
// 
// 
//            Text("Counter: \(counter)")
//            Divider()
//
//            Button("Increment") {
//                counter += 1
//            }
//            Spacer()
//        }
//    }
//}

#Preview {
    ContentView()
}

//
//
//protocol Car : Equatable {
//    var fuelType: Double {get}
//
//    func calculateTax() -> Double
//}
//
//
//func buyCar(budget: Double) -> some Car {
//    if budget < 500 {
//        return SmallCar(fuelType: 80)
//    }
//    return SmallCar(fuelType: 90)
//}
// 
//
//
//struct Bus : Car {
//    var fuelType: Double
//     
//    func calculateTax() -> Double {
//        return 50
//    }
//}
//
//
//struct SmallCar : Car {
//    var fuelType: Double
//
//    func calculateTax() -> Double {
//        return 50
//    }
//}



//let car1 = buyCar(budget: 400)
//let car2 = buyCar(budget: 800)
//////
//if car1 == car2 {
//    
//}

//
//protocol Container {
//    func pack (item: Self)
//}
//
//struct Box : Container {
//    func pack (item: Self) {
//        print("box")
//        
//        let label = UILabel()
//        label.font =
//        label.text = "w23324"
//    }
//}
//
//func buyContainer() -> any Container {
//    return Box()
//}

//
//
//protocol Animal {
//    func makeSound()
//}
//
//func playSound1<T: Animal>(of animal: T){
//    animal.makeSound()
//}
//
//func playSound2(of animal: Animal){
//    animal.makeSound()
//}
