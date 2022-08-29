local changedImage = false
local disableImage = false

local textCreated = false
local circleCreated = false

local counterPos = {{300,230},{300,230},{300,230},{300,230}} -- first value: Three image pos X and Y. Second value: Ready? image x and y. Third value: Set image x and y. Fourth value: GO! image x and y.
local counterScale = {{1,1},{1,1},{1,1},{1,1}}


--[[
    Introducions:
    To change value in the counterPos or counterScale, just need to know that:

        tablePos: 1 = Three
        tablePos: 2 = Two/Ready?
        tablePos: 3 = One/Set?
        tablePos: 4 = Go!

    like this:
    changeCountPos(changeAll:bollean,posX:number,posY:number,tablePos)
    changeCountScale(changeAll:bollean,scaleX:number,scaleY:number,tablePos)

    changeALl = change all values in the array.

    if you want to disable the count down song, just put "-silence" in the first function in changeCountDown(), like that:
        changeCountDown('-silence','',false,false,false,false,1,1,0,0)
--]]
function onCreate()
        if string.lower(songName) ~= 'sanic' and
        string.lower(songName) ~= 'you-cant-run-encore' and
        string.lower(songName) ~= 'chaos'  and
        string.lower(songName) ~= 'soulless-nikocover' and
        string.lower(songName) ~= 'soulless-orycover' and
        string.lower(songName) ~= 'soulless' and
        string.lower(songName) ~= 'fatality' and
        string.lower(songName) ~= 'too-slow-encore' and
        string.lower(songName) ~= 'endless-encore' and
        string.lower(songName) ~= 'sunshine' and
        string.lower(songName) ~= 'sunshine-encore' and
        string.lower(songName) ~= 'milk' and
        string.lower(songName) ~= 'black-sun' and
        string.lower(songName) ~= 'too-fest' and
        string.lower(songName) ~= 'manual-blast' and
        string.find(string.lower(songName),'milk',0,true) == nil and
        string.lower(songName)  ~= 'cycles-encore' then
        startSonicCount(string.lower(songName),string.lower(songName))
        elseif string.lower(songName)  == 'cycles-encore' then
            startSonicCount('cycles','cycles')
        elseif string.lower(songName)  == 'too-slow-encore' then
            startSonicCount('too-slow','too-slow')
        elseif string.lower(songName)  == 'endless-encore' then
            startSonicCount('endless','endless')
        elseif string.lower(songName) == 'you-cant-run-encore' then
            startSonicCount('you-cant-run','you-cant-run')
        elseif string.lower(songName) == 'black-sun' or songName == 'manual-blast' then
            startSonicCount('faker','faker')
        elseif string.lower(songName) == 'fatality' then
            changeCounterPos(true,450,250,1)
            changeCounterScale(true,3,3,1)
            changeCountDown('-Fatal','StartScreens/fatal_',true,true,true,false,false)
        elseif string.lower(songName) == 'sunshine' or string.lower(songName) == 'sunshine-encore' then
            changeCounterPos(false,260,200,2)
            changeCounterPos(false,250,90,4)
            changeCounterScale(false,1.3,1.3,4)
            changeCountDown('-Tails','StartScreens/tails_',true,true,true,false,true)
        elseif string.match(string.lower(songName),'soulless') == 'soulless' then
            changeCountDown('-silence','',true,false,true,false,true)
        elseif string.match(string.lower(songName),'milk') == 'milk' then
            milkCountDown('milk',nil)
        end
