
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth 
local _H = display.contentHeight
local tank
local mAbs = math.abs
local restartMenu
local bullet

local d = 0
local f = 0
local g = 0
local N
centerX = display.contentCenterX
centerY = display.contentCenterY
screenLeft = display.screenOriginX
screenWidth = display.contentWidth - screenLeft
screenRight = screenLeft + screenWidth
screenTop = display.screenOriginY
screenHeight = display.contentHeight
screenBottom = screenTop + screenHeight



local physics = require("physics")

physics.start()

--physics.setDrawMode("hybrid") --Set physics Draw mode
physics.setScale( 60 ) -- a value that seems good for small objects (based on playtesting)
physics.setGravity( 0, 0 ) -- overhead view, therefore no gravity vector




local screenW, screenH = _W, _H
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight --Screen Size properties

local airplane = 1
local tiger = 2
local options = 3

local gameOver 
local mode








--Setup mainpage

function mainpage()
	gameState="none"
	
	display.setDefault( "anchorX", 0.0 )	

	display.setDefault( "anchorY", 0.0 )

	mainpageGroup = display.newGroup()
	-- print("mainpage")
	
	local mainpageBG = display.newImage("image/war-thunder.jpg", true, 20, 1, true)
	mainpageGroup:insert(mainpageBG)

	local onePlayerButton = display.newImage( "image/s-l300.jpg", 200, 350, true)
	onePlayerButton.id = airplane
	mainpageGroup:insert(onePlayerButton)
	onePlayerButton.width = 450
	onePlayerButton.height = 150

	local twoPlayerButton = display.newImage( "image/download.jpg", 200, 700, true)
	twoPlayerButton.id = tiger
	mainpageGroup:insert(twoPlayerButton)
	twoPlayerButton.height = 125

	local optionsButton = display.newImage( "image/settings.png", 200, 850, true)
	optionsButton.id = options
	mainpageGroup:insert(optionsButton)

	display.setDefault( "anchorX", 0.5 )	
	display.setDefault( "anchorY", 0.5 )

	local beginaudio= audio.loadSound("sounds/WW2dogfight.mp3")
	local backgroundMusicChannel = audio.play( beginaudio, { loops=-1 }  ) 
	


	
	onePlayerButton:addEventListener("touch", init)
	twoPlayerButton:addEventListener("touch", init)
	optionsButton:addEventListener("touch", init)
	

			local buzzOn = display.newImage( "image/war-base-logo-web-size2.png", centerX, 75, true)
	
	end
					
	--Setup Gameplay Stage
	function gameStage()

	
	stageGroup = display.newGroup()

pauseBtn = display.newImage("image/pause.png",750,-10 )
	pauseBtn:addEventListener("touch", 
		function() 
			
			local gameState = "paused"
			restartMenu(gameState)
		end
	)




if mode == airplane then


	----------------------------------- AIRPLANE --------------
	N = 1
	
  

   audio.stop(1)

	 local bullet 
score = 0 
life = 100  
local health = display.newText(score,150,150,native.systemFont,65)
stageGroup:insert(health)
health:setFillColor( 93/255, 184/255, 93/255 )


health.x=15;
health.y = -85


--local force 
function movetank ( event)
if(event.phase =="began") then 
local speed = 1500/screenWidth +(mAbs(force.x - event.x))
transition.to(force ,{time = speed , x = event.x })

