globals
    // Generated
rect gg_rct_Pen= null
trigger gg_trg_coreInit= null
trigger gg_trg_coreGame= null
trigger gg_trg_changelog= null
trigger gg_trg_Merchant= null
trigger gg_trg_miscClean= null
trigger gg_trg_miscGoldTick= null
trigger gg_trg_miscZoom= null
trigger gg_trg_miscAngle= null
trigger gg_trg_miscGold= null
trigger gg_trg_miscControl= null
trigger gg_trg_miscUncontrol= null
trigger gg_trg_miscLeaves= null
trigger gg_trg_miscFace= null
trigger gg_trg_miscFriendlyAttack= null
trigger gg_trg_miscKillReturn= null
trigger gg_trg_miscSmartSave= null
trigger gg_trg_sheepFarmSelfDestruct= null
trigger gg_trg_sheepSaveDeath= null
trigger gg_trg_sheepWispLeave= null
trigger gg_trg_sheepCommands= null
trigger gg_trg_sheepJotyeFarm= null
trigger gg_trg_sheepDestroyLastFarm= null
trigger gg_trg_sheepDisableStacksOnWisp= null
trigger gg_trg_wolfQuickBuy= null
trigger gg_trg_wolfWhiteWolf= null
trigger gg_trg_wolfLumber= null
trigger gg_trg_wolfWard= null
trigger gg_trg_wolfCloakOfFlames= null
trigger gg_trg_eggGem= null
trigger gg_trg_eggDolly= null
unit gg_unit_ngme_0013= null
string gameState= "init"
integer array saveskills
timer myTimer= CreateTimer()
timerdialog myTimerDialog= CreateTimerDialog(myTimer)
unit array wolves
unit array sheeps
unit array wisps
unit array wws
force sheepTeam= CreateForce()
force wolfTeam= CreateForce()
force wispTeam= CreateForce()
string array color
integer array items
integer array bounty
multiboard board
string array myArg
integer myArgCount= 0
boolean array gemActivated
boolean array dEnabled
    
constant string defeatString= "Yooz bee uhn disgreysd too shahkruh!"
constant string infoString= "Fixus by |CFF959697Chakra|r\nchakra@sheeptag.net\nClan OviS @ Lordaeron (USWest)"
constant real quickBuyTax= 1.5
constant real quickSellTax= .5
    
integer someInteger
integer array wolfWhiteWolf_itemType
timer array wwTimer
timerdialog array wwTimerDialog
integer array dollyClick
boolean katama= true


//JASSHelper struct globals:
constant integer si__sheep=1
integer si__sheep_F=0
integer si__sheep_I=0
integer array si__sheep_V
integer s__sheep_type= 'uC04'
integer s__sheep_blacktype= 'uC02'
integer s__sheep_silvertype= 'u000'
integer s__sheep_goldtype= 'u001'
integer s__sheep_xability= 'A00D'
integer s__sheep_dolly= 'nshf'
integer s__sheep_katama= 'n002'
integer s__sheep_jotye= 'h006'
integer s__sheep_dability= 'AOww'
constant integer si__wisp=2
integer si__wisp_F=0
integer si__wisp_I=0
integer array si__wisp_V
integer s__wisp_type= 'eC01'
constant integer si__wolf=3
integer si__wolf_F=0
integer si__wolf_I=0
integer array si__wolf_V
integer s__wolf_type= 'EC03'
integer s__wolf_blacktype= 'E002'
integer s__wolf_imbatype= 'E000'
integer s__wolf_wwtype= 'eC16'
integer s__wolf_wwitem= 'I003'
integer s__wolf_cloakitem= 'clfm'
integer s__wolf_wardtype= 'n001'
integer s__wolf_wardability= 'A001'
integer s__wolf_golemtype= 'ngst'
integer s__wolf_stalkertype= 'nfel'
integer s__wolf_item1= 'ratf'
integer s__wolf_item2= 'ratc'
integer s__wolf_item3= 'rat9'
integer s__wolf_item4= 'rat6'
integer s__wolf_itemGlobal= 'mcou'
integer s__wolf_gem= 'gemt'
constant integer si__myItem=4
integer si__myItem_F=0
integer si__myItem_I=0
integer array si__myItem_V
string array s__myItem_name
integer array s__myItem_gold
integer array s__myItem_lumber
integer array s__myItem_ID
constant integer si__bountyStruct=5
integer si__bountyStruct_F=0
integer si__bountyStruct_I=0
integer array si__bountyStruct_V
integer array s__bountyStruct_ID
integer array s__bountyStruct_gold
integer array s__bountyStruct_XP

endglobals
native GetPlayerUnitTypeCount takes player p, integer unitid            returns integer
native GetBuilding          takes player p                              returns unit
native UnitAlive            takes unit id                               returns boolean


//Generated allocator of sheep
function s__sheep__allocate takes nothing returns integer
 local integer this=si__sheep_F
    if (this!=0) then
        set si__sheep_F=si__sheep_V[this]
    else
        set si__sheep_I=si__sheep_I+1
        set this=si__sheep_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__sheep_V[this]=-1
 return this
endfunction

//Generated destructor of sheep
function s__sheep_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__sheep_V[this]!=-1) then
        return
    endif
    set si__sheep_V[this]=si__sheep_F
    set si__sheep_F=this
endfunction

//Generated allocator of bountyStruct
function s__bountyStruct__allocate takes nothing returns integer
 local integer this=si__bountyStruct_F
    if (this!=0) then
        set si__bountyStruct_F=si__bountyStruct_V[this]
    else
        set si__bountyStruct_I=si__bountyStruct_I+1
        set this=si__bountyStruct_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__bountyStruct_V[this]=-1
 return this
endfunction

//Generated destructor of bountyStruct
function s__bountyStruct_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__bountyStruct_V[this]!=-1) then
        return
    endif
    set si__bountyStruct_V[this]=si__bountyStruct_F
    set si__bountyStruct_F=this
endfunction

//Generated allocator of myItem
function s__myItem__allocate takes nothing returns integer
 local integer this=si__myItem_F
    if (this!=0) then
        set si__myItem_F=si__myItem_V[this]
    else
        set si__myItem_I=si__myItem_I+1
        set this=si__myItem_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__myItem_V[this]=-1
 return this
endfunction

//Generated destructor of myItem
function s__myItem_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__myItem_V[this]!=-1) then
        return
    endif
    set si__myItem_V[this]=si__myItem_F
    set si__myItem_F=this
endfunction

//Generated allocator of wolf
function s__wolf__allocate takes nothing returns integer
 local integer this=si__wolf_F
    if (this!=0) then
        set si__wolf_F=si__wolf_V[this]
    else
        set si__wolf_I=si__wolf_I+1
        set this=si__wolf_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__wolf_V[this]=-1
 return this
endfunction

//Generated destructor of wolf
function s__wolf_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__wolf_V[this]!=-1) then
        return
    endif
    set si__wolf_V[this]=si__wolf_F
    set si__wolf_F=this
endfunction

//Generated allocator of wisp
function s__wisp__allocate takes nothing returns integer
 local integer this=si__wisp_F
    if (this!=0) then
        set si__wisp_F=si__wisp_V[this]
    else
        set si__wisp_I=si__wisp_I+1
        set this=si__wisp_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__wisp_V[this]=-1
 return this
endfunction

//Generated destructor of wisp
function s__wisp_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__wisp_V[this]!=-1) then
        return
    endif
    set si__wisp_V[this]=si__wisp_F
    set si__wisp_F=this
endfunction

//===========================================================================
// 
// Ultimate Sheep Tag Fixus 1.12
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Sun Jan 01 16:29:41 2012
//   Map Author: Chakra
// 
//===========================================================================

//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************


function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=CreateUnit(p, 'nC12', - 4608.0, 4096.0, 270.000)
    set u=CreateUnit(p, 'ngme', - 4992.0, 3712.0, 270.000)
    set u=CreateUnit(p, 'ngme', 4864.0, - 5504.0, 270.000)
    set u=CreateUnit(p, 'nC12', 5248.0, - 5504.0, 270.000)
endfunction

//===========================================================================
function CreateNeutralPassive takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u=CreateUnit(p, 'nshf', - 258.8, - 849.1, 198.529)
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings()
    call CreatePlayerBuildings()
    call CreateNeutralPassive()
    call CreatePlayerUnits()
endfunction

//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************

function CreateRegions takes nothing returns nothing
    local weathereffect we

    set gg_rct_Pen=Rect(- 640.0, - 1280.0, 128.0, - 448.0)
endfunction

//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//TESH.scrollpos=39
//TESH.alwaysfold=0










//Ends the game, awarding wins/loses and other W3MMD data
function endGame takes integer t returns nothing
    local integer i= 0
    call TimerDialogDisplay(myTimerDialog, false)
    loop
        exitwhen i == 12
        call DisplayTimedTextToPlayer(Player(i), 0, 0, 30, infoString)
        set i=i + 1
    endloop
    call TimerStart(myTimer, 3, false, null)
    call TimerDialogSetTitle(myTimerDialog, "Ending in...")
    call TimerDialogDisplay(myTimerDialog, true)
    call TriggerSleepAction(3)
    set i=0
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), sheepTeam) then
            if t < 1 then
                call CustomVictoryBJ(Player(i), true, true)
            else
                call CustomDefeatBJ(Player(i), defeatString)
            endif
        else
            if t > 1 then
                call CustomVictoryBJ(Player(i), true, true)
            else
                call CustomDefeatBJ(Player(i), defeatString)
            endif
        endif
        set i=i + 1
    endloop
endfunction

//Duh
function TriggerRegisterPlayerEventAll takes trigger t,playerevent e returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        call TriggerRegisterPlayerEvent(t, Player(i), e)
        set i=i + 1
    endloop
endfunction

//Duh
function TriggerRegisterPlayerUnitEventAll takes trigger t,playerunitevent p,boolexpr b returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        call TriggerRegisterPlayerUnitEvent(t, Player(i), p, b)
        set i=i + 1
    endloop
endfunction

//Duh
function TriggerRegisterPlayerAllianceChangeAll takes trigger t,alliancetype a returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        call TriggerRegisterPlayerAllianceChange(t, Player(i), a)
        set i=i + 1
    endloop
endfunction

//Duh
function TriggerRegisterPlayerChatEventAll takes trigger t,string s,boolean match returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        call TriggerRegisterPlayerChatEvent(t, Player(i), s, match)
        set i=i + 1
    endloop
