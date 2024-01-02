/* +-------------------------------------------------------------------------+
 | Actual Game.t - This is the main file that will be run when the user    | 
 |                  wants to play the game. They can choose from single and| 
 |                  multiplayer and if they chose single player, they can  |
 |                  choose between easy, medium and hard difficulties. The |
 |                  objective of the single player mode is to shoot the    |
 |                  targets and collect enough points before 30 secs runs  |
 |                  out. In multiplayer, it is a pvp senario where you and |
 |                  the person right beside you get to battle each other   |
 |                  and the first to lose all 3 lives loses. In both game  |
 |                  modes, the user has an ability called 'Tracer' and it  |
 |                  allows them to dash 90 pixels in whichever direction   |
 |                  they're facing. Lastly the user can also choose the    |
 |                  rules tab, which will show them the rules for both     |
 |                  game modes and the control for player 1 and player 2.  |
 +-------------------------------------------------------------------------+
 | Author -  Kavin Nimalarajan                                             |
 | Date   -  June 09 2023                                                  |
 +-------------------------------------------------------------------------+
 | Input  -  User(s) key presses                                           |
 | Output -  A main menu, a single player game mode where there is map,    |
 |           player, target, timer, and points counter. There is also a    |
 |           lives counter [hearts], bullet inventory icon, and tracer     |
 |           cooldown. In multiplayer it is the same thing as single player|
 |           but exept for having a target, timer and points counter there |
 |           is another player with a new set of lives, bullet inventory   | 
 |           and tracer cooldown.                                          |
 +-------------------------------------------------------------------------+ */

include "Player.t"

%Declaring Variables for the Menu
var cControl : array char of boolean
var iGameMode, iMenuOption, iMenuAccumulator, iMenu1, iMenu2, iMenu3, iSingleplayer2,
    iMultiplayer1, iMultiplayer2, iRule1, iRule2, iRule3, iYes, iNo, iSingleplayerWin, iSingleplayerLose, iPlayer1Win, iPlayer2Win : int := 0
var bExit : boolean := false

iMenuOption := 1

var iHeart1, iHeart2, iHeart3, P1Lives, P2Lives, iEasy, iMed, iHard, iEasy2, iMed2, iHard2, iFont, iTimerAccum,
    iBullets1, iBullets2, iBullets3, iBullets4, iBullets5, iTimer, iPoints, iPointsReq, iWidth,
    iP1TracerAccum, iP2TracerAccum, iTarget, iTargetLocation, iTargetX, iTargetY : int := 0
var oPlayer, oPlayer2 : PlayerClass
var cLet : array char of boolean
var bP1Bulletkey, bP1Tracerkey, bP2Bulletkey, bP2Tracerkey : boolean := true
var sTimer, sPoints, sPlayAgain : string
ConstructPlayer (oPlayer)
ConstructPlayer (oPlayer2)

%Declaring Variables for the Menu Images
iMenu1 := Pic.Scale (Pic.FileNew ("Menu1.bmp"), 1600, 750)
iMenu2 := Pic.Scale (Pic.FileNew ("Menu2.bmp"), 1600, 750)
iMenu3 := Pic.Scale (Pic.FileNew ("Menu3.bmp"), 1600, 750)

%Declaring Pictures for the Loading Screens
iSingleplayer2 := Pic.Scale (Pic.FileNew ("Singleplayer.bmp"), 1600, 750)
iMultiplayer1 := Pic.Scale (Pic.FileNew ("Multiplayer1.bmp"), 1600, 750)
iMultiplayer2 := Pic.Scale (Pic.FileNew ("Multiplayer2.bmp"), 1600, 750)
iRule1 := Pic.Scale (Pic.FileNew ("Rules1.bmp"), 1600, 750)
iRule2 := Pic.Scale (Pic.FileNew ("Rules2.bmp"), 1600, 750)
iRule3 := Pic.Scale (Pic.FileNew ("Rules3.bmp"), 1600, 750)

