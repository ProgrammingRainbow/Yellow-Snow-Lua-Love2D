local FLAKE_SPEED = 300
local GROUND_HEIGHT = 550

local Flake = {}

function Flake:new(image, is_white)
	local newFlake = {}
	newFlake._image = image
	newFlake._is_white = is_white
	newFlake._width, newFlake._height = image:getDimensions()
	setmetatable(newFlake, { __index = self })
	return newFlake
end

function Flake:reset(full)
	if full then
		self._y = -self._height - math.random(0, love.graphics.getHeight() * 2)
	else
		self._y = -self._height - math.random(0, love.graphics.getHeight())
	end
	self._x = math.random(0, (love.graphics.getWidth() - self._width))
end

function Flake:bottom()
	return self._y + self._height
end

function Flake:left()
	return self._x
end

function Flake:right()
	return self._x + self._width
end

function Flake:is_white()
	return self._is_white
end

function Flake:update(dt)
	self._y = self._y + FLAKE_SPEED * dt
	if self:bottom() > GROUND_HEIGHT then
		self:reset(false)
	end
end

function Flake:draw()
	love.graphics.draw(self._image, self._x, self._y)
end

return Flake
