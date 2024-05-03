function [cam1, cam2] = load_cameras(file)
arguments
    file (1,1) string {mustBeFile}
end

d = jsondecode(fileread(file));

cam1 = struct(lat=d.ludvina(1), lon=d.ludvina(2), name="Ludvina");
% Ludvina location metadata, believed accurate

cam2 = struct(lat=d.strathmore(1), lon=d.strathmore(2), name="Strathmore");
% imprecise--only the nearest town "Strathmore, AB" is known.

end