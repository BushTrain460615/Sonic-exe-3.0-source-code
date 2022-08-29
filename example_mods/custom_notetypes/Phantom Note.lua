local phantomTime = {}
local currentPos = 1

function onCreate()
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'Phantom Note' then
            setPropertyFromGroup('unspawnNotes', i,'texture','PHANTOMNOTE_assets')
            setPropertyFromGroup('unspawnNotes', i,'ignoreNote',true)
        end
    end
end
function onBeatHit()
    for phantomLenght = 1,#phantomTime do
        if phantomTime[phantomLenght] ~= nil then
            if phantomTime[phantomLenght] > 0 then
                phantomTime[phantomLenght] = phantomTime[phantomLenght] - 0.01
                setProperty('health',getProperty('health') - 0.023)
            elseif phantomTime[phantomLenght] <= 0 then
                table.remove(phantomTime,phantomLenght)
                currentPos = phantomLenght
            end
        end
    end
end
function goodNoteHit(id,data,noteType,sustain)
    if noteType == 'Phantom Note' then
        table.insert(phantomTime,currentPos,0.5)
        currentPos = currentPos + 1
    end
end