import Igis
import Scenes
import Foundation


class Ball: RenderableEntity, MouseMoveHandler {
    let ellipse = Ellipse(center:Point(x:0, y:0), radiusX:30, radiusY:30, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.orange))
    let fillStyle = FillStyle(color:Color(.red))
    let lineWidth = LineWidth(width:5)

    var velocityX : Int
    var velocityY : Int

    var targetVelocityX: Double
    var targetVelocityY: Double

    var targetRadius: Int
    let scoreLeft: Text
    let scoreRight: Text
    var currentScoreLeft = 0
    var currentScoreRight = 0
    
    

    init() {
        // Using a meaningful name can be helpful for debugging
        velocityX = 0
        velocityY = 0

        targetVelocityX = 0
        targetVelocityY = 0

        targetRadius = ellipse.radiusX
        scoreLeft = Text(location:Point(x:100,y:100), text:"")
        scoreLeft.font = "34pt Arial"
        scoreRight = Text(location:Point(x:100,y:100), text:"")
        scoreRight.font = "34pt Arial"
        
        super.init(name:"Ball")
    }

        override func setup(canvasSize: Size, canvas: Canvas) {
            // Position the ellipse at the center of the canvas
            ellipse.center = canvasSize.center
            dispatcher.registerMouseMoveHandler(handler:self)
        }

        override func teardown() {
            dispatcher.unregisterMouseMoveHandler(handler:self)
        }
        
        override func render(canvas:Canvas) {
            canvas.render(strokeStyle, fillStyle, lineWidth, ellipse)
        
        }

        func onMouseMove(globalLocation: Point, movement: Point) {
            ellipse.center = globalLocation
        }

        override func boundingRect() -> Rect {
            return Rect(topLeft: Point(x: ellipse.center.x - 30, y: ellipse.center.y - 30), size:Size(width: 60, height: 60))
        }

        func changeVelocity(velocityX:Int, velocityY:Int) {
            self.velocityX = velocityX
            self.velocityY = velocityY
        }

        override func calculate(canvasSize: Size) {
            ellipse.center += Point(x: velocityX, y: velocityY)
            // Form a bounding rectangle around the canvas
            let canvasBoundingRect = Rect(size:canvasSize)

            // Form a bounding rect around the ball (ellipse)
            let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY),
                                        size:Size(width:ellipse.radiusX*2, height:ellipse.radiusY*2))

            // Determine if we've moved outside of the canvas boundary rect
            let tooFarLeft = ballBoundingRect.topLeft.x < canvasBoundingRect.topLeft.x
            let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width > canvasBoundingRect.topLeft.x + canvasBoundingRect.size.width

            let tooFarUp = ballBoundingRect.topLeft.y < canvasBoundingRect.topLeft.y
            let tooFarDown = ballBoundingRect.topLeft.y + ballBoundingRect.size.height > canvasBoundingRect.topLeft.y + canvasBoundingRect.size.height

              // If we're too far to the left or right, we bounce the x velocity
              if tooFarLeft || tooFarRight {
                  velocityX = -velocityX*3
                  ellipse.radiusX /= 2
              }
              if velocityX < -3 {
                  velocityX += 1
              } else if velocityX > 3 {
                  velocityX -= 1
              }

              if ellipse.radiusX < 30 {
                  ellipse.radiusX += 1
              }

             
            // If we're too far to the top or bottom, we bound the y velocity
              if tooFarUp || tooFarDown {
                  velocityY = -velocityY*3
                  ellipse.radiusY /= 2
              
              }
              if velocityY < -5 {
                  velocityY += 1
              } else if velocityY > 5 {
                  velocityY -= 1
              }

              if ellipse.radiusY < 30 {
                  ellipse.radiusY += 1
              }

              
        }
        }

