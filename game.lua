local Player = require("player")
local Flake = require("flake")

local Game = {
	_is_playing = true,
	_music_paused = false,
	_score = 0,
}

function Game:load()
	math.randomseed(os.time())

	-- Load Game Graphics.
	self.backgroundImage = love.graphics.newImage("images/background.png")
	self.playerImage = love.graphics.newImage("images/player.png")
	self.whiteImage = love.graphics.newImage("images/white.png")
	self.yellowImage = love.graphics.newImage("images/yellow.png")

	-- Load Game Sounds.
	self.collect = love.audio.newSource("sounds/collect.ogg", "static")
	self.hit = love.audio.newSource("sounds/hit.ogg", "static")
	self.music = love.audio.newSource("music/winter_loop.ogg", "stream")

	-- Load and set font.
	self.font = love.graphics.newFont("fonts/freesansbold.ttf", 24)
	love.graphics.setFont(self.font)

	-- Create Player objects.
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

	-- Play background music on repeat.
	self.music:setLooping(true)
	self.music:play()
end

function Game:isPlaying()
	return self._is_playing
end

function Game:reset()
	self._score = 0
	for _, flake in ipairs(self.flakes) do
		flake:reset(true)
	end
	self._is_playing = true
	if not self._music_paused then
		self.music:play()
	end
end

function Game:checkCollision(flake)
	if
		flake:bottom() > self.player.top()
		and flake:right() > self.player:left()
		and flake:left() < self.player:right()
	then
		if flake:isWhite() then
			self.collect:clone():play()
			self._score = self._score + 1
			flake:reset(false)
		else
			self.music:stop()
			self.hit:clone():play()
			self._is_playing = false
		end
	end
end

function Game:pauseMusic()
	if self.music:isPlaying() then
		self._music_paused = true
		self.music:pause()
	else
		self._music_paused = false
		if self._is_playing then
			self.music:play()
		end
	end
end

function Game:update(dt)
	if self:isPlaying() then
		self.player:update(dt)
		for _, flake in ipairs(self.flakes) do
			flake:update(dt)
			self:checkCollision(flake)
		end
	end
end

function Game:draw()
	love.graphics.draw(self.backgroundImage)
	self.player:draw()
	for _, flake in ipairs(self.flakes) do
		flake:draw()
	end
	love.graphics.print("Score: " .. math.floor(self._score), 10, 10)
end

return Game