endfunction

//Splits a string into arguments around string c. If bb true, first argument is ignored.
function Split takes string s,string c,boolean bb returns nothing
    local integer i= 0
    local integer n= 0
    loop
        exitwhen i == myArgCount
        set myArg[i]=null
        set i=i + 1
    endloop
    set i=0
    if bb then
        loop
            exitwhen SubString(s, 0, 1) == c
            set s=SubString(s, 1, StringLength(s))
        endloop
    endif
    set s=SubString(s, 1, StringLength(s))
    loop
        exitwhen s == null
        set i=0
        loop
            exitwhen SubString(s, i, i + 1) == c or SubString(s, i, i + 1) == null
            set i=i + 1
        endloop
        set myArg[n]=SubString(s, 0, i)
        set s=SubString(s, i + 1, StringLength(s))
        set n=n + 1
    endloop
    set myArgCount=n
endfunction

function SmallText takes integer amount,unit u,integer cc,real x,real y returns nothing
    local texttag tt= CreateTextTag()
    if GetUnitAbilityLevel(u, 'Alv1') > 0 then
        call DestroyTextTag(tt)
    elseif IsVisibleToPlayer(GetUnitX(u), GetUnitY(u), GetLocalPlayer()) then
        call SetTextTagPermanent(tt, false)
        call SetTextTagPos(tt, GetUnitX(u) + x, GetUnitY(u) + y, 25)
        call SetTextTagText(tt, color[cc] + "+" + I2S(amount), 0.0276)
        //call SetTextTagColor(tt, 217, 217, 25, 0)
        call SetTextTagFadepoint(tt, 0)
        call SetTextTagVelocity(tt, 0, 0.027734375)
        call SetTextTagLifespan(tt, 3)
    endif
endfunction

function isHere takes nothing returns boolean
    return GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING
endfunction

function countHereEnum takes nothing returns nothing
    if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING then
        set someInteger=someInteger + 1
    endif
endfunction

//Counts players in force that are here
function countHere takes force f returns integer
    set someInteger=0
    call ForForce(f, function countHereEnum)
    return someInteger
endfunction

function countHereRealEnum takes nothing returns nothing
    if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_USER then
        set someInteger=someInteger + 1
    endif
endfunction

//Counts players in force that are here
function countHereReal takes force f returns integer
    set someInteger=0
    call ForForce(f, function countHereRealEnum)
    return someInteger
endfunction

//Grabs the player's main unit
function mainUnit takes player p returns unit
    if GetPlayerId(p) > 6 then
        return wolves[GetPlayerId(p)]
    else
        if IsPlayerInForce(p, sheepTeam) then
            return sheeps[GetPlayerId(p)]
        else
            return wisps[GetPlayerId(p)]
        endif
    endif
endfunction

//Returns the index in which string part is found in string whole
function InStr takes string whole,string part returns integer
    local integer index= 0
    loop
        exitwhen StringLength(whole) - index < StringLength(part)
        if SubString(whole, index, StringLength(part) + index) == part then
            return index
        endif
        set index=index + 1
    endloop
    return - 1
endfunction

function reloadMultiboard takes nothing returns nothing
    local integer i= 0
    local integer index= 0
    call MultiboardDisplay(board, false)
    call DestroyMultiboard(board)
    set board=CreateMultiboard()
    call MultiboardSetTitleText(board, "Ultimate Sheep Tag Fixus")
    call MultiboardSetColumnCount(board, 2)
    call MultiboardSetRowCount(board, 5 + CountPlayersInForceBJ(sheepTeam) + CountPlayersInForceBJ(wolfTeam) + CountPlayersInForceBJ(wispTeam))
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[12] + "Sheep: " + I2S(countHere(sheepTeam)))
    call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), "Saves")
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 1), true, false)
    set index=index + 1
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), sheepTeam) then
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[i] + GetPlayerName(Player(i)))
            call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
            call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
            if saveskills[i] >= 25 then
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNMaskOfDeath.blp")
            elseif saveskills[i] >= 15 then
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheClaw.blp")
            elseif saveskills[i] >= 10 then
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNSheep.blp")
            else
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNPolymorph.blp")
            endif
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), I2S(saveskills[i]))
            set index=index + 1
        endif
        set i=i + 1
    endloop
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 1), true, false)
    set index=index + 1
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[12] + "Wisps: " + I2S(countHere(wispTeam)))
    call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), "Saves")
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 1), true, false)
    set index=index + 1
    set i=0
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), wispTeam) then
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[i] + GetPlayerName(Player(i)))
            call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
            call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
            call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNWisp.blp")
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), I2S(saveskills[i]))
            set index=index + 1
        endif
        set i=i + 1
    endloop
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 1), true, false)
    set index=index + 1
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[13] + "Wolves: " + I2S(countHere(wolfTeam)))
    call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
    call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), "Kills")
    call MultiboardSetItemStyle(MultiboardGetItem(board, index, 1), true, false)
    set index=index + 1
    set i=0
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), wolfTeam) then
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 0), color[i] + GetPlayerName(Player(i)))
            call MultiboardSetItemWidth(MultiboardGetItem(board, index, 0), .1)
            call MultiboardSetItemStyle(MultiboardGetItem(board, index, 0), true, false)
            if saveskills[i] >= 50 then
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNDoomGuard.blp")
            elseif saveskills[i] >= 10 then
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNDireWolf.blp")
            else
                call MultiboardSetItemIcon(MultiboardGetItem(board, index, 1), "ReplaceableTextures\\CommandButtons\\BTNTimberWolf.blp")
            endif
            call MultiboardSetItemValue(MultiboardGetItem(board, index, 1), I2S(saveskills[i]))
            set index=index + 1
        endif
        set i=i + 1
    endloop
    call MultiboardDisplay(board, true)
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: coreInit
//===========================================================================
//TESH.scrollpos=-1
//TESH.alwaysfold=0
function Trig_coreInitDelay_Actions takes nothing returns nothing
    local integer i
    local integer n
    local integer pCount= 0
    local quest q
    local questitem qi
    set q=CreateQuest()
    call QuestSetTitle(q, "Ultimate Sheep Tag Fixus")
    call QuestSetDescription(q, "Fixus by |CFF959697Chakra|r\nchakra@sheeptag.net\nClan OviS @ Lordaeron\nClan StH @ Azeroth")
    call QuestSetIconPath(q, "ReplaceableTextures\\CommandButtons\\BTNAcorn.blp")
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Fixus by |CFF959697Chakra|r")
    set qi=null
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Ultimate Sheep Tag using |CFF959697Chakra|r's Sheep Tag Template file.")
    set q=null
    set qi=null
    
    set q=CreateQuest()
    call QuestSetTitle(q, "Sheep")
    call QuestSetIconPath(q, "ReplaceableTextures\\CommandButtons\\BTNSheep.blp")
    call QuestSetRequired(q, false)
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Either last 25 minutes or until all wolves leave to win.")
    set qi=null
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Build farms to survive.")
    set qi=null
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Save dead sheep to last.")
    set q=null
    set qi=null
    
    set q=CreateQuest()
    call QuestSetTitle(q, "Wolves")
    call QuestSetIconPath(q, "ReplaceableTextures\\CommandButtons\\BTNRaider.blp")
    call QuestSetRequired(q, false)
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Either kill all sheep or wait until all sheep leave to win.")
    set qi=null
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Buy items to kill sheep.")
    set qi=null
    set qi=QuestCreateItem(q)
    call QuestItemSetDescription(qi, "Camp the middle to avoid killed sheep to be revived.")
    set q=null
    set qi=null
    
    set i=0
    loop
        exitwhen i == 12
        call DisplayTimedTextToPlayer(Player(i), 0, 0, 3, infoString)
        set i=i + 1
    endloop
    
    if countHere(wolfTeam) == 0 or countHere(sheepTeam) == 0 then
        call endGame(1)
        return
    endif
    
    call TimerStart(myTimer, 3, false, null)
    call TimerDialogSetTitle(myTimerDialog, "Starting in...")
    call TimerDialogDisplay(myTimerDialog, true)
    set board=CreateMultiboard()
endfunction