--transition.to(bullet ,{time = speed , x = event.x})




	 bullet = display.newCircle( 100, 100, 10 )
   stageGroup:insert(bullet)
   physics.addBody( bullet, "dynamic", { radius=10 , friction=0.5 ,bounce=0.2} )
    bullet:applyForce(1,-20,bullet.x , bullet.y)  

  bullet.x = force.x
  bullet.y = 650 

   -- 
    local fireAudio = audio.loadSound("sounds/Arrow+Swoosh+2.mp3")
    audio.play(fireAudio)
	




	end

	end

	local bg = display.newImage("image/23979351020_768d5eacc1_c.jpg")
		stageGroup:insert(bg)
		bg.width = screenWidth ;
		bg.height = screenHeight
		bg.x=centerX 
		bg.y=centerY
		bg:addEventListener("touch",movetank)

	 force = display.newImageRect("image/airplane2.jpg",400,400) -- airplane 
	 stageGroup:insert(force)
     force.x = 480
     force.y = 950

	physics.addBody(force,"static",{friction=0.5 ,bounce=0.2} )

	---------------------    GAME OVER FUNCTION -----------------


   function gameover(gameState)
   	N = 0

			pauseBtn:removeSelf()
			menuGroup = display.newGroup()
			
			stageGroup:removeSelf()


	            function gmpic()

		
		
				local bggameoverImage = display.newImage("image/destroy.jpg")
				bggameoverImage.width = screenWidth ;
				bggameoverImage.height = screenHeight
				bggameoverImage.x=centerX 
				bggameoverImage.y=centerY
				menuGroup:insert(bggameoverImage)

				
				local gameoverImage = display.newImage("game_over.png",centerX,centerY,true )
			transition.to( gameoverImage,{delay=2500,time=2000,x=-420, rotation=360})
			
			print("button")

		    end 	
			    timer.performWithDelay(100 ,function() gmpic() end , 1)
			    gameState = "paused"
			 timer.performWithDelay(4750 ,function() newgamebutton() end , 1)
    


           function newgamebutton()
				
			if gameState == "paused" then
				local backDrop = display.newRect(0, 0, screenW, screenH )
				backDrop.anchorX = 0
				backDrop.anchorY = 0
				menuGroup:insert(backDrop)
				backDrop:setFillColor(0, 0, 0,100/255)
					--transition.cancel()



			end
			
			local restartGameImage = display.newImage("image/newGameButton.png",centerX,centerY,true )
			menuGroup:insert(restartGameImage)
			restartGameImage.state = gameState
			
			restartGameImage:addEventListener('touch', restartGame)

	
             end




		--Restart Game
		function restartGame( event )
			local gameState = event.target.state
			if event.phase == "ended"  then
		    mainpageGroup.isVisible = false
				if gameState == "gameOver" then
					gameOverGroup:removeSelf()
				end
					
					menuGroup:removeSelf() --Removes Menu Group Objects

					timer.performWithDelay(1000, mainpage, 1) -- Calls mainpage screen
		end	
		end





	end


    local function Acol(self , event)

	local BGL = display.newRect(50, 0, screenW, screenH )
		BGL.x = -220
		BGL.y = -575
		stageGroup:insert(BGL)
		BGL:setFillColor(0, 0, 0,100/255)


     transition.fadeOut( BGL, { time=750 , iterations=-1} )
	

     transition.fadeOut( power, { time=450 , iterations=-1} )
	 life = life -1 



 	power = display.newText(life,150,150,native.systemFont,55)
     stageGroup:insert(power)
     power:setFillColor( 93/255, 184/255, 93/255 )
     power.x=105;
     power.y = -85
     --bullet.isVisible = false
     if(life < 11) then 
	power:setFillColor( 1, 0, 0 )

	end

	if(life == 0) then 
		
	transition.cancel();
	
    gameover(gameState) 
			
		
			
			
		
	end


		end



	force:addEventListener("collision",Acol)

	

	-----------------------------------------------------------------------  
    -------------   CREATE FUNCTION FOR TANK 3 ---------------

	function tank3f()
		 g = 0
		 local t3bullet


	local tank3 = display.newImageRect("image/tank.jpeg",250,250)
	stageGroup:insert(tank3)
	tank3.x = 590
	tank3.y = 20
	tank3.rotation = -90

	physics.addBody(tank3,"static",{friction=0.5 ,bounce=0.2} )


	t3bullet = display.newCircle( 100, 100, 10 )
		    stageGroup:insert(t3bullet)
		    t3bullet.x = 590
			t3bullet.y = 180

	  
	    physics.addBody( t3bullet, "physics", { radius=10 , friction = 0.1} )



		function BULL3()
		t3bullet.x = 590
		t3bullet.y = 180
		transition.to( t3bullet,{time=2000, y= 2220 , iterations =-1})
	--	print("T3")
	     end 


	    
		timer.performWithDelay(2000 ,function() BULL3() end , -1)
		

