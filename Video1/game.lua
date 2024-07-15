local Game = {}

function Game:load()
	-- Load Game Graphics.
	self.backgroundImage = love.graphics.newImage("images/background.png")
end

function Game:draw()
	love.graphics.draw(self.backgroundImage)
end

return Game
