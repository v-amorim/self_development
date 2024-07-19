/********************************************************

Description: add some custom script options processing here

DO NOT MODIFY this file in SVP's folder - it will be overwritten
on the next SVP update! Edit the following file instead:

* Windows: %APPDATA%\SVP4\override.js
* Mac: ~/Library/Application Support/SVP4/override.js
* Linux: ~/.local/share/SVP4/override.js

COPY some internal SVPflow options from override_list.txt.

Howeve it's recommended to add needed options via
  Application settings -> Additional options -> All settings -> User defines options
instead of hard-coding them here.

********************************************************/

override = function () {
  //Example:
  //smooth.mask.area_sharp		= 1.0;

  /***** INSERT BELOW THIS LINE *****/

  levels.pel = 1;
  levels.scale.up = 1;
  levels.scale.down = 1;
  levels.full = true;
  analyse.block.w = 32;
  analyse.block.h = 32;
  analyse.block.overlap = 2;
  analyse.main.levels = 4;
  analyse.main.search.type = 8;
  analyse.main.search.distance = -8;
  analyse.main.search.coarse.type = 4;
  analyse.main.search.coarse.distance = -16;
  analyse.main.search.coarse.bad.range = 0;
  analyse.main.penalty.lambda = 1.0;
  analyse.main.penalty.plevel = 4.0;
  analyse.main.penalty.lsad = 800;
  analyse.main.penalty.pnew = 5;
  analyse.main.penalty.pglobal = 5;
  analyse.main.penalty.pzero = 10;
  analyse.main.penalty.pnbour = 5;
  analyse.main.penalty.prev = 0;
  analyse.refine[0] = { thsad: 2000, search: { distance: 2, type: 4 } };
  smooth.algo = 23;
  smooth.scene.mode = 0;
  smooth.mask.cover = 20;
  smooth.mask.area = 8;
  smooth.mask.area_sharp = 0.70;
  smooth.scene.limits.m1 = 3600;
  smooth.scene.limits.m2 = 7200;
  smooth.scene.limits.scene = 10400;
  smooth.scene.limits.zero = 10;
  smooth.scene.limits.blocks = 60;

  /***** INSERT ABOVE THIS LINE *****/
}
