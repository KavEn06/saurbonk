/* +-------------------------------------------------------------------------+
 |         Program Description                                             |
 +-------------------------------------------------------------------------+
 | Author -                                                                |
 | Date   -                                                                |
 +-------------------------------------------------------------------------+
 | Input  -                                                                |
 | Output -                                                                |
 +-------------------------------------------------------------------------+ */

include "Player.t"


var oPlayer, oPlayer2: PlayerClass
var cLet : array char of boolean
var bulletshotonthiskeypress, traceronthiskeypress : boolean := true
var iGravity, NumPlatforms, Background : int
var rVelocity, rJump : real
ConstructPlayer (oPlayer)
ConstructPlayer (oPlayer2)
rJump := 15
iGravity := 1
rVelocity := 0
NumPlatforms := 1

oPlayer -> SetSpeed (4)
oPlayer -> SetPlayer ("Jae")
oPlayer -> Show

oPlayer2 -> SetSpeed (4)
oPlayer2 -> SetPlayer ("Joe")
oPlayer2 -> Show


View.Set ("graphics:1600;750,nobuttonbar")
setscreen ("offscreenonly")

loop
    cls
    Input.KeyDown (cLet)
    if cLet ('w') and oPlayer -> GetinJump = false then
	oPlayer -> Move (Direction.Up)
    elsif (cLet ('d')) then
	oPlayer -> Move (Direction.Right)
    elsif (cLet ('a')) then
	oPlayer -> Move (Direction.Left)
    end if

    if cLet ('r') then
	if not bulletshotonthiskeypress then
	put "Shoot"
	    oPlayer -> Shoot
	end if
	bulletshotonthiskeypress := true
    else
    put "not shoot" 
	bulletshotonthiskeypress := false
    end if

    if cLet ('q') then
	if not traceronthiskeypress then
	    oPlayer -> Move (Direction.Tracer)
	end if
	traceronthiskeypress := true
    else
	traceronthiskeypress := false
    end if

    if cLet ('w') = false and cLet ('a') = false and cLet ('d') = false and cLet ('r') = false then
	oPlayer -> Move (Direction.Stand)
    end if

    oPlayer -> Gravity
    oPlayer -> PlayerCollision

    if oPlayer -> GetY < 10 /*The equal 10 would be a block detection thing*/ then
	oPlayer -> SetY (10)
	oPlayer -> SetVelocity (0)
	oPlayer -> SetinJump (false)
    end if

    oPlayer -> SetInv
    oPlayer -> MoveBullets
    oPlayer -> Show


    % if cLet ('i') and oPlayer2 -> GetinJump = false then
    %     oPlayer2 -> Move (Direction.Up)
    % elsif (cLet ('l')) then
    %     oPlayer2 -> Move (Direction.Right)
    % elsif (cLet ('j')) then
    %     oPlayer2 -> Move (Direction.Left)
    % end if
    % 
    % if cLet ('p') then
    %     if not bulletshotonthiskeypress then
    %         oPlayer2 -> Shoot
    %     end if
    %     bulletshotonthiskeypress := true
    % else
    %     bulletshotonthiskeypress := false
    % end if
    % 
    % if cLet ('u') then
    %     if not traceronthiskeypress then
    %         oPlayer2 -> Move (Direction.Tracer)
    %     end if
    %     traceronthiskeypress := true
    % else
    %     traceronthiskeypress := false
    % end if
    % 
    % if cLet ('i') = false and cLet ('j') = false and cLet ('l') = false and cLet ('p') = false then
    %     oPlayer2 -> Move (Direction.Stand)
    % end if
    % 
    % oPlayer2 -> Gravity
    % oPlayer2 -> PlayerCollision
    % 
    % if oPlayer2 -> GetY < 10 then
    %     oPlayer2 -> SetY (10)
    %     oPlayer2 -> SetVelocity (0)
    %     oPlayer2 -> SetinJump (false)
    % end if
    % 
    % 
    % oPlayer2 -> MoveBullets
    % oPlayer2 -> Show     
    
    View.Update
    delay (15)
end loop

%Look at process and fork