local t3h = 10
local function t3c(event)
	collisionball = display.newImage("image/Muzzle_flash_VFX.png")
	collisionball.width = 55 ;
    collisionball.height = 55
	collisionball.x = event.target.x
	collisionball.y = event.target.y 
	bullet.isVisible = true
	transition.fadeOut( collisionball, { time=450 , iterations=-1} )
   transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
    --bullet:removeSelf()
   
	t3h = t3h -1 ; 
	--print(" me 3 " .. t3h);
	if(t3h < 3 and t3h > 1) then 
	transition.blink( tank3 ,{time=2500})
	elseif(t3h<2) then 
	 g = 1
	tank3:removeSelf()
	 t3bullet:removeSelf()
	
	score  =score +1 
	
      

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85
    

	end

	 end
	tank3:addEventListener("collision",t3c)





	
	end

	-------------   CREATE FUNCTION FOR TANK 2 ---------------


	function tank2f()
		local t2bullet
		d = 0 
		local tank2 = display.newImageRect("image/tank.jpeg",250,250)
		stageGroup:insert(tank2)
		tank2.x = 320
		tank2.y = 20
		tank2.rotation = -90

		physics.addBody(tank2,"static",{friction=0.5 ,bounce=0.2} )

		t2bullet = display.newCircle( 100, 100, 10 )
	    stageGroup:insert(t2bullet)
	    t2bullet.x = 320
		t2bullet.y = 180

	    

	    physics.addBody( t2bullet, "physics", { radius=10 , friction = 0.1} )


		
		function BULL2()
			t2bullet.x = 320
		    t2bullet.y = 180
		    transition.to( t2bullet,{time=2500, y= 2220 , iterations =1})
		--  print("T2")
	       end 


	    
		timer.performWithDelay(1500 ,function() BULL2() end , -1)
	   


local t2h = 10
local function t2c(event)
   	collisionbal2 = display.newImage("image/Muzzle_flash_VFX.png")
	collisionbal2.width = 55 ;
    collisionbal2.height = 55
	collisionbal2.x = event.target.x
	collisionbal2.y = event.target.y 
	transition.fadeOut( collisionbal2, { time=450 , iterations=-1} )
	transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
   -- bullet:removeSelf()

	t2h = t2h -1 ; 
	print(" me 2 " ..t2h);
	if(t2h < 4 and t2h > 1) then 

	transition.blink( tank2 ,{time=2500})
	elseif(t2h<2) then 
	tank2:removeSelf()
	t2bullet:removeSelf()
	d = 1
	score  =score +1 
	

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85


    

	end

	 end
	tank2:addEventListener("collision",t2c)


	end

	-------------   CREATE FUNCTION FOR TANK 1 ---------------
	function tank1f()
		local t1bullet
		f = 0 
		local tank1 = display.newImageRect("image/tank.jpeg",250,250)
		stageGroup:insert(tank1)
		tank1.x = 50
        tank1.y = 20
		tank1.rotation = -90

		physics.addBody(tank1,"static",{friction=0.5 ,bounce=0.2} )
		

		t1bullet = display.newCircle( 100, 100, 10 )
	    stageGroup:insert(t1bullet)
	    t1bullet.x = 80
		t1bullet.y = 180

	    --t2bullet.isVisible = false

	    physics.addBody( t1bullet, "physics", { radius=10 , friction = 0.1} )

      --  t2bullet.isVisible = true
		
		function BULL1()
		t1bullet.x = 80
		t1bullet.y = 180
		    transition.to( t1bullet,{time=2500, y= 2220 , iterations =1})
		--  print("T2")
	       end 


	    
		timer.performWithDelay(1500 ,function() BULL1() end , -1)


		local t1h = 10
		local function t1c(event)
		   	collisionbal1 = display.newImage("image/Muzzle_flash_VFX.png")
			collisionbal1.width = 55 ;
		    collisionbal1.height = 55
			collisionbal1.x = event.target.x
			collisionbal1.y = event.target.y 
			transition.fadeOut( collisionbal1, { time=450 , iterations=-1} )
			transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
			--bullet:removeSelf()
		    

		t1h = t1h -1 ; 
	--	print(" me 2 " ..t1h);
		if(t1h < 4 and t1h > 1) then 

		transition.blink( tank1 ,{time=2500})
		elseif(t1h<2) then 
			tank1:removeSelf()
			t1bullet:removeSelf()
	
	f = 1
	
	score  =score +1 
	

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85


    

end

 end

tank1:addEventListener("collision",t1c)

	end


tank1f() 
tank2f()
tank3f()






	function check(event) 
	if g == 1  then

	--	print("TANK3 WILL BACK ")
		timer.performWithDelay(1500 ,function() tank3f() end , 1)
	end


		if d == 1  then
     --  print("TANK2 WILL BACK ")

       timer.performWithDelay(2000 ,function() tank2f() end , 1)
       
			end 


			if f == 1 then
		--print(" TANK1 WILL BACK ")
		timer.performWithDelay(1800 ,function() tank1f() end , 1)
		
