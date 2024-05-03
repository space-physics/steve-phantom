function steve_phantom(only2d, dosave)
arguments
  only2d (1,1) logical = false
  dosave (1,1) logical = false
end

assert(~isMATLABReleaseOlderThan("R2022b"))

% https://www.ngdc.noaa.gov/geomag/calculators/magcalc.shtml#igrfwmm
% 2020-01-01 55N 100W

fjson = "params.json";

[cam1, cam2] = load_cameras(fjson);

[s1, s2] = phantom(fjson);

%% plots
f0 = figure(Name="Cameras");
plot2d_map(f0, s1, s2, cam1, cam2)
if dosave, exportgraphics(f0, "cameras.png"), end

if only2d, return, end

f1 = uifigure(Name="Camera: Ludvina", HandleVisibility='on');
g1 = geoglobe(f1, NextPlot="add", Basemap="landcover", Terrain = "None");
plot_feature(g1, s1, s2, cam1)

f2 = uifigure(Name="Camera: Strathmore, AB", HandleVisibility='on');
g2 = geoglobe(f2, NextPlot="add", Basemap="landcover", Terrain = "None");
plot_feature(g2, s1, s2, cam2)

end