end
function startSonicCount(name,text)
    if string.match(name, ' ') ~= nil then
        name = string.gsub(name,' ','-')--This will replace the space with a trace
    end
    if string.match(text, ' ') ~= nil then
        text = string.gsub(text,' ','-')--This will replace the space with a trace
    end
    setProperty('introSoundsSuffix','-silence')
    makeLuaSprite('blackScreenSonicCount','',0,0)
    setObjectCamera('blackScreenSonicCount','other')
    makeGraphic('blackScreenSonicCount',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreenSonicCount',true)
    if name ~= nil then
        makeLuaSprite('startCircle','StartScreens/Circle-'..name,800,00)
        setObjectCamera('startCircle','other')
        addLuaSprite('startCircle',true)
        circleCreated = true
    end
    if text ~= nil then
        makeLuaSprite('startText','StartScreens/Text-'..text,-800,00)
        setObjectCamera('startText','other')
        addLuaSprite('startText',true)
        textCreated = true
    end
    runTimer('tweenWow',0.2)
    runTimer('tween2',getPropertyFromClass('Conductor','crochet')/ 1000 * 5)
end
function milkCountDown(name,text)
    if string.match(name, " ") ~= nil then
        name = string.gsub(name," ","-")--This will replace the space with a trance
    end
    setProperty('introSoundsSuffix','-silence')
    makeLuaSprite('blackScreenSonicCount','',0,0)
    setObjectCamera('blackScreenSonicCount','other')
    makeGraphic('blackScreenSonicCount',screenWidth,screenHeight,'000000')
    addLuaSprite('blackScreenSonicCount',true)
    if name ~= nil then
        makeLuaSprite('startCircle','StartScreens/Circle-'..name,0,0)
        setProperty('startCircle.scale.x',0)
        setObjectCamera('startCircle','other')
        addLuaSprite('startCircle',true)
        circleCreated = true
    end
    if text ~= nil then
        makeLuaSprite('startText','StartScreens/Text-'..text,0,0)
        setObjectCamera('startText','other')
        addLuaSprite('startText',true)
        textCreated = true
    end
    runTimer('tweenMajin',0.2)
    runTimer('tween2',getPropertyFromClass('Conductor','crochet')/ 1000 * 5)
end
function onTimerCompleted(tag)
    if tag == 'tweenWow' then
        if circleCreated == true then
            doTweenX('circleX','startCircle',0,0.6,'quartOut')
        end
        if textCreated == true then
            doTweenX('textX','startText',0,0.6,'quartOut')
        end
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    end
    if tag == 'tweenMajin' then
        if circleCreated == true then
            doTweenX('circleX','startCircle.scale',1,0.4,'bounceOut')
        end
        if textCreated == true then
            doTweenX('textX','startText.scale',1,0.4,'bounceOut')
        end
        playSound('flatBONK')
        --doTweenX('circleX','startCircle',0,0.7,'linear')
        --doTweenX('textX','startText',0,0.7,'linear')
    end
    if tag == 'tween2' then
        --doTweenX('circleX','startCircle',-900,0.7,'quartOut')
        --doTweenX('textX','startText',1200,0.7,'quartOut')
        doTweenAlpha('blackScreenDestroy','blackScreenSonicCount',0,0.5,'linear')
        runTimer('tweenCircle',0.5)
    end
    if tag == 'tweenCircle' then
        doTweenAlpha('circleDestroy','startCircle',0,0.5,'linear')
        doTweenAlpha('textDestroy','startText',0,0.5,'linear')
    end
end
function onCountdownTick(counter)
    if counter > 0 then
        addLuaSprite('customIntro'..counter,true)
        doTweenAlpha('byeCustomIntro'..counter,'customIntro'..counter,0,getPropertyFromClass('Conductor','crochet')/ 1000,'linear')
        if counter == 1 then
            if disableImage == true then
                setProperty('countdownReady.visible',false)
            end
            if changedImage == true then
                doTweenAlpha('byeReady','customIntro'..counter,0,0.5,'linear')
            end
        elseif counter == 2 then
            if disableImage == true then
                setProperty('countdownSet.visible',false)
            end
            removeLuaSprite('customIntro'..(counter -1),true)
        elseif counter == 3 then
            if disableImage == true then
                setProperty('countdownGo.visible',false)
            end
            removeLuaSprite('customIntro'..(counter -1),true)
        end
    end
end
function changeCountDown(songCountName,image,changeSong,changeImage,disableCountDownImage,haveThreeImage,antialiasing)
    disableImage = disableCountDownImage
    if changeSong == true then
        setProperty('introSoundsSuffix',songCountName)
    end
    if changeImage == true then
        changedImage = true
        if haveThreeImage == true then
            for countDown = 1,3 do
                makeLuaSprite('customIntro'..countDown,image..countDown,counterPos[countDown][1],counterPos[countDown][2])
                setObjectCamera('customIntro'..countDown,'hud')
                scaleObject('customIntro'..countDown,counterScale[countDown][1],counterScale[countDown ][2])
                setProperty('customIntro'..countDown..'.antialiasing',antialiasing)
            end
        else
            for countDown = 1,2 do
                makeLuaSprite('customIntro'..countDown,image..countDown,counterPos[countDown + 1][1],counterPos[countDown + 1][2])
                setObjectCamera('customIntro'..countDown,'hud')
                scaleObject('customIntro'..countDown,counterScale[countDown + 1][1],counterScale[countDown + 1][2])
                setProperty('customIntro'..countDown..'.antialiasing',antialiasing)
            end
        end
        makeLuaSprite('customIntro3',image..'go',counterPos[4][1],counterPos[4][2])
        setObjectCamera('customIntro3','hud')
        scaleObject('customIntro3',counterScale[4][1],counterScale[4][2])
        setProperty('customIntro3.antialiasing',antialiasing)
    end
end
function onTweenCompleted(tag)
    if tag == 'circleDestroy' then
        if circleCreated == true then
            removeLuaSprite('startCircle',true)
        end
        if textCreated == true then
            removeLuaSprite('startText',true)
        end
        removeLuaSprite('blackScreenSonicCount',true)
    end
    if tag == 'byeCustomIntro3' then
        removeLuaSprite('customIntro3',true)
    end
end
function changeCounterPos(changeAll,posX,posY,tablePos)
    if changeAll == true then
        for counterLength = 1,#counterPos do
            table.remove(counterPos,counterLength)
            table.insert(counterPos,counterLength,{posX,posY})
        end

    else
        table.remove(counterPos,tablePos)
        table.insert(counterPos,tablePos,{posX,posY})
    end
end
function changeCounterScale(changeAll,scaleX,scaleY,tablePos)
    if changeAll == true then
        for scaleLength = 1,#counterScale do
            table.remove(counterScale,scaleLength)
            table.insert(counterScale,tablePos,{scaleX,scaleY})
        end

    else
        table.remove(counterScale,tablePos)
        table.insert(counterScale,tablePos,{scaleX,scaleY})
    end
end