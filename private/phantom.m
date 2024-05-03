function [s1, s2] = phantom(pfile)
arguments
  pfile (1,1) string {mustBeFile}
end

d = jsondecode(fileread(pfile));

% midpoint to programatically look

%% feature 1

s1.h = [d.lower_alt_km + d.height_km, nan, d.lower_alt_km];
s1.h(2) = s1.h(3) + (s1.h(1) - s1.h(3)) / 2;

sr1 = [0, s1.h(2) - s1.h(3), s1.h(1) - s1.h(3)];

[s1.lat, s1.lon] = aer2geodetic(d.Bdecl + 180, d.Bincl, sr1, ...
    d.feat1lat, d.feat1lon, s1.h(3), wgs84Ellipsoid);

%% feature 2

s2.h = [d.lower_alt_km + d.height_km, nan, d.lower_alt_km];
s2.h(2) = s2.h(3) + (s2.h(1) - s2.h(3)) / 2;

sr2 = [0, s2.h(2) - s2.h(3), s2.h(1) - s2.h(3)];

[s2.lat, s2.lon] = aer2geodetic(d.Bdecl + 180, d.Bincl, sr2, ...
    d.feat2lat, d.feat2lon, s2.h(3), wgs84Ellipsoid);

end