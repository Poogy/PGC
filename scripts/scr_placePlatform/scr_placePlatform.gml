///scr_placePlatform();
scr_basic();

maxHeightDifference = 4; //between platforms
minPlatformLength = 3;

heightY = 0; //At which heights the last tiles were placed

placesPerRow = rows - 2; //24
placesPerColumn = columns - 2; //17

platformAmt = irandom_range(1, 3);
spaceBetweenPlatformModifier = irandom_range(-1,1); //To determine how a line will look

definiteSpace = false;
frontSpace = 0;
frontBackSpace = 0;

spaces = platformAmt + spaceBetweenPlatformModifier; //(n-1, n, n+1) = (space inbetween, + at the front/back, + everywhere)
if((spaceBetweenPlatformModifier == 0) || (spaces == 0)){frontBackSpace = irandom_range(1,2); definiteSpace = true;}
if(frontBackSpace == 1) frontSpace = true;
else if(frontBackSpace == 2) frontSpace = false;
if(spaces == 0) spaces = 1; //against zero space to pass through

freeSpacePerHeightLevel = irandom_range(spaces, placesPerRow - platformAmt * minPlatformLength);
freeSpaceLeft = freeSpacePerHeightLevel;
for(f = 1; f <= spaces; f++){
	spaceLength[f] = irandom_range(1, freeSpaceLeft - (spaces - f));
	freeSpaceLeft -= spaceLength[f];
}
if(freeSpaceLeft > 0) spaceLength[spaces] += freeSpaceLeft; //Add leftover free space

placesForPlatforms = placesPerRow - freeSpacePerHeightLevel;
spacesForPlatformsLeft = placesForPlatforms;

for(a = 1; a <= platformAmt; a++){
	platformLength[a] = irandom_range(minPlatformLength, spacesForPlatformsLeft - (platformAmt - a) * minPlatformLength);//minRange to How much is left
	spacesForPlatformsLeft -= platformLength[a];
}
if(spacesForPlatformsLeft > 0) platformLength[platformAmt] += spacesForPlatformsLeft; //Add leftover space to the last Platform


//Place Platforms
for(h = 0; heightY < placesPerColumn - 1; h++){ //Choose how many Platforms there should be
	posY[h] = irandom_range(2, maxHeightDifference);
	heightY += posY[h];
	
	//starting_x = irandom_range(1, freeSpacePerHeightLevel);
	for(a = 1; a <= platformAmt; a++){
		if(definiteSpace){
			if(frontSpace){
				if(platformAmt == 1) posX[1] = spaceLength[1]; //Front Space
				else if(platformAmt == 2) {posX[1] = spaceLength[1]; posX[2] = posX[1] + platformLength[1] + spaceLength[2]} //Front Space
				else if(platformAmt == 3) {posX[1] = spaceLength[1]; posX[2] = posX[1] + platformLength[1] + spaceLength[2]; posX[3] = posX[2] + platformLength[2] + spaceLength[3]} //Front Space
			}else{
				if(platformAmt == 1) posX[1] = 0; //Back Space
				else if(platformAmt == 2) {posX[1] = 0; posX[2] = platformLength[1] + spaceLength[2]} //Back Space
				else if(platformAmt == 3) {posX[1] = 0; posX[2] = platformLength[1] + spaceLength[2]; posX[3] = posX[2] + platformLength[2] + spaceLength[3]} //Back Space
			}
		}else{
			if(spaceBetweenPlatformModifier == 1){
				if(platformAmt == 1) posX[1] = spaceLength[1]; //Front + Back Space
				else if(platformAmt == 2) {posX[1] = spaceLength[1]; posX[2] = posX[1] + platformLength[1] + spaceLength[2]} //Front + Back Space
				else if(platformAmt == 3) {posX[1] = spaceLength[1]; posX[2] = posX[1] + platformLength[1] + spaceLength[2]; posX[3] = posX[2] + platformLength[2] + spaceLength[3]} //Front + Back Space
			}else if(spaceBetweenPlatformModifier == -1){
				if(platformAmt == 2) {posX[1] = 0; posX[2] = platformLength[1] + spaceLength[1]} //No space around
				else if(platformAmt == 3) {posX[1] = 0; posX[2] = platformLength[1] + spaceLength[1]; posX[3] = posX[2] + platformLength[2] + spaceLength[2]} //No space around
			}
		}
	}
	for(nr = 1; nr <= platformAmt; nr++){
		for(l = 1; l < platformLength[nr]; l++){ //Place Platform
			instance_create_depth(16 + 32 * (posX[nr] + l), HEIGHT - 16 - 32 * heightY, 0, obj_solid);
		}
	}
}