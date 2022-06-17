# 다양한 어플을 하나로 묶어 하나의 앱을 만들기

**이 앱은 첫 화면 아랫부분에는 세 개의 탭이 있고 [계산기]탭를 선택하면 사칙연산이 가능한 계산기 화면이 나옵니다.**  
**또한 [명언]탭을 선택하면 버튼을 클릭해 랜덤으로 명언을 보여줍니다. 그리고 초기 화면의 [그림판]탭을 선택하면 첫화면으로 이동할 수 있습니다.**

*상황에 따라 하나의 뷰가 아니라 다양한 내용, 즉 여러 개의 뷰를 보여 줄 때가 더 많기 때문에 이를 위해 여러 개의 뷰와 더불어 뷰를 선택해 이동할 수 있게 해주는 컨트롤러가 필요합니다.*
*그 역할을 하는 것이 바로 탭 바 컨트롤러입니다. 이러한 탭 바를 이용하는 대표적인 앱에는 아이폰의 시계, 음악, 전화 앱이 있습니다.*
*예시로 탭 바 컨트롤러를 이용해 시계라는 큰 앱을 탭 세계 시계, 알람, 스톰워치, 타이머 탭으로 구분하여 상황에 맞게 사용할 수 있습니다.* 


> 각각의 탭을 선택할 때마다 다른 화면을 볼 수 있을 뿐만 아니라 화면을 이동할 때도 탭을 선택하면 되므로 쉽게 여러개의 화면을 넣기 위해 탭 바 컨트롤러를 이용했습니다.  
> 탭 바를 사용하깊위해 탭 바 컨트롤러를 추가하고 기본뷰를 추가하고 기본 뷰를 추가한 후 기본 뷰의 탭바를 삭제 한 뒤 앱을 키면 그림판이 막바로 나오도록 그림판을 연결시켜주었습니다. 
> 시뮬레이터는 [iPhone 13 Pro]를 이용했지만 자동 레이아웃(Auto Layout)을 설정해 기기의 디스플레이 크기와 관계없이 동일한 레이아웃을 구현하는 기능을 추가했습니다. 
> C언어를 참고해 프로그램을 만들었습니다.

***

* 그림판

```
    var lastPoint: CGPoint!
    var lineSize: CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
```
바로 전에 터치하거나 이동한 위치를 선언합니다.
선의 두께를 2.0으로 설정합니다.
선의 색상을 빨간색으로 설정합니다.

```
@IBAction func btnLineBlack(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
    }
    
    @IBAction func btnLineRed(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
    }
    
    @IBAction func btnLineGreen(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
    }
    
    @IBAction func btnLineBule(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
    }
    
    @IBAction func btnLineWidth(_ sender: UIButton) {
        lineSize = CGFloat((txfLineWidth.text! as NSString).floatValue)
    }
    
```
검정, 빨강, 초록, 파랑 색상 추가하고 두께 기능을 설정합니다.

```
    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
```
이미지 뷰의 이미지를 삭제합니다.

```
        let touch = touches.first! as UITouch
        lastPoint = touch.location(in: imgView)
```
현재 발생한 터치 이벤트를 가지고 옵니다.
터치된 위치를 lastPoint에 할당합니다.

```
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        lastPoint = currPoint
```
그림을 그리기 위한 콘텍스트 생성합니다.  
선 색상을 설정합니다.    
선 끝 모양을 라운드로 설정합니다.   
선 두께를 설정합니다.    
현재 발생한 터치 이벤트를 가지고 옵니다. 
터치된 좌표를 currPoint로 가지고 옵니다.
현재 imgView에 있는 전체 이미지를 imgView의 크기로 그립니다.   
lastPoint 위치로 시작 위치를 이동합니다.   
lastPoint에서 currPoint까지 선을 추가합니다.   
추가한 선을 콘텍스트에 그립니다.    
현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 할당합니다.    
그림 그리기를 끝냅니다.   
현재 터치된 위치를 lastPoint라는 변수에 할당합니다. 

```
        if motion == .motionShake {
            imgView.image = nil
        }         
```
폰을 흔드는 모션이 발생하면 이미지 뷰의 이미지를 삭제합니다.    

***

* 계산기

```
    case unknown 
```
어떠한 연산자도 해당하지 않을 때를 대비해 case unknown을 두었습니다.

```
    var displayNumber = "" 
    var firstOperand = "" 
    var secondOperand = "" 
    var result = "" 
    var currentOperation: Operation = .unknown 
```
계산기의 상태값을 가지고 있는 프로퍼티를 만듭니다.  
displayNumber은 계산기가 눌러질 때마다 lblNumberOutput 값을 할당받는 프로퍼티  
firstOperand는 이전 계산값을 저장하는 프로퍼티 (첫 번째 피연산자)    
secondOperand는 새롭게 입력된 값을 저장하는 프로퍼티 (두 번째 피연산자)   
currentOperation: Operation은 현재 어떤 연산자가 입력되었는지 알 수 있게 연산자의 값을 저장하는 프로퍼티로 선언하였습니다.

