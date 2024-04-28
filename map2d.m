% show camera locations

function map2d()

assert(~isMATLABReleaseOlderThan('R2023a'))

camera1loc = [48.035108, -97.368604];
% Ludvina location metadata, believed accurate

camera2loc = [51.0086, -113.3994];
% imprecise--only the nearest town "strathmore, AB" is known.

land = readgeotable('landareas.shp');

geoplot(land)

ax = gca;
set(ax, NextPlot='add')

geoscatter(ax, [camera1loc(1), camera2loc(1)], [camera1loc(2), camera2loc(2)], 200, 'filled')

geolimits(ax, [45, 55], [-115, -95])


end