%Declaring Pictures for the Hearts of the Players
iHeart1 := Pic.Scale (Pic.FileNew ("1Heart.bmp"), 240, 60)
iHeart2 := Pic.Scale (Pic.FileNew ("2Heart.bmp"), 240, 60)
iHeart3 := Pic.Scale (Pic.FileNew ("3Heart.bmp"), 240, 60)

%Declaring the Bullet Inventory Pictures
iBullets1 := Pic.Scale (Pic.FileNew ("Bullets1.bmp"), 75, 60)
iBullets2 := Pic.Scale (Pic.FileNew ("Bullets2.bmp"), 75, 60)
iBullets3 := Pic.Scale (Pic.FileNew ("Bullets3.bmp"), 75, 60)
iBullets4 := Pic.Scale (Pic.FileNew ("Bullets4.bmp"), 75, 60)
iBullets5 := Pic.Scale (Pic.FileNew ("Bullets5.bmp"), 75, 60)

%Declaring the Easy, Medium, Hard Selection Screens
iEasy := Pic.Scale (Pic.FileNew ("Easy1.bmp"), 1600, 750)
iMed := Pic.Scale (Pic.FileNew ("Med1.bmp"), 1600, 750)
iHard := Pic.Scale (Pic.FileNew ("Hard1.bmp"), 1600, 750)
iEasy2 := Pic.Scale (Pic.FileNew ("Easy2.bmp"), 1600, 750)
iMed2 := Pic.Scale (Pic.FileNew ("Med2.bmp"), 1600, 750)
iHard2 := Pic.Scale (Pic.FileNew ("Hard2.bmp"), 1600, 750)

%Font that will be used for time and points
iFont := Font.New ("Power Clear:42")

%Declaring the Target Image for Singleplayer
iTarget := Pic.Scale (Pic.FileNew ("Bullseye.bmp"), 50, 50)
Pic.SetTransparentColour (iTarget, 7)

%Declaring the Images for Win, Loss and if the User Wants to Play Again
iYes := Pic.Scale (Pic.FileNew ("Yes.bmp"), 1600, 750)
iNo := Pic.Scale (Pic.FileNew ("No.bmp"), 1600, 750)
iSingleplayerWin := Pic.Scale (Pic.FileNew ("SingleplayerWin.bmp"), 1600, 750)
iSingleplayerLose := Pic.Scale (Pic.FileNew ("SingleplayerLose.bmp"), 1600, 750)
iPlayer1Win := Pic.Scale (Pic.FileNew ("Player1win.bmp"), 1600, 750)
iPlayer2Win := Pic.Scale (Pic.FileNew ("Player2win.bmp"), 1600, 750)

%Setting the Display to be 1600 x 750 pixels
View.Set ("graphics:1600;750,nobuttonbar")

