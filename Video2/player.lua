local PLAYER_SPEED = 300
local LEFT_OFFSET = 47
local RIGHT_OFFSET = 47
local PLAYER_Y = 378

local Player = {
	_y = PLAYER_Y,
	_is_right = true,
}

function Player:new(image)
	local newPlayer = {}
	newPlayer._image = image
	newPlayer._width, newPlayer._height = image:getDimensions()
	self._x = (love.graphics.getWidth() - newPlayer._width) / 2
	setmetatable(newPlayer, { __index = self })
	return newPlayer
end

function Player:left()
	return self._x + LEFT_OFFSET
end

function Player:right()
	return self._x + self._width - RIGHT_OFFSET
end

function Player:update(dt)
	if love.keyboard.isDown("left") then
		self._is_right = false
		self._x = self._x - PLAYER_SPEED * dt
		if self:left() < 0 then
			self._x = -LEFT_OFFSET
		end
	end
	if love.keyboard.isDown("right") then
		self._is_right = true
		self._x = self._x + PLAYER_SPEED * dt
		if self:right() > love.graphics.getWidth() then
			self._x = love.graphics.getWidth() + RIGHT_OFFSET - self._width
		end
	end
end

function Player:draw()
	if self._is_right then
		love.graphics.draw(self._image, self._x, self._y, 0, 1, 1)
	else
		love.graphics.draw(self._image, self._x + self._width, self._y, 0, -1, 1)
	end
end

return Player
