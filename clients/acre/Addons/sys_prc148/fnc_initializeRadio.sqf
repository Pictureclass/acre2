//fnc_initializeRadio.sqf
#include "script_component.hpp"

params ["_radioId", "_event", "_eventData", "_radioData"];

HASH_SET(_radioData, "currentState", "DefaultDisplay");
HASH_SET(_radioData, "menuPage", 0);
HASH_SET(_radioData, "menuIndex", 0);
HASH_SET(_radioData, "entryCursor", 0);
HASH_SET(_radioData, "selectedEntry", -1);
HASH_SET(_radioData, "editEntry", false);
HASH_SET(_radioData, "currentEditEntry", "");
HASH_SET(_radioData, "volume", 1);
HASH_SET(_radioData, "radioOn", 1);
HASH_SET(_radioData, "audioPath", "TOPAUDIO");

_eventData params ["_baseName", "_preset"];
private _presetData = [_baseName, _preset] call EFUNC(sys_data,getPresetData);

private _channels = HASH_GET(_presetData,"channels");

private _currentChannels = HASH_GET(_radioData,"channels");

SCRATCH_SET(_radioId, "currentTransmissions", []);

if(isNil "_currentChannels") then {
    _currentChannels = HASH_COPY(_channels);
    HASH_SET(_radioData,"channels",_currentChannels);
};

HASH_SET(_radioData, "channelKnobPosition", 0);
HASH_SET(_radioData, "currentGroup", 0);

private _groups = HASH_GET(_presetData,"groups");
HASH_SET(_radioData, "groups", +_groups);