//===========================================================================
function InitTrig_coreInit takes nothing returns nothing
    local trigger t= CreateTrigger()
    local integer i
    call SetMapFlag(MAP_SHARED_ADVANCED_CONTROL, true)
    call TriggerRegisterTimerEvent(t, .01, false)
    call TriggerAddAction(t, function Trig_coreInitDelay_Actions)
    set i=0
    loop
        exitwhen i == 12
        set saveskills[i]=0
        set dollyClick[i]=0
        set gemActivated[i]=false
        set dEnabled[i]=false
        set i=i + 1
    endloop
    set i=0
    loop
        exitwhen i == 99
        set items[i]=s__myItem__allocate()
        set i=i + 1
    endloop
    set i=0
    set s__myItem_name[items[i]]="supergolem"
    set s__myItem_gold[items[i]]=350
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='I001'
    set i=i + 1
    set s__myItem_name[items[i]]="stalker"
    set s__myItem_gold[items[i]]=100
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='fgfh'
    set i=i + 1
    set s__myItem_name[items[i]]="golem"
    set s__myItem_gold[items[i]]=100
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='fgrg'
    set i=i + 1
    set s__myItem_name[items[i]]="speed"
    set s__myItem_gold[items[i]]=15
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='pspd'
    set i=i + 1
    set s__myItem_name[items[i]]="invis"
    set s__myItem_gold[items[i]]=35
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='pinv'
    set i=i + 1
    set s__myItem_name[items[i]]="mana"
    set s__myItem_gold[items[i]]=20
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='pman'
    set i=i + 1
    set s__myItem_name[items[i]]="cheese"
    set s__myItem_gold[items[i]]=0
    set s__myItem_lumber[items[i]]=2
    set s__myItem_ID[items[i]]='I003'
    set i=i + 1
    set s__myItem_name[items[i]]="50"
    set s__myItem_gold[items[i]]=350
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='I002'
    set i=i + 1
    set s__myItem_name[items[i]]="sabre"
    set s__myItem_gold[items[i]]=300
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='I000'
    set i=i + 1
    set s__myItem_name[items[i]]="21"
    set s__myItem_gold[items[i]]=126
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='ratf'
    set i=i + 1
    set s__myItem_name[items[i]]="12"
    set s__myItem_gold[items[i]]=60
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='ratc'
    set i=i + 1
    set s__myItem_name[items[i]]="dagger"
    set s__myItem_gold[items[i]]=67
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='mcou'
    set i=i + 1
    set s__myItem_name[items[i]]="cloak"
    set s__myItem_gold[items[i]]=250
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='clfm'
    set i=i + 1
    set s__myItem_name[items[i]]="neck"
    set s__myItem_gold[items[i]]=150
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='nspi'
    set i=i + 1
    set s__myItem_name[items[i]]="boots"
    set s__myItem_gold[items[i]]=70
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='bspd'
    set i=i + 1
    set s__myItem_name[items[i]]="gem"
    set s__myItem_gold[items[i]]=150
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='gemt'
    set i=i + 1
    set s__myItem_name[items[i]]="orb"
    set s__myItem_gold[items[i]]=300
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='ofir'
    set i=i + 1
    set s__myItem_name[items[i]]="scope"
    set s__myItem_gold[items[i]]=30
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='tels'
    set i=i + 1
    set s__myItem_name[items[i]]="invul"
    set s__myItem_gold[items[i]]=25
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='pnvu'
    set i=i + 1
    set s__myItem_name[items[i]]="6"
    set s__myItem_gold[items[i]]=18
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='rat6'
    set i=i + 1
    set s__myItem_name[items[i]]="gloves"
    set s__myItem_gold[items[i]]=80
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='gcel'
    set i=i + 1
    set s__myItem_name[items[i]]="9"
    set s__myItem_gold[items[i]]=36
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='rat9'
    set i=i + 1
    set s__myItem_name[items[i]]="shadow"
    set s__myItem_gold[items[i]]=125
    set s__myItem_lumber[items[i]]=0
    set s__myItem_ID[items[i]]='clsd'
    set color[0]="|CFFFF0303"
    set color[1]="|CFF0042FF"
    set color[2]="|CFF1CE6B9"
    set color[3]="|CFF540081"
    set color[4]="|CFFFFFF01"
    set color[5]="|CFFFE8A0E"
    set color[6]="|CFF20C000"
    set color[7]="|CFFE55BB0"
    set color[8]="|CFF959697"
    set color[9]="|CFF7EBFF1"
    set color[10]="|CFF106246"
    set color[11]="|CFF4E2A04"
    set color[12]="|CFF3F81F8"
    set color[13]="|CFFC00040"
    set color[14]="|CFFD9D919"
    set i=0
    loop
        exitwhen i == 99
        set bounty[i]=s__bountyStruct__allocate()
        set s__bountyStruct_ID[bounty[i]]=0
        set s__bountyStruct_XP[bounty[i]]=0
        set i=i + 1
    endloop
    set i=0
    set s__bountyStruct_ID[bounty[i]]='hlum' //Aura  0
    set s__bountyStruct_gold[bounty[i]]=5
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hhou' //Farm  1
    set s__bountyStruct_gold[bounty[i]]=2
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hctw' //Frost 2
    set s__bountyStruct_gold[bounty[i]]=5
    set s__bountyStruct_XP[bounty[i]]=5
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hbla' //Saving    3
    set s__bountyStruct_gold[bounty[i]]=10
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hbar' //Upgraded  4
    set s__bountyStruct_gold[bounty[i]]=3
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h004' //Black 5
    set s__bountyStruct_gold[bounty[i]]=2
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h000' //Gold  6
    set s__bountyStruct_gold[bounty[i]]=3
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hC06' //Hard  7
    set s__bountyStruct_gold[bounty[i]]=3
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h002' //Invis 8
    set s__bountyStruct_gold[bounty[i]]=5
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h005' //Sentry    9
    set s__bountyStruct_gold[bounty[i]]=5
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h001' //Silver    10
    set s__bountyStruct_gold[bounty[i]]=2
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='hC07' //Tiny  11
    set s__bountyStruct_gold[bounty[i]]=1
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h003' //Stun  12
    set s__bountyStruct_gold[bounty[i]]=10
    set s__bountyStruct_XP[bounty[i]]=10
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='n000' //Stack 13
    set s__bountyStruct_gold[bounty[i]]=2
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='e001' //Magic 14
    set s__bountyStruct_gold[bounty[i]]=10
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h006' //Jotye 15
    set s__bountyStruct_gold[bounty[i]]=5
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h007' //Silver-G 16
    set s__bountyStruct_gold[bounty[i]]=2
    set i=i + 1
    set s__bountyStruct_ID[bounty[i]]='h008' //Power 17
    set s__bountyStruct_gold[bounty[i]]=20
    set s__bountyStruct_XP[bounty[i]]=20
    call ForceEnumAllies(sheepTeam, Player(0), Condition(function isHere))
    call ForceEnumAllies(wolfTeam, Player(11), Condition(function isHere))
endfunction
//===========================================================================
// Trigger: coreGame
//===========================================================================
//TESH.scrollpos=41
//TESH.alwaysfold=0
function Trig_coreGame_Actions takes nothing returns nothing
    local integer i
    local integer n
    if gameState == "init" then
        call TimerDialogDisplay(myTimerDialog, false)
        set i=0
        loop
            exitwhen i == 12
            if IsPlayerInForce(Player(i), sheepTeam) and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
                set sheeps[i]=CreateUnit(Player(i), s__sheep_type, GetStartLocationX(i), GetStartLocationY(i), 270)
                if GetLocalPlayer() == Player(i) then
                    call ClearSelection()
                    call SelectUnit(sheeps[i], true)
                    call PanCameraToTimed(GetStartLocationX(i), GetStartLocationY(i), 0)
                endif
                if InStr(GetPlayerName(Player(i)) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sheeps[i], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", sheeps[i], "origin")
                endif
                if GetPlayerController(Player(i)) == MAP_CONTROL_COMPUTER then
                    set n=0
                    loop
                        exitwhen n == 12
                        if IsPlayerInForce(Player(n), sheepTeam) then
                            call SetPlayerAlliance(Player(i), Player(n), ALLIANCE_SHARED_ADVANCED_CONTROL, true)
                            call SetPlayerAlliance(Player(i), Player(n), ALLIANCE_SHARED_CONTROL, true)
                        endif
                        set n=n + 1
                    endloop
                endif
            endif
            set i=i + 1
        endloop
        set gameState="start"
        call TimerStart(myTimer, 15, false, null)
        call TimerDialogSetTitle(myTimerDialog, "Wolves in...")
        call TimerDialogDisplay(myTimerDialog, true)
        call reloadMultiboard()
    elseif gameState == "start" then
        call TimerDialogDisplay(myTimerDialog, false)
        set i=0
        loop
            exitwhen i == 12
            if IsPlayerInForce(Player(i), wolfTeam) and GetPlayerSlotState(Player(i)) != PLAYER_SLOT_STATE_EMPTY then
                set wolves[i]=CreateUnit(Player(i), s__wolf_type, GetStartLocationX(i), GetStartLocationY(i), 270)
                call UnitAddItem(wolves[i], CreateItem(s__wolf_itemGlobal, GetStartLocationX(i), GetStartLocationY(i)))
                if countHere(wolfTeam) == 1 then
                    call UnitAddItem(wolves[i], CreateItem(s__wolf_item1, GetStartLocationX(i), GetStartLocationY(i)))
                elseif countHere(wolfTeam) == 2 then
                    call UnitAddItem(wolves[i], CreateItem(s__wolf_item2, GetStartLocationX(i), GetStartLocationY(i)))
                elseif countHere(wolfTeam) == 3 then
                    call UnitAddItem(wolves[i], CreateItem(s__wolf_item3, GetStartLocationX(i), GetStartLocationY(i)))
                elseif countHere(wolfTeam) == 4 then
                    call UnitAddItem(wolves[i], CreateItem(s__wolf_item4, GetStartLocationX(i), GetStartLocationY(i)))
                endif
                if InStr(GetPlayerName(Player(i)) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", wolves[i], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", wolves[i], "head")
                endif
                if GetLocalPlayer() == Player(i) then
                    call ClearSelection()
                    call SelectUnit(wolves[i], true)
                    call PanCameraToTimed(- 256, - 1024, 0)
                endif
                if GetPlayerController(Player(i)) == MAP_CONTROL_COMPUTER then
                    set n=0
                    loop
                        exitwhen n == 12
                        if IsPlayerInForce(Player(n), wolfTeam) then
                            call SetPlayerAlliance(Player(i), Player(n), ALLIANCE_SHARED_ADVANCED_CONTROL, true)
                            call SetPlayerAlliance(Player(i), Player(n), ALLIANCE_SHARED_CONTROL, true)
                        endif
                        set n=n + 1
                    endloop
                endif
            endif
            set i=i + 1
        endloop
        set gameState="play"
        call TimerStart(myTimer, 1500, false, null)
        call TimerDialogSetTitle(myTimerDialog, "Sheep win in...")
        call TimerDialogDisplay(myTimerDialog, true)
    elseif gameState == "play" then
        call endGame(0)
    endif
endfunction

//===========================================================================
function InitTrig_coreGame takes nothing returns nothing
    set gg_trg_coreGame=CreateTrigger()
    call TriggerRegisterTimerExpireEvent(gg_trg_coreGame, myTimer)
    call TriggerAddAction(gg_trg_coreGame, function Trig_coreGame_Actions)
endfunction
//===========================================================================
// Trigger: changelog
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
//===========================================================================
// Trigger: miscClean
//
// Work
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscClean_Actions takes nothing returns nothing
    if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == false then
        call TriggerSleepAction(2)
        call RemoveUnit(GetTriggerUnit())
    endif
endfunction

//===========================================================================
function InitTrig_miscClean takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function Trig_miscClean_Actions)
endfunction
//===========================================================================
// Trigger: miscGoldTick
//
// Work
//===========================================================================
//TESH.scrollpos=12
//TESH.alwaysfold=0
function notComputer takes nothing returns boolean
    return GetPlayerController(GetFilterPlayer()) != MAP_CONTROL_COMPUTER
endfunction

