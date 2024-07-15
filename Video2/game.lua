local Player = require("player")

local Game = {}

function Game:load()
	-- Load Game Graphics.
	self.backgroundImage = love.graphics.newImage("images/background.png")
	self.playerImage = love.graphics.newImage("images/player.png")

	-- Create Player objects.
	self.player = Player:new(self.playerImage)
end

function Game:update(dt)
	self.player:update(dt)
end

function Game:draw()
	love.graphics.draw(self.backgroundImage)
	self.player:draw()
end

return Game
