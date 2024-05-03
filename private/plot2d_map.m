function plot2d_map(f, s1, s2, c1, c2)
arguments
    f (1,1) matlab.ui.Figure
    s1 (1,1) struct
    s2 (1,1) struct
    c1 (1,1) struct
    c2 (1,1) struct
end

g = geoaxes(f, NextPlot="add");
geobasemap(g, "streets-light")

% https://www.mathworks.com/help/map/ref/geoplot3.html
geoplot(g, [c1.lat, c2.lat], [c1.lon, c2.lon], ...
    LineStyle="None", LineWidth=3, Marker="o", Color="magenta", MarkerSize=10)

geoplot(g, s1.lat, s1.lon, DisplayName="feature1", Color="cyan", LineWidth=3)
geoplot(g, s2.lat, s2.lon, DisplayName="feature2", Color="red", LineWidth=3)

minlat = 0.9*(min(c1.lat, c2.lat));
maxlat = 1.1*(max(c1.lat, c2.lat));
minlon = 0.9*(min(c1.lon, c2.lon));
maxlon = 1.1*(max(c1.lon, c2.lon));

geolimits(g, [minlat, maxlat], [maxlon, minlon])

text(c1.lat, c1.lon, c1.name, Color="black")
text(c2.lat, c2.lon, c2.name, Color="black")

title(g, "Cameras")

legend(g)
end