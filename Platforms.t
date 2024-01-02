/* +-------------------------------------------------------------------------+
 | Platforms.t - Object Platform, makes platforms/blocks for player to     |
 |              interact with in the map. The X, Y values, dimension and  |
 |               colour can be set for each platform. Each platform also   |
 |               has its own plater -> platform collision detection to see |
 |               if a player if above or under it.                         |
 +-------------------------------------------------------------------------+
 | Author - Kavin Nimalarajan                                              |
 | Date   - June 09 2023                                                   |
 +-------------------------------------------------------------------------+
 | Input  - none                                                           |
 | Output - none                                                           |
 +-------------------------------------------------------------------------+ */

%Using vec2 for x and y values [using vec2 because its easier for x and y variables since x and y values are going to be set multiple times]   
type vec2 :
    record
	x, y : int
    end record
     
class Platform 
    %Imports vec2 
    import vec2 
    
    %Export list of procedure s
    export SetPosition, SetDimension, SetHitbox, SetColour, GetX, GetY, GetDimensionX, GetDimensionY, 
	Show, Collision, UnderCollision

    %Declaring variables     
    var iColour : int := 0 
    var plat, dimension, hitbox1, hitbox2, pos : vec2 
    var collision, under_collision : boolean := false 
    
    %Setting all the values to 0
    plat.x := 0 
    plat.y := 0 
    dimension.x := 0 
    dimension.y := 0 
    hitbox1.x := 0
    hitbox1.y := 0 
    hitbox2.x := 0 
    hitbox2.y := 0 
    
    %Sets the X and Y value of the platform 
    procedure SetPosition (ipX, ipY : int) 
	plat.x := ipX 
	plat.y := ipY 
    end SetPosition 
    
    %Sets the width and height of the platform 
    procedure SetDimension (ipDimensionX, ipDimensionY : int) 
	dimension.x := ipDimensionX 
	dimension.y := ipDimensionY 
    end SetDimension 
    
    %Imports the player hitbox 
    procedure SetHitbox (ipX1, ipX2, ipX, ipY: int) 
	hitbox1.x := ipX1
	hitbox2.x := ipX2
	pos.x := ipX
	pos.y := ipY
    end SetHitbox 
    
    %Gets the platforms X value 
    function GetX : int
	result plat.x
    end GetX

    %Gets the platforms Y value
    function GetY : int
	result plat.y
    end GetY

    %Gets the platforms width
    function GetDimensionX : int
	result dimension.x
    end GetDimensionX

    %Gets the platforms height
    function GetDimensionY : int
	result dimension.y
    end GetDimensionY
    
    %Sets the colour of the platform 
    procedure SetColour(ipColour : int)
	iColour := ipColour 
    end SetColour 
    
    %Shows the platform 
    procedure Show
	Draw.FillBox (plat.x, plat.y, plat.x + dimension.x, plat.y + dimension.y, iColour) 
    end Show

    %Returns true or false if the player is ontop of the platform and touching it  
    function Collision : boolean 
    
	if pos.y > plat.y + dimension.y and hitbox2.x > plat.x and hitbox1.x < plat.x + dimension.x then 
	    collision := true 
	
	elsif pos.y < dimension.y then 
	    collision := false 
	  
	elsif hitbox2.x < plat.x or hitbox1.x > plat.x + dimension.x then 
	    collision := false 
	    
	end if 
	result collision
    end Collision 
    
   %Returns treu or false if the player is under the platform and touching it  
   function UnderCollision : boolean
	if pos.y + 61 < plat.y and pos.x < plat.x + dimension.x and pos.x + 55 > plat.x then 
	    under_collision := true 
	    
	elsif pos.x > plat.x + dimension.x or pos.x + 55 < plat.x or pos.y > plat.y + dimension.y then 
	    under_collision := false 
	    
	end if 
	result under_collision
    end UnderCollision 
end Platform 

type PlatformClass : pointer to Platform  
