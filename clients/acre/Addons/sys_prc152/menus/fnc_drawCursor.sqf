//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE_1("drawCursor", _this);
// Swap the background and foreground colors for a text range
private ["_id", "_start", "_i", "_textCtrl", "_display", "_len", "_saveLength"];
_display = uiNamespace getVariable QUOTE(GVAR(currentDisplay));

params["_row", "_range", ["_highlight", true], ["_alignment", ALIGN_LEFT]];

_id = (_row * 1000) +1;

_start = (_range select 0);
if(_alignment != ALIGN_LEFT) then {
    // Its a center or right align, so we need to find the furst character
    // in the row, and align on that.
    TRACE_1("Highlighting non-left alignment","");
    _rowCount = 0;
    if(_row > 20) then {
        if(_row > 30) then {
            if(_row > 40) then {
                _rowCount = COLUMNS_XXLARGE;
            } else {
                _rowCount = COLUMNS_XLARGE;
            };
        } else {
            _rowCount = COLUMNS_LARGE;
        };
    } else {
        _rowCount = COLUMNS_SMALL;
    };
    
    _start = 0;
    for "_i" from _start to _rowCount do {
        _textCtrl = _display displayCtrl (_id+_i);
        _text = ctrlText _textCtrl;
        if(_text != "") exitWith {
            _start = _i + (_range select 0);
        };
    };
    for "_i" from _start to _rowCount do {
        _textCtrl = _display displayCtrl (_id+_i);
        _text = ctrlText _textCtrl;
        if(_text != "") then {
            _saveLength = _i;
        };
    };
    TRACE_2("Determined start and save", _start, _saveLength);
} else {
    //TODO _rowCount is undefined
    _saveLength = _rowCount;
};

_len = (_range select 1);
if(_len < 1) then {
    // Find the length of the string, and highlight it
    _len = _saveLength - _start;
} else {
    TRACE_2("Highlighting", _start, _len);
    if(_alignment != ALIGN_LEFT) then {
        _len = _len - 1;
    };
};
for "_i" from _start to (_start+_len) do {
    _textCtrl = _display displayCtrl (_id+_i);
    if(_highlight) then {
        
        _textCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2, 1];
        _textCtrl ctrlSetTextColor [115/255, 126/255, 42/255, 1];
    } else {
        _textCtrl ctrlSetBackgroundColor [0.2, 0.2, 0.2 ,0];
        _textCtrl ctrlSetTextColor [0.2, 0.2, 0.2, 1]
    };
    _textCtrl ctrlCommit 0;
};