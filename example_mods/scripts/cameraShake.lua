local enableShake = true
local dadCharacters = {'ycr','ycr-mad','scorched','FakerExe'}
function opponentNoteHit()
    if enableShake == true then
        for dadLength = 1,#dadCharacters do
            if getProperty('dad.curCharacter') == dadCharacters[dadLength] then
                cameraShake('camGame',0.005,0.1)
                cameraShake('camHUD',0.003,0.1)
            end
        end
    end
end
function onStepHit()
    if songName == 'manual-blast' then
        if curStep == 4979 then
            enableShake = false
        end
    end
end