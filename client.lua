-- Zmienne

local maxHealth = 100 -- maksymalne zdrowie gracza

-- Funkcje

function spawnPlayer()
    local playerPed = GetPlayerPed(-1)
    local spawnCoords = vector3(-267.5, 7031.5, 7.5) -- stałe współrzędne spawnu black medica

    -- tworzenie spawnu dla gracza
    RequestModel("s_m_m_doctor_01")
    while not HasModelLoaded("s_m_m_doctor_01") do
        Citizen.Wait(100)
    end
    local spawnPed = CreatePed(26, "s_m_m_doctor_01", spawnCoords.x, spawnCoords.y, spawnCoords.z, 0, true, false)
    SetEntityAsMissionEntity(spawnPed, true, true)
    SetBlockingOfNonTemporaryEvents(spawnPed, true)
    TaskStartScenarioInPlace(spawnPed, "WORLD_HUMAN_SMOKING", 0, true)

    -- dodawanie zdrowia do gracza
    SetEntityHealth(playerPed, maxHealth)
    ShowNotification("Black Medyk udzielił Ci pomocy.")
end

-- Eventy

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 38) then -- Przytrzymanie E
            spawnPlayer()
        end
    end
end)

-- Funkcje pomocnicze

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