%Menu Loop
loop
    Input.KeyDown (cControl)

    %Menu Controls
    if cControl ('s') and iMenuOption = 1 and iMenuAccumulator = 0 then
	iMenuOption := 2
	%The accumulator is there so that there is a delay before they can go down or up again
	iMenuAccumulator := 1
    end if

    if cControl ('s') and iMenuOption = 2 and iMenuAccumulator = 0 then
	iMenuOption := 3
	iMenuAccumulator := 1
    end if

    if cControl ('s') and iMenuOption = 3 and iMenuAccumulator = 0 then
	iMenuOption := 1
	iMenuAccumulator := 1
    end if

    if cControl ('w') and iMenuOption = 1 and iMenuAccumulator = 0 then
	iMenuOption := 3
	iMenuAccumulator := 1
    end if

    if cControl ('w') and iMenuOption = 2 and iMenuAccumulator = 0 then
	iMenuOption := 1
	iMenuAccumulator := 1
    end if

    if cControl ('w') and iMenuOption = 3 and iMenuAccumulator = 0 then
	iMenuOption := 2
	iMenuAccumulator := 1
    end if

    %If they went down or up, the acumulator starts
    if iMenuAccumulator > 0 then
	iMenuAccumulator := iMenuAccumulator + 3
    end if

    %After two turns, it gets set to be 0, allowing them to move again
    if iMenuAccumulator > 4 then
	iMenuAccumulator := 0
    end if

    if iMenuOption = 1 then
	if cControl ('r') then
	    iGameMode := 1
	    bExit := true
	end if
	Pic.Draw (iMenu1, 0, 0, picCopy)

    elsif iMenuOption = 2 then
	if cControl ('r') then
	    iGameMode := 2
	    bExit := true
	end if
	Pic.Draw (iMenu2, 0, 0, picCopy)

    elsif iMenuOption = 3 then
	if cControl ('r') then
	    loop
		%Draws the Controls Picture for Player 1
		Pic.DrawSpecial (iRule1, 0, 0, picCopy, picFadeIn, 500)
		View.Update ()
		delay (5)
		%Exits when the user presses any button
		exit when hasch
	    end loop
	    Input.Flush

	    loop
		%Draws the Controls Picture for Player 2
		Pic.DrawSpecial (iRule2, 0, 0, picCopy, picFadeIn, 500)
		View.Update ()
		delay (5)
		%Exits when the user presses any button
		exit when hasch
	    end loop
	    Input.Flush

	    loop
		%Draws the Game Rules for Multiplayer and Singleplayer
		Pic.DrawSpecial (iRule3, 0, 0, picCopy, picFadeIn, 500)
		View.Update ()
		delay (5)
		%Exits when the user presses any button
		exit when hasch
	    end loop
	    Input.Flush

	end if
	Pic.Draw (iMenu3, 0, 0, picCopy)
    end if

    Input.Flush
    delay (100)
    exit when bExit = true
end loop


