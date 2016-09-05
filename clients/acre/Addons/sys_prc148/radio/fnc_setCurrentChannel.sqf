//fnc_setCurrentChannel.sqf
#include "script_component.hpp"

params ["_radioId", "_event", "_eventData", "_radioData"];

TRACE_1("SETTING CURRENT CHANNEL",_this);
private _groups = HASH_GET(_radioData, "groups");
private _group = _groups select HASH_GET(_radioData, "currentGroup");

if(!(_eventData in (_group select 1))) then {
    {
        _x params ["","_channelNums"];
        private _groupIndex = _forEachIndex;
        if(_eventData in _channelNums) exitWith {
            {
                if(_x == _eventData) then {
                    HASH_SET(_radioData, "currentGroup", _groupIndex);
                    HASH_SET(_radioData, "channelKnobPosition", _forEachIndex);
                };
            } forEach _channelNums;
        };
    } forEach _groups;
};

private _channelsCount = count ([_radioId, "getState", "channels"] call EFUNC(sys_data,dataEvent)) - 1;
_eventData = (0 max _eventData) min _channelsCount;

HASH_SET(_radioData,"currentChannel",_eventData);
