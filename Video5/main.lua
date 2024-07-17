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

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "space" and not Game:isPlaying() then
		Game:reset()
	elseif key == "m" then
		Game:pauseMusic()
	end
end