```
guard let numberValue = sender.title(for: .normal)
  else {
    return
  }
```
버튼을 누르면 계산기에 입력한 숫자를 가져오는 기능을 구현합니다.

```

        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "." 
            self.lblNumberOutput.text = self.displayNumber
```
소수점을 포함하여 9칸까지 작성 가능하게끔 합니다. 더해서 소수점이 중복 입력되지 않게합니다.  
? 앞의 self.displayNumber += self.displayNumber.isEmpty가 참이면 0.을 반환하고, 결값이 거짓이면 .를 반환합니다.

```
    func operation(_ operation: Operation) {
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = "" 
                
                guard let firstOperand = Double(self.firstOperand) 
                else {
                  return
                }
                guard let secondOperand = Double(self.secondOperand)    
                else {
                  return
                  }
                  
                switch currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
```
파라미터로 전달받은 연산자를 계산하고 계산한 결과값을 화면에 표시합니다.
여기서 self.displayNumber = "" 는 또 다음 피연산자를 받기 위해 집어넣었습니다.
Double로 피연산자의 형변환을 시켜줍니다. 
연산자에 따라 첫 번째 피연산자와 두 번째 피연산자 계산합니다.

```
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
```
만약 소수점 아래의 값이 없다면 다시 정수로 형변환을 시켜줍니다.

```         
                self.firstOperand = self.result
                self.lblNumberOutput.text = self.result
```
한 번의 연산이 끝났다면 그 연산의 결과값과 다음 피연산자를 다음 연산자를 가지고 계산을 합니다.  
따라서 첫 번째 연산자 프로퍼티에 결과값을 할당합니다.

```
               self.currentOperation = operation 
```
만약 세 숫자가 들어오면 먼저 들어온 두 숫자를 연산한 후  currentOperation에 .Subtract 할당합니다.

```
                    self.firstOperand = self.displayNumber
                    self.currentOperation = operation
                    self.displayNumber = ""
```
.unknown : 값이 초기화된 상태에서 사용자가 첫 번째 피연산자와 연산자를 입력한 상태입니다.   
만약 1+이라면 firstOperand에 1할당, currentOperation에 .Add 할당합니다.   
self.firstOperand = self.displayNumber는 화면에 표시된 피연산자입니다.
self.currentOperation = operation은 선택한 연산자입니다.
self.displayNumber = ""는 첫 번째 피연산자를 해당 프로퍼티에 할당했으므로 초기화하고. 두 번째 피연산자를 받기 위해 넣었습니다.

***

* 명언

```
let quotes = [
        Quote(contents:"죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다.", name:"벤다이크"),
        Quote(contents:"나는 나 자신을 빼 놓고는 모두 안다.", name:"이용"),
        Quote(contents:"편견이란 실효성이 없는 의견이다.", name:"임브로스 빌"),
        Quote(contents:"죽음을 두려워하는 나머지 삶을", name:"이크"),
        Quote(contents:"시작조차 못하는 사람이 많다.", name:"벤다"),
    ]
```
버튼을 클릭하면 나올 수 있도록 문구와 이름을 지정해 5가지의 명언을 만듭니다.

```
let random = Int(arc4random_uniform(5))
        let quotes_instance = quotes[random]
        self.nameLabel.text = quotes_instance.name
        self.quoteLabel.text = quotes_instance.contents
```
0~4 사이의 난수를 생성합니다.
버튼을 클릭 시 나타날 명언을 랜덤으로 설정합니다.

*** 
    

* 후기
    아이폰에 있는 앱을 모아 하나의 앱을 만들면 어떨까? 라는 생각에서 시작되어 세 개의 앱을 합쳐 하나의 어플리케이션으로 만들었습니다. 표현하고 싶은 부분들이 많았지만 아직은 미숙한지라 엉성하게 만드는 것 밖에 못했습니다. 하지만 게속 수정판을 올려나가면서 하나의 완성된 작품을 만들 수 있는 날까지 노력해야겠다는 마음이 생겼습니다. 그리고 swift가 C언어와 겹치는 부분이 많다고 느꼈습니다. 어플을 제작하는데 제일 어려움을 겪었던 어플은 계산기였습니다. 이런 계산기 하나에 여러 복잡한 코드가 들어간다는 것에 게산기가 대단해 보일 정도입니다. 다른 github 회원분들의 게시글을 보며 저도 자주 어플들을 만들고 접해서 저만의 창작물을 만들어 playstore에 올리고 싶다는 욕심이 생겼습니다.   

* 참고 서적  

  송호정 , 이범근 지음 | 이지스퍼블리싱 | 2021년 01월 26일 출간 Do it! 스위프트로 아이폰 앱 만들기: 입문 개정판 5판  
  송호정 , 이범근 지음 | 이지스퍼블리싱 | 2021년 01월 26일 출간 Do it! 스위프트로 아이폰 앱 만들기: 입개정 6판   
  윤성우 지음 | 오렌지미디어 | 2010년 11월 01일 출간 윤성우의 열혈 C 프로그래밍 개정판  
  
  


