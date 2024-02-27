//
//  ContentView.swift
//  Calorie Tracker Using Core Data
//
//  Created by poonam mittal on 13/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    

    //@StateObject var jsonVM = JSONViewModel()
    //MARK: BODY SECTION
    var body: some View {
       
        NavigationView { //START NAVIGATION VIEW
            ZStack{
                
                Color.gray
                
                    .ignoresSafeArea()
               
                VStack(spacing: 10) { // START VStack
                    NavigationLink {
                        AddUserDetailView()
                        
                    } label: {
                        Text("Sign Up")
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .cornerRadius(20)
                    }
                    
                    NavigationLink {
                        UserListView()
                    } label: {
                        Text("View User Details")
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .cornerRadius(20)
                            
                    }
                } // END VStack
                
                
                .navigationTitle("Calorie Tracker")
            }
            
        } ///END NAVIGATION VIEW
      
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
