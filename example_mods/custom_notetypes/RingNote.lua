local ringCounter = 0
function onCreate()
    for i = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i,'noteType') == 'RingNote' then
            setPropertyFromGroup('unspawnNotes', i,'texture','RingNote')
            setPropertyFromGroup('unspawnNotes', i,'noAnimation',true)
            setPropertyFromGroup('unspawnNotes', i,'ignoreNote',true)
        end
    end
    makeLuaSprite('RingCounterImage','Counter',1100,600)
    setObjectCamera('RingCounterImage','hud')
    addLuaSprite('RingCounterImage',true)

    makeLuaText('RingCounterText',ringCounter,100,getProperty('RingCounterImage.x') + 230,getProperty('RingCounterImage.y') + 15)
    setObjectCamera('RingCounterText','hud')
    setProperty('RingCounterText.scale.x',4)
    setProperty('RingCounterText.scale.y',4)
    setProperty('RingCounterText.antialiasing',false)
    setTextAlignment('RingCounterText','left')
    setTextColor('RingCounterText','FFCC33')
    setTextBorder('RingCounterText',1,'CC6700')
    addLuaText('RingCounterText')
end
function goodNoteHit(id,data,noteType,sus)
    if noteType == 'RingNote' then
        playSound('Ring')
        ringCounter = ringCounter + 1
        setTextString('RingCounterText',ringCounter)
    end
    if ringCounter > 0 then
        if getPropertyFromGroup('notes',id,'hitHealth') < 0 then
            setProperty('health',getProperty('health') + (getPropertyFromGroup('notes',id,'hitHealth') * -1))
            ringCounter = ringCounter - 1
        end
        if getPropertyFromGroup('notes',id,'hitCausesMiss') == true then
            setProperty('health',getProperty('health') + math.abs(getPropertyFromGroup('notes',id,'hitHealth')))
            ringCounter = ringCounter - 1
        end
    end
end

function noteMiss(id,data,noteType,sus)
    if getPropertyFromGroup('notes',id,'ignoreNote') == false and ringCounter > 0 then
        ringCounter = ringCounter - 1
        setProperty('songMisses',getProperty('songMisses') - 1)
        setTextString('RingCounterText',ringCounter)
        RecalculateRating()
        if getPropertyFromGroup('notes',id,'hitHealth') > 0 then
            setProperty('health',getProperty('health') + getPropertyFromGroup('notes',id,'hitHealth'))
        end
    end
end