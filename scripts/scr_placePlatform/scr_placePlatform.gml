///scr_placePlatform();
scr_basic();

maxHeightDifference = 4;
minPlatformLength = 3;

heightY = 0;

placesPerRow = rows - 2; //24
placesPerColumn = columns - 2; //17

platformAmt = irandom_range(1, 3);

freeSpacePerHeightLevel = irandom_range(platformAmt + (platformAmt - 1), placesPerRow - platformAmt * minPlatformLength );

placesForPlatforms = placesPerRow - freeSpacePerHeightLevel;
spacesForPlatformsLeft = placesForPlatforms;

for(a = 1; a <= platformAmt; a++){
	platformLength[a] = irandom_range(minPlatformLength, spacesForPlatformsLeft - (platformAmt - a) * minPlatformLength)
	spacesForPlatformsLeft -= platformLength[a];
}

for(h = 0; heightY < placesPerColumn - 1; h++){ //Choose how many Platforms there should be
	posY[h] = irandom_range(2, maxHeightDifference);
	heightY += posY[h];
	
	starting_x = irandom_range(1, freeSpacePerHeightLevel);
	for(l = 0; l < platformLength; l++){ //Place Platform
		instance_create_depth(16 + 32 * (starting_x + l), HEIGHT - 16 - 32 * heightY, 0, obj_solid);
	}
}