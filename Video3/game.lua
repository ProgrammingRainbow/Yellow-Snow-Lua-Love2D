local Player = require("player")
local Flake = require("flake")

local Game = {}

function Game:load()
	math.randomseed(os.time())

	-- Load Game Graphics.
	self.backgroundImage = love.graphics.newImage("images/background.png")
	self.playerImage = love.graphics.newImage("images/player.png")
	self.whiteImage = love.graphics.newImage("images/white.png")
	self.yellowImage = love.graphics.newImage("images/yellow.png")

	-- Create Player object.
	self.player = Player:new(self.playerImage)

	-- Generate list of flakes.
	self.flakes = {}
	for _ = 1, 10 do
		local flake = Flake:new(self.whiteImage, true)
		flake:reset(true)
		table.insert(self.flakes, flake)
	end
	for _ = 1, 5 do
		local flake = Flake:new(self.yellowImage, false)
		flake:reset(true)
		table.insert(self.flakes, flake)
	end
end

function Game:update(dt)
	self.player:update(dt)
	for _, flake in ipairs(self.flakes) do
		flake:update(dt)
	end
end

function Game:draw()
	love.graphics.draw(self.backgroundImage)
	self.player:draw()
	for _, flake in ipairs(self.flakes) do
		flake:draw()
	end
end

return Game
