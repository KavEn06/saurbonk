/* +-------------------------------------------------------------------------+
 | Bullet.t - Object Bullet, creates every single bullet that the player   |
 |            will ever shoot. Here things such as the X, Y values,        |
 |            direction and label [which player the bullet belongs to] can |
 |            be changed. Values such as the X, Y values and label of the  |
 |            bullet are also acessable to check for platform collisions or|
 |            player collisions.                                           |
 +-------------------------------------------------------------------------+
 | Author -  Kavin Nimalarajan                                             |
 | Date   -  June 09 2023                                                  |
 +-------------------------------------------------------------------------+
 | Input  -  none                                                          |
 | Output -  none                                                          |
 +-------------------------------------------------------------------------+ */

class Bullet
    %Export list of procedures 
    export SetBulletX, SetBulletY, SetBulletDir, GetBulletDir, GetBulletX, GetBulletY,
	BulletShow, BulletMove, SetBulletLabel, GetBulletLabel

    %Declaring the variables 
    var iBulletX, iBulletY, iDirection, iColour : int := 0
    var sLabel : string := "-"

    %Sets the X value of the bullet
    procedure SetBulletX (ipBulletX : int)
	iBulletX := ipBulletX
    end SetBulletX

    %Sets the Y value of the bullet
    procedure SetBulletY (ipBulletY : int)
	iBulletY := ipBulletY
    end SetBulletY

    %Sets which way the bullet is going to move 
    procedure SetBulletDir (ipBulletDir : int)
	iDirection := ipBulletDir
    end SetBulletDir

    %Gets the X value of the bullet
    function GetBulletX : int
	result iBulletX
    end GetBulletX

    %Gets the Y value of the bullet
    function GetBulletY : int
	result iBulletY
    end GetBulletY

    %Gets the direction of the bullet
    function GetBulletDir : int
	result iDirection
    end GetBulletDir

    %Gets which player the bullet belongs to 
    function GetBulletLabel : string
	result sLabel
    end GetBulletLabel

    %Sets which player the bullet belongs to     
    procedure SetBulletLabel (ipLabel : string)
	sLabel := ipLabel
	
	if sLabel = "Jae" then 
	    iColour := 4 
	elsif sLabel = "Joe" then 
	    iColour := 127
	end if     
    end SetBulletLabel

    %Shows the bullet
    procedure BulletShow
	drawfillbox (iBulletX, iBulletY, iBulletX + 5, iBulletY + 5, iColour)          % <- Right Code for the player thing
    end BulletShow

    %Moves the bullet 
    procedure BulletMove
	if iDirection = 0 then
	    iBulletX -= 7
	elsif iDirection = 1 then
	    iBulletX += 7
	end if
	BulletShow
    end BulletMove
end Bullet

type BulletClass : pointer to Bullet

%Constructs the bullet
procedure ConstructBullet (var opP : BulletClass)
    new Bullet, opP

    opP -> SetBulletX (320)
    opP -> SetBulletY (200)
    opP -> SetBulletDir (1)
end ConstructBullet

%Destructs the bullet
procedure DestructBullet (var opP : BulletClass)
    free opP
end DestructBullet
