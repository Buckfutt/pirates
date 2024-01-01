addon.author = 'K0D3R'
addon.name = 'pirates'
addon.version = '1.0'
addon.language = 'English'

require('common');
local chat = require('chat');
local zone = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);

ashita.events.register('load', 'load_event', function()
    ZoneChangeFunction(zone)
end);

ashita.events.register('unload', 'unload_event', function()
	ashita.events.unregister('packet_in', 'packet_in_zone_change_check');
end);

ashita.events.register('packet_in', 'packet_in_zone_change_check', function(e)
    if (e.id == 0x00A) then
        local newZone = struct.unpack('H', e.data, 0x30 + 1);
        if (newZone ~= zone) then
            ZoneChangeFunction(zone, newZone);
            zone = newZone;
        end
    end
end);

function ZoneChangeFunction(zone, newZone)
    if newZone == 220 or newZone == 221 then
		print(chat.header('Pirate Detector') .. ': ' .. chat.message('No pirates...'));
    elseif newZone == 227 or newZone == 228 then
		print(chat.header('Pirate Detector') .. ': ' .. chat.success('Pirates~!'));
	elseif newZone == 252 then
		print(chat.header('Pirate Detector') .. ': ' .. chat.error('OMG PIRATES!!!'));
    end
end