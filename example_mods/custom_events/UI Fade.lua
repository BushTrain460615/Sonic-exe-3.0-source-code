local Easing = ''
local duration = 0
local target = ''

local commaStart = 0
local commaEnd = 0
function onEvent(name, value1, value2)
	if name == 'UI Fade' then

            if string.find(value1,',',0,true) ~= nil then
                  
                  commaStart,commaEnd = string.find(value1,',',0,true)
                  Easing = string.sub(value1,commaEnd + 1)
                  target = string.sub(value1,0,commaEnd - 1)
            else

                  target = value1
		      Easing = 'quartOut'
            end
		duration = tonumber(value2)
            if duration == 0 then
                  duration = 0.001
            end
            for strumLineLength = 0,7 do
                  noteTweenAlpha('byeNotes'..strumLineLength, strumLineLength, target, duration, Easing);
            end
            doTweenAlpha('hpBar', 'healthBar', target, duration, Easing)
            doTweenAlpha('hpicon1', 'iconP1', target, duration,Easing)
            doTweenAlpha('hpicon2', 'iconP2', target, duration, Easing)
            doTweenAlpha('score', 'scoreTxt', target, duration, Easing)
            doTweenAlpha('timeBar', 'timeBar', target, duration, Easing)
            doTweenAlpha('timeBarTxt', 'timeTxt', target, duration, Easing)
            doTweenAlpha('botplytxt', 'botplayTxt', target, duration, Easing)
	end
end