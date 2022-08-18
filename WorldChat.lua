
-- ES MUY FÁCIL HACER SPAM CON ESTE SCRIPT, ASÍ QUE ASEGÚRATE DE PONER LAS REGLAS DE USO BIEN CLARAS --

local b = '|CFF2DEDCA' --> Color del texto y los marcos.

local function Chat (E,P,M)
	if M:find("#")==1 then  local A = P:IsAlliance() 
		local function C()   local c=P:GetClassMask()
			if c==1 then return "C69B6D" elseif c==2 then return "F48CBA"
			elseif c==4 then return "AAD372" elseif c==8 then return "FFF468"
			elseif c==16 then return "FFFFFF" elseif c==32 then return "C41E3A"
			elseif c==64 then return "0070DD" elseif c==128 then return "3FC7EB"
			elseif c==256 then return "8788EE" elseif c==1024 then return "FF7C0A"
			end
		end

		local forma = "%s"..b.."[|r|Hplayer:%s|h|CFF"..C().."%s|r"..b.."]: %s"		

		if A==true then 
			i="|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:16:16:0:0:64:64:0:32:0:38|t"
		else
			i="|TInterface\\TargetingFrame\\UI-PVP-HORDE:16:16:0:0:64:64:0:38:0:36|t"
		end

		M = M:gsub("#","",1)
		M = forma:format(i, P:GetName(), P:GetName(), M)
		SendWorldMessage(M)
		return false
	end	
end 

local function Log(E,P) 
	local function Timed(ev,de,re,w) 
		w:SendBroadcastMessage('|cff98b9d9Para usar el WorldChat escribe "#" antes de tu mensaje.')
	end
	P:RegisterEvent(Timed,2000,1)
end
RegisterPlayerEvent(18,Chat)   RegisterPlayerEvent(3,Log)