%Singleplayer
if iGameMode = 1 then
    %First loop is here if the player wants to play again
    loop
	%Resets all the variable values if they want to play again
	P1Lives := 3
	iP1TracerAccum := 0
	iMenuOption := 1
	iGameMode := 0
	iMenuAccumulator := 0
	iTimer := 30
	bExit := false
	iPoints := 0
	iTargetLocation := 0

	%Sets the screen size
	View.Set ("graphics:1600;750,nobuttonbar")
	delay (300)

	%Difficult Selection
	loop
	    Input.KeyDown (cControl)
	    Input.Flush
	    %Menu Controls
	    if cControl ('d') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 2
		%The accumulator is there so that there is a delay before they can go down or up again
		iMenuAccumulator := 1
	    end if

	    if cControl ('d') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 3
		iMenuAccumulator := 1
	    end if

	    if cControl ('d') and iMenuOption = 3 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 3
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 3 and iMenuAccumulator = 0 then
		iMenuOption := 2
		iMenuAccumulator := 1
	    end if

	    %If they went down or up, the acumulator starts
	    if iMenuAccumulator > 0 then
		iMenuAccumulator := iMenuAccumulator + 3
	    end if

	    %After two turns, it gets set to be 0, allowing them to move again
	    if iMenuAccumulator > 4 then
		iMenuAccumulator := 0
	    end if

	    %Easy
	    if iMenuOption = 1 then
		if cControl ('r') then
		    iGameMode := 1
		    bExit := true
		end if
		Pic.Draw (iEasy, 0, 0, picCopy)

	    %Medium
	    elsif iMenuOption = 2 then
		if cControl ('r') then
		    iGameMode := 2
		    bExit := true
		end if
		Pic.Draw (iMed, 0, 0, picCopy)

	    %Hard 
	    elsif iMenuOption = 3 then
		if cControl ('r') then
		    iGameMode := 3
		    bExit := true
		end if
		Pic.Draw (iHard, 0, 0, picCopy)
	    end if

	    Input.Flush
	    delay (100)
	    exit when bExit = true
	end loop

	%Draws the controls for singleplayer 
	Pic.DrawSpecial (iSingleplayer2, 0, 0, picCopy, picFadeIn, 500)
	delay (2500)

	%Sets the points requirment and draws picture to show points requirment
	if iGameMode = 1 then
	    iPointsReq := 50
	    Pic.DrawSpecial (iEasy2, 0, 0, picCopy, picFadeIn, 500)
	    delay (2500)
	elsif iGameMode = 2 then
	    iPointsReq := 80
	    Pic.DrawSpecial (iMed2, 0, 0, picCopy, picFadeIn, 500)
	    delay (2500)
	elsif iGameMode = 3 then
	    iPointsReq := 100
	    Pic.DrawSpecial (iHard2, 0, 0, picCopy, picFadeIn, 500)
	    delay (2500)
	end if

	%Sets the screen to offscreenonly
	setscreen ("offscreenonly")
	
	%Sets the player coordinates, speed and player type 
	oPlayer -> SetSpeed (5)
	oPlayer -> SetPlayer ("Jae")
	oPlayer -> Show
	oPlayer -> SetX (770)
	oPlayer -> SetY (209)
	oPlayer -> SetFacing (1)

	loop
	    %Clears the screen and draws top and bottom borders, hearts and targets 
	    cls
	    Draw.FillBox (0, 650, 1600, 750, 7)
	    Draw.FillBox (0, 0, 1600, 9, 7)
	    Pic.Draw (iHeart3, 20, 670, picCopy)
	    Pic.Draw (iTarget, iTargetX, iTargetY, picMerge)
	    Draw.Oval (iTargetX + 25, iTargetY + 25, 25, 25, 7) 

	    %Tracer ability cooldown bar 
	    if iP1TracerAccum < 120 then
		Draw.FillBox (375, 685, iP1TracerAccum + 376, 715, 40)
	    else
		Draw.FillBox (375, 685, 496, 715, 10)
	    end if

	    %Draws bullets icon based on amount of bullets in inventory 
	    if oPlayer -> GetInv = 5 then
		Pic.Draw (iBullets5, 280, 670, picCopy)

	    elsif oPlayer -> GetInv = 4 then
		Pic.Draw (iBullets4, 280, 670, picCopy)

	    elsif oPlayer -> GetInv = 3 then
		Pic.Draw (iBullets3, 280, 670, picCopy)

	    elsif oPlayer -> GetInv = 2 then
		Pic.Draw (iBullets2, 280, 670, picCopy)

	    elsif oPlayer -> GetInv = 1 then
		Pic.Draw (iBullets1, 280, 670, picCopy)
	    end if

	    Input.KeyDown (cLet)
	    %Movement 
	    if cLet ('w') and oPlayer -> GetinJump = false then
		oPlayer -> Move (Direction.Up)
	    elsif (cLet ('d')) then
		oPlayer -> Move (Direction.Right)
	    elsif (cLet ('a')) then
		oPlayer -> Move (Direction.Left)
	    end if

	    %Shooting the bullets 
	    if cLet ('e') then
		if not bP1Bulletkey then
		    oPlayer -> Shoot
		end if
		%Bulletkey checks if the user is holding down the key 
		bP1Bulletkey := true
	    else
		bP1Bulletkey := false
	    end if

	    %Tracer [teleport ability] 
	    if cLet ('q') then
		if not bP1Tracerkey and iP1TracerAccum >= 120 then
		    oPlayer -> Move (Direction.Tracer)
		    iP1TracerAccum := 0
		    bP1Tracerkey := true
		else
		    bP1Tracerkey := false
		end if
	    end if

	    %If non of the movement keys are pressed, the player will go to a stand animation 
	    if cLet ('w') = false and cLet ('a') = false and cLet ('d') = false and cLet ('r') = false then
		oPlayer -> Move (Direction.Stand)
	    end if
	    
	    %Checks if player bullet is touching the target 
	    oPlayer -> IsTouching (iTargetX, iTargetY, 50, 50)
	    
	    %If it is then it adds 1 sec to the timer and 10 points to the total points 
	    if oPlayer -> GetIsTouching = true then
		%Rand.Int is here to move the target to a random location after its been hit 
		iTargetLocation := Rand.Int (1, 11)
		oPlayer -> SetIsTouching (false)
		iTimer := iTimer + 1
		iPoints := iPoints + 10

		if iTargetLocation = 1 then
		    iTargetX := 775
		    iTargetY := 320

		elsif iTargetLocation = 2 then
		    iTargetX := 180
		    iTargetY := 547

		elsif iTargetLocation = 3 then
		    iTargetX := 1330
		    iTargetY := 547

		elsif iTargetLocation = 4 then
		    iTargetX := 35
		    iTargetY := 95

		elsif iTargetLocation = 5 then
		    iTargetX := 1515
		    iTargetY := 95

		elsif iTargetLocation = 6 then
		    iTargetX := 670
		    iTargetY := 20

		elsif iTargetLocation = 7 then
		    iTargetX := 895
		    iTargetY := 20

		elsif iTargetLocation = 8 then
		    iTargetX := 435
		    iTargetY := 180

		elsif iTargetLocation = 9 then
		    iTargetX := 1115
		    iTargetY := 180

		elsif iTargetLocation = 10 then
		    iTargetX := 775
		    iTargetY := 475

		elsif iTargetLocation = 11 then
		    iTargetX := 20
		    iTargetY := 475

		end if
	    end if

	    %Gravitty and collision with platforms 
	    oPlayer -> Gravity
	    oPlayer -> PlayerCollision

	    %The floor of the map 
	    if oPlayer -> GetY < 10 then
		oPlayer -> SetY (10)
		oPlayer -> SetVelocity (0)
		oPlayer -> SetinJump (false)
	    end if

	    %Counter down from the timer every 1 second 
	    if iTimerAccum mod 67 = 0 then
		iTimer := iTimer - 1
		iTimerAccum := 0
	    end if

	    %Sets bullet inventory, moves bullets, shows player and has tracer and timer accumulators 
	    oPlayer -> SetInv
	    oPlayer -> MoveBullets
	    oPlayer -> Show
	    iP1TracerAccum := iP1TracerAccum + 1
	    iTimerAccum := iTimerAccum + 1

	    %Displays the timer 
	    sTimer := intstr (iTimer)
	    iWidth := Font.Width (sTimer, iFont)
	    Font.Draw (sTimer, maxx div 2 - iWidth div 2, 680, iFont, white)

	    %Displayer the current points 
	    sPoints := "Points: " + intstr (iPoints)
	    iWidth := Font.Width (sPoints, iFont)
	    Font.Draw (sPoints, maxx - 200 - iWidth div 2, 680, iFont, white)

	    View.Update
	    delay (15)
	    exit when iPoints = iPointsReq or iTimer = 0
	end loop

	%Sets the screen to nooffscreenonly so then there isn't a need for View.Update 
	setscreen ("nooffscreenonly")
	
	%Checks if the player won or lost 
	if iPoints = iPointsReq or iTimer not= 0 then
	    Pic.Draw (iSingleplayerWin, 0, 0, picCopy)
	    delay (2000)
	elsif iPoints < iPointsReq and iTimer = 0 then
	    Pic.Draw (iSingleplayerLose, 0, 0, picCopy)
	    delay (2000)
	end if

	%Resets the varibles for play again selection 
	iMenuOption := 1
	sPlayAgain := '-'
	iMenuAccumulator := 0
	bExit := false

	%Loop for play again selection 
	loop
	    Input.KeyDown (cControl)
	    %Menu Controls
	    if cControl ('d') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 2
		%The accumulator is there so that there is a delay before they can go down or up again
		iMenuAccumulator := 1
	    end if

	    if cControl ('d') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 2
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    %If they went down or up, the acumulator starts
	    if iMenuAccumulator > 0 then
		iMenuAccumulator := iMenuAccumulator + 3
	    end if

	    %After two turns, it gets set to be 0, allowing them to move again
	    if iMenuAccumulator > 4 then
		iMenuAccumulator := 0
	    end if

	    if iMenuOption = 1 then
		if cControl ('r') then
		    sPlayAgain := "yes"
		    bExit := true
		end if
		Pic.Draw (iYes, 0, 0, picCopy)

	    elsif iMenuOption = 2 then
		if cControl ('r') then
		    sPlayAgain := "no"
		    bExit := true
		end if
		Pic.Draw (iNo, 0, 0, picCopy)
	    end if

	    Input.Flush
	    delay (100)
	    exit when bExit = true
	end loop
	
	%Exits when the user doesn't want to play again 
	exit when sPlayAgain = "no"
    end loop

