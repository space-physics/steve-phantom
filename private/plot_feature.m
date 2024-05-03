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