function Trig_miscGoldTick_Actions takes nothing returns nothing
    local integer i= 0
    local integer n
    local force f
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), sheepTeam) then
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 1)
        else
            if ModuloInteger(GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD), countHereReal(wolfTeam)) == 0 and GetPlayerController(Player(i)) == MAP_CONTROL_COMPUTER then
                set n=0
                set f=CreateForce()
                call ForceEnumAllies(f, Player(i), Condition(function notComputer))
                loop
                    exitwhen n == 12
                    if IsPlayerInForce(Player(n), f) then
                        call SetPlayerState(Player(n), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(n), PLAYER_STATE_RESOURCE_GOLD) + GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) / countHereReal(wolfTeam))
                    endif
                    set n=n + 1
                endloop
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, 0)
                call DestroyForce(f)
                set f=null
            endif
        endif
        set i=i + 1
    endloop
endfunction

function Trig_miscSavingTick_Actions takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        if IsPlayerInForce(Player(i), sheepTeam) then
            if saveskills[i] >= 25 then
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 2 * GetPlayerUnitTypeCount(Player(i), 'hbla'))
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 4 * GetPlayerUnitTypeCount(Player(i), 'h009'))
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 8 * GetPlayerUnitTypeCount(Player(i), 'h00A'))
            else
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + GetPlayerUnitTypeCount(Player(i), 'hbla'))
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 2 * GetPlayerUnitTypeCount(Player(i), 'h009'))
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 4 * GetPlayerUnitTypeCount(Player(i), 'h00A'))
            endif
        else
            call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + 1)
        endif
        set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_miscGoldTick takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterTimerEvent(t, 2, true)
    call TriggerAddAction(t, function Trig_miscGoldTick_Actions)
    set t=null
    set t=CreateTrigger()
    call TriggerRegisterTimerEvent(t, 4, true)
    call TriggerAddAction(t, function Trig_miscSavingTick_Actions)
endfunction
//===========================================================================
// Trigger: miscZoom
//
// Work
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscZoom_Actions takes nothing returns nothing
    call Split(GetEventPlayerChatString() , " " , true)
    if GetLocalPlayer() == GetTriggerPlayer() then
        call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, S2R(myArg[0]), 0)
    endif
endfunction

//===========================================================================
function InitTrig_miscZoom takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-zoom " , false)
    call TriggerRegisterPlayerChatEventAll(t , "-z " , false)
    call TriggerAddAction(t, function Trig_miscZoom_Actions)
endfunction
//===========================================================================
// Trigger: miscAngle
//
// Work
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscAngle_Actions takes nothing returns nothing
    call Split(GetEventPlayerChatString() , " " , true)
    if myArgCount == 1 and GetLocalPlayer() == GetTriggerPlayer() then
        call SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, S2R(myArg[0]), 0)
    endif
endfunction

//===========================================================================
function InitTrig_miscAngle takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-angle " , false)
    call TriggerRegisterPlayerChatEventAll(t , "-a " , false)
    call TriggerAddAction(t, function Trig_miscAngle_Actions)
endfunction
//===========================================================================
// Trigger: miscGold
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function miscGold_Actions takes nothing returns nothing
    call Split(GetEventPlayerChatString() , " " , true)
    if S2I(myArg[0]) > 0 and S2I(myArg[0]) < 13 and IsPlayerAlly(GetTriggerPlayer(), Player(S2I(myArg[0]) - 1)) and GetPlayerSlotState(Player(S2I(myArg[0]) - 1)) == PLAYER_SLOT_STATE_PLAYING and GetTriggerPlayer() != Player(S2I(myArg[0]) - 1) then
        call BJDebugMsg("apple")
        if myArgCount == 2 and S2I(myArg[1]) <= GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) and S2I(myArg[1]) > 0 then
            call DisplayTextToPlayer(Player(S2I(myArg[0]) - 1), 0, 0, color[GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer()) + "|r gave you " + myArg[1] + " gold.")
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, myArg[1] + " gold given to " + color[S2I(myArg[0]) - 1] + GetPlayerName(Player(S2I(myArg[0]) - 1)) + "|r.")
            call SetPlayerState(Player(S2I(myArg[0]) - 1), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(S2I(myArg[0]) - 1), PLAYER_STATE_RESOURCE_GOLD) + S2I(myArg[1]))
            call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) - S2I(myArg[1]))
        elseif myArgCount == 1 and S2I(myArg[1]) <= GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) then
            call DisplayTextToPlayer(Player(S2I(myArg[0]) - 1), 0, 0, color[GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer()) + "|r gave you " + I2S(GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD)) + " gold.")
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, I2S(GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD)) + " gold given to " + color[S2I(myArg[0]) - 1] + GetPlayerName(Player(S2I(myArg[0]) - 1)) + "|r.")
            call SetPlayerState(Player(S2I(myArg[0]) - 1), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(S2I(myArg[0]) - 1), PLAYER_STATE_RESOURCE_GOLD) + GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD))
            call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        endif
    endif
endfunction

//===========================================================================
function InitTrig_miscGold takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-g " , false)
    call TriggerAddAction(t, function miscGold_Actions)
endfunction
//===========================================================================
// Trigger: miscControl
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscControl_Actions takes nothing returns nothing
    call Split(GetEventPlayerChatString() , " " , true)
    if myArgCount == 1 and S2I(myArg[0]) > 0 and S2I(myArg[0]) < 13 and IsPlayerAlly(GetTriggerPlayer(), Player(S2I(myArg[0]) - 1)) and GetPlayerSlotState(Player(S2I(myArg[0]) - 1)) == PLAYER_SLOT_STATE_PLAYING then
        call SetPlayerAllianceStateBJ(GetTriggerPlayer(), Player(S2I(myArg[0]) - 1), bj_ALLIANCE_ALLIED_ADVUNITS)
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Control given to " + color[S2I(myArg[0]) - 1] + GetPlayerName(Player(S2I(myArg[0]) - 1)) + "|r.")
        call DisplayTextToPlayer(Player(S2I(myArg[0]) - 1), 0, 0, color[GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer()) + "|r gave you control.")
    endif
endfunction

//===========================================================================
function InitTrig_miscControl takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-c " , false)
    call TriggerAddAction(t, function Trig_miscControl_Actions)
endfunction
//===========================================================================
// Trigger: miscUncontrol
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscUncontrol_Actions takes nothing returns nothing
    call Split(GetEventPlayerChatString() , " " , true)
    if myArgCount == 1 and S2I(myArg[0]) > 0 and S2I(myArg[0]) < 13 and IsPlayerAlly(GetTriggerPlayer(), Player(S2I(myArg[0]) - 1)) and GetPlayerSlotState(Player(S2I(myArg[0]) - 1)) == PLAYER_SLOT_STATE_PLAYING then
        call SetPlayerAllianceStateBJ(GetTriggerPlayer(), Player(S2I(myArg[0]) - 1), bj_ALLIANCE_ALLIED_VISION)
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Control taken from " + color[S2I(myArg[0]) - 1] + GetPlayerName(Player(S2I(myArg[0]) - 1)) + "|r.")
        call DisplayTextToPlayer(Player(S2I(myArg[0]) - 1), 0, 0, color[GetPlayerId(GetTriggerPlayer())] + GetPlayerName(GetTriggerPlayer()) + "|r took back control.")
    endif
endfunction

//===========================================================================
function InitTrig_miscUncontrol takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-uc " , false)
    call TriggerAddAction(t, function Trig_miscUncontrol_Actions)
endfunction
//===========================================================================
// Trigger: miscLeaves
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscLeaves_Actions takes nothing returns nothing
    local integer i
    local force f= CreateForce()
    call SetPlayerName(GetTriggerPlayer(), "|r" + GetPlayerName(GetTriggerPlayer()))
    call ForceEnumAllies(f, GetTriggerPlayer(), null)
    call ForceRemovePlayer(f, GetTriggerPlayer())
    if countHere(f) == 0 then
        if IsPlayerInForce(GetTriggerPlayer(), sheepTeam) then
            call endGame(2)
        else
            call endGame(1)
        endif
    else
        set i=0
        loop
            exitwhen i == 12
            if IsPlayerInForce(Player(i), f) then
                call SetPlayerAllianceStateBJ(GetTriggerPlayer(), Player(i), bj_ALLIANCE_ALLIED_ADVUNITS)
                call DisplayTextToPlayer(Player(i), 0, 0, color[i] + GetPlayerName(GetTriggerPlayer()) + "|r gave you " + I2S(GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) / countHere(f)) + " gold.")
                call SmallText(GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) / countHere(f) , wolves[i] , 14 , 0 , 0)
                call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) / countHere(f))
            endif
            set i=i + 1
        endloop
        call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, 0)
        if IsPlayerInForce(GetTriggerPlayer(), sheepTeam) then
            call RemoveUnit(mainUnit(GetTriggerPlayer()))
        endif
    endif
    call DestroyForce(f)
    set f=null
    call reloadMultiboard()
endfunction

//===========================================================================
function InitTrig_miscLeaves takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerEventAll(t , EVENT_PLAYER_LEAVE)
    call TriggerAddAction(t, function Trig_miscLeaves_Actions)
endfunction
 //===========================================================================
// Trigger: miscFace
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function miscFace_Actions takes nothing returns nothing
    local group g= CreateGroup()
    local unit u
    call Split(GetEventPlayerChatString() , " " , true)
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), null)
    loop
        set u=FirstOfGroup(g)
        exitwhen u == null
        if SubString(myArg[0], 0, 1) == "+" then
            call SetUnitFacing(u, GetUnitFacing(u) + S2R(SubString(myArg[0], 1, StringLength(myArg[0]) - 7)))
        elseif SubString(myArg[0], 0, 1) == "-" then
            call SetUnitFacing(u, GetUnitFacing(u) - S2R(SubString(myArg[0], 1, StringLength(myArg[0]) - 7)))
        else
            call SetUnitFacing(u, S2R(myArg[0]))
        endif
        call GroupRemoveUnit(g, u)
        set u=null
    endloop
    call DestroyGroup(g)
    set g=null
endfunction

//===========================================================================
function InitTrig_miscFace takes nothing returns nothing
    set gg_trg_miscFace=CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(gg_trg_miscFace , "-face " , false)
    call TriggerAddAction(gg_trg_miscFace, function miscFace_Actions)
endfunction
//===========================================================================
// Trigger: miscFriendlyAttack
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function miscFriendlyAttack_Actions takes nothing returns nothing
    if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetAttacker())) and GetUnitTypeId(GetTriggerUnit()) != s__wisp_type then
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) then
            call KillUnit(GetTriggerUnit())
        endif
    endif
endfunction

