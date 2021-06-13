print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^0 ^0Adico^7")
print("^0[^3Version^0] ^7:^0 ^1.0^7")
print("^0[^2Download^0] ^7:^0 ^https://github.com/Adiicoo/ZoneSafe_Adico^7")
print("^0======================================================================^7")


local zones = {

	['30'] = { ['x'] = 228.17, ['y'] = -783.78, ['z'] = 30.70}, -- PC

	['45'] = { ['x'] = -480.93, ['y'] = -691.26, ['z'] = 19.980}, -- Spawn metro

	['46'] = { ['x'] = 447.452, ['y'] = -992.327, ['z'] = 24.420}, -- Comico

	['50'] = { ['x'] = 357.77, ['y'] = -591.15, ['z'] = 28.78}, -- Devant hopital

	['40'] = { ['x'] = -41.151, ['y'] = -1099.496, ['z'] = 25.347}, -- Auto Ecole et interieur hopital

	['80'] = { ['x'] = 1643.759, ['y'] = 2530.987, ['z'] = 44.564}, -- Prison federal£

	['30'] = { ['x'] = -796.32, ['y'] = -223.28, ['z'] = 37.07}, -- Concess


}

ESX = nil

local notifIn = false

local notifOut = false

local veh = false

local closestZone = 1

local distance = 0

local safe = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()

	while true do

		local playerPed = GetPlayerPed(-1)

		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))

		local minDistance = 100000

		for k,v in pairs(zones) do

			dist = Vdist(zones[k].x, zones[k].y, zones[k].z, x, y, z)

			if dist < minDistance then

				minDistance = dist

				closestZone = k

				distance = tonumber(k)

			end

		end

		local vehs = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)

		if (GetPedInVehicleSeat(vehs, -1) == GetPlayerPed(PlayerId())) and veh == false then	

		SetEntityInvincible(vehs, false)

		elseif (GetPedInVehicleSeat(vehs, -1) == GetPlayerPed(PlayerId())) and veh == true then

		SetEntityInvincible(vehs, true)

		end

		Citizen.Wait(10000)

	end

end)



Citizen.CreateThread(function()

	while true do

		Citizen.Wait(5)

		local player = GetPlayerPed(-1)

		local x,y,z = table.unpack(GetEntityCoords(player, true))

		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

	

		if dist <= distance then

			if not notifIn then	

				veh = true				

				local vehs = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)

				if (GetPedInVehicleSeat(vehs, -1) == GetPlayerPed(PlayerId())) then	

				SetEntityInvincible(vehs, true)

				end

				safe = true

				SetEntityInvincible(player, true)												  

				NetworkSetFriendlyFireOption(false)

				SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)

				ESX.ShowAdvancedNotification("Vous êtes dans un lieu sécurisé.", "", "", "CHAR_CHENG", 0)
				ESX.ShowAdvancedNotification("Vous ne pouvez pas sortir vos armes", "", "", "CHAR_CHENG", 0)

				notifIn = true

				notifOut = false

			end

		else

			if not notifOut then

				veh = false

				local vehs = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)

				if (GetPedInVehicleSeat(vehs, -1) == GetPlayerPed(PlayerId())) then	

				SetEntityInvincible(vehs, false)

				end

				safe = false

				SetEntityInvincible(player, false)

				NetworkSetFriendlyFireOption(true)

				ESX.ShowAdvancedNotification("Vous n\'êtes plus dans un lieu sécurisé.", "", "", "CHAR_CHENG", 0)
				ESX.ShowAdvancedNotification("Vous pouvez reprendre vos armes", "", "", "CHAR_CHENG", 0)

				notifOut = true

				notifIn = false

			end

		end

		if notifIn then

		DisableControlAction(2, 37, true)

		DisablePlayerFiring(player, true)

		DisableControlAction(0, 106, true)

		DisableControlAction(0, 140, true)

			if IsDisabledControlJustPressed(2, 37) then

				SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)

			end

			if IsDisabledControlJustPressed(0, 106) then

				SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)

			end

		end

	end

end)



AddEventHandler('safe:Check', function(cb)

cb(safe)

end)








print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^0 ^0Adico^7")
print("^0[^3Version^0] ^7:^0 ^1.0^7")
print("^0[^2Download^0] ^7:^0 ^5vene En DM Discord คძɿ८૦#8716^7")
print("^0======================================================================^7")



print("©by Adico Adico")
