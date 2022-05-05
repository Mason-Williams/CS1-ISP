import Igis
import Scenes

class ScoreBoard: RenderableEntity {
    var rectangle: Rectangle
    var score: Text
    var currentScore = 0

    init(rect:Rect) {
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
        score = Text(location: Point(x:500,y:50), text:"")
        score.font = "10pt Arial"
        super.init(name:"ScoreBoard")
    }

    public func incrementScore() {
        currentScore += 1
    }

    override func render(canvas:Canvas) {
        let strokeStyle = StrokeStyle(color:Color(.blue))
        let lineWidth = LineWidth(width:5)
        score = Text(location: Point(x:500,y:50), text:"\(currentScore)")
        score.font = "50pt Arial"
        canvas.render(strokeStyle,lineWidth,score)
    }

    func move(to point:Point) {
        rectangle.rect.topLeft = point
    }

    override func boundingRect() -> Rect {
        return rectangle.rect
    }

    override func calculate(canvasSize:Size) {
        score.text = "\(currentScore)"
    }

}
