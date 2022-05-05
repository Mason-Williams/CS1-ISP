import Scenes
import Igis
/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler{

    let ball = Ball()
    let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:100)))
    let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:100)))
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: ball, at: .front)
        ball.changeVelocity(velocityX: 6, velocityY: 10)

        insert(entity: paddleLeft, at: .front)
        insert(entity: paddleRight, at: .front)

    }
    override func preSetup(canvasSize: Size, canvas: Canvas) {
        //let canvasBoundingRect = Rect(size:canvasSize)
        paddleLeft.move(to:Point(x: 10, y: canvasSize.center.y))
        paddleRight.move(to:Point(x: canvasSize.width - 20, y: canvasSize.center.y))


        dispatcher.registerKeyDownHandler(handler: self)
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

        print(key)
        if key == "ArrowDown" {

            paddleRight.rectangle.rect.topLeft.y += 10

        }
        else if key == "ArrowUp" {

            paddleRight.rectangle.rect.topLeft.y -= 10
        }

        else if key == "w" {
            paddleLeft.rectangle.rect.topLeft.y -= 10
        }

        else if key == "s" {
            paddleLeft.rectangle.rect.topLeft.y += 10
        }
    }




    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }

    override func preCalculate(canvas:Canvas) {
        
        let ballBoundingRect = ball.boundingRect()
        let leftPaddleBoundingRect = paddleLeft.boundingRect()
        let leftPaddleContainment = leftPaddleBoundingRect.containment(target: ballBoundingRect)
        let leftPaddleTargetContainmentSet : ContainmentSet = [.overlapsRight, .contact]
        
        if leftPaddleTargetContainmentSet.isSubset(of: leftPaddleContainment) {
            ball.velocityX = -ball.velocityX
            print("left paddle impacted")
        }
        let rightPaddleBoundingRect = paddleRight.boundingRect()
        let rightPaddleContainment = rightPaddleBoundingRect.containment(target: ballBoundingRect)
        let rightPaddleTargetContainmentSet : ContainmentSet = [.overlapsLeft, .contact]
        if rightPaddleTargetContainmentSet.isSubset(of: rightPaddleContainment) {
            ball.velocityX = -ball.velocityX
            print("right paddle impacted")
        }
        
    }
}

   
