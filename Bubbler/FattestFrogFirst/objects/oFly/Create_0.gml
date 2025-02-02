/// @description Insert description here
// You can write your code in this editor


ogX = x;

var randomNum = random(100);

myScale = 0.5;

 
if (randomNum > 66) {
	
	// only have brussel flies come in after the frog has grown twice
	var frogEvoStage = 0;
	for (i = 0; i < instance_number(oFrog); i++) {
		tempFrog =  instance_find(oFrog,i);
		if instance_exists(tempFrog) {
			if (tempFrog.frogEvolutionStage > frogEvoStage) {
				frogEvoStage = tempFrog.frogEvolutionStage;
			}
		}
	}
	
	if (frogEvoStage >= 3) {
		
		if (random(100) > 50) {
			sprite_index = sFly_CarrotCritter;
			myScale = 0.5;	
		} else {
			sprite_index = sFly_Brussel;
			myScale = 0.5;	
		}
		
		
	} else {
		
		// earlier frog evolution
		sprite_index = sFly_CarrotCritter;
		myScale = 0.5;
	}
	
	
} else if (randomNum > 33) {
	sprite_index = sBananaFruitFly;
	myScale = 0.5;
}

var flipMe = 1;
if (random(100) > 50) {
	flipMe = -1;
}

image_xscale = myScale*flipMe;
image_yscale = myScale;

curvePercent = 0.0;

curve = animcurve_get_channel(AnimationCurve2, "curve1");

curveFlyingIn = animcurve_get_channel(AnimationCurveFlyingIn, "curve1");

stateFlyingIn = function() {
	
	curvePercent += 1/50;
	
	var curveTime = animcurve_channel_evaluate(curveFlyingIn, curvePercent );
	 
	x = lerp(startX, targetX, curvePercent);
	 
	y =   lerp(startY, targetY, curvePercent);
 
	  
	 if (curvePercent > 1.0) {
		curvePercent = 0;	 
		myState = stateFloatingAround;
	 }

	 
}

stateFloatingAround = function(){
	
curvePercent += 1/50;
 
 if (curvePercent > 1.0) {
	curvePercent = 0;	 
 }



 y += 3*animcurve_channel_evaluate(curve, curvePercent );
 
 x += 3*sin(get_timer()/2); // don't use ogX because the fly moves toward the bubble	
}


myState = stateFlyingIn; // don't add brackets beside this
