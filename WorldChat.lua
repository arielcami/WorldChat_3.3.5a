
local TIME = 6 	--> Coloca los SEGUNDOS de espera para usar el WorldChat nuevamente.

local b = '|CFF2DEDCA' --> Color del texto y los marcos.

local function Chat (E,P,M)

	if M:find("#")==1 then

		local Q = CharDBQuery("SELECT `off_on` FROM `aa_worldchat` WHERE `PlayerGUID` = "..P:GetGUIDLow().."")

		if Q:GetInt8(0) == 0 then 

			local function C()   local c=P:GetClassMask()
				if c==1 then return "C69B6D" elseif c==2 then return "F48CBA"
				elseif c==4 then return "AAD372" elseif c==8 then return "FFF468"
				elseif c==16 then return "FFFFFF" elseif c==32 then return "C41E3A"
				elseif c==64 then return "0070DD" elseif c==128 then return "3FC7EB"
				elseif c==256 then return "8788EE" elseif c==1024 then return "FF7C0A"
				end
			end

			local forma = "%s"..b.."[|r|Hplayer:%s|h|CFF"..C().."%s|r"..b.."]: %s"

			local A = P:IsAlliance()	

			if A==true then 
				i="|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:16:16:0:0:64:64:0:32:0:38|t"
			else
				i="|TInterface\\TargetingFrame\\UI-PVP-HORDE:16:16:0:0:64:64:0:38:0:36|t"
			end

			M = M:gsub("#","",1)
			M = forma:format(i, P:GetName(), P:GetName(), M)
			SendWorldMessage(M)

			CharDBExecute("UPDATE `aa_worldchat` SET `off_on` = 1 WHERE `PlayerGUID` = "..P:GetGUIDLow().."")

				local function count(ev, del, rep, PLAYER) 
					CharDBExecute("UPDATE `aa_worldchat` SET `off_on` = 0 WHERE `PlayerGUID` = "..PLAYER:GetGUIDLow().."")
				end
				local seg = (TIME*1000)
				P:RegisterEvent(count, seg, 1)

			return false
		else
			P:SendBroadcastMessage('|cff98b9d9Debes esperar unos segundos para usar el WorldChat otra vez.') return false
		end

	else
		return
	end
end 

local function LogIn(E,P)

	CharDBExecute("INSERT IGNORE INTO `aa_worldchat` (`PlayerGUID`,`off_on`) VALUES ("..P:GetGUIDLow()..", 0)")

	local function Timed(ev,de,re,w) 
		w:SendBroadcastMessage('|cff98b9d9Para usar el WorldChat escribe # antes de tu mensaje.')
	end
	P:RegisterEvent(Timed,2000,1)
end 

local function LogOut(E,P) CharDBExecute("DELETE FROM `aa_worldchat` WHERE `PlayerGUID` = "..P:GetGUIDLow().."") end

local function ElunaReload(E) CharDBExecute("CREATE TABLE IF NOT EXISTS `aa_worldchat` (`PlayerGUID` INT(20) NOT NULL UNIQUE, `off_on` INT(1) NOT NULL)") end

RegisterPlayerEvent(18, Chat)
RegisterPlayerEvent(3, LogIn)  
RegisterPlayerEvent(4, LogOut)   
RegisterServerEvent(33, ElunaReload)