%Multiplayer
elsif iGameMode = 2 then
    %Loop is for if the player wants to play again 
    loop
	%Sets the ability accumulators and lives for both players 
	iP1TracerAccum := 0
	iP2TracerAccum := 0
	P1Lives := 3
	P2Lives := 3

	%Draws player 1 and player 2 loading screens 
	Pic.DrawSpecial (iMultiplayer1, 0, 0, picCopy, picFadeIn, 500)
	delay (2500)
	Pic.DrawSpecial (iMultiplayer2, 0, 0, picCopy, picFadeIn, 500)
	delay (2500)

	%Sets the screen to offscreenonly 
	setscreen ("offscreenonly")

	loop
	    %After on the players lose a heart, both the players values get reset 
	    oPlayer -> SetSpeed (5)
	    oPlayer -> SetPlayer ("Jae")
	    oPlayer -> Show

	    oPlayer2 -> SetSpeed (5)
	    oPlayer2 -> SetPlayer ("Joe")
	    oPlayer2 -> Show

	    oPlayer -> SetX (10)
	    oPlayer -> SetY (10)
	    oPlayer -> SetFacing (1)
	    oPlayer -> SetBulletCol (false)
	    oPlayer -> ClearBullets
	    oPlayer2 -> SetX (1590)
	    oPlayer2 -> SetY (10)
	    oPlayer2 -> SetFacing (0)
	    oPlayer2 -> SetBulletCol (false)
	    oPlayer2 -> ClearBullets

	    loop
		cls
		
		%Draws the top and bottom borders 
		Draw.FillBox (0, 650, 1600, 750, 7)
		Draw.FillBox (0, 0, 1600, 9, 7)

		%Draws player 1 and player 2 tracer cooldowns 
		if iP1TracerAccum < 120 then
		    Draw.FillBox (375, 685, iP1TracerAccum + 376, 715, 40)
		else
		    Draw.FillBox (375, 685, 496, 715, 10)
		end if

		if iP2TracerAccum < 120 then
		    Draw.FillBox (1235, 685, 1236 - iP2TracerAccum, 715, 40)
		else
		    Draw.FillBox (1235, 685, 1116, 715, 10)
		end if

		%Draws player 1 and player 2 hearts based on their lives count
		if P1Lives = 3 then
		    Pic.Draw (iHeart3, 20, 670, picCopy)

		elsif P1Lives = 2 then
		    Pic.Draw (iHeart2, 20, 670, picCopy)

		elsif P1Lives = 1 then
		    Pic.Draw (iHeart1, 20, 670, picCopy)
		end if

		if P2Lives = 3 then
		    Pic.Draw (iHeart3, 1350, 670, picCopy)

		elsif P2Lives = 2 then
		    Pic.Draw (iHeart2, 1433, 670, picCopy)

		elsif P2Lives = 1 then
		    Pic.Draw (iHeart1, 1516, 670, picCopy)
		end if

		%Draws bullet icon for corresponding to the number of bullets in both players inventory 
		if oPlayer -> GetInv = 5 then
		    Pic.Draw (iBullets5, 280, 670, picCopy)

		elsif oPlayer -> GetInv = 4 then
		    Pic.Draw (iBullets4, 280, 670, picCopy)

		elsif oPlayer -> GetInv = 3 then
		    Pic.Draw (iBullets3, 280, 670, picCopy)

		elsif oPlayer -> GetInv = 2 then
		    Pic.Draw (iBullets2, 280, 670, picCopy)

		elsif oPlayer -> GetInv = 1 then
		    Pic.Draw (iBullets1, 280, 670, picCopy)

		end if

		if oPlayer2 -> GetInv = 5 then
		    Pic.Draw (iBullets5, 1255, 670, picCopy)

		elsif oPlayer2 -> GetInv = 4 then
		    Pic.Draw (iBullets4, 1255, 670, picCopy)

		elsif oPlayer2 -> GetInv = 3 then
		    Pic.Draw (iBullets3, 1255, 670, picCopy)

		elsif oPlayer2 -> GetInv = 2 then
		    Pic.Draw (iBullets2, 1255, 670, picCopy)

		elsif oPlayer2 -> GetInv = 1 then
		    Pic.Draw (iBullets1, 1255, 670, picCopy)

		end if


		Input.KeyDown (cLet)
		%Player 1 movement 
		if cLet ('w') and oPlayer -> GetinJump = false then
		    oPlayer -> Move (Direction.Up)
		elsif (cLet ('d')) then
		    oPlayer -> Move (Direction.Right)
		elsif (cLet ('a')) then
		    oPlayer -> Move (Direction.Left)
		end if

		%Player 1 shoot
		if cLet ('e') then
		    if not bP1Bulletkey then
			oPlayer -> Shoot
		    end if
		    %Bulletkey checks if the user is holding down the key 
		    bP1Bulletkey := true
		else
		    bP1Bulletkey := false
		end if

		%Player 1 tracer [teleport ability] 
		if cLet ('q') then
		    if not bP1Tracerkey and iP1TracerAccum >= 120 then
			oPlayer -> Move (Direction.Tracer)
			iP1TracerAccum := 0
			%Tracerkey checks if the user is holding down the key 
			bP1Tracerkey := true
		    else
			bP1Tracerkey := false
		    end if
		end if

		%If non of the movement keys are pressed, the player is in its standing frame
		if cLet ('w') = false and cLet ('a') = false and cLet ('d') = false and cLet ('r') = false then
		    oPlayer -> Move (Direction.Stand)
		end if
    
		%Player 1 gravity and platform collision 
		oPlayer -> Gravity
		oPlayer -> PlayerCollision

		%The floor of the map 
		if oPlayer -> GetY < 10 then
		    oPlayer -> SetY (10)
		    oPlayer -> SetVelocity (0)
		    oPlayer -> SetinJump (false)
		end if

		%Checks if the player 1's bullets hit player 2 
		oPlayer -> PlayerBulletCol (oPlayer2 -> GetHitbox1x, oPlayer2 -> GetHitbox1y, oPlayer2 -> GetHitbox2x, oPlayer2 -> GetHitbox2y,
		    oPlayer2 -> GetHeadbox1x, oPlayer2 -> GetHeadbox1y, oPlayer2 -> GetHeadbox2x, oPlayer2 -> GetHeadbox2y)

		%If it did, player 2 loses 1 life 
		if oPlayer -> GetBulletCol = true then
		    P2Lives := P2Lives - 1
		end if
    
		%Sets bullets inv, moves bullets, shows player
		oPlayer -> SetInv
		oPlayer -> MoveBullets
		oPlayer -> Show
		
		%Tracer cooldown accumulator 
		iP1TracerAccum := iP1TracerAccum + 1


		%Player 2 movement     
		if cLet ('i') and oPlayer2 -> GetinJump = false then
		    oPlayer2 -> Move (Direction.Up)
		elsif (cLet ('l')) then
		    oPlayer2 -> Move (Direction.Right)
		elsif (cLet ('j')) then
		    oPlayer2 -> Move (Direction.Left)
		end if

		%Player 2 shoot
		if cLet ('o') then
		    if not bP2Bulletkey then
			oPlayer2 -> Shoot
		    end if
		   %Bulletkey checks if the user is holding down the key 
		    bP2Bulletkey := true
		else
		    bP2Bulletkey := false
		end if

		%Player 2 tracer [teleport ability] 
		if cLet ('u') then
		    if not bP2Tracerkey and iP2TracerAccum >= 120 then
			oPlayer2 -> Move (Direction.Tracer)
			iP2TracerAccum := 0
			%Tracerkey checks if the user is holding down the key 
			bP2Tracerkey := true
		    else
			bP2Tracerkey := false
		    end if
		end if

		%If non of the movement keys are pressed, the player is in its standing frame               
		if cLet ('i') = false and cLet ('j') = false and cLet ('l') = false and cLet ('p') = false then
		    oPlayer2 -> Move (Direction.Stand)
		end if

		%Player 2 gravity and platform collision 
		oPlayer2 -> Gravity
		oPlayer2 -> PlayerCollision

		%The floor of the map 
		if oPlayer2 -> GetY < 10 then
		    oPlayer2 -> SetY (10)
		    oPlayer2 -> SetVelocity (0)
		    oPlayer2 -> SetinJump (false)
		end if

		%Checks if the player 2's bullets hit player 1 
		oPlayer2 -> PlayerBulletCol (oPlayer -> GetHitbox1x, oPlayer -> GetHitbox1y, oPlayer -> GetHitbox2x, oPlayer -> GetHitbox2y,
		    oPlayer -> GetHeadbox1x, oPlayer -> GetHeadbox1y, oPlayer -> GetHeadbox2x, oPlayer -> GetHeadbox2y)

		%If it did, player 2 loses 1 life 
		if oPlayer2 -> GetBulletCol = true then
		    P1Lives := P1Lives - 1
		end if

		%Sets bullets inv, moves bullets, shows player 
		oPlayer2 -> SetInv
		oPlayer2 -> MoveBullets
		oPlayer2 -> Show
		
		%Tracer cooldown accumulator  
		iP2TracerAccum := iP2TracerAccum + 1

		View.Update
		delay (15)
		exit when oPlayer -> GetBulletCol = true or oPlayer2 -> GetBulletCol = true
	    end loop
	    
	    %When one of the players live go to 0 then the game ends 
	    exit when P1Lives = 0 or P2Lives = 0
	end loop

	%Sets the screen to nooffscreenonly so then there isn't a need for View.Update 
	setscreen ("nooffscreenonly")
	
	%Checks if player 1 or player 2 won 
	if P1Lives = 0 then
	    Pic.Draw (iPlayer2Win, 0, 0, picCopy)
	    delay (2000)
	elsif P2Lives = 0 then
	    Pic.Draw (iPlayer1Win, 0, 0, picCopy)
	    delay (2000)
	end if

	%Resets the varibles for play again selection 
	iMenuOption := 1
	sPlayAgain := '-'
	iMenuAccumulator := 0
	bExit := false

	%Loop for play again selection 
	loop
	    Input.KeyDown (cControl)
	    %Menu Controls
	    if cControl ('d') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 2
		%The accumulator is there so that there is a delay before they can go down or up again
		iMenuAccumulator := 1
	    end if

	    if cControl ('d') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 1 and iMenuAccumulator = 0 then
		iMenuOption := 2
		iMenuAccumulator := 1
	    end if

	    if cControl ('a') and iMenuOption = 2 and iMenuAccumulator = 0 then
		iMenuOption := 1
		iMenuAccumulator := 1
	    end if

	    %If they went down or up, the acumulator starts
	    if iMenuAccumulator > 0 then
		iMenuAccumulator := iMenuAccumulator + 3
	    end if

	    %After two turns, it gets set to be 0, allowing them to move again
	    if iMenuAccumulator > 4 then
		iMenuAccumulator := 0
	    end if

	    if iMenuOption = 1 then
		if cControl ('r') then
		    sPlayAgain := "yes"
		    bExit := true
		end if
		Pic.Draw (iYes, 0, 0, picCopy)

	    elsif iMenuOption = 2 then
		if cControl ('r') then
		    sPlayAgain := "no"
		    bExit := true
		end if
		Pic.Draw (iNo, 0, 0, picCopy)
	    end if

	    Input.Flush
	    delay (100)
	    exit when bExit = true
	end loop
	
	%Exits when the player doesn't want to play again 
	exit when sPlayAgain = "no"
    end loop

end if

var iFinisher : int 

iFinisher := Pic.Scale (Pic.FileNew ("Finisher.bmp"), 1600, 750)

%Finishing screen
Pic.Draw (iFinisher, 0, 0, picCopy) 
