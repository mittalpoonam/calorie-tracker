//
//  ProfileView.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 12/02/24.
//

import SwiftUI

struct UserListView: View {
   
    @StateObject var userDetailVM = UserDetailViewModel()
    @State var individualUser: User = User()
    
    //MARK: BODY SECTION
    var body: some View {
        
        ZStack {
            Color.gray
            .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    
                    headerDataView
                    ForEach(userDetailVM.users, id: \.self) { user in
                        
                        if let name = user.name,
                           let height = user.height,
                           let weight = user.weight,
                           let sex = user.sex,
                           let bmr = user.bmr {
                            HStack {
                                Text(name)
                                    .font(.system(size: 11))
                                    .frame(width: 50,height: 17, alignment: .leading)
                                Text(height)
                                    .font(.system(size: 11))
                                    .frame(width: 50,height: 17, alignment: .leading)
                                Text(weight)
                                    .font(.system(size: 11))
                                    .frame(width: 50,height: 17, alignment: .leading)
                                
                                Text(sex)
                                    .font(.system(size: 11))
                                    .frame(width: 40,height: 17, alignment: .leading)
                                
                                Text(bmr)
                                    .font(.system(size: 11))
                                    .frame(width: 50,height: 17, alignment: .leading)
                                
                                NavigationLink {
                                    
                                    ViewDataForPartcularUser(currentUser: user)
                                } label: {
                                    Text("View")
                                        .font(.system(size: 11))
                                        .frame(width: 35, alignment: .leading)
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                }
                                
                                NavigationLink {
                                    
                                    AddDataView(individualUser: user)
                                } label: {
                                    addData
                                }
                                
                            }
                        }
                        
                    }
                    Spacer()
                    
                }
            }
        }
        .navigationTitle("User Details")
            
    }
        
}
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

//MARK: COMPONENTS

extension UserListView {
    
    private var headerDataView: some View {
        
        HStack {
            Text("Name")
                .font(.system(size: 11))
                .frame(width: 50,height: 17, alignment: .leading)
                .bold()
            Text("Height")
                .font(.system(size: 11))
                .frame(width: 50,height: 17, alignment: .leading)
                .bold()
            Text("Weight")
                .font(.system(size: 11))
                .frame(width: 50,height: 17, alignment: .leading)
                .bold()
            Text("Gender")
                .font(.system(size: 11))
                .frame(width:40,height: 17, alignment: .leading)
                .bold()
            Text("BMR")
                .font(.system(size: 11))
                .frame(width: 50,height: 17, alignment: .leading)
                .bold()
            Text("Action")
                .font(.system(size: 11))
                .frame(width: 100,height: 17, alignment: .leading)
                .bold()
            
        }
    }
    
    private var addData: some View {
        Text("Add Data")
            .font(.system(size: 11))
            .frame(width: 65, alignment: .leading)
            .foregroundColor(.white)
            .background(Color.black)
    }
}


