//
//  ContentView.swift
//  Video 3
//
//  Created by Tate Wrigley on 30/07/2022.
//

import SwiftUI


struct TeslaDataModel {
    
    var image: UIImage
    var mainTitle: String
    var secondaryTitle: String
    var button1Text: String
    var button2Text : String?
    
    
    
}

protocol CoordinatorDelegate {
    func currentPageIndex(index: Int)
    func scrollIsMoving(contentOffset: CGPoint)
    
}
struct ContentView: View, CoordinatorDelegate {
    
    @State var currentPageIndex = 0
    func scrollIsMoving(contentOffset: CGPoint) {
        print(contentOffset.y)
        
        withAnimation(.default, {
            if contentOffset.y > 0 {
                isMoving = true
            }
         
        })
    
    }
    
    func currentPageIndex(index: Int) {
        currentPageIndex = index
        
        currentTesla = CollectionView._dataModel![index]
        
        withAnimation(.default, {
            isMoving = false
        })
    }
    
   @State var isMoving = false
    
    @State var begin = false
    
     @State var CollectionView =  CollectionViewUIViewRepresentable(dataModel: [
      TeslaDataModel(image: UIImage(named: "Car1")!, mainTitle: "Model Y", secondaryTitle: "2% Company Car Tax. Learn More", button1Text: "Custom Order", button2Text: "Test Drive"),
      TeslaDataModel(image: UIImage(named: "Car2")!, mainTitle: "Model 3", secondaryTitle: "2% Company Car Tax. Learn More", button1Text: "Custom Order", button2Text: "Explore Inventory"),
      TeslaDataModel(image: UIImage(named: "Car3")!, mainTitle: "Model S", secondaryTitle: "2% Company Car Tax. Learn More", button1Text: "Custom Order", button2Text: "Explore Inventory"),
      TeslaDataModel(image: UIImage(named: "Car4")!, mainTitle: "Solar and Powerwall", secondaryTitle: "Power Everything", button1Text: "Custom Order"),
      TeslaDataModel(image: UIImage(named: "Car5")!, mainTitle: "Model X", secondaryTitle: "", button1Text: "Custom Order", button2Text: "Test Drive"),
      TeslaDataModel(image: UIImage(named: "Car6")!, mainTitle: "Accessories", secondaryTitle: "", button1Text: "Shop Now"),
    ])
    
    @State var currentTesla : TeslaDataModel =  TeslaDataModel(image: UIImage(named: "Car1")!, mainTitle: "Model Y", secondaryTitle: "2% Company Car Tax. Learn More", button1Text: "Custom Order", button2Text: "Test Drive")
    
    @State var showMenu = false
    var body: some View {
     

        ZStack {
            if begin == true {
                
                ZStack {
                    
                    CollectionView.onAppear(perform: {
                        
                        withAnimation(.default, {
                            isMoving = false
                        })
                    })
                    VStack {
                        
                        Spacer().frame(width: nil, height: 50, alignment: .center)
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.default, {
                                    showMenu = true
                                })
                            
                            } , label: {
                                
                                ZStack {
                                    Rectangle().frame(width: 100, height: 40, alignment: .center).cornerRadius(20).foregroundColor(.white).opacity(0.5)
                                    Text("Menu").foregroundColor(.black)
                                }
                            })
                        }.padding(10)
                        Spacer().frame(width: nil, height: 50, alignment: .center)
                        Text(currentTesla.mainTitle).opacity(isMoving ? 0 : 1.0).font(.system(size: 40))
                        Text(currentTesla.secondaryTitle).opacity(isMoving ? 0 : 1.0)
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                Rectangle().frame(width: 300, height: 40, alignment: .center).cornerRadius(20).foregroundColor(Color(uiColor: #colorLiteral(red: 0.2256434262, green: 0.2356180251, blue: 0.2483223081, alpha: 1))).opacity(0.95)
                                Text(currentTesla.button1Text)
                            }
                           
                        }).opacity(isMoving ? 0 : 1.0).foregroundColor(.white)
                        Button(action: {
                            
                        } , label: {
                            ZStack {
                                Rectangle().frame(width: 300, height: 40, alignment: .center).cornerRadius(20).foregroundColor(.white).opacity(0.95)
                                Text(currentTesla.button2Text ?? "").foregroundColor(.black)
                            }
                        }).opacity(isMoving || (currentTesla.button2Text == nil) ? 0 : 1.0)
                        