//===========================================================================
function InitTrig_miscFriendlyAttack takes nothing returns nothing
    set gg_trg_miscFriendlyAttack=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_miscFriendlyAttack, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddAction(gg_trg_miscFriendlyAttack, function miscFriendlyAttack_Actions)
endfunction
//===========================================================================
// Trigger: miscKillReturn
//
// struct bountyStruct
//     integer ID
//     integer gold
//     real XP
// endstruct
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscKillReturn_Actions takes nothing returns nothing
    local integer i= 0
    if GetKillingUnit() != null then
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and IsUnitAlly(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) == false and GetUnitTypeId(GetTriggerUnit()) != s__wolf_wardtype then
            loop
                exitwhen bounty[i] == 0
                if s__bountyStruct_ID[bounty[i]] == GetUnitTypeId(GetTriggerUnit()) then
                    if s__bountyStruct_gold[bounty[i]] > 0 then
                        call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + s__bountyStruct_gold[bounty[i]])
                        call SmallText(s__bountyStruct_gold[bounty[i]] , GetTriggerUnit() , 14 , 0 , 0)
                    endif
                    if s__bountyStruct_XP[bounty[i]] > 0 then
                        call SetHeroXP(mainUnit(GetOwningPlayer(GetKillingUnit())), GetHeroXP(mainUnit(GetOwningPlayer(GetKillingUnit()))) + s__bountyStruct_XP[bounty[i]], true)
                        call SmallText(s__bountyStruct_XP[bounty[i]] , GetTriggerUnit() , 3 , 16 , - 32)
                    endif
                    exitwhen 0 == 0
                endif
                set i=i + 1
            endloop
        elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_wardtype and IsUnitAlly(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) == false then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 5)
            call SmallText(5 , GetKillingUnit() , 14 , 0 , 0)
        elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_golemtype and IsUnitAlly(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) == false then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 50)
            call SmallText(50 , GetKillingUnit() , 14 , 0 , 0)
        elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_stalkertype and IsUnitAlly(GetKillingUnit(), GetOwningPlayer(GetTriggerUnit())) == false then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 75)
            call SmallText(75 , GetKillingUnit() , 14 , 0 , 0)
        endif
    endif
endfunction

//===========================================================================
function InitTrig_miscKillReturn takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function Trig_miscKillReturn_Actions)
endfunction
//===========================================================================
// Trigger: miscSmartSave
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_miscSmartSave_Actions takes nothing returns nothing
    if OrderId2StringBJ(GetIssuedOrderId()) == "smart" then
        if IsUnitAlly(GetTriggerUnit(), GetOwningPlayer(GetOrderTargetUnit())) and GetUnitTypeId(GetOrderTargetUnit()) == s__wisp_type then
            call IssueTargetOrder(GetTriggerUnit(), "attack", GetOrderTargetUnit())
        endif
    endif
endfunction

//===========================================================================
function InitTrig_miscSmartSave takes nothing returns nothing
    set gg_trg_miscSmartSave=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_miscSmartSave, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
    call TriggerAddAction(gg_trg_miscSmartSave, function Trig_miscSmartSave_Actions)
endfunction
//===========================================================================
// Trigger: sheepFarmSelfDestruct
//
// Work
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_sheepFarmSelfDestruct_Actions takes nothing returns nothing
    call KillUnit(GetTriggerUnit())
endfunction

//===========================================================================
function InitTrig_sheepFarmSelfDestruct takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_TRAIN_START)
    call TriggerAddAction(t, function Trig_sheepFarmSelfDestruct_Actions)
endfunction
//===========================================================================
// Trigger: sheepSaveDeath
//
// ToDo:
// Make this trigger readable by seperating parts into functions
// tatic integer type = 'EC03'
//     static integer blacktype = 'E002'
//     static integer imbatype = 'E000'
//===========================================================================
//TESH.scrollpos=156
//TESH.alwaysfold=0
function sheepSaveDeath_removeDyingSheepUnits takes nothing returns boolean
    if GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(GetTriggerUnit()) then
        //return UnitDamageTarget(GetKillingUnit(), GetFilterUnit(), 10000, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        //call KillUnit(GetFilterUnit())
        call RemoveUnit(GetFilterUnit())
    endif
    return false
endfunction

function sheepSaveDeath_isEnemy takes nothing returns boolean
    return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == false
endfunction

function Trig_sheepSaveDeath_Actions takes nothing returns nothing
    local group g
    local force fo
    local integer i
    local real x
    local real y
    local real f
    local player p
    local integer l
    local integer array it
    local boolean lose= true
    local real totalRange= 0
    local real array range
    local unit u
    local integer aType
    if GetUnitTypeId(GetTriggerUnit()) == s__sheep_type or GetUnitTypeId(GetTriggerUnit()) == s__sheep_blacktype or GetUnitTypeId(GetTriggerUnit()) == s__sheep_silvertype or GetUnitTypeId(GetTriggerUnit()) == s__sheep_goldtype then
        call ForceRemovePlayer(sheepTeam, GetOwningPlayer(GetTriggerUnit()))
        call ForceAddPlayer(wispTeam, GetOwningPlayer(GetTriggerUnit()))
        call DisplayTextToForce(GetPlayersAll(), color[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] + GetPlayerName(GetOwningPlayer(GetTriggerUnit())) + "|r has been " + color[13] + "killed|r by " + color[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] + GetPlayerName(GetOwningPlayer(GetKillingUnit())) + "|r!")
        set g=CreateGroup()
        call GroupEnumUnitsInRect(g, GetWorldBounds(), Condition(function sheepSaveDeath_removeDyingSheepUnits))
        set wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__wisp_type, - 256, - 832, 270)
        call SetUnitPathing(wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], false)
        if InStr(GetPlayerName(GetOwningPlayer(GetTriggerUnit())) , "Grim") >= 0 then
            call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
            call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
        endif
        set saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))]=saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] + 1
        if saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 10 or saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 50 then
            if saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 10 then
                set aType=s__wolf_blacktype
            else
                set aType=s__wolf_imbatype
            endif
            set p=GetOwningPlayer(GetKillingUnit())
            if GetUnitTypeId(wolves[GetPlayerId(p)]) != s__wolf_wwtype then
                set x=GetUnitX(wolves[GetPlayerId(p)])
                set y=GetUnitY(wolves[GetPlayerId(p)])
                set f=GetUnitFacing(wolves[GetPlayerId(p)])
                set l=GetUnitLevel(wolves[GetPlayerId(p)])
                set i=0
                loop
                    exitwhen i == 6
                    set it[i]=GetItemTypeId(UnitItemInSlot(wolves[GetPlayerId(p)], i))
                    set i=i + 1
                endloop
                call RemoveUnit(wolves[GetPlayerId(p)])
                set wolves[GetPlayerId(p)]=CreateUnit(p, aType, x, y, f)
                call SetHeroLevel(wolves[GetPlayerId(p)], l, false)
                if InStr(GetPlayerName(p) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", wolves[GetPlayerId(p)], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", wolves[GetPlayerId(p)], "head")
                endif
                call SelectUnitForPlayerSingle(wolves[GetPlayerId(p)], p)
                set i=0
                loop
                    exitwhen i == 6
                    call UnitAddItem(wolves[GetPlayerId(p)], CreateItem(it[i], x, y))
                    set i=i + 1
                endloop
                call UnitAddItem(wolves[GetPlayerId(p)], CreateItem(s__wolf_cloakitem, x, y))
            else
                set x=GetUnitX(wws[GetPlayerId(p)])
                set y=GetUnitY(wws[GetPlayerId(p)])
                set f=GetUnitFacing(wws[GetPlayerId(p)])
                set l=GetUnitLevel(wws[GetPlayerId(p)])
                set i=0
                loop
                    exitwhen i == 6
                    set it[i]=GetItemTypeId(UnitItemInSlot(wws[GetPlayerId(p)], i))
                    set i=i + 1
                endloop
                call RemoveUnit(wws[GetPlayerId(p)])
                set wws[GetPlayerId(p)]=CreateUnit(Player(15), aType, x, y, f)
                call SetUnitX(wws[GetPlayerId(p)], - 6144)
                call SetUnitY(wws[GetPlayerId(p)], - 6656)
                call PauseUnit(wws[GetPlayerId(p)], true)
                call SetHeroLevel(wws[GetPlayerId(p)], l, false)
                set i=0
                loop
                    exitwhen i == 6
                    call UnitAddItem(wws[GetPlayerId(p)], CreateItem(it[i], x, y))
                    set i=i + 1
                endloop
                call UnitAddItem(wws[GetPlayerId(p)], CreateItem(s__wolf_cloakitem, x, y))
            endif
        endif
        call DestroyGroup(g)
        set g=null
        set i=0
        loop
            exitwhen i == 12
            if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and IsPlayerInForce(Player(i), wolfTeam) then
                if Player(i) == GetOwningPlayer(GetKillingUnit()) then
                    call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + R2I(( I2R(countHere(sheepTeam)) + I2R(countHere(wispTeam)) ) / I2R(countHere(wolfTeam)) * 12.5))
                    call SmallText(R2I(( I2R(countHere(sheepTeam)) + I2R(countHere(wispTeam)) ) / I2R(countHere(wolfTeam)) * 12.5) , wolves[i] , 14 , 0 , 0)
                else
                    call SetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) + R2I(( I2R(countHere(sheepTeam)) + I2R(countHere(wispTeam)) ) / I2R(countHere(wolfTeam)) * 10))
                    call SmallText(R2I(( I2R(countHere(sheepTeam)) + I2R(countHere(wispTeam)) ) / I2R(countHere(wolfTeam)) * 10) , wolves[i] , 14 , 0 , 0)
                endif
            endif
            set i=i + 1
        endloop
    elseif GetUnitTypeId(GetTriggerUnit()) == s__wisp_type then
        if GetUnitTypeId(GetKillingUnit()) != s__wisp_type then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 100)
            call SmallText(100 , GetKillingUnit() , 14 , 0 , 0)
            call ForceAddPlayer(sheepTeam, GetOwningPlayer(GetTriggerUnit()))
            call ForceRemovePlayer(wispTeam, GetOwningPlayer(GetTriggerUnit()))
            call DisplayTextToForce(GetPlayersAll(), color[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] + GetPlayerName(GetOwningPlayer(GetTriggerUnit())) + "|r has been " + color[12] + "saved|r by " + color[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] + GetPlayerName(GetOwningPlayer(GetKillingUnit())) + "|r!")
            loop
                set i=GetRandomInt(0, 12)
                exitwhen IsPlayerInForce(Player(i), sheepTeam)
            endloop
            set x=GetStartLocationX(i)
            set y=GetStartLocationY(i)
            if saveskills[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] >= 25 then
                set sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__sheep_goldtype, x, y, 270)
            elseif saveskills[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] >= 15 then
                set sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__sheep_silvertype, x, y, 270)
            elseif saveskills[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] >= 10 then
                set sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__sheep_blacktype, x, y, 270)
            else
                set sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__sheep_type, x, y, 270)
            endif
            if GetLocalPlayer() == GetOwningPlayer(GetTriggerUnit()) then
                call PanCameraToTimed(x, y, 0)
                call ClearSelection()
                call SelectUnit(sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], true)
            endif
            if dEnabled[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
                call UnitAddAbility(sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], s__sheep_dability)
            endif
            if InStr(GetPlayerName(GetOwningPlayer(GetTriggerUnit())) , "Grim") >= 0 then
                call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
                call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", sheeps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
            endif
            set saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))]=saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] + 1
            if saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 10 and IsPlayerInForce(GetOwningPlayer(GetKillingUnit()), sheepTeam) then
                set x=GetUnitX(GetKillingUnit())
                set y=GetUnitY(GetKillingUnit())
                set f=GetUnitFacing(GetKillingUnit())
                set p=GetOwningPlayer(GetKillingUnit())
                call RemoveUnit(GetKillingUnit())
                set sheeps[GetPlayerId(p)]=CreateUnit(p, s__sheep_blacktype, x, y, f)
                call SelectUnitForPlayerSingle(sheeps[GetPlayerId(p)], Player(GetPlayerId(p)))
                if dEnabled[GetPlayerId(p)] then
                    call UnitAddAbility(sheeps[GetPlayerId(p)], s__sheep_dability)
                endif
                if InStr(GetPlayerName(p) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sheeps[GetPlayerId(p)], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", sheeps[GetPlayerId(p)], "origin")
                endif
            elseif saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 15 and IsPlayerInForce(GetOwningPlayer(GetKillingUnit()), sheepTeam) then
                set x=GetUnitX(GetKillingUnit())
                set y=GetUnitY(GetKillingUnit())
                set f=GetUnitFacing(GetKillingUnit())
                set p=GetOwningPlayer(GetKillingUnit())
                call RemoveUnit(GetKillingUnit())
                set sheeps[GetPlayerId(p)]=CreateUnit(p, s__sheep_silvertype, x, y, f)
                call SelectUnitForPlayerSingle(sheeps[GetPlayerId(p)], Player(GetPlayerId(p)))
                if dEnabled[GetPlayerId(p)] then
                    call UnitAddAbility(sheeps[GetPlayerId(p)], s__sheep_dability)
                endif
                if InStr(GetPlayerName(p) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sheeps[GetPlayerId(p)], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", sheeps[GetPlayerId(p)], "origin")
                endif
            elseif saveskills[GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 25 and IsPlayerInForce(GetOwningPlayer(GetKillingUnit()), sheepTeam) then
                set x=GetUnitX(GetKillingUnit())
                set y=GetUnitY(GetKillingUnit())
                set f=GetUnitFacing(GetKillingUnit())
                set p=GetOwningPlayer(GetKillingUnit())
                call RemoveUnit(GetKillingUnit())
                set sheeps[GetPlayerId(p)]=CreateUnit(p, s__sheep_goldtype, x, y, f)
                call SelectUnitForPlayerSingle(sheeps[GetPlayerId(p)], Player(GetPlayerId(p)))
                if dEnabled[GetPlayerId(p)] then
                    call UnitAddAbility(sheeps[GetPlayerId(p)], s__sheep_dability)
                endif
                if InStr(GetPlayerName(p) , "Grim") >= 0 then
                    call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sheeps[GetPlayerId(p)], "origin")
                    call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", sheeps[GetPlayerId(p)], "origin")
                endif
            endif
        else
            set wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__wisp_type, - 256, - 832, 270)
            call SetUnitPathing(wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], false)
            if InStr(GetPlayerName(GetOwningPlayer(GetTriggerUnit())) , "Grim") >= 0 then
                call AddSpecialEffectTarget("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
                call AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl", wisps[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))], "origin")
            endif
        endif
    elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_type or GetUnitTypeId(GetTriggerUnit()) == s__wolf_blacktype or GetUnitTypeId(GetTriggerUnit()) == s__wolf_imbatype then
        if GetUnitTypeId(GetTriggerUnit()) == s__wolf_type then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 1000)
            call SmallText(1000 , GetKillingUnit() , 14 , 0 , 0)
        elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_blacktype then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 5000)
            call SmallText(5000 , GetKillingUnit() , 14 , 0 , 0)
        elseif GetUnitTypeId(GetTriggerUnit()) == s__wolf_imbatype then
            call SetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetKillingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 25000)
            call SmallText(25000 , GetKillingUnit() , 14 , 0 , 0)
        endif
        call TriggerSleepAction(5)
        call ReviveHero(GetTriggerUnit(), GetStartLocationX(GetPlayerId(GetOwningPlayer(GetTriggerUnit()))), GetStartLocationY(GetPlayerId(GetOwningPlayer(GetTriggerUnit()))), true)
    endif
    call reloadMultiboard()
    if countHere(sheepTeam) == 0 then
        call endGame(2)
    endif
