//add in custom light object to make spawned item more obvious
params ["_object"];

_light = "#lightpoint" createVehicleLocal getPos _object;
_light setLightBrightness 0.2;
_light setLightAmbient [0.0, 1.0, 0.0];
_light setLightColor [0.0, 1.0, 0.0];
_light lightAttachObject [_object, [0,0,0]];