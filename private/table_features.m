function [s1, s2] = table_features()
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