endfunction

//===========================================================================
function InitTrig_sheepSaveDeath takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddAction(t, function Trig_sheepSaveDeath_Actions)
endfunction
//===========================================================================
// Trigger: sheepWispLeave
//
// Work
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_sheepWispLeave_Actions takes nothing returns nothing
    if GetUnitTypeId(GetTriggerUnit()) == s__wisp_type then
        call SetUnitPosition(GetTriggerUnit(), - 256, - 832)
    endif
endfunction

//===========================================================================
function InitTrig_sheepWispLeave takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterLeaveRectSimple(t, gg_rct_Pen)
    call TriggerAddAction(t, function Trig_sheepWispLeave_Actions)
endfunction
//===========================================================================
// Trigger: sheepCommands
//
// 0 2 3 9 12 14 15
//===========================================================================
//TESH.scrollpos=27
//TESH.alwaysfold=0
function Trig_sheepCommands_RemoveProperFarms takes nothing returns boolean
    if GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[1]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[4]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[5]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[6]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[7]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[8]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[10]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[11]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[13]] or GetUnitTypeId(GetFilterUnit()) == s__bountyStruct_ID[bounty[16]] then
        //call KillUnit(GetFilterUnit())
        call RemoveUnit(GetFilterUnit())
    endif
    return false
endfunction

function Trig_sheepCommands_RemoveAllButSaving takes nothing returns boolean
    if GetUnitTypeId(GetFilterUnit()) != s__bountyStruct_ID[bounty[3]] and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) then
        //call KillUnit(GetFilterUnit())
        call RemoveUnit(GetFilterUnit())
    endif
    return false
endfunction

function Trig_sheepCommands_Actions takes nothing returns nothing
    local integer i= 0
    local integer n
    local group g
    if GetEventPlayerChatString() == "-d" then
        set g=CreateGroup()
        call GroupEnumUnitsOfPlayer(g, GetTriggerPlayer(), Condition(function Trig_sheepCommands_RemoveProperFarms))
        call DestroyGroup(g)
        set g=null
        return
    elseif GetEventPlayerChatString() == "-d on" then
        set dEnabled[GetPlayerId(GetTriggerPlayer())]=true
        call UnitAddAbility(sheeps[GetPlayerId(GetTriggerPlayer())], s__sheep_dability)
        return
    elseif GetEventPlayerChatString() == "-d off" then
        set dEnabled[GetPlayerId(GetTriggerPlayer())]=false
        call UnitRemoveAbility(sheeps[GetPlayerId(GetTriggerPlayer())], s__sheep_dability)
        return
    elseif GetEventPlayerChatString() == "-dall" then
        set g=CreateGroup()
        call GroupEnumUnitsOfPlayer(g, GetTriggerPlayer(), Condition(function Trig_sheepCommands_RemoveAllButSaving))
        call DestroyGroup(g)
        set g=null
        return
    endif
    loop
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
            if Player(i) == GetTriggerPlayer() then
                set n=0
                loop
                    exitwhen n == 12
                    if GetEventPlayerChatString() == "-wolf gold" then
                        call DisplayTextToPlayer(Player(n), 0, 0, color[i] + GetPlayerName(GetTriggerPlayer()) + "|r gave the shepherds 100 gold!")
                        if IsPlayerInForce(Player(n), wolfTeam) then
                            call SetPlayerState(Player(n), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(n), PLAYER_STATE_RESOURCE_GOLD) + 100)
                        endif
                    elseif GetEventPlayerChatString() == "-destroy all farms" then
                        call DisplayTextToPlayer(Player(n), 0, 0, color[i] + GetPlayerName(GetTriggerPlayer()) + "|r has destroyed all the farms!")
                        if n == 0 then
                            set g=CreateGroup()
                            call GroupEnumUnitsInRect(g, GetWorldBounds(), Condition(function Trig_sheepCommands_RemoveProperFarms))
                            call DestroyGroup(g)
                            set g=null
                        endif
                    endif
                    set n=n + 1
                endloop
            else
                return
            endif
        endif
        set i=i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_sheepCommands takes nothing returns nothing
    set gg_trg_sheepCommands=CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-wolf gold" , true)
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-destroy all farms" , true)
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-d" , true)
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-dall" , true)
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-d on" , true)
    call TriggerRegisterPlayerChatEventAll(gg_trg_sheepCommands , "-d off" , true)
    call TriggerAddAction(gg_trg_sheepCommands, function Trig_sheepCommands_Actions)
endfunction
//===========================================================================
// Trigger: sheepJotyeFarm
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_sheepJotyeFarm_isJotye takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == s__sheep_jotye and UnitAlive(GetFilterUnit())
endfunction

function Trig_sheepJotyeFarm_Actions takes nothing returns nothing
    local group g
    if GetUnitTypeId(GetTriggerUnit()) == s__wolf_type or GetUnitTypeId(GetTriggerUnit()) == s__wolf_blacktype or GetUnitTypeId(GetTriggerUnit()) == s__wolf_imbatype or GetUnitTypeId(GetTriggerUnit()) == s__wolf_golemtype or GetUnitTypeId(GetTriggerUnit()) == s__wolf_stalkertype then
        set g=CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 1024, Condition(function Trig_sheepJotyeFarm_isJotye))
        if CountUnitsInGroup(g) > 0 then
            call DisableTrigger(GetTriggeringTrigger())
            call IssuePointOrderById(GetTriggerUnit(), GetIssuedOrderId(), GetUnitX(GetTriggerUnit()) + ( GetUnitX(GetTriggerUnit()) - GetOrderPointX() ), GetUnitY(GetTriggerUnit()) + ( GetUnitY(GetTriggerUnit()) - GetOrderPointY() ))
            call EnableTrigger(GetTriggeringTrigger())
        endif
        call DestroyGroup(g)
        set g=null
    endif
endfunction

//===========================================================================
function InitTrig_sheepJotyeFarm takes nothing returns nothing
    set gg_trg_sheepJotyeFarm=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_sheepJotyeFarm, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddAction(gg_trg_sheepJotyeFarm, function Trig_sheepJotyeFarm_Actions)
endfunction
//===========================================================================
// Trigger: sheepDestroyLastFarm
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_sheepDestroyLastFarm_Actions takes nothing returns nothing
    local group g
    if GetSpellAbilityId() == s__sheep_xability then
        call KillUnit(GetBuilding(GetOwningPlayer(GetTriggerUnit())))
    elseif GetSpellAbilityId() == s__sheep_dability then
        set g=CreateGroup()
        call GroupEnumUnitsOfPlayer(g, GetTriggerPlayer(), Condition(function Trig_sheepCommands_RemoveProperFarms))
        call DestroyGroup(g)
        set g=null
    endif
endfunction

//===========================================================================
function InitTrig_sheepDestroyLastFarm takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddAction(t, function Trig_sheepDestroyLastFarm_Actions)
endfunction
//===========================================================================
// Trigger: wolfQuickBuy
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function hasInventoryAndControlled takes nothing returns boolean
    return IsUnitIllusion(GetFilterUnit()) == false and GetUnitAbilityLevel(GetFilterUnit(), 'AInv') > 0 and ( GetPlayerAlliance(GetOwningPlayer(GetFilterUnit()), GetTriggerPlayer(), ALLIANCE_SHARED_ADVANCED_CONTROL) or GetOwningPlayer(GetFilterUnit()) == GetTriggerPlayer() )
endfunction

function wolfQuickBuy_Actions takes nothing returns nothing
    local integer i= 0
    local group g= CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), Condition(function hasInventoryAndControlled))
    if CountUnitsInGroup(g) > 0 then
        set u=FirstOfGroup(g)
    else
        set u=wolves[GetPlayerId(GetTriggerPlayer())]
    endif
    call DestroyGroup(g)
    set g=null
    if IsPlayerInForce(GetTriggerPlayer(), wolfTeam) then
        call Split(GetEventPlayerChatString() , " " , true)
        loop
            exitwhen s__myItem_name[items[i]] == null
            if myArg[0] == s__myItem_name[items[i]] then
                if GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) >= R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax) and GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) >= R2I(I2R(s__myItem_lumber[items[i]]) * quickBuyTax) then
                    call UnitAddItem(u, CreateItem(s__myItem_ID[items[i]], GetUnitX(u), GetUnitY(u)))
                    call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) - R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax))
                    call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) - R2I(I2R(s__myItem_lumber[items[i]]) * quickBuyTax))
                elseif GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) < R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax) and GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) < R2I(I2R(s__myItem_lumber[items[i]]) * quickBuyTax) then
                    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "That item costs " + I2S(R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax)) + " gold and " + I2S(R2I(I2R(s__myItem_lumber[items[i]]) * quickBuyTax)) + " lumber.")
                elseif GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) < R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax) then
                    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "That item costs " + I2S(R2I(I2R(s__myItem_gold[items[i]]) * quickBuyTax)) + " gold.")
                else
                    call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "That item costs " + I2S(R2I(I2R(s__myItem_lumber[items[i]]) * quickBuyTax)) + " lumber.")
                endif
                exitwhen 0 == 0
            endif
            set i=i + 1
        endloop
    endif
endfunction

function wolfQuickSell_Actions takes nothing returns nothing
    local integer i
    local integer n= 0
    local group g= CreateGroup()
    local unit u
    call GroupEnumUnitsSelected(g, GetTriggerPlayer(), Condition(function hasInventoryAndControlled))
    if CountUnitsInGroup(g) > 0 then
        set u=FirstOfGroup(g)
    else
        set u=wolves[GetPlayerId(GetTriggerPlayer())]
    endif
    call DestroyGroup(g)
    set g=null
    if IsPlayerInForce(GetTriggerPlayer(), wolfTeam) then
        call Split(GetEventPlayerChatString() , " " , true)
        if myArg[0] == "all" then
            call Split("-sell 1 2 3 4 5 6" , " " , true)
        endif
        loop
            exitwhen myArg[n] == null
            if UnitItemInSlot(u, S2I(myArg[n]) - 1) != null then
                set i=0
                loop
                    exitwhen s__myItem_ID[items[i]] == null
                    if GetItemTypeId(UnitItemInSlot(u, S2I(myArg[n]) - 1)) == s__myItem_ID[items[i]] then
                        call RemoveItem(UnitItemInSlot(u, S2I(myArg[n]) - 1))
                        call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) + R2I(I2R(s__myItem_gold[items[i]]) * quickSellTax))
                        call SetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetTriggerPlayer(), PLAYER_STATE_RESOURCE_LUMBER) + R2I(I2R(s__myItem_lumber[items[i]]) * quickSellTax))
                        exitwhen true
                    endif
                    set i=i + 1
                endloop
            endif
            set n=n + 1
        endloop
    endif
endfunction

//===========================================================================
function InitTrig_wolfQuickBuy takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-buy " , false)
    call TriggerAddAction(t, function wolfQuickBuy_Actions)
    set t=null
    set t=CreateTrigger()
    call TriggerRegisterPlayerChatEventAll(t , "-sell " , false)
    call TriggerAddAction(t, function wolfQuickSell_Actions)
endfunction
//===========================================================================
// Trigger: wolfWhiteWolf
//===========================================================================
//TESH.scrollpos=19
//TESH.alwaysfold=0

function Trig_wolfWhiteWolf_Actions takes nothing returns nothing
    local real x
    local real y
    local real f
    local player p
    local unit u
    if GetItemTypeId(GetManipulatedItem()) == s__wolf_wwitem then //WW
        call RemoveItem(GetManipulatedItem())
        set x=GetUnitX(GetTriggerUnit())
        set y=GetUnitY(GetTriggerUnit())
        set f=GetUnitFacing(GetTriggerUnit())
        set p=GetOwningPlayer(GetTriggerUnit())
        call PauseUnit(GetTriggerUnit(), true)
        call SetUnitOwner(GetTriggerUnit(), Player(15), false)
        call SetUnitX(GetTriggerUnit(), - 6144)
        call SetUnitY(GetTriggerUnit(), - 6656)
        set wws[GetPlayerId(p)]=GetTriggerUnit()
        set wolves[GetPlayerId(p)]=CreateUnit(p, s__wolf_wwtype, x, y, f)
        call SelectUnitForPlayerSingle(wolves[GetPlayerId(p)], p)
        call TimerStart(wwTimer[GetPlayerId(p)], 60, false, null)
        call TimerDialogSetTitle(wwTimerDialog[GetPlayerId(p)], "Changing in...")
        if GetLocalPlayer() == p then
            call TimerDialogDisplay(wwTimerDialog[GetPlayerId(p)], true)
        endif
        call TriggerSleepAction(60)
        if GetLocalPlayer() == p then
            call TimerDialogDisplay(wwTimerDialog[GetPlayerId(p)], false)
        endif
        set x=GetUnitX(wolves[GetPlayerId(p)])
        set y=GetUnitY(wolves[GetPlayerId(p)])
        set f=GetUnitFacing(wolves[GetPlayerId(p)])
        call RemoveUnit(wolves[GetPlayerId(p)])
        call PauseUnit(wws[GetPlayerId(p)], false)
        call SetUnitOwner(wws[GetPlayerId(p)], p, false)
        call SetUnitPosition(wws[GetPlayerId(p)], x, y)
        set wolves[GetPlayerId(p)]=wws[GetPlayerId(p)]
        call SelectUnitForPlayerSingle(wolves[GetPlayerId(p)], p)
    endif
endfunction

//===========================================================================
function InitTrig_wolfWhiteWolf takes nothing returns nothing
    local integer i= 0
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    call TriggerAddAction(t, function Trig_wolfWhiteWolf_Actions)
    loop
        exitwhen i == 12
        set wwTimer[i]=CreateTimer()
        set wwTimerDialog[i]=CreateTimerDialog(wwTimer[i])
        set i=i + 1
    endloop
endfunction
//===========================================================================
// Trigger: wolfLumber
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_wolfLumber_Actions takes nothing returns nothing
    if GetHeroLevel(GetTriggerUnit()) >= 3 then
        call SetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER) + 2)
    endif
endfunction

//===========================================================================
function InitTrig_wolfLumber takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_HERO_LEVEL)
    call TriggerAddAction(t, function Trig_wolfLumber_Actions)
endfunction
//===========================================================================
// Trigger: wolfWard
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_wolfWard_Actions takes nothing returns nothing
    local location loc= GetSpellTargetLoc()
    local unit u
    if GetSpellAbilityId() == s__wolf_wardability then
        set u=CreateUnit(GetOwningPlayer(GetTriggerUnit()), s__wolf_wardtype, GetLocationX(loc), GetLocationY(loc), 270)
        call SetUnitPosition(u, GetLocationX(loc), GetLocationY(loc))
        call UnitApplyTimedLife(u, 'BTLF', 240)
        set u=null
    endif
    call RemoveLocation(loc)
    set loc=null
endfunction

//===========================================================================
function InitTrig_wolfWard takes nothing returns nothing
    local trigger t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddAction(t, function Trig_wolfWard_Actions)
endfunction
//===========================================================================
// Trigger: wolfCloakOfFlames
//===========================================================================
//TESH.scrollpos=15
//TESH.alwaysfold=0
function wolfCloakOfFlames_HasCloak takes nothing returns boolean
    local integer i= 0
    loop
        exitwhen i == 6
        if GetItemTypeId(UnitItemInSlot(GetFilterUnit(), i)) == s__wolf_cloakitem and IsUnitIllusion(GetFilterUnit()) == false then //cloak
            return true
        endif
        set i=i + 1
    endloop
    return false
