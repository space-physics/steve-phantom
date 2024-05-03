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