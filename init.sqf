enableSaving [ false, false ];

if (isDedicated) then {debug_source = "Server";} else {debug_source = name player;};

[] call compileFinal preprocessFileLineNumbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_sectors.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\fetch_params.sqf";
[] call compileFinal preprocessFileLineNumbers "kp_liberation_config.sqf";
[] call compileFinal preprocessFileLineNumbers "presets\init_presets.sqf";
/*
switch (KP_liberation_preset) do {
	case 0: {[] call compileFinal preprocessFileLineNumbers "presets\custom.sqf";};
	case 1: {[] call compileFinal preprocessFileLineNumbers "presets\apex_tanoa.sqf";};
	case 2: {[] call compileFinal preprocessFileLineNumbers "presets\rhs.sqf";};
	case 3: {[] call compileFinal preprocessFileLineNumbers "presets\rhs_bw.sqf";};
	case 4: {[] call compileFinal preprocessFileLineNumbers "presets\rhs_takistan.sqf";};
	case 5: {[] call compileFinal preprocessFileLineNumbers "presets\3cbBAF.sqf";};
	default {[] call compileFinal preprocessFileLineNumbers "presets\custom.sqf";};
};*/
[] execVM "GREUH\scripts\GREUH_activate.sqf";
//[] execVM "scripts\uke\RestartTimer.sqf";

[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_shared.sqf";

if (isServer) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\server\init_server.sqf";
};

if (!isDedicated && !hasInterface && isMultiplayer) then {
	[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\hc_manager.sqf";
};

if (hasInterface || isServer) then
{
	[] call compileFinal preprocessFileLineNumbers "addons\welcome\welcome.sqf";
};

if (!isDedicated && hasInterface) then {
	waitUntil {alive player};
	if (debug_source != name player) then {debug_source = name player};
	[] call compileFinal preprocessFileLineNumbers "scripts\client\init_client.sqf";
} else {
	setViewDistance 1600;
};

[] call compileFinal preprocessFileLineNumbers "scripts\uke\client\ukeinit.sqf";
//if (KP_liberation_debug) then {private _text = format ["[KP LIBERATION] [DEBUG] init.sqf done for: %1", debug_source];_text remoteExec ["diag_log",2];};

_pic = "Pictures\logo.paa";
	[
		'<img align=''left'' size=''1.5'' shadow=''0'' image='+(str(_pic))+' />',
		safeZoneX+0.00,
		safeZoneY+safeZoneH-0.12,
		99999,
		0,
		0,
		3090
	] spawn bis_fnc_dynamicText;