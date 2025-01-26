/// @description Insert description here
// You can write your code in this editor

 x += mySpeed*( -input_value("left") + input_value("right"));

 y += mySpeed*(-input_value("up") + input_value("down"));
 
 

rh_axis = -input_value("aim_left") + input_value("aim_right");
rv_axis = -input_value("aim_up") + input_value("aim_down");

wandRadius = wandLength*sqrt(rh_axis*rh_axis + rv_axis*rv_axis);



//if (abs(wandRadius )> 5) and (alarm[0] <= 0) {
	//
	 //alarm[0] = 1*room_speed;
//}


wandAngleInDegrees =  point_direction(  x, y , x + rh_axis*100,  y - rv_axis*100 );

/*
wandX = x + rh_axis*100;
wandY = y + rv_axis*100;
*/

//wandX = x+ wandRadius*dcos(wandAngleInDegrees);
//wandY = y + wandRadius*dsin(wandAngleInDegrees);

 

playerPosPrev.Copy( playerPos );
playerPos.Set( x, y );
playerPosDelta.Set( playerPos.x - playerPosPrev.x, playerPos.y - playerPosPrev.y );

wandClosePosPrev.Copy( wandClosePos );
wandClosePos.Set( 
    x + dcos( wandAngleInDegrees ) * playerRadius, 
    y + dsin( wandAngleInDegrees ) * playerRadius
);
wandClosePosDelta.Set( wandClosePos.x - wandClosePosPrev.x, wandClosePos.y - wandClosePosPrev.y );

wandFarPosPrev.Copy( wandFarPos );
wandFarPos.Set( 
    x + dcos( wandAngleInDegrees ) * ( playerRadius + wandRadius ), 
    y + dsin( wandAngleInDegrees ) * ( playerRadius + wandRadius )
);
wandFarPosDelta.Set( wandFarPos.x - wandFarPosPrev.x, wandFarPos.y - wandFarPosPrev.y );

wandCentrePos.Set( ( wandClosePos.x + wandFarPos.x ) / 2, ( wandClosePos.y + wandFarPos.y ) / 2 );


wandNormal.Set( wandClosePos.y - wandFarPos.y, -( wandClosePos.x - wandFarPos.x ) );
wandNormal.Normalize();


wandSpeedVec.Set( ( wandClosePosDelta.x + wandFarPosDelta.x ) / 2, ( wandClosePosDelta.y + wandFarPosDelta.y ) / 2 );
wandSpeed = wandSpeedVec.Magnitude();
wandTransverseSpeed = abs( wandSpeedVec.Dot( wandNormal ) );


if( wandTransverseSpeed > wandSpeedCreatesBubble && wandRadius > wandRadiusCreatesBubble ) {
    if( wandCentrePos.SqrDistance( lastBubbleCreatedPoint ) > createNewBubbleDistSqr && current_time > afterTimeCanCreateBubble ) {

        
        // Create a new Bubble or add to currently-creating Bubble
        if( currentBubbleFramework == noone ) {
            currentBubbleFramework = instance_create_depth(wandCentrePos.x, wandCentrePos.y, 5, oBubbleFramework);
	
      	    currentBubbleFramework.playerNum = player; 
      	
      		if (player == 1) {
      	
      			currentBubbleFramework.image_blend = c_green;
      		}
        }
	    currentBubbleFramework.radius = wandRadius;
	
	    var bubbleScale = abs(wandRadius)/maxRadius;
	    currentBubbleFramework.image_xscale = bubbleScale;
	    currentBubbleFramework.image_yscale = bubbleScale;


        currentBubbleFramework.AddNewBall( wandCentrePos.x, wandCentrePos.y, wandRadius / 2 );
        // ds_list_add(obj_metaballs.balls, new obj_metaballs.Ball( wandCentrePos.x, wandCentrePos.y, wandRadius/2));



        afterTimeCanCreateBubble = current_time + createBubbleCooldownMS;
        lastBubbleCreatedPoint.Copy( wandCentrePos );
    }
}
