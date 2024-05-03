function steve_table(only2d, dosave)
arguments
  only2d (1,1) logical = false
  dosave (1,1) logical = false
end

assert(~isMATLABReleaseOlderThan("R2022b"))

[cam1, cam2] = load_cameras("params.json");

[s1, s2] = table_features();

%% plots
f0 = figure(Name="Cameras");
plot2d_map(f0, s1, s2, cam1, cam2)
if dosave, exportgraphics(f0, "cameras.png"), end

if only2d, return, end

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