endfunction

function Trig_wolfCloakOfFlames_Actions takes nothing returns nothing
    local integer i= 0
    local integer n
    local real x
    local real y
    local group g
    local group r= CreateGroup()
    local unit u
    local unit t
    call GroupEnumUnitsInRect(r, GetWorldBounds(), Condition(function wolfCloakOfFlames_HasCloak))
    loop
        set t=FirstOfGroup(r)
        exitwhen t == null
        set x=GetUnitX(t)
        set y=GetUnitY(t)
        set g=CreateGroup()
        call GroupEnumUnitsInRange(g, x, y, 256, null)
        loop
            set u=FirstOfGroup(g)
            exitwhen u == null
            if IsUnitType(u, UNIT_TYPE_STRUCTURE) then
                set n=0
                loop
                    exitwhen n == 6
                    if GetItemTypeId(UnitItemInSlot(t, n)) == s__wolf_cloakitem then //cloak
                        call UnitDamageTarget(t, u, 15, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                    endif
                    set n=n + 1
                endloop
            endif
            call GroupRemoveUnit(g, u)
            set u=null
        endloop
        call DestroyGroup(g)
        set g=null
        call GroupRemoveUnit(r, t)
        set t=null
    endloop
    call DestroyGroup(r)
    set r=null
endfunction

//===========================================================================
function InitTrig_wolfCloakOfFlames takes nothing returns nothing
    set gg_trg_wolfCloakOfFlames=CreateTrigger()
    call TriggerRegisterTimerEvent(gg_trg_wolfCloakOfFlames, 1, true)
    call TriggerAddAction(gg_trg_wolfCloakOfFlames, function Trig_wolfCloakOfFlames_Actions)
endfunction
//===========================================================================
// Trigger: eggGem
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_eggGem_Actions takes nothing returns nothing
    local integer i= GetRandomInt(0, 100)
    if GetItemTypeId(GetManipulatedItem()) == s__wolf_gem then
        if gemActivated[GetPlayerId(GetTriggerPlayer())] then
            set gemActivated[GetPlayerId(GetTriggerPlayer())]=false
            call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, color[3] + "Gem deactivated.")
        else
            set gemActivated[GetPlayerId(GetTriggerPlayer())]=true
            if i == 0 then
                call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, color[3] + "Perfect gem activated.")
            else
                call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, color[3] + "Gem activated.")
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_eggGem takes nothing returns nothing
    set gg_trg_eggGem=CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(gg_trg_eggGem, EVENT_PLAYER_UNIT_USE_ITEM)
    call TriggerAddAction(gg_trg_eggGem, function Trig_eggGem_Actions)
endfunction
//===========================================================================
// Trigger: eggDolly
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0

function Trig_eggDolly_Actions takes nothing returns nothing
    local effect e
    set dollyClick[GetPlayerId(GetTriggerPlayer())]=dollyClick[GetPlayerId(GetTriggerPlayer())] + 1
    if dollyClick[GetPlayerId(GetTriggerPlayer())] > 10 then
        set e=AddSpecialEffectTarget("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdx", GetTriggerUnit(), "origin")
        call DestroyEffect(e)
        set e=AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdx", GetTriggerUnit(), "origin")
        call DestroyEffect(e)
        set e=AddSpecialEffectTarget("Abilities\\Weapons\\Mortar\\MortarMissile.mdx", GetTriggerUnit(), "origin")
        call DestroyEffect(e)
        set e=AddSpecialEffectTarget("Objects\\Spawnmodels\\Orc\\OrcSmallDeathExplode\\OrcSmallDeathExplode.mdx", GetTriggerUnit(), "origin")
        call DestroyEffect(e)
        if katama then
            set katama=false
            call CreateUnit(Player(15), s__sheep_katama, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), GetUnitFacing(GetTriggerUnit()) + 180)
        endif
        call KillUnit(GetTriggerUnit())
        if GetTriggerPlayer() == GetLocalPlayer() then
            call EnableUserControl(false)
            call TriggerSleepAction(60)
            call EnableUserControl(true)
        endif
    endif
endfunction

function Trig_eggDolly_Tick takes nothing returns nothing
    local integer i= 0
    loop
        exitwhen i == 12
        if dollyClick[i] > 0 then
            set dollyClick[i]=dollyClick[i] - 1
        endif
        set i=i + 1
    endloop
    if CountLivingPlayerUnitsOfTypeId(s__sheep_dolly, Player(15)) == 0 then
        call CreateUnit(Player(15), s__sheep_dolly, - 256, - 768, 270)
    endif
endfunction

function Trig_eggDolly_isDolly takes nothing returns boolean
    return GetUnitTypeId(GetFilterUnit()) == s__sheep_dolly
endfunction

//===========================================================================
function InitTrig_eggDolly takes nothing returns nothing
    local trigger t= CreateTrigger()
    set gg_trg_eggDolly=CreateTrigger()
    call TriggerRegisterPlayerUnitEventAll(gg_trg_eggDolly , EVENT_PLAYER_UNIT_SELECTED , Condition(function Trig_eggDolly_isDolly))
    call TriggerAddAction(gg_trg_eggDolly, function Trig_eggDolly_Actions)
    call TriggerRegisterTimerEvent(t, 1, true)
    call TriggerAddAction(t, function Trig_eggDolly_Tick)
endfunction
//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_coreInit()
    call InitTrig_coreGame()
    //Function not found: call InitTrig_changelog()
    call InitTrig_miscClean()
    call InitTrig_miscGoldTick()
    call InitTrig_miscZoom()
    call InitTrig_miscAngle()
    call InitTrig_miscGold()
    call InitTrig_miscControl()
    call InitTrig_miscUncontrol()
    call InitTrig_miscLeaves()
    call InitTrig_miscFace()
    call InitTrig_miscFriendlyAttack()
    call InitTrig_miscKillReturn()
    call InitTrig_miscSmartSave()
    call InitTrig_sheepFarmSelfDestruct()
    call InitTrig_sheepSaveDeath()
    call InitTrig_sheepWispLeave()
    call InitTrig_sheepCommands()
    call InitTrig_sheepJotyeFarm()
    call InitTrig_sheepDestroyLastFarm()
    call InitTrig_wolfQuickBuy()
    call InitTrig_wolfWhiteWolf()
    call InitTrig_wolfLumber()
    call InitTrig_wolfWard()
    call InitTrig_wolfCloakOfFlames()
    call InitTrig_eggGem()
    call InitTrig_eggDolly()
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_coreInit)
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call ForcePlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)

    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call ForcePlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)

    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call ForcePlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)

    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call ForcePlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)

    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call ForcePlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)

    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call ForcePlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)

    // Player 6
    call SetPlayerStartLocation(Player(6), 6)
    call ForcePlayerStartLocation(Player(6), 6)
    call SetPlayerColor(Player(6), ConvertPlayerColor(6))
    call SetPlayerRacePreference(Player(6), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(6), false)
    call SetPlayerController(Player(6), MAP_CONTROL_USER)

    // Player 7
    call SetPlayerStartLocation(Player(7), 7)
    call ForcePlayerStartLocation(Player(7), 7)
    call SetPlayerColor(Player(7), ConvertPlayerColor(7))
    call SetPlayerRacePreference(Player(7), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(7), false)
    call SetPlayerController(Player(7), MAP_CONTROL_USER)

    // Player 8
    call SetPlayerStartLocation(Player(8), 8)
    call SetPlayerColor(Player(8), ConvertPlayerColor(8))
    call SetPlayerRacePreference(Player(8), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(8), false)
    call SetPlayerController(Player(8), MAP_CONTROL_USER)

    // Player 9
    call SetPlayerStartLocation(Player(9), 9)
    call SetPlayerColor(Player(9), ConvertPlayerColor(9))
    call SetPlayerRacePreference(Player(9), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(9), false)
    call SetPlayerController(Player(9), MAP_CONTROL_USER)

    // Player 10
    call SetPlayerStartLocation(Player(10), 10)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_USER)

    // Player 11
    call SetPlayerStartLocation(Player(11), 11)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_USER)

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_013
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(6), 0)
    call SetPlayerState(Player(6), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(7), 0)
    call SetPlayerState(Player(7), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(7), Player(6), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(6), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(6), Player(7), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(7), Player(6), true)

    // Force: TRIGSTR_809
    call SetPlayerTeam(Player(8), 1)
    call SetPlayerState(Player(8), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(9), 1)
    call SetPlayerState(Player(9), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(10), 1)
    call SetPlayerState(Player(10), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(11), 1)
    call SetPlayerState(Player(11), PLAYER_STATE_ALLIED_VICTORY, 1)

    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(10), true)

    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(8), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(9), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(8), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(9), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(10), true)

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)

    call SetStartLocPrioCount(5, 1)
    call SetStartLocPrio(5, 0, 8, MAP_LOC_PRIO_HIGH)
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 5760.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 5760.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 5504.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 4352.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 5760.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 4352.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 5504.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 5760.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateRegions()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs1143932071")

    call InitGlobals()
    call InitCustomTriggers()
    call ConditionalTriggerExecute(gg_trg_coreInit) // INLINED!!

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName("TRIGSTR_039")
    call SetMapDescription("TRIGSTR_041")
    call SetPlayers(12)
    call SetTeams(12)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)

    call DefineStartLocation(0, - 896.0, - 1216.0)
    call DefineStartLocation(1, - 768.0, - 1408.0)
    call DefineStartLocation(2, - 128.0, - 1600.0)
    call DefineStartLocation(3, 384.0, - 1408.0)
    call DefineStartLocation(4, 320.0, - 704.0)
    call DefineStartLocation(5, 0.0, - 256.0)
    call DefineStartLocation(6, - 768.0, - 256.0)
    call DefineStartLocation(7, - 896.0, - 704.0)
    call DefineStartLocation(8, - 320.0, - 768.0)
    call DefineStartLocation(9, - 192.0, - 768.0)
    call DefineStartLocation(10, - 320.0, - 896.0)
    call DefineStartLocation(11, - 192.0, - 896.0)

    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

function jasshelper__initstructs1143932071 takes nothing returns nothing






endfunction
