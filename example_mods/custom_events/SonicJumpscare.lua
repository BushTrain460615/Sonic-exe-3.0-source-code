function onCreatePost()
    makeLuaSprite('SonicJumpscare0','simplejump',0,0)
    setObjectCamera('SonicJumpscare0','other')
    scaleObject('SonicJumpscare0',0.7,0.7)

    makeLuaSprite('SonicJumpscare1','JUMPSCARES/Tails',0,0)
    setObjectCamera('SonicJumpscare1','other')
    makeLuaSprite('SonicJumpscare2','JUMPSCARES/Knuckles',0,0)
    setObjectCamera('SonicJumpscare2','other')
    makeLuaSprite('SonicJumpscare3','JUMPSCARES/Eggman',0,0)
    setObjectCamera('SonicJumpscare3','other')

    makeAnimatedLuaSprite('FlashingShit','daSTAT',0,0)
    addAnimationByPrefix('FlashingShit','glitch','staticFLASH',24,true)
    setProperty('FlashingShit.alpha',0.3)
    scaleObject('FlashingShit',3.2,2.45)
    setObjectCamera('FlashingShit','other')
    for JUMPSCARES = 0,3 do
        addLuaSprite('SonicJumpscare'..JUMPSCARES,true)
        setProperty('SonicJumpscare'..JUMPSCARES..'.alpha',0)
    end
end
function onEvent(name,v1)
    if name == 'SonicJumpscare' then
        setProperty('SonicJumpscare'..v1..'.alpha',0.95)
        cameraShake('game',0.04,0.6)
        runTimer('destroyJumpscare'..v1,0.1)
        if tonumber(v1) == 0 then
            playSound('sppok')
        elseif tonumber(v1) == 1 then
            playSound('P3Jumps/TailsScreamLOL',0.1)
        elseif tonumber(v1) == 2 then
            playSound('P3Jumps/KnucklesScreamLOL',0.15)
        elseif tonumber(v1) == 3 then
            playSound('P3Jumps/EggmanScreamLOL',0.1)
        end
        if tonumber(v1) ~= 0 then
            doTweenX('HelloJumpscareX'..v1,'SonicJumpscare'..v1..'.scale',1.1,0.1,'linear')
            doTweenY('HelloJumpscareY'..v1,'SonicJumpscare'..v1..'.scale',1.1,0.1,'linear')
        end
        runTimer('destroyFlashShit',0.2)
        addLuaSprite('FlashingShit',true)
        setObjectOrder('FlashingShit',getObjectOrder('SonicJumpscare'..v1) + 1)

    end
end

function onTimerCompleted(tag)
    if string.match(tag,'destroyJumpscare') == 'destroyJumpscare' and tag ~= 'destroyJumpscare0' then
        for JUMPSCARES = 1,3 do
            if tag == 'destroyJumpscare'..JUMPSCARES then
                doTweenAlpha('ByeJumpscareAlpha'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES,0,0.1,'linear')
                doTweenX('ByeJumpscareX'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES..'.scale',1,0.1,'linear')
                doTweenY('ByeJumpscareY'..JUMPSCARES,'SonicJumpscare'..JUMPSCARES..'.scale',1,0.1,'linear')
            end
        end
    elseif tag == 'destroyJumpscare0' then
        removeLuaSprite('SonicJumpscare0',false)

    elseif tag == 'destroyFlashShit' then
        removeLuaSprite('FlashingShit',false)
    end
end