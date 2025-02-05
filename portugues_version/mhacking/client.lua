----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- https://github.com/Eboraci
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local carrof_hash = GetHashKey('stockade')
local seguranca = GetHashKey("s_m_m_security_01")
local carro_segurancas_hash = GetHashKey('cognoscenti2')

local local_hack_x = 1275.682
local local_hack_y = -1710.426
local local_hack_z = 54.771 

local quantia = 300000
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(1)
      local ped = PlayerPedId()
      local distancia_hack = GetDistanceBetweenCoords(GetEntityCoords(ped), local_hack_x, local_hack_y, local_hack_z)
      if distancia_hack <=1 and not IsEntityDead(ped) then
        drawTxt("PRESSIONE  ~b~E~w~  PARA HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
        if IsControlJustPressed(0, 38) and (UpdateOnscreenKeyboard() ~= 0)then
          RequestAnimDict('anim@heists@prison_heistig1_p1_guard_checks_bus')
          while not HasAnimDictLoaded('anim@heists@prison_heistig1_p1_guard_checks_bus') do
						Wait(10)
          end
          SetEntityHeading(ped,310.46)
          TaskPlayAnim(ped,'anim@heists@prison_heistig1_p1_guard_checks_bus','loop',8.0,8.0,-1,1,0,false,false,false)
          Wait(1500)
          DoScreenFadeOut(1000)
          TriggerEvent('mhacking:show')
          TriggerEvent('mhacking:start',7,20,mycb)
        end
      end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECANDO E CONSTRUINDO
-----------------------------------------------------------------------------------------------------------------------------------------
function mycb(successo, temporestante)
  if successo then
    local ped = PlayerPedId()
    print('Hackeou com '..temporestante..' segundos restantes.')
    TriggerEvent('mhacking:hide')
    DoScreenFadeIn(1000)
    Wait(1350)
    ClearPedTasks(ped)
    setupModelo(carrof_hash)
    setupModelo(carro_segurancas_hash)
    local carrof_spw = CreateVehicle(carrof_hash, -2959.50, 492.623, 14.81, 88.75, true, false)
    local carros_spw = CreateVehicle(carro_segurancas_hash, -2943.69, 492.69, 15.29, 88.75, true, false)
    carrosinfo(carrof_spw)
    carrosinfo(carros_spw)
    setupModelo(seguranca)
    local seguranca_spw = CreatePedInsideVehicle(carrof_spw, 4, seguranca, -1, true, false)
    local seguranca_spw_2 = CreatePedInsideVehicle(carrof_spw, 4, seguranca, 0, true, false)
    local seguranca_spw_3 = CreatePedInsideVehicle(carros_spw, 4, seguranca, -1, true, false)
    local seguranca_spw_4 = CreatePedInsideVehicle(carros_spw, 4, seguranca, 0, true, false)
    SetEntityAsMissionEntity(seguranca_spw, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_2, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_3, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_4, 0, 0) 
    guardasinfo(seguranca_spw)
    guardasinfo(seguranca_spw_2)
    guardasinfo(seguranca_spw_3)
    guardasinfo(seguranca_spw_4)
    local blip_carrof = AddBlipForEntity(carrof_spw)
    SetBlipColour(blip_carrof, 36)
    SetBlipRoute(blip_carrof, true)
    SetBlipRouteColour(blip_carrof, 2)
    TaskVehicleDriveToCoordLongrange(seguranca_spw, carrof_spw, -97.805, -869.55, 26.813, 20.0, 447, 1)
    TaskVehicleDriveToCoordLongrange(seguranca_spw_3, carros_spw, -97.805, -869.55, 26.813, 20.0, 447, 1)
    while true do
      Wait(0)
      if GetVehicleBodyHealth(carrof_spw) < 5.0 then
        break
      end
      dinheiro_tick(carrof_spw,carros_spw)
    end
  else
    print('Falha')
    local ped = PlayerPedId()
    TriggerEvent('mhacking:hide')
    DoScreenFadeIn(1000)
    Wait(1350)
    ClearPedTasks(ped)
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSTRUINDO MODELOS
-----------------------------------------------------------------------------------------------------------------------------------------
function setupModelo(modelo)
  RequestModel(modelo)
  while not HasModelLoaded(modelo) do
    RequestModel(modelo)
    Wait(10)
  end
  SetModelAsNoLongerNeeded(modelo)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAS
-----------------------------------------------------------------------------------------------------------------------------------------
function guardasinfo(inputPed)
  SetPedShootRate(inputPed,  700)
  AddArmourToPed(inputPed, GetPlayerMaxArmour(seguranca_spw)- GetPedArmour(seguranca_spw))
  SetPedAlertness(inputPed, 3)
  SetPedAccuracy(inputPed, 81)
  SetEntityHealth(inputPed,  200)
  SetPedFleeAttributes(inputPed, false, true)
  SetPedCombatAttributes(inputPed, 46, true)
  SetPedCombatAttributes(inputPed, 0, true)
  SetPedCombatAttributes(inputPed, 2, true)
  SetPedCombatAttributes(inputPed, 52, true)
  SetPedCombatAbility(inputPed,  2)
  SetPedCombatRange(inputPed, 2)
  SetPedPathAvoidFire(inputPed,  0)
  SetPedPathCanUseLadders(inputPed,1)
  SetPedPathCanDropFromHeight(inputPed, 1)
  SetPedPathPreferToAvoidWater(inputPed, 1)
  SetPedGeneratesDeadBodyEvents(inputPed, 1)
  GiveWeaponToPed(inputPed, GetHashKey("WEAPON_COMBATPISTOL"), 5000, false, true)
  GiveWeaponToPed(inputPed, GetHashKey("WEAPON_SMG"), 5000, false, true)
  SetPedRelationshipGroupHash(inputPed, GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TERMINANDO DE BUILDAR OS CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function carrosinfo(inputcarro)
  RequestCollisionForModel(inputcarro)
  N_0x06faacd625d80caa(inputcarro)
  SetVehicleDoorsLocked(inputcarro , 7)
  SetEntityAsNoLongerNeeded(inputcarro)
  SetVehicleOnGroundProperly(inputcarro)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO E LIMPANDO O QUE SOBROU
-----------------------------------------------------------------------------------------------------------------------------------------
function dinheiro_tick(variavel, variavel_2)
  for i=0, 6, 1 do
    if GetVehicleDoorAngleRatio(variavel, 2) > .1 or GetVehicleDoorAngleRatio(variavel, 3) > .1 then
      local ped = PlayerPedId()
      GetEntityCoords(variavel, 1)
      local a,b,c = table.unpack((GetEntityCoords(variavel_2)))
      local x,y,z = table.unpack(GetEntityCoords(variavel))
      dinheiro_carrof = CreateAmbientPickup(GetHashKey("PICKUP_MONEY_SECURITY_CASE"), GetOffsetFromEntityInWorldCoords(variavel, 0.0, -5.0, -0.3001), 0, 300000) 
      ClearPedTasks(ped)
      Wait(15000)
      AddExplosion(x, y, z, 8, 100.0, true, false, 10.0)
      AddExplosion(a, b, c, 8, 100.0, true, false, 10.0)
      break
    end
  end
end



