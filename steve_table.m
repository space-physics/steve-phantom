function steve_table()

assert(~isMATLABReleaseOlderThan("R2022b"))

cam1 = [48.035108, -97.368604];
% Ludvina location metadata, believed accurate

cam2 = [51.0086, -113.3994];
% imprecise--only the nearest town "Strathmore, AB" is known.

plot_cameras(uifigure(Name="Cameras"), cam1, cam2)

[s1, s2] = gen_features();

plot_feature(uifigure(Name="Camera: Ludvina"), s1, s2, cam1)

plot_feature(uifigure(Name="Camera: Strathmore, AB"), s1, s2, cam2)
end


function plot_cameras(fig, cam1, cam2)
arguments
    fig (1,1)
    cam1 (1,2)
    cam2 (1,2)
end

g = geoglobe(fig, NextPlot="add", Basemap="landcover", Terrain = "None");
% https://www.mathworks.com/help/map/ref/geoplot3.html
geoplot3(g, [cam1(1), cam2(1)], [cam1(2), cam2(2)], 0, ...
    LineStyle="None", LineWidth=3, Marker="o", Color="magenta", MarkerSize=20, ...
    HeightReference="ellipsoid")

end


function [s1, s2] = gen_features()
%% Table 2 of K.D. thesis
% compute a midpoint to programatically look

s1.h = [385.1, nan, 306.4]; % km;
s1.h(2) = s1.h(3) + (s1.h(1) - s1.h(3)) / 2;

[s1.lat, s1.lon] = track2("gc", 54.8289, -105.0326, 55.1481, -98.6261, ...
    wgs84Ellipsoid, "degrees", 3);

s2.h = [409.7, nan, 274.2];
s2.h(2) = s2.h(3) + (s2.h(1) - s2.h(3)) / 2;

[s2.lat, s2.lon] = track2("gc", 56.0677, -102.3670, 55.9727, -97.9053, ...
    wgs84Ellipsoid, "degrees", 3);

end


function plot_feature(fig, s1, s2, cam1)
arguments
    fig (1,1)
    s1 (1,1) struct
    s2 (1,1) struct
    cam1 (1,2)
end

% https://www.mathworks.com/help/map/ref/geoglobe.html
g = geoglobe(fig, NextPlot="add", Basemap="landcover", Terrain = "None");

geoplot3(g, s1.lat, s1.lon, s1.h*1e3, ...
    HeightReference = "ellipsoid")

geoplot3(g, s2.lat, s2.lon, s2.h*1e3, ...
    HeightReference = "ellipsoid")

compute_look(g, s1, cam1)

end


function compute_look(g, s, cam)
arguments
    g (1,1)
    s (1,1) struct
    cam (1,2)
end

% compute look
[az, el, ~] = geodetic2aer(s.lat(2), s.lon(2), s.h(2)*1e3, cam(1), cam(2), 0, wgs84Ellipsoid);

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campos.html
campos(g, cam(1), cam(2))

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheight.html
camheight(g, 0)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheading.html
camheading(g, az)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campitch.html
campitch(g, el)

end