                        Spacer().frame(width: nil, height: 100, alignment: .center)
                    }
              
                        
                    HStack {
                        Spacer()
                  
                    ZStack {
                        Rectangle().foregroundColor(.white).shadow(color: .black, radius: 10.0, x: 0, y: 0)
                        VStack {
                            Spacer().frame(width: nil, height: 50, alignment: .center)
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation(.default ,{
                                        showMenu = false
                                    })
                                }, label: {
                                    Text("X").foregroundColor(.black)
                                })
                            }.padding(20)
                            Spacer()
                            ScrollView {
                                VStack(alignment: .leading, spacing: 20, content: {
                                    
                          
                                    
                            
                              
                                        
                                  
                                Text("Model S")
                                Text("Model 3")
                                Text("Model X")
                                Text("Model Y")
                                Text("Existing Inventory")
                                Text("Used Inventory")
                                Text("Trade-in")
                                Text("Test Drive")
                                Text("Company Cars")
                                Text("Powerwall")
                                    
                                    
                             
                             
                                })
                            }
                            Spacer()
                        }
                    }.frame(width: 300, height: UIScreen.main.bounds.height, alignment: .center).offset(x: showMenu ? 0 : 300, y: 0).opacity(showMenu ? 1 : 0.0)
                    }
                    
                }
             
            }
            
            
        }.ignoresSafeArea().onAppear(perform: {
            CollectionView.coordinateDelegate = self
            begin = true
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CollectionViewUIViewRepresentable : UIViewRepresentable , CoordinatorDelegate {
   
    
   
    
    var coordinateDelegate: CoordinatorDelegate?
    
    func currentPageIndex(index: Int) {
       
        coordinateDelegate?.currentPageIndex(index: index)
    }
   
    
    func scrollIsMoving(contentOffset: CGPoint) {
        coordinateDelegate?.scrollIsMoving(contentOffset: contentOffset)
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        
        uiView.automaticallyAdjustsScrollIndicatorInsets = false
        uiView.reloadData()
        
    }
    
    
    var _dataModel : [TeslaDataModel]?
 
 
    init(dataModel: [TeslaDataModel]){
        
     
        _dataModel = dataModel
    }
    
    func makeCoordinator() -> Coordinator {
        
        let coord = Coordinator(uiviewRepresentable: self)
        
        coord.coordinateDelegate = self
     
        return coord
    }

    
    
    typealias UIViewType = UICollectionView
    
 
    
  
    
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifer)
        collectionView.isPagingEnabled = true
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.contentInset = .init(top: -20, left: 0, bottom: 0, right: 0)
        return collectionView
    }
    
    
    
}

class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    var coordinateDelegate: CoordinatorDelegate?
    
    var _uiviewRepresentable : CollectionViewUIViewRepresentable?
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
     
        coordinateDelegate?.currentPageIndex(index: Int(scrollView.contentOffset.y / scrollView.frame.size.height))
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        coordinateDelegate?.scrollIsMoving(contentOffset: scrollView.contentOffset)
    }
    init(uiviewRepresentable: CollectionViewUIViewRepresentable) {
        _uiviewRepresentable = uiviewRepresentable
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (_uiviewRepresentable?._dataModel!.count)!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifer, for: indexPath) as! CustomCell
        cell.setupImage(teslaDataModel: (_uiviewRepresentable?._dataModel![indexPath.row])!)
        return cell
    }
    

    
    
}

class CustomCell : UICollectionViewCell {
    
    static let identifer = "CustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
    }
    
    let imageView = UIImageView()
    
    func setupImage(teslaDataModel : TeslaDataModel) {
        
        imageView.image = UIImage(data: teslaDataModel.image.jpegData(compressionQuality: 0.5)!)!
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



struct CustomImageView : UIViewRepresentable {
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.layoutIfNeeded()
    }
    
    typealias UIViewType = UIImageView
    
    var _image = UIImage()
    
    init(image: UIImage) {
        _image = image
    }
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        imageView.image = _image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    
}


