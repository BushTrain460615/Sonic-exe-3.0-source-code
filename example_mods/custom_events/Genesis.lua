local ChangedCharacter = false

local enableChange = true
local enableGF = true

local dadCharacter = 'pixelrunsonic'
local bfCharacter = 'bfpickel-new'
local gfCharacter = 'gf-pixel'

local curDadCharacter = nil
local curBFCharacter = nil
local curGFCharacter = nil

local changeNotes = 0

local curZoom = 0

local bfX = 0
local bfY = 0

local dadX = 0
local dadY = 0

local gfX = 0
local gfY = 0
function onCreate()
    if songName == 'you-cant-run-encore' then
        dadCharacter = 'pixelrunsonic-new'
    end
end
function onCreatePost()
    addCharacterToList(bfCharacter,'boyfriend')
    addCharacterToList(dadCharacter,'dad')
    if enableGF == true then
        addCharacterToList(gfCharacter,'gf')
    end
    precacheImage('run/GreenHill')
    precacheImage('StaticPixel')
    makeLuaSprite('greenHill','run/GreenHill',-350,-650)
    setProperty('greenHill.antialiasing',false)
    scaleObject('greenHill',8.2,8.2)
    addLuaScript('greenHill')
    addLuaScript('custom_events/static')
end
function onUpdate()
    if changeNotes == 2 then
        for notesLength = 0,getProperty('notes.length') do
            if getPropertyFromGroup('notes',notesLength,'noteType') == '' and getPropertyFromGroup('notes',notesLength,'texture') ~= 'PIXELNOTE_assets' then
                setPropertyFromGroup('notes',notesLength,'texture','PIXELNOTE_assets')
            end
        end
    elseif changeNotes == 1 then
        for notesLength = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes',notesLength,'noteType') == '' then
                setPropertyFromGroup('notes',notesLength,'texture','')
            end
        end
        changeNotes = 0
    end
    if ChangedCharacter == false and enableChange == true then
        bfX = getProperty('boyfriend.x')
        bfY = getProperty('boyfriend.y')
        dadX = getProperty('dad.x')
        dadY = getProperty('dad.y')
        curDadCharacter = getProperty('dad.curCharacter')
        curBFCharacter = getProperty('boyfriend.curCharacter')
        curZoom = getProperty('defaultCamZoom')
        if enableGF == true then
            gfX = getProperty('gf.x')
            gfY = getProperty('gf.y')
            curGFCharacter = getProperty('gf.curCharacter')
        end
    end

end
function onEvent(name,v1)
    if name == 'Genesis' then
        if string.lower(v1) ~= 'false' then
            changeNotes = 2
            ChangedCharacter = true
            if enableChange == true then
                triggerEvent('Change Character','bf',bfCharacter)
                triggerEvent('Change Character','dad',dadCharacter)

            end
            setProperty('defaultCamZoom',1)
            setProperty('greenHill.x',getProperty('boyfriend.x') - 1400)
            setProperty('greenHill.y',getProperty('boyfriend.y') - 850)
            addLuaSprite('greenHill')
            setProperty('boyfriend.x',getProperty('greenHill.x') + 1100 +  getProperty('boyfriend.positionArray[0]'))
            setProperty('boyfriend.y',getProperty('greenHill.y') + 250 + getProperty('boyfriend.positionArray[1]'))

            setProperty('dad.x',getProperty('greenHill.x') + 450 + getProperty('dad.positionArray[0]'))
            setProperty('dad.y',getProperty('greenHill.y') + 250 +  getProperty('dad.positionArray[1]'))
            triggerEvent('static','true','')
            runTimer('changeNotesSonic',0.2)
            if enableGF == true then
                triggerEvent('Change Character','gf',gfCharacter)
                setProperty('gf.x',getProperty('greenHill.x') + 700 + getProperty('gf.positionArray[0]'))
                setProperty('gf.y',getProperty('greenHill.y') + 300 + getProperty('gf.positionArray[1]'))
            end
        else
            changeNotes = 1
            triggerEvent('static','false','')
            removeLuaSprite('greenHill',false)
            setProperty('defaultCamZoom',curZoom)
            triggerEvent('Change Character','bf',curBFCharacter)
            triggerEvent('Change Character','dad',curDadCharacter)
            if enableGF == true then
                triggerEvent('Change Character','gf',curGFCharacter)
                setProperty('gf.x',gfX)
                setProperty('gf.y',gfY)
            end
            setProperty('boyfriend.x',bfX)
            setProperty('boyfriend.y',bfY)
            setProperty('dad.x',dadX)
            setProperty('dad.y',dadY)
            runTimer('backCharacter',0.1)
            runTimer('backNotesSonic',0.2)

        end
    end
end
function onTimerCompleted(tag)
    if tag == 'backCharacter' then
        ChangedCharacter = false
    end
    if tag == 'changeNotesSonic' then
        for strumLineNotes = 0,7 do
            setPropertyFromGroup('strumLineNotes',strumLineNotes,'texture','PixelNOTE_assets')
        end
    end
    if tag == 'backNotesSonic' then
        for strumLineNotes = 0,7 do
            setPropertyFromGroup('strumLineNotes',strumLineNotes,'texture','NOTE_assets')
        end
    end
end