function love.load()
    target = {}
    target.x = math.random(30, love.graphics.getWidth())
    target.y = math.random(30, love.graphics.getHeight())
    target.radius = 50
    target.time = 30
    target.hitCircle = 250

    nextTarget = {}
    nextTarget.x = math.random(30, love.graphics.getWidth())
    nextTarget.y = math.random(30, love.graphics.getHeight())
    nextTarget.radius = 50
    nextTarget.time = 30
    nextTarget.hitCircle = 250    

    score = 0
    timer = 0

    gameFont = love.graphics.newFont(40)

    hitSound = love.audio.newSource( 'sounds/drum-hitclap.wav', 'static')

end

function love.update(dt)
    -- do ifs for every level with diferents values

    target.time = target.time - 1
    target.hitCircle = target.hitCircle - 0.6

    if love.keyboard.isDown( "z" , "x" ) and (target.hitCircle > target.radius and target.hitCircle < 85) then
        local mouseToTarget = distanceBetween(love.mouse.getX(), love.mouse.getY(), target.x ,target.y)
        if mouseToTarget < target.radius then
            hitTarget()
        end
    end
end

function love.draw()

    --score
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0, 0)

    --next target
    love.graphics.setColor(1,1,1) 
    love.graphics.circle('fill', nextTarget.x, nextTarget.y, nextTarget.radius)  

    if target.time > 0 then
        --current target
        love.graphics.setColor(1,0,0)
        love.graphics.circle('fill', target.x, target.y, target.radius)   

        if target.hitCircle > target.radius then
            if target.hitCircle > 85 then
                love.graphics.setColor(1,1,1) 
                love.graphics.circle('line', target.x, target.y, target.hitCircle)    
            else
                love.graphics.setColor(0,1,0) 
                love.graphics.circle('line', target.x, target.y, target.hitCircle)    
            end
        end
    else
        target.time = 400
        target.hitCircle = 250
        moveTarget()
        score = 0
    end

end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 and (target.hitCircle > target.radius and target.hitCircle < 85) then
        local mouseToTarget = distanceBetween(x, y, target.x ,target.y)
        if mouseToTarget < target.radius then
            hitTarget()
        end
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end

function hitTarget()
    score = score + 1
    moveTarget()
    love.audio.play( hitSound )
    target.time = 400
    target.hitCircle = 250
end

function moveTarget()
    target = nextTarget

    nextTarget.x = math.random(30, love.graphics.getWidth())
    nextTarget.y = math.random(30, love.graphics.getHeight())
    nextTarget.radius = 50
    nextTarget.time = 30
    nextTarget.hitCircle = 250    
end

