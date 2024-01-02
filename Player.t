/* +------------------------------------------------------------------------+
 | Player.t -                                              |
 +-------------------------------------------------------------------------+
 | Author - Kavin Nimalarajan                                              |
 | Date   - June 09 2023                                                   |
 +-------------------------------------------------------------------------+
 | Input  - none                                                           |
 | Output - none                                                           |
 +-------------------------------------------------------------------------+ */

type Direction : enum (Left, Right, Up, Stand, Tracer)
include "Bullet.t"
include "Platforms.t"

class Player
    %Importing Direction to move the player and bullet.t to shoot projectiles
    import Direction, Bullet, ConstructBullet, DestructBullet, vec2, Platform

    export SetX, SetY, SetSpeed, SetFacing, Gravity, PlayerCollision, GetInv, SetInv, GetIsTouching, SetIsTouching,
	GetX, GetY, GetSpeed, GetFacing, IsTouching, SetBackColour, PlayerBulletCol, GetBulletCol, SetBulletCol,
	Show, Move, MoveBullets, AddBullet, Shoot, SetPlayer, SetVelocity, SetinJump, GetinJump, ClearBullets,
	GetHitbox1x, GetHitbox1y, GetHitbox2x, GetHitbox2y, GetHeadbox1x, GetHeadbox1y, GetHeadbox2x, GetHeadbox2y

    %Variable Declaration statements
    var sType : string := "Jae"

    var platforms : array 1 .. 45 of ^Platform

    var rVelocity, riJump, rGravity : real

    var inJump, bBulletCollision, bIsTouching : boolean := false

    var iX, iY, iColour, iSpeed, iFacing, iBulletX, iHitbox1x, iHitbox2x, iHitbox1y, iHitbox2y, iBulletNumber,
	iBulletY, iBackColour, iFrameCounter, iHeadbox1x, iHeadbox1y, iHeadbox2x, iHeadbox2y,
	iStand, iRun1, iRun2, iRun3, iRun4, iRun5, iRun6, iJump, iNumPlatforms, iNumBullets, iBulletAccumulator, iBulletInv,
	iMiriStand, iMiriRun1, iMiriRun2, iMiriRun3, iMiriRun4, iMiriRun5, iMiriRun6, iMiriJump : int := 0

    iHitbox1x := 0
    iHitbox1y := 0
    iHitbox2x := 0
    riJump := 15
    rGravity := 0.85
    rVelocity := 0
    iNumPlatforms := 45
    iNumBullets := 10


    for i : 1 .. iNumPlatforms
	new Platform, platforms (i)
    end for

    %Left Side of Platforms
    platforms (1) -> SetPosition (0, 80)
    platforms (1) -> SetDimension (115, 7)
    platforms (1) -> SetColour (7)

    platforms (2) -> SetPosition (113, 80)
    platforms (2) -> SetDimension (7, 32)
    platforms (2) -> SetColour (7)

    platforms (3) -> SetPosition (200, 150)
    platforms (3) -> SetDimension (100, 7)
    platforms (3) -> SetColour (7)

    platforms (4) -> SetPosition (225, 150)
    platforms (4) -> SetDimension (7, 30)
    platforms (4) -> SetColour (7)

    platforms (5) -> SetPosition (0, 260)
    platforms (5) -> SetDimension (120, 7)
    platforms (5) -> SetColour (7)

    platforms (6) -> SetPosition (300, 255)
    platforms (6) -> SetDimension (100, 7)
    platforms (6) -> SetColour (7)

    platforms (7) -> SetPosition (400, 255)
    platforms (7) -> SetDimension (7, 28)
    platforms (7) -> SetColour (7)

    platforms (8) -> SetPosition (145, 365)
    platforms (8) -> SetDimension (115, 7)
    platforms (8) -> SetColour (7)

    platforms (9) -> SetPosition (0, 455)
    platforms (9) -> SetDimension (70, 7)
    platforms (9) -> SetColour (7)

    platforms (10) -> SetPosition (330, 430)
    platforms (10) -> SetDimension (70, 7)
    platforms (10) -> SetColour (7)

    platforms (11) -> SetPosition (400, 430)
    platforms (11) -> SetDimension (7, 28)
    platforms (11) -> SetColour (7)

    platforms (12) -> SetPosition (150, 530)
    platforms (12) -> SetDimension (100, 7)
    platforms (12) -> SetColour (7)

    %Right Side of Platforms
    platforms (13) -> SetPosition (1485, 80)
    platforms (13) -> SetDimension (115, 7)
    platforms (13) -> SetColour (7)

    platforms (14) -> SetPosition (1480, 80)
    platforms (14) -> SetDimension (7, 32)
    platforms (14) -> SetColour (7)

    platforms (15) -> SetPosition (1300, 150)
    platforms (15) -> SetDimension (100, 7)
    platforms (15) -> SetColour (7)

    platforms (16) -> SetPosition (1368, 150)
    platforms (16) -> SetDimension (7, 30)
    platforms (16) -> SetColour (7)

    platforms (17) -> SetPosition (1480, 260)
    platforms (17) -> SetDimension (120, 7)
    platforms (17) -> SetColour (7)

    platforms (18) -> SetPosition (1200, 255)
    platforms (18) -> SetDimension (100, 7)
    platforms (18) -> SetColour (7)

    platforms (19) -> SetPosition (1193, 255)
    platforms (19) -> SetDimension (7, 28)
    platforms (19) -> SetColour (7)

    platforms (20) -> SetPosition (1340, 365)
    platforms (20) -> SetDimension (115, 7)
    platforms (20) -> SetColour (7)

    platforms (21) -> SetPosition (1530, 455)
    platforms (21) -> SetDimension (70, 7)
    platforms (21) -> SetColour (7)

    platforms (22) -> SetPosition (1200, 430)
    platforms (22) -> SetDimension (70, 7)
    platforms (22) -> SetColour (7)

    platforms (23) -> SetPosition (1193, 430)
    platforms (23) -> SetDimension (7, 28)
    platforms (23) -> SetColour (7)

    platforms (24) -> SetPosition (1350, 530)
    platforms (24) -> SetDimension (100, 7)
    platforms (24) -> SetColour (7)

    %Middle of Platforms
    platforms (25) -> SetPosition (510, 370)
    platforms (25) -> SetDimension (120, 7)
    platforms (25) -> SetColour (7)

    platforms (26) -> SetPosition (970, 370)
    platforms (26) -> SetDimension (120, 7)
    platforms (26) -> SetColour (7)

    platforms (27) -> SetPosition (675, 460)
    platforms (27) -> SetDimension (70, 7)
    platforms (27) -> SetColour (7)

    platforms (28) -> SetPosition (740, 460)
    platforms (28) -> SetDimension (7, 32)
    platforms (28) -> SetColour (7)

    platforms (29) -> SetPosition (855, 460)
    platforms (29) -> SetDimension (70, 7)
    platforms (29) -> SetColour (7)

    platforms (30) -> SetPosition (853, 460)
    platforms (30) -> SetDimension (7, 32)
    platforms (30) -> SetColour (7)

    platforms (31) -> SetPosition (740, 0)
    platforms (31) -> SetDimension (7, 120)
    platforms (31) -> SetColour (7)

    platforms (32) -> SetPosition (853, 0)
    platforms (32) -> SetDimension (7, 120)
    platforms (32) -> SetColour (7)

    platforms (33) -> SetPosition (740, 121)
    platforms (33) -> SetDimension (120, 7)
    platforms (33) -> SetColour (7)

    platforms (34) -> SetPosition (660, 80)
    platforms (34) -> SetDimension (7, 72)
    platforms (34) -> SetColour (7)

    platforms (35) -> SetPosition (933, 80)
    platforms (35) -> SetDimension (7, 72)
    platforms (35) -> SetColour (7)

    platforms (36) -> SetPosition (660, 200)
    platforms (36) -> SetDimension (280, 7)
    platforms (36) -> SetColour (7)

    platforms (37) -> SetPosition (610, 80)
    platforms (37) -> SetDimension (55, 7)
    platforms (37) -> SetColour (7)

    platforms (38) -> SetPosition (935, 80)
    platforms (38) -> SetDimension (55, 7)
    platforms (38) -> SetColour (7)

    platforms (39) -> SetPosition (0, 650)
    platforms (39) -> SetDimension (1600, 7)
    platforms (39) -> SetColour (7)

    %Sets the type of player [there is Jae (red) and Joe (blue)]
    procedure SetPlayer (spType : string)
	sType := spType

	iStand := Pic.Scale (Pic.FileNew (sType + "Stand.bmp"), 55, 61)
	Pic.SetTransparentColour (iStand, 7)
	iMiriStand := Pic.Mirror (iStand)

	iRun1 := Pic.Scale (Pic.FileNew (sType + "Run1.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun1, 7)
	iMiriRun1 := Pic.Mirror (iRun1)

	iRun2 := Pic.Scale (Pic.FileNew (sType + "Run2.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun2, 7)
	iMiriRun2 := Pic.Mirror (iRun2)

	iRun3 := Pic.Scale (Pic.FileNew (sType + "Run3.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun3, 7)
	iMiriRun3 := Pic.Mirror (iRun3)

	iRun4 := Pic.Scale (Pic.FileNew (sType + "Run4.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun4, 7)
	iMiriRun4 := Pic.Mirror (iRun4)

	iRun5 := Pic.Scale (Pic.FileNew (sType + "Run5.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun5, 7)
	iMiriRun5 := Pic.Mirror (iRun5)

	iRun6 := Pic.Scale (Pic.FileNew (sType + "Run6.bmp"), 55, 61)
	Pic.SetTransparentColour (iRun6, 7)
	iMiriRun6 := Pic.Mirror (iRun6)

	iJump := Pic.Scale (Pic.FileNew (sType + "Jump.bmp"), 55, 61)
	Pic.SetTransparentColour (iJump, 7)
	iMiriJump := Pic.Mirror (iJump)

    end SetPlayer

    %Sets the X value of the player
    procedure SetX (ipX : int)
	iX := ipX
    end SetX

    %Sets the Y value of the player
    procedure SetY (ipY : int)
	iY := ipY
    end SetY

    %Sets how fast the player moves per key press
    procedure SetSpeed (ipSpeed : int)
	iSpeed := ipSpeed
    end SetSpeed

    %Sets the direction that the player faces [left (0) or right (1)]
    procedure SetFacing (ipFacing : int)
	iFacing := ipFacing
    end SetFacing

    %Sets the background a colour
    procedure SetBackColour (ipBackColour : int)
	iBackColour := ipBackColour
    end SetBackColour

    %sets the jumping force of the player (velocity)
    procedure SetVelocity (ipVelocity : real)
	rVelocity := ipVelocity
    end SetVelocity

    %This sets the boolean of weither the player is in their jump or not
    procedure SetinJump (ipJump : boolean)
	inJump := ipJump
    end SetinJump

    %Gets the current X value of the player
    function GetX : int
	result iX
    end GetX

    %Gets the current Y value of the player
    function GetY : int
	result iY
    end GetY

    %Gets the speed value
    function GetSpeed : int
	result iSpeed
    end GetSpeed

    %Gets the direction that the player is facing [left (0) or right (1)]
    function GetFacing : int
	result iFacing
    end GetFacing

    %Gets the boolean of weither the player is in their jump or not
    function GetinJump : boolean
	result inJump
    end GetinJump

    %Get Functions for the Hitbox for the Other Player
    function GetHitbox1x : int
	result iHitbox1x
    end GetHitbox1x

    %Gets the hitbox values of the player 
    function GetHitbox1y : int
	result iHitbox1y
    end GetHitbox1y

    function GetHitbox2x : int
	result iHitbox2x
    end GetHitbox2x

    function GetHitbox2y : int
	result iHitbox2y
    end GetHitbox2y

    function GetHeadbox1x : int
	result iHeadbox1x
    end GetHeadbox1x

    function GetHeadbox1y : int
	result iHeadbox1y
    end GetHeadbox1y

    function GetHeadbox2x : int
	result iHeadbox2x
    end GetHeadbox2x

    function GetHeadbox2y : int
	result iHeadbox2y
    end GetHeadbox2y

    %If the player is colliding over or under the platform, this code will check it and move the player out of the platform 
    procedure PlayerCollision
	for i : 1 .. iNumPlatforms
	    platforms (i) -> Show
	    platforms (i) -> SetHitbox (iHitbox1x, iHitbox2x, iX, iY)
	    if platforms (i) -> UnderCollision = true and iY + 63 > platforms (i) -> GetY then
		rVelocity := 0
		iY := platforms (i) -> GetY - 62

	    elsif platforms (i) -> Collision = true and iY < platforms (i) -> GetY + platforms (i) -> GetDimensionY then
		rVelocity := 0
		iY := platforms (i) -> GetY + platforms (i) -> GetDimensionY
		inJump := false

	    else
		if iHeadbox2x > platforms (i) -> GetX and iHeadbox2x < platforms (i) -> GetX + platforms (i) -> GetDimensionX
			and iHeadbox1y < platforms (i) -> GetY + platforms (i) -> GetDimensionY and iHeadbox2y > platforms (i) -> GetY then
		    iX := platforms (i) -> GetX - 55

		elsif iHeadbox1x < platforms (i) -> GetX + platforms (i) -> GetDimensionX and iHeadbox1x > platforms (i) -> GetX
			and iHeadbox1y < platforms (i) -> GetY + platforms (i) -> GetDimensionY and iHeadbox2y > platforms (i) -> GetY then
		    iX := platforms (i) -> GetX + platforms (i) -> GetDimensionX

		elsif iHitbox2x > platforms (i) -> GetX and iHitbox2x < platforms (i) -> GetX + platforms (i) -> GetDimensionX
			and iHitbox1y < platforms (i) -> GetY + platforms (i) -> GetDimensionY and iHitbox2y > platforms (i) -> GetY then
		    if iFacing = 1 then
			iX := platforms (i) -> GetX - 40
		    end if

		elsif iHitbox1x > platforms (i) -> GetX and iHitbox1x < platforms (i) -> GetX + platforms (i) -> GetDimensionX
			and iHitbox1y < platforms (i) -> GetY + platforms (i) -> GetDimensionY and iHitbox2y > platforms (i) -> GetY then
		    if iFacing = 0 then
			iX := platforms (i) -> GetX + platforms (i) -> GetDimensionX - 15
		    end if

		end if
	    end if


	end for
    end PlayerCollision

    %This will be placed in the loop of the main code and every time the loop, loops around, this will decrease the jump strength [velocity] of the player by the gravity level
    procedure Gravity
	%This is the part where pixels are added to the player and this decreases every time the loop loops around so then the player will then start to fall
	rVelocity := rVelocity - rGravity
	iY := iY + round (rVelocity)

	%These if statements update the players feet and head hitboxs everytime the loop loops around
	if iFacing = 1 then
	    iHitbox1x := iX + 5
	    iHitbox1y := iY
	    iHitbox2x := iX + 40
	    iHitbox2y := iY + 35

	elsif iFacing = 0 then
	    iHitbox2x := iX + 50
	    iHitbox2y := iY + 35
	    iHitbox1y := iY
	    iHitbox1x := iX + 15

	end if

	%These are the hitbox coordinates for the head of the player
	iHeadbox1x := iX
	iHeadbox1y := iY + 35
	iHeadbox2x := iX + 55
	iHeadbox2y := iY + 61

	if rVelocity < 0 then
	    inJump := true
	end if

    end Gravity


    %Shows the player
    procedure Show

	if iFrameCounter = 0 and iFacing = 1 then
	    Pic.Draw (iStand, iX, iY, picMerge)

	elsif iFrameCounter > 0 and iFrameCounter <= 4 and iFacing = 1 then
	    Pic.Draw (iRun1, iX, iY, picMerge)

	elsif iFrameCounter > 4 and iFrameCounter <= 8 and iFacing = 1 then
	    Pic.Draw (iRun2, iX, iY, picMerge)

	elsif iFrameCounter > 8 and iFrameCounter <= 12 and iFacing = 1 then
	    Pic.Draw (iRun3, iX, iY, picMerge)

	elsif iFrameCounter > 12 and iFrameCounter <= 16 and iFacing = 1 then
	    Pic.Draw (iRun4, iX, iY, picMerge)

	elsif iFrameCounter > 16 and iFrameCounter <= 20 and iFacing = 1 then
	    Pic.Draw (iRun5, iX, iY, picMerge)

	elsif iFrameCounter > 20 and iFrameCounter <= 24 and iFacing = 1 then
	    Pic.Draw (iRun6, iX, iY, picMerge)

	elsif iFrameCounter = 25 then
	    Pic.Draw (iJump, iX, iY, picMerge)

	end if


	if iFrameCounter = 0 and iFacing = 0 then
	    Pic.Draw (iMiriStand, iX, iY, picMerge)

	elsif iFrameCounter < 0 and iFrameCounter >= -4 and iFacing = 0 then
	    Pic.Draw (iMiriRun1, iX, iY, picMerge)

	elsif iFrameCounter < -4 and iFrameCounter >= -8 and iFacing = 0 then
	    Pic.Draw (iMiriRun2, iX, iY, picMerge)

	elsif iFrameCounter < -8 and iFrameCounter >= -12 and iFacing = 0 then
	    Pic.Draw (iMiriRun3, iX, iY, picMerge)

	elsif iFrameCounter < -12 and iFrameCounter >= -16 and iFacing = 0 then
	    Pic.Draw (iMiriRun4, iX, iY, picMerge)

	elsif iFrameCounter < -16 and iFrameCounter >= -20 and iFacing = 0 then
	    Pic.Draw (iMiriRun5, iX, iY, picMerge)

	elsif iFrameCounter < -20 and iFrameCounter >= -24 and iFacing = 0 then
	    Pic.Draw (iMiriRun6, iX, iY, picMerge)

	elsif iFrameCounter = -25 then
	    Pic.Draw (iMiriJump, iX, iY, picMerge)

	end if
    end Show

    %When a key is pressed the player is moved either left or right (th
    procedure Move (pDirection : Direction)
	case pDirection of
	    label Direction.Left :
		iFacing := 0
		SetX (GetX - GetSpeed)

		if inJump = true then
		    iFrameCounter := -25
		end if

		if inJump = false then
		    if iFrameCounter > 0 or iFrameCounter = -24 or iFrameCounter = -25 then
			iFrameCounter := -1
		    else
			iFrameCounter := iFrameCounter - 1
		    end if
		end if

	    label Direction.Right :
		iFacing := 1
		SetX (GetX + GetSpeed)

		if inJump = true then
		    iFrameCounter := 25
		end if

		if inJump = false then
		    if iFrameCounter < 0 or iFrameCounter = 24 or iFrameCounter = 25 then
			iFrameCounter := 1
		    else
			iFrameCounter := iFrameCounter + 1
		    end if
		end if

	    label Direction.Up :
		rVelocity := riJump
		inJump := true

		if iFacing = 0 then
		    iFrameCounter := -25

		elsif iFacing = 1 then
		    iFrameCounter := 25

		end if

	    label Direction.Stand :
		iFrameCounter := 0

	    label Direction.Tracer :
		if iFacing = 0 then
		    if iX - 90 < 0 then
			SetX (0)
		    else
			SetX (GetX - 90)
		    end if

		elsif iFacing = 1 then
		    if iX + 90 > maxx then
			SetX (maxx)
		    else
			SetX (GetX + 90)
		    end if
		end if
	end case

	if iX > maxx - 55 then
	    iX := maxx - 55
	elsif iX < 0 then
	    iX := 0
	end if
    end Move

    var iBulletsmin : int := 0
    if sType = "Jae" then
	iBulletsmin := 0
	iNumBullets := 10
    elsif sType = "Joe" then
	iBulletsmin := 11
	iNumBullets := 20
    end if

    var bullets : array 0 .. 20 of ^Bullet

    for i : iBulletsmin .. iNumBullets
	new Bullet, bullets (i)
    end for

    %Adds new bullet in the flexable array and calls for a new bullet object in bullet.t and sets the direction of the bullet corresponding to the direction that the player is facing
    procedure AddBullet (ipBulletNum, ipBX, ipBY, ipFace : int, ipLabel : string)
	bullets (ipBulletNum) -> SetBulletLabel (sType)
	bullets (ipBulletNum) -> SetBulletDir (ipFace)
	bullets (ipBulletNum) -> SetBulletY (ipBY)
	if ipFace = 1 then
	    bullets (ipBulletNum) -> SetBulletX (ipBX + 5)
	elsif ipFace = 0 then
	    bullets (ipBulletNum) -> SetBulletX (ipBX - 5)
	end if
    end AddBullet

    %Gets the bullet name and moves the bullet that was just called in AddBullet
    procedure MoveBullets
	for i : iBulletsmin .. iNumBullets
	    bullets (i) -> BulletMove
	end for

	for b : iBulletsmin .. iNumBullets
	    for p : 1 .. iNumPlatforms

		if bullets (b) -> GetBulletX + 5 > platforms (p) -> GetX and bullets (b) -> GetBulletX + 5 < platforms (p) -> GetX + platforms (p) -> GetDimensionX
			and bullets (b) -> GetBulletY < platforms (p) -> GetY + platforms (p) -> GetDimensionY and bullets (b) -> GetBulletY + 5 > platforms (p) -> GetY then
		    bullets (b) -> SetBulletX (1700)
		    bullets (b) -> SetBulletY (1000)

		elsif bullets (b) -> GetBulletX < platforms (p) -> GetX + platforms (p) -> GetDimensionX and bullets (b) -> GetBulletX > platforms (p) -> GetX
			and bullets (b) -> GetBulletY < platforms (p) -> GetY + platforms (p) -> GetDimensionY and bullets (b) -> GetBulletY + 5 > platforms (p) -> GetY then
		    bullets (b) -> SetBulletX (1700)
		    bullets (b) -> SetBulletY (1000)
		end if
	    end for
	end for
    end MoveBullets
    
    %Sets bullet collision
    procedure SetBulletCol (ipCollision : boolean)
	bBulletCollision := ipCollision
    end SetBulletCol

    %Gets if there a bullet collision
    function GetBulletCol : boolean
	result bBulletCollision
    end GetBulletCol

    %Checks if any of this players bulletse have hit the other players (hence why hitbox values of imported) 
    procedure PlayerBulletCol (ipHitbox1x, ipHitbox1y, ipHitbox2x, ipHitbox2y, ipHeadbox1x, ipHeadbox1y, ipHeadbox2x, ipHeadbox2y : int)
	for b : iBulletsmin .. iNumBullets
	    % put "active bullet"
	    % put bullets (b) -> GetBulletX
	    % Draw.FillBox(iHeadbox1x, iHeadbox1y, iHeadbox2x, iHeadbox2y, 14)
	    % Draw.FillBox(iHitbox1x, iHitbox1y, iHitbox2x, iHitbox2y, 14)
	    % Draw.FillBox(bullets (b) -> GetBulletX, bullets (b) -> GetBulletY, bullets (b) -> GetBulletX+10, bullets (b) -> GetBulletY+10, 14)
	    if ipHeadbox2x > bullets (b) -> GetBulletX and ipHeadbox1x < bullets (b) -> GetBulletX + 5
		    and ipHeadbox1y < bullets (b) -> GetBulletY + 5 and ipHeadbox2y > bullets (b) -> GetBulletY then
		%iX := platforms (i) -> GetX - 55
		bBulletCollision := true
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)

	    elsif ipHeadbox1x < bullets (b) -> GetBulletX + 5 and ipHeadbox1x > bullets (b) -> GetBulletX
		    and ipHeadbox1y < bullets (b) -> GetBulletY + 5 and ipHeadbox2y > bullets (b) -> GetBulletY then
		%iX := platforms (i) -> GetX + platforms (i) -> GetDimensionX
		bBulletCollision := true
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)

	    elsif ipHitbox2x > bullets (b) -> GetBulletX and ipHitbox1x < bullets (b) -> GetBulletX + 5
		    and ipHitbox1y < bullets (b) -> GetBulletY + 5 and ipHitbox2y > bullets (b) -> GetBulletY then
		%iX := platforms (i) -> GetX - 55
		bBulletCollision := true
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)

	    elsif ipHitbox1x < bullets (b) -> GetBulletX + 5 and ipHitbox1x > bullets (b) -> GetBulletX
		    and ipHitbox1y < bullets (b) -> GetBulletY + 5 and ipHitbox2y > bullets (b) -> GetBulletY then
		bBulletCollision := true
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)

		%iX := platforms (i) -> GetX + platforms (i) -> GetDimensionX
	    end if
	end for
    end PlayerBulletCol

    %Checks if inputed X and Y values are inside the player and will return a true or false
    procedure IsTouching (ipX, ipY, ipWidth, ipHeight : int)
	for b : iBulletsmin .. iNumBullets
	    if bullets (b) -> GetBulletX + 5 > ipX and bullets (b) -> GetBulletX + 5 < ipX + ipWidth
		    and bullets (b) -> GetBulletY < ipY + ipHeight and bullets (b) -> GetBulletY + 5 > ipY then
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)
		bIsTouching := true
	    elsif bullets (b) -> GetBulletX < ipX + ipWidth and bullets (b) -> GetBulletX > ipX
		    and bullets (b) -> GetBulletY < ipY + ipHeight and bullets (b) -> GetBulletY + 5 > ipY then
		bullets (b) -> SetBulletX (1700)
		bullets (b) -> SetBulletY (1000)
		bIsTouching := true

	    end if
	end for
    end IsTouching

    %Everytime the procedure is called, all the bullets get moved somewhere offscreen
    procedure ClearBullets
	for b : iBulletsmin .. iNumBullets
	    bullets (b) -> SetBulletX (1700)
	    bullets (b) -> SetBulletY (1000)
	end for
    end ClearBullets

    %Sets if the bullets is touching 
    procedure SetIsTouching (ipIsTouching : boolean)
	bIsTouching := ipIsTouching
    end SetIsTouching

    %Gets if the bullets is touching
    function GetIsTouching : boolean
	result bIsTouching
    end GetIsTouching

    %This is the procedure that gets called from the main code and prompts AddBullet to construct a new bullet, this procedure also counters the amount of bullets
    procedure Shoot
	if iBulletNumber = iNumBullets then
	    iBulletNumber := iBulletsmin
	else
	    iBulletNumber := iBulletNumber + 1
	end if

	if iBulletInv > 0 then
	    AddBullet (iBulletNumber, iX + 23, iY + 25, iFacing, sType)
	    iBulletInv := iBulletInv - 1
	end if
    end Shoot

    %Every 100 times the main loop, loop around, the players' inventory will gain 1 bullet
    procedure SetInv
	iBulletAccumulator := iBulletAccumulator + 1
	if iBulletAccumulator mod 100 = 0 then
	    if iBulletInv not= 5 then
		iBulletInv := iBulletInv + 1
	    end if
	end if
    end SetInv

    %Gets the amount of bullets they have 
    function GetInv : int
	result iBulletInv
    end GetInv
end Player

%Creates the object class of Player
type PlayerClass : pointer to Player

%Sets all of the properties of Player.t to their default values, and creates the object
procedure ConstructPlayer (var opP : PlayerClass)
    new Player, opP

    setscreen ("graphics")

    opP -> SetX (320)
    opP -> SetY (200)
    opP -> SetSpeed (5)
    opP -> SetFacing (1)
    opP -> SetBackColour (0)
    opP -> SetPlayer ("Joe")
    opP -> SetinJump (false)

end ConstructPlayer

%Destructs the object
procedure DestructPlayer (var opP : PlayerClass)
    free opP
end DestructPlayer
