function onCreate()
	-- background shit
	makeLuaSprite('Sunshine', 'Sunshine', -600, -300);
	setScrollFactor('Sunshine', 0.9, 0.9);

	addLuaSprite('Sunshine', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end