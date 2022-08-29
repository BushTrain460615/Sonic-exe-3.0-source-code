local zooming = false
local currentTarget = 0
function onEvent(name,value1,value2)
    if name == "Set Cam Zoom" then
		local easing = 'sineInOut'
		local easingStart = 0
		local easingEnd = 0
		local duration = 0

		local easings = {'quart','quint','sine','linear','bounce','back','circ','cube','elastic','expo','quad','smoothStep'}

		local textStringStart = 0
		local textStringLast = 0
		textStringStart,textStringLast = string.find(value2,value2)
		if string.find(value2,',',0,true) ~= nil then
			easingStart,easingEnd = string.find(value2,',',textStringStart,true)
			easing = string.sub(value2,easingEnd + 1)
			if string.sub(value2,0,easingStart - 1) ~= string.sub(value2,textStringLast - 1,textStringLast) then
				duration = string.sub(value2,0,easingStart - 1)
			else
				duration = 0.8
			end
		else
			for easingsLength = 1,#easings do
				if string.find(string.lower(value2),easings[easingsLength],0,true) ~= nil then
					easing = value2
				else
					easing = 'sineInOut'
				end
			end
			if tonumber(value2) == nil then
				duration = 0.8
			else
				duration = tonumber(value2)
			end
		end
		currentTarget = value1
		doTweenZoom('camz','camGame',value1,duration,easing)
		zooming = true
    elseif name == 'Add Camera Zoom' and zooming == true and currentTarget ~= 0 then
		setProperty('camGame.zoom',getProperty('camGame.zoom') - value1)
	end
end
function onBeatHit()
	if curBeat % 4 == 0 and getProperty('camZooming') == true and zooming == true and currentTarget ~= 0 then
		setProperty('camGame.zoom',getProperty('camGame.zoom') - 0.015)
	end
end
function onTweenCompleted(name)
	if name == 'camz' then
		zooming = false
		currentTarget = 0
    	setProperty("defaultCamZoom",getProperty('camGame.zoom'))
	end
end