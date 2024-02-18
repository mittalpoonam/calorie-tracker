//
//  DetailView.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 17/02/24.
//

import SwiftUI

struct DetailView: View {
    
    
    
    //MARK: PROPERTIES
    @State var foodDetailVM: FoodDetailViewModel = FoodDetailViewModel()
    @State var activityDetailVM: ActivityDetailViewModel = ActivityDetailViewModel()
    var currentUser: User
    var date: String
    
    
    
    //MARK: BODY SECTION
    var body: some View {
        
            ZStack { //START ZTACK
                Color.gray.ignoresSafeArea()
                
            ScrollView(.vertical, showsIndicators: true) {
                VStack { //START VSTACK
                    Text("Food Data")
                        .bold()
                        .underline()
                    
                    headerViewForFood
                    viewForFood
                    
                    Text("Activity Data")
                        .bold()
                        .underline()
                    
                    headerViewForActivity
                    viewForActivity
                    
                    Spacer()
                } //END VSTACK
            }
        }//END ZSTACK
        .navigationTitle("Data Description")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(currentUser: User(), date: "")
    }
}

//MARK: LOGIC/FUNCTIONALITY PLUS COMPONENTS
extension DetailView {
 
    private var headerViewForFood: some View {
        HStack {
            Text("Date")
                .font(.system(size: 11))
                .frame(width: 70, height: 17, alignment: .leading)
            Text("Meal Type")
                .font(.system(size: 11))
                .frame(width: 80, height: 17, alignment: .leading)
            Text("Food Group")
                .font(.system(size: 11))
                .frame(width: 90, height: 17, alignment: .leading)
            Text("Serving")
                .font(.system(size: 11))
                .frame(width: 60, height: 17, alignment: .leading)
            Text("CalorieIn")
                .font(.system(size: 11))
                .frame(width: 60, height: 17, alignment: .leading)
        }
        .foregroundColor(Color.white)
        .background(Color.black)
    }
    
    
    private var viewForFood: some View {
        
             ForEach(foodDetailVM.foods) { food in
                 let userDate = CommonFuncs.dateFormatting(date: food.date.unsafelyUnwrapped)
             
             if food.userId == currentUser.userId  && date == userDate  {
              
                 if let caloriIn = food.calorieIn,
                    let mealType = food.mealType,
                    let foodGroup = food.foodGroup,
                    let serving = food.serving {
                     HStack {
                         Text(date)
                             .font(.system(size: 11))
                             .frame(width: 70, height: 17, alignment: .leading)
                         Text("\(mealType)")
                             .font(.system(size: 11))
                             .frame(width: 80, height: 17, alignment: .leading)
                         Text("\(foodGroup)")
                             .font(.system(size: 11))
                             .frame(width: 90, height: 17, alignment: .leading)
                         Text("\(serving)")
                             .font(.system(size: 11))
                             .frame(width: 60, height: 17, alignment: .leading)
                         Text("\(caloriIn)")
                             .font(.system(size: 11))
                             .frame(width: 60, height: 17, alignment: .leading)
                     }
                 }
             }
             
         }
     }

    
    private var headerViewForActivity: some View {
        HStack {
            Text("Date")
                .font(.system(size: 11))
                .frame(width: 75, height: 17, alignment: .leading)
            Text("Name")
                .font(.system(size: 11))
                .frame(width: 55, height: 17, alignment: .leading)
            Text("Description")
                .font(.system(size: 11))
                .frame(width: 80, height: 17, alignment: .leading)
            Text("MET Value")
                .font(.system(size: 11))
                .frame(width: 70, height: 17, alignment: .leading)
            Text("Calorie Out")
                .font(.system(size: 11))
                .frame(width: 70, height: 17, alignment: .leading)
        }
        .foregroundColor(Color.white)
        .background(Color.black)
    }
    
    private var viewForActivity: some View {
         
              ForEach(activityDetailVM.activities) { activity in
                  let userDate = CommonFuncs.dateFormatting(date: activity.date.unsafelyUnwrapped)
              
              if activity.userId == currentUser.userId  && date == userDate  {
               
                  if let name = activity.activityName,
                     let desc = activity.activityDesc,
                     let met = activity.metValue,
                     let calorieOut = activity.calorieOut
                    // duration, calorieOut
                      {
                      HStack {
                          Text(date)
                              .font(.system(size: 11))
                              .frame(width: 75, height: 17, alignment: .leading)
                          Text("\(name)")
                              .font(.system(size: 11))
                              .frame(width: 55, height: 17, alignment: .leading)
                          Text("\(desc)")
                              .font(.system(size: 11))
                              .frame(width: 80, height: 17, alignment: .leading)
                          Text("\(met)")
                              .font(.system(size: 11))
                              .frame(width: 70, height: 17, alignment: .leading)
                          
                          Text("\(calorieOut)")
                              .font(.system(size: 11))
                              .frame(width: 70, height: 17, alignment: .leading)
                      }
                  }
              }
              
          }
      }

}
