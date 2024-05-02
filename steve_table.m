function steve_table(dosave)
arguments
  dosave (1,1) logical = false
end

assert(~isMATLABReleaseOlderThan("R2022b"))

cam1 = struct(lat=48.035108, lon=-97.368604, name="Ludvina");
% Ludvina location metadata, believed accurate

cam2 = struct(lat=51.0086, lon=-113.3994, name="Strathmore");
% imprecise--only the nearest town "Strathmore, AB" is known.

f0 = figure(Name="Cameras");
plot_cameras(f0, cam1, cam2)
if dosave, exportgraphics(f0, "cameras.png"), end

[s1, s2] = gen_features();

f1 = uifigure(Name="Camera: Ludvina", HandleVisibility='on');
g1 = geoglobe(f1, NextPlot="add", Basemap="landcover", Terrain = "None");
plot_feature(g1, s1, s2, cam1)
% matlab R2024a (?) bug, old/new desktop: blank PDF/PNG output.
%if dosave, exportapp(f1, "ludvina.png"), end

f2 = uifigure(Name="Camera: Strathmore, AB", HandleVisibility='on');
g2 = geoglobe(f2, NextPlot="add", Basemap="landcover", Terrain = "None");
plot_feature(g2, s1, s2, cam2)
%if dosave, exportapp(f2, "strathmore.png"), end
end


function plot_cameras(f, c1, c2)
arguments
    f (1,1) matlab.ui.Figure
    c1 (1,1) struct
    c2 (1,1) struct
end

g = geoaxes(f);
geobasemap(g, "streets-light")

% https://www.mathworks.com/help/map/ref/geoplot3.html
geoplot(g, [c1.lat, c2.lat], [c1.lon, c2.lon], ...
    LineStyle="None", LineWidth=3, Marker="o", Color="magenta", MarkerSize=10)

minlat = 0.9*(min(c1.lat, c2.lat));
maxlat = 1.1*(max(c1.lat, c2.lat));
minlon = 0.9*(min(c1.lon, c2.lon));
maxlon = 1.1*(max(c1.lon, c2.lon));

geolimits(g, [minlat, maxlat], [maxlon, minlon])

text(c1.lat, c1.lon, c1.name, Color="black")
text(c2.lat, c2.lon, c2.name, Color="black")

title(g, "Cameras")
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


function plot_feature(g, s1, s2, cam)
arguments
    g (1,1) globe.graphics.GeographicGlobe
    s1 (1,1) struct
    s2 (1,1) struct
    cam (1,1) struct
end

% https://www.mathworks.com/help/map/ref/geoglobe.html

geoplot3(g, s1.lat, s1.lon, s1.h*1e3, ...
    HeightReference = "ellipsoid")

geoplot3(g, s2.lat, s2.lon, s2.h*1e3, ...
    HeightReference = "ellipsoid")

compute_look(g, s1, cam)

end


function compute_look(g, s, cam)
arguments
    g (1,1) globe.graphics.GeographicGlobe
    s (1,1) struct
    cam (1,1) struct
end

% compute look
[az, el, ~] = geodetic2aer(s.lat(2), s.lon(2), s.h(2)*1e3, ...
    cam.lat, cam.lon, 0, wgs84Ellipsoid);

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campos.html
campos(g, cam.lat, cam.lon)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheight.html
camheight(g, 0)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.camheading.html
camheading(g, az)

% https://www.mathworks.com/help/map/ref/globe.graphics.geographicglobe.campitch.html
campitch(g, el)

end
