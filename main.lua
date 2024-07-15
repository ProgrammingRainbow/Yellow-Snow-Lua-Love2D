local Game = require("game")

function love.load()
	Game:load()
end

function love.update(dt)
	Game:update(dt)
end

function love.draw()
	Game:draw()
end

function love.keypressed(k)
	if k == "escape" then
		love.event.quit()
	elseif k == "space" and not Game:is_playing() then
		Game:reset()
	elseif k == "m" then
		Game:pause_music()
	end
end