else
--	print(" All good  ")
end



end
if(N == 1) then
	print (" is " .. N )
timer.performWithDelay(3000 ,function() check(event) end , - 1)
end





  ------------------------------------------------- TANK-------------------



elseif mode == tiger then

	--local force
	N = 1
 mAbs = math.abs -----------------------------
 audio.stop(1)

	 local bullet 
score = 0 
life = 100 
local health = display.newText(score,150,150,native.systemFont,65)
stageGroup:insert(health)
health:setFillColor( 93/255, 184/255, 93/255 )


health.x=15;
health.y = -85


--local force 
function movetank ( event)
if(event.phase =="began") then 
local speed = 1500/screenWidth +(mAbs(force.x - event.x))
transition.to(force ,{time = speed , x = event.x })
transition.to(bullet ,{time = speed , x = event.x})


	 bullet = display.newCircle( 100, 100, 10 )
   stageGroup:insert(bullet)
   physics.addBody( bullet, "dynamic", { radius=10 , friction=0.5 ,bounce=0.2} )
      		 
  bullet.x = force.x
  bullet.y = 650 

    bullet:applyForce(1,-20,bullet.x , bullet.y)
    local fireAudio = audio.loadSound("sounds/TANK.mp3")
    audio.play(fireAudio)
	




	end

	end

      local bg = display.newImage("image/23979351020_768d5eacc1_c.jpg")
		stageGroup:insert(bg)
		bg.width = screenWidth ;
		bg.height = screenHeight
		bg.x=centerX 
		bg.y=centerY
		bg:addEventListener("touch",movetank)

	 force = display.newImageRect("image/unnamed.png",500,500) -- airplane 
	 stageGroup:insert(force)
     force.x = 480
     force.y = 950
     force.rotation = -29

     physics.addBody(force,"static",{friction=0.5 ,bounce=0.2} )

	---------------------    GAME OVER FUNCTION -----------------


   function gameover(gameState)

         	N = 0

			pauseBtn:removeSelf()
			menuGroup = display.newGroup()
			stageGroup:removeSelf()


	            function gmpic()

		
		
				local bggameoverImage = display.newImage("image/Destroyed_Tiger.png")
				bggameoverImage.width = screenWidth ;
				bggameoverImage.height = screenHeight
				bggameoverImage.x=centerX 
				bggameoverImage.y=centerY
				menuGroup:insert(bggameoverImage)

				
				local gameoverImage = display.newImage("image/game_over.png",centerX,centerY,true )
			transition.to( gameoverImage,{delay=2500,time=2000,x=-420, rotation=360})
			
			print("button")

		    end 	
			    timer.performWithDelay(100 ,function() gmpic() end , 1)
			    gameState = "paused"
			 timer.performWithDelay(4750 ,function() newgamebutton() end , 1)
    


           function newgamebutton()
				
			if gameState == "paused" then
				local backDrop = display.newRect(0, 0, screenW, screenH )
				backDrop.anchorX = 0
				backDrop.anchorY = 0
				menuGroup:insert(backDrop)
				backDrop:setFillColor(0, 0, 0,100/255)
				



			end
			
			local restartGameImage = display.newImage("image/newGameButton.png",centerX,centerY,true )
			menuGroup:insert(restartGameImage)
			restartGameImage.state = gameState
			
			restartGameImage:addEventListener('touch', restartGame)

	
             end




		--Restart Game
		function restartGame( event )
			local gameState = event.target.state
			if event.phase == "ended"  then
		    mainpageGroup.isVisible = false
				if gameState == "gameOver" then
					gameOverGroup:removeSelf()
				end
					
					menuGroup:removeSelf() --Removes Menu Group Objects

					timer.performWithDelay(1000, mainpage, 1) -- Calls mainpage screen
		end	
		end









	end

 










