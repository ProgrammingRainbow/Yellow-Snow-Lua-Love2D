local Game = require("game")

function love.load()
	Game:load()
end

function love.update() end

function love.draw()
	Game:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
