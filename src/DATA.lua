-----------------------------------------------------------------
-- ///////////////////////////////////////////////////////// DATA
-----------------------------------------------------------------

norm = function (v) return (v / 255) end

DATA = {}

DATA.cB37700 = {r = norm(179), g = norm(119), b = norm(0),   a = 1}
DATA.c804000 = {r = norm(128), g = norm(64),  b = norm(0),   a = 1}
DATA.cCC8800 = {r = norm(204), g = norm(136), b = norm(0),   a = 1}
DATA.c004D0D = {r = norm(0),   g = norm(77),  b = norm(13),  a = 1}

-- BOSQUE
DATA.cB37700 = {r = norm(143), g = norm(111), b = norm(47),   a = 1} --ROAD
DATA.c804000 = {r = norm(97), g = norm(74),  b = norm(0),   a = 1} --RUMBLE
DATA.cCC8800 = {r = norm(29), g = norm(120), b = norm(56),   a = 1}  --LINE
DATA.c004D0D = {r = norm(43),   g = norm(173),  b = norm(82),  a = 1} --GRASS

--MIX
DATA.mB37700 = {r = norm(173), g = norm(162), b = norm(83),   a = 1} 
DATA.m804000 = {r = norm(153), g = norm(130),  b = norm(101),   a = 1} 
DATA.mCC8800 = {r = norm(222), g = norm(213), b = norm(155),   a = 1} 
DATA.m004D0D = {r = norm(34),   g = norm(77),  b = norm(55),  a = 1} 

--PLAYA
DATA.pB37700 = {r = norm(255), g = norm(252), b = norm(191),   a = 1}
DATA.p804000 = {r = norm(241), g = norm(122),  b = norm(86),   a = 1}
DATA.pCC8800 = {r = norm(252), g = norm(244), b = norm(88),   a = 1}
DATA.p004D0D = {r = norm(221),   g = norm(196),  b = norm(184),  a = 1}

DATA.road = {width = 2000}
DATA.background = {speed = 5000}
DATA.segment = {lenght = 150, lanes = 7}
DATA.camera = {}

DATA.scale = {turtle = 2000, deco = 3500}

return DATA

-----------------------------------------------------------------