local function Acol(self , event)


		local BGL = display.newRect(50, 0, screenW, screenH )
		BGL.x = -220
		BGL.y = -575
		stageGroup:insert(BGL)
		BGL:setFillColor(0, 0, 0,100/255)


    transition.fadeOut( BGL, { time=750 , iterations=-1} )

    transition.fadeOut( power, { time=450 , iterations=-1} )
	life = life -1 


	print(life)
    power = display.newText(life,150,150,native.systemFont,55)
     stageGroup:insert(power)
     power:setFillColor( 93/255, 184/255, 93/255 )
     power.x=120
     power.y = -85
     --bullet.isVisible = false
     if(life < 11) then 
	power:setFillColor( 1, 0, 0 )

	end

	if(life == 0) then 
	
	transition.cancel();
	
    gameover(gameState) 
			
			 
			
			
			
		
    end


	end



    force:addEventListener("collision",Acol)

	

	-----------------------------------------------------------------------  
    -------------   CREATE FUNCTION FOR TANK 3 ---------------

	function tank3f()
		 g = 0
		 local t3bullet


	local tank3 = display.newImageRect("image/tank.jpeg",250,250)
		stageGroup:insert(tank3)
		tank3.x = 590
		tank3.y = 20
		tank3.rotation = -90

		physics.addBody(tank3,"static",{friction=0.5 ,bounce=0.2} )


		t3bullet = display.newCircle( 100, 100, 10 )
		    stageGroup:insert(t3bullet)
		    t3bullet.x = 590
			t3bullet.y = 180

	  
	    physics.addBody( t3bullet, "physics", { radius=10 , friction = 0.1} )




		function BULL3()
		t3bullet.x = 590
		t3bullet.y = 180
		transition.to( t3bullet,{time=2000, y= 2220 , iterations =-1})
	--	print("T3")
	     end 


	    
		timer.performWithDelay(2000 ,function() BULL3() end , -1)
		

local t3h = 10
local function t3c(event)
	collisionball = display.newImage("image/Muzzle_flash_VFX.png")
	collisionball.width = 55 ;
    collisionball.height = 55
	collisionball.x = event.target.x
	collisionball.y = event.target.y 
	bullet.isVisible = true
	transition.fadeOut( collisionball, { time=450 , iterations=-1} )
	transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
    --bullet:removeSelf()
   
	t3h = t3h -1 ; 
	-- print(" me 3 " .. t3h);
	if(t3h < 3 and t3h > 1) then 
	transition.blink( tank3 ,{time=2500})
	elseif(t3h<2) then 
	 g = 1
	tank3:removeSelf()
	 t3bullet:removeSelf()
	
	score  =score +1 
	
      

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85
    

	end


	 end
	tank3:addEventListener("collision",t3c)


	




	
	end

	-------------   CREATE FUNCTION FOR TANK 2 ---------------


	function tank2f()
		local t2bullet
		d = 0 
		local tank2 = display.newImageRect("image/tank.jpeg",250,250)
		stageGroup:insert(tank2)
		tank2.x = 320
		tank2.y = 20
		tank2.rotation = -90

		physics.addBody(tank2,"static",{friction=0.5 ,bounce=0.2} )

		t2bullet = display.newCircle( 100, 100, 10 )
	    stageGroup:insert(t2bullet)
	    t2bullet.x = 320
		 t2bullet.y = 180

	    

	    physics.addBody( t2bullet, "physics", { radius=10 , friction = 0.1} )

     
		
		function BULL2()
			t2bullet.x = 320
		    t2bullet.y = 180
			
		    transition.to( t2bullet,{time=2500, y= 2220 , iterations =1})
		--  print("T2")
	       end 


	    
		timer.performWithDelay(1500 ,function() BULL2() end , -1)
	   


	local t2h = 10
	local function t2c(event)
   	collisionbal2 = display.newImage("image/Muzzle_flash_VFX.png")
	collisionbal2.width = 55 ;
    collisionbal2.height = 55
	collisionbal2.x = event.target.x
	collisionbal2.y = event.target.y 
	transition.fadeOut( collisionbal2, { time=450 , iterations=-1} )
	transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
   -- bullet:removeSelf()

	t2h = t2h -1 ; 
	-- print(" me 2 " ..t2h);
	if(t2h < 4 and t2h > 1) then 

	transition.blink( tank2 ,{time=2500})
	elseif(t2h<2) then 
	tank2:removeSelf()
	t2bullet:removeSelf()
	d = 1
	score  =score +1 
	

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85


    

	end

	 end
	tank2:addEventListener("collision",t2c)



	end

	-------------   CREATE FUNCTION FOR TANK 1 ---------------

	function tank1f()
		local t1bullet
		f = 0 
		local tank1 = display.newImageRect("image/tank.jpeg",250,250)
		stageGroup:insert(tank1)
		tank1.x = 50
        tank1.y = 20
		tank1.rotation = -90

		physics.addBody(tank1,"static",{friction=0.5 ,bounce=0.2} )
		

		t1bullet = display.newCircle( 100, 100, 10 )
	    stageGroup:insert(t1bullet)
	    t1bullet.x = 80
		t1bullet.y = 180

	    --t2bullet.isVisible = false

	    physics.addBody( t1bullet, "physics", { radius=10 , friction = 0.1} )

      --  t2bullet.isVisible = true
		
		function BULL1()
		t1bullet.x = 80
		t1bullet.y = 180
		    transition.to( t1bullet,{time=2500, y= 2220 , iterations =1})
		--  print("T2")
	       end 


	    
		timer.performWithDelay(1500 ,function() BULL1() end , -1)

   
		local t1h = 10
		local function t1c(event)
		   	collisionbal1 = display.newImage("image/Muzzle_flash_VFX.png")
			collisionbal1.width = 55 ;
		    collisionbal1.height = 55
			collisionbal1.x = event.target.x
			collisionbal1.y = event.target.y 
			transition.fadeOut( collisionbal1, { time=450 , iterations=-1} )
			transition.to( bullet, {delay = 1000 , time=1050 , bullet:removeSelf() , iterations=1} )
			--bullet:removeSelf()
		    

		t1h = t1h -1 ; 
	--	print(" me 2 " ..t1h);
		if(t1h < 4 and t1h > 1) then 

		transition.blink( tank1 ,{time=2500})
		elseif(t1h<2) then 
			tank1:removeSelf()
	
	f = 1
	score  =score +1 
	

     transition.fadeOut( health, { time=450 , iterations=-1} )
	 health = display.newText(score,150,150,native.systemFont,65)
     stageGroup:insert(health)
     health:setFillColor( 93/255, 184/255, 93/255 )
     health.x=15;
     health.y = -85


    

