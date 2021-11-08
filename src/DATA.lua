-----------------------------------------------------------------
-- ///////////////////////////////////////////////////////// DATA
-----------------------------------------------------------------

norm = function (v) return (v / 255) end

DATA = {}

DATA.cB37700 = {r = norm(179), g = norm(119), b = norm(0),   a = 1}
DATA.c804000 = {r = norm(128), g = norm(64),  b = norm(0),   a = 1}
DATA.cCC8800 = {r = norm(204), g = norm(136), b = norm(0),   a = 1}
DATA.c004D0D = {r = norm(0),   g = norm(77),  b = norm(13),  a = 1}

DATA.road = {width = 1200}
DATA.segment = {lenght = 150, lanes = 16}
DATA.camera = {}


return DATA

-----------------------------------------------------------------