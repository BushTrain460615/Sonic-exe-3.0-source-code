local PopupLength = 0
local PopupCreate = false
local PopupsDeleted = {}



function onCreate()
    precacheImage('error_popups')
    precacheImage('fatal_mouse_cursor')
    makeLuaSprite('fatalCursor','fatal_mouse_cursor',getMouseX('other'),getMouseY('other'))
    setObjectCamera('fatalCursor','other')
    addLuaSprite('fatalCursor',true)

end
function onEvent(name,v1,v2)
    if name == 'Fatality Popup' and PopupCreate == false then
        table.insert(PopupsDeleted,(PopupLength + 1),false)
        makeAnimatedLuaSprite('FatalityPopup'..(PopupLength + 1),'error_popups',math.random(150,700),math.random(0,screenHeight - 264))
        addAnimationByPrefix('FatalityPopup'..(PopupLength + 1),'error','idle',24,false)
        addAnimationByPrefix('FatalityPopup'..(PopupLength + 1),'byeError','bye',24,false)
        setProperty('FatalityPopup'..(PopupLength + 1)..'.antialiasing',false)
        setObjectCamera('FatalityPopup'..(PopupLength + 1),'other')
        scaleObject('FatalityPopup'..(PopupLength + 1),1.6,1.6)
        addLuaSprite('FatalityPopup'..(PopupLength + 1),true)
        setObjectOrder('fatalCursor',getObjectOrder('FatalityPopup'..(PopupLength + 1)) + 1)
        if v2 ~= '' and tonumber(v2) ~= nil then
            runTimer('PupopDelete'..(PopupLength + 1),v2)
        end
        PopupLength = PopupLength + 1
        runTimer('PopupEnable',0.1)
        PopupCreate = true
    elseif name == 'Clear Fatality Popups' then
        for deletedPopus = 1,PopupLength do
            if deletedPopus ~= PopupsDeleted[deletedPopus] then
                objectPlayAnimation('FatalityPopup'..deletedPopus,'byeError',true)
            end
        end
    end
end
function onUpdate()
    for PopupCounter = 1,PopupLength do
        if PopupsDeleted[PopupCounter] == false then
            if getMouseX('other') >= getProperty('FatalityPopup'..PopupCounter..'.x') + (getProperty('FatalityPopup'..PopupCounter..'.width')/2.5) and getMouseX('other') <= getProperty('FatalityPopup'..PopupCounter..'.x') + (getProperty('FatalityPopup'..PopupCounter..'.width')/1.75) and  getMouseY('other') >= getProperty('FatalityPopup'..PopupCounter..'.y') + (getProperty('FatalityPopup'..PopupCounter..'.height')/1.5) and getMouseY('other') <= getProperty('FatalityPopup'..PopupCounter..'.y') + (getProperty('FatalityPopup'..PopupCounter..'.height')/1.05)  and getPropertyFromClass('flixel.FlxG','mouse.justPressed') == true then
                objectPlayAnimation('FatalityPopup'..PopupCounter,'byeError',false)
            end
            if getProperty('FatalityPopup'..PopupCounter..'.animation.curAnim.finished') and getProperty('FatalityPopup'..PopupCounter..'.animation.curAnim.name') == 'byeError' then
                table.remove(PopupsDeleted,PopupCounter)
                table.insert(PopupsDeleted,PopupCounter,true)
                removeLuaSprite('FatalityPopup'..PopupCounter,true)
            end
        end
    end
    
    setPropertyFromClass('flixel.FlxG','mouse.visible',false)
    setProperty('fatalCursor.x',getMouseX('other'))
    setProperty('fatalCursor.y',getMouseY('other'))

end
function onTimerCompleted(tag)
    if string.find(tag,'PupopDelete',0,true) ~= nil then
        for PupopTimerCounter = 1,PopupLength do
            if tag == 'PupopDelete'..PupopTimerCounter then
                if PupopTimerCounter ~= PopupsDeleted[PupopTimerCounter] then
                    objectPlayAnimation('FatalityPopup'..PupopTimerCounter,'byeError',false)
                end
            end
        end
    end
    if tag == 'PopupEnable' then
        PopupCreate = false
    end
end