end

 end


tank1:addEventListener("collision",t1c)

	end

tank1f()
tank2f()
tank3f()





	function check(event) 
	if g == 1  then

	--	print("TANK3 WILL BACK ")
		timer.performWithDelay(1500 ,function() tank3f() end , 1)
	end


		if d == 1  then
    --   print("TANK2 WILL BACK ")

       timer.performWithDelay(2000 ,function() tank2f() end , 1)
  
			end 


			if f == 1 then
		-- print(" TANK1 WILL BACK ")
		timer.performWithDelay(1800 ,function() tank1f() end , 1)
		
else
	-- print(" All good  ")
end




end

if(N == 1) then

timer.performWithDelay(4000 ,function() check(event) end , -1)
end





  ------------------------------------------------- TANK-------------------

	end



end



--------------------------------------------------
--In game restart menu
function  restartMenu(gameState)
	pauseBtn:removeSelf()
	menuGroup = display.newGroup()
	stageGroup:removeSelf()
		
	if gameState == "paused" then
		local backDrop = display.newRect(0, 0, screenW, screenH )
		backDrop.anchorX = 0
		backDrop.anchorY = 0
		menuGroup:insert(backDrop)
		backDrop:setFillColor(0, 0, 0,100/255)
			transition.cancel()



	end
	
	local restartGameImage = display.newImage("image/newGameButton.png",centerX,centerY,true )
	menuGroup:insert(restartGameImage)
	restartGameImage.state = gameState
	transition.cancel()
	restartGameImage:addEventListener('touch', restartGame)

	
end




--Restart Game
function restartGame( event )
	local gameState = event.target.state
	if event.phase == "ended"  then
    mainpageGroup.isVisible = false
		if gameState == "gameOver" then
			gameOverGroup:removeSelf()
		end
			
			menuGroup:removeSelf() --Removes Menu Group Objects
		

			timer.performWithDelay(1000, mainpage, 1) 
	end
end






--Displays options menu
function optionMenu()

	audio.stop(1)
	
	
end



function init( event )
	 
	mode = event.target.id

	if mode == airplane or mode == tiger then
		print("init ")
		

		
	mainpageGroup:removeSelf()-- Removes mainpage screen objects
		
	timer.performWithDelay(800, gameStage, 1)
	
		
	elseif mode == options then
		local mainpageButtonAnimation = transition.to( mainpageGroup, { alpha= 0, xScale= 1, yScale=1.0, time=400} ) -- Transitions mainpage Menu to options Menu
		optionMenu()
	end
	
		
end

-- Set Up mainpage Screen

mainpage()







