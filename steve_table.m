function g = steve_table(fig)
arguments
    fig (1,1) = uifigure
end

assert(~isMATLABReleaseOlderThan("R2021a"))

cam1 = [48.035108, -97.368604];
% Ludvina location metadata, believed accurate

cam2 = [51.0086, -113.3994];
% imprecise--only the nearest town "Strathmore, AB" is known.

% https://www.mathworks.com/help/map/ref/geoglobe.html
g = geoglobe(fig, NextPlot="add", Basemap="landcover", Terrain = "None");

% https://www.mathworks.com/help/map/ref/geoplot3.html
geoplot3(g, [cam1(1), cam2(1)], [cam1(2), cam2(2)], 0, ...
    LineStyle="None", LineWidth=3, Marker="o", Color="magenta", MarkerSize=20, ...
    HeightReference="ellipsoid")

%% Table 2 of K.D. thesis
% deg, deg, km
s1 = [54.8289, -105.0326, 385.1;
      55.1481, -98.6261, 306.4];

s2 = [56.0677, -102.3670, 409.7;
      55.9727, -97.9053, 274.2];

geoplot3(g, s1(:,1), s1(:,2), s1(:,3)*1e3, ...
    HeightReference = "ellipsoid")

geoplot3(g, s2(:,1), s2(:,2), s2(:,3)*1e3, ...
    HeightReference = "ellipsoid")

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campos.html
campos(g, cam1(1), cam1(2))

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheight.html
camheight(g, 0)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheading.html
camheading(g, 340)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campitch.html
campitch(g, 13.5)
end
