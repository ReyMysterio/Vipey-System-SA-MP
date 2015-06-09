#include <a_samp> 
#include <sscanf2>
#include <ZCMD> 
#include <DOF2> 
#include <CTime>

//===== [ COLORS ] =====// 
#define VERMELHO						0xFF0000FF 
#define AZUL_BEST						0x1E90FFFF 
#define VERDE							0x00FF00FF 
#define COLOR_MAGENTA					0xFF00FFFF 

//===== [ MACROS ] =====// 
#define SendClientFormat(%0,%1,%2,%3); \ 
	format(Str, sizeof(Str), %2, %3); SendClientMessage(%0, %1, Str); 

#define SendClientFormatToAll(%0,%1,%2); \ 
	format(Str, sizeof(Str), %1, %2); SendClientMessageToAll(%0, Str); 

#define @_CallBack:%0(%1) \ 
	forward%0(%1); public%0(%1) 

//===== [ DIALOGS ] =====// 
#define DIALOG_COR_VIP				5001 

//===== [ NEWS ] =====// 
new Str[128]; 
//==================== 


public OnFilterScriptInit() 
{ 
	print("\n----------------------------------------------");
	print(" VIPEY CARREGADO COM SUCESSO! BY:REYMYSTERIO");
	print("------------------------------------------------\n");
	SetTimer("AtualizarChatBubble", 1000, true); 
	return 1; 
} 

public OnFilterScriptExit() 
{ 
	DOF2_Exit(); 
	return 1; 
} 

public OnPlayerDisconnect(playerid, reason) 
{ 
	return 1; 
} 

public OnPlayerSpawn(playerid) 
{ 
	if( GetPVarInt(playerid, "Spawnou") != 1 ) { 

		if( IsPlayerVIP(playerid )) { 

			format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 

			if( gettime() > DOF2_GetInt(Str, "Vencimento") ) { 

				RemoverV(playerid); 
				SendClientMessage(playerid, VERMELHO, "Seu VIP expirou e já não tem mais acesso aos comandos exclusivo VIP!"); 
				return 1; 
			} 
			else { 

				SendClientMessage(playerid, AZUL_BEST, "Você é um jogador VIP! Para ver o vencimento digite /Vencimento!"); 
				SetPVarInt(playerid, "Spawnou", 1); 
				return 1; 
			} 
		} 
	} 
	return 1; 
} 

public OnPlayerText(playerid, text[]) 
{ 
	if(IsPlayerVIP(playerid)) { 

		format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 

		new cor = DOF2_GetInt(Str, "CorVIP"); 

		if( cor == 1) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FF00FF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if( cor == 2) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FFFF00}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if ( cor == 3) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FFA500}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if( cor == 4) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{00FF00}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if( cor == 5) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{00FFFF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if( cor == 6) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{0000FF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if(cor == 7) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{B5B5B5}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
		else if( cor == 8) { 

			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FF0000}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text); 
			SendClientMessageToAll(GetPlayerColor(playerid), Str); 
		} 
	} 
    return 1; 
} 

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	if(dialogid == DIALOG_COR_VIP) { 

		if ( response ) { 

			format(Str, sizeof(Str), "VIPs/%s.ini", PlayerName(playerid)); 
			DOF2_SetInt(Str, "CorVIP", (listitem + 1) ); 
			DOF2_SaveFile(); 
			SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!"); 
		} 
	} 
	return 1; 
} 

CMD:setarvip(playerid, params[]) 
{ 
	new ID, dias; 

	if(!IsPlayerAdmin(playerid)) 
		return SendClientMessage(playerid, VERMELHO, "Comando inválido!"); 

	if(sscanf(params, "ud", ID, dias)) 
		return SendClientMessage(playerid, VERMELHO, "Digite: /SetarVIP (id-do-jogador) (Dias)"); 

	if( IsPlayerConnected(ID) ) { 

		if(dias > 30) 
			return SendClientMessage(playerid, VERMELHO, "Você não pode dar mais que 30 dias de VIP! Tente de novo!"); 

		SetarV(ID, dias); 
		SendClientFormat(playerid, AZUL_BEST, "Você deu %d de VIP para o(a) jogador(a) %s[%d]", dias, PlayerName(ID), ID); 
		SendClientFormat(ID, AZUL_BEST, "O(A) Staff %s setou %d dias de VIP para você!", PlayerName(playerid), dias); 
		return 1; 
	} 
	else { 

		SendClientMessage(playerid, VERMELHO, "Jogador não conectado!"); 
		return 1; 
	} 
} 

CMD:agendarvip(playerid, params[]) 
{ 
	new nick[24], dias; 

	if ( sscanf(params, "s[24]d", nick, dias) ) 
		return SendClientMessage(playerid, -1, "Use /agendarvip [nick] [dias]"); 

	format(Str, sizeof(Str), "/VIPs/%s.ini", nick ); 

	if ( !fexist(Str) ) 
		DOF2_CreateFile(Str); 

	DOF2_SetInt(Str, "Vencimento", (gettime() + (dias * 86400) ) ); 
	DOF2_SaveFile(); 

	format(Str, sizeof(Str), "Você deu %d dias de VIP para %s!", dias, nick ); 
	SendClientMessage(playerid, -1, Str); 

	return 1; 
} 

CMD:removervip(playerid, params[]) 
{ 
	new ID; 

	if(!IsPlayerAdmin(playerid)) 
		return SendClientMessage(playerid, VERMELHO, "Comando inválido!"); 

	if(sscanf(params, "u", ID)) 
		return SendClientMessage(playerid, VERMELHO, "Digite: Use: /RemoverVip (id-do-jogador)"); 

	if( IsPlayerConnected(ID) ) 
	{ 
		if(IsPlayerVIP(ID)) 
		{ 
			RemoverV(ID); 
			SendClientFormat(playerid, AZUL_BEST, "Você removeu o VIP do(a) jogador(a) %s[%d]!", PlayerName(ID), ID); 
			SendClientFormat(ID, AZUL_BEST, "O(A) Staff %s removeu o seu VIP!", PlayerName(playerid)); 
			return 1; 
		} 
		else SendClientMessage(playerid, VERMELHO, "Esse jogador não é VIP!"); 
		return 1;
	} 
	else SendClientMessage(playerid, VERMELHO, "Jogador não conectado!");
	return 1; 
} 

CMD:vencimento(playerid)
{ 
	if ( IsPlayerVIP(playerid) ) 
	{ 
		new StringCat[256]; 

		format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 

		new tm <tmStamp>;
		localtime(Time: DOF2_GetInt(Str, "Vencimento"), tmStamp);
			
		new  szStr[64];
		strftime(szStr, sizeof(szStr), "%d/%m/%Y às %X", tmStamp); 

		format(Str, sizeof(Str), "{00FFFF}Nick: {FFFFFF}%s[{00FFFF}%d{FFFFFF}]\n\n", PlayerName(playerid), playerid); 
		strcat(StringCat, Str); 
		format(Str, sizeof(Str), "{00FFFF}Vencimento: {FFFFFF}%s \n\n", szStr); 
		strcat(StringCat, Str); 
		strcat(StringCat, "Aproveite o seu VIP até o último minuto!\n{00FF00}Creditos: {FFFFFF}ReyMysterio\n"); 

		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{FF0000}Vencimento", StringCat, "Fechar", #); 
		return 1; 
    } 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!");
	return 1;
} 

CMD:vips(playerid) 
{ 
	new ContarVIPs = 0; 
	new StringCat[1000]; 

	for(new i = 0; i < MAX_PLAYERS; i++) 
	{ 
		if(IsPlayerConnected(i)) 
		{ 
			if(IsPlayerVIP(playerid)) 
			{ 
				format(Str, sizeof(Str), "{00FFFF}%s {FFFFFF}[{00FFFF}%i{FFFFFF}]\n", PlayerName(i), i); 
				strcat(StringCat, Str); 
				ContarVIPs++; 
			} 
		} 
	} 

	if(ContarVIPs == 0) 
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{FFFFFF}VIPs Online [{FF0000} 0{FFFFFF}]", "{FF0000}Nenhum VIP online!", "Fechar", #); 
	else if(ContarVIPs == 1) 
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{FFFFFF}VIP Online [{00BFFF} 1 {FFFFFF}]", StringCat, "Fechar", #); 
	else { 
		format(Str, sizeof(Str), "{FFFFFF}VIPs Online [{00BFFF} %d {FFFFFF}]", ContarVIPs); 
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, Str, StringCat, "Fechar", #); 
	} 
	return 1; 
} 

CMD:coletev(playerid) 
{ 
	if(IsPlayerVIP(playerid)) { 

		SendClientMessage(playerid, VERDE, "Colete criado com sucesso!"); 
		SetPlayerArmour(playerid, 100.0); 
		return 1; 
	} 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!");
	return 1;
} 

CMD:jetpackv(playerid) 
{ 
	if(IsPlayerVIP(playerid)) { 

		if(IsPlayerInAnyVehicle(playerid)) 
			return SendClientMessage(playerid, VERMELHO, "Você não pode utilizar esse comando em um veículo!"); 

		SendClientMessage(playerid, VERDE, "Jetpack criado com sucesso!"); 
		SetPlayerSpecialAction(playerid, 2); 
		return 1; 
	} 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!"); 
	return 1;
} 

CMD:v(playerid, params[]) 
{ 
	new texto[128], StringText[128]; 
	if(IsPlayerVIP(playerid)) 
	{ 
		if(sscanf(params, "s", texto)) return SendClientMessage(playerid, VERMELHO, "Use: /V (Texto)"); 
		if(strval(texto) > 100) return SendClientMessage(playerid, VERMELHO, "Texto muito grande, diminua por favor!"); 
		format(StringText, sizeof(StringText), "## Chat-VIP ## %s[%i]: %s", PlayerName(playerid), playerid, texto); 
		ChatVIP(COLOR_MAGENTA, StringText, playerid); 
		return 1; 
	} 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!"); 
	return 1; 
} 

CMD:comandosvip(playerid) 
{ 
	if(IsPlayerVIP(playerid)) 
	{ 
		new StringCat[256]; 
		strcat(StringCat, "{00FFFF}/Vencimento {FFFFFF}- Use para ver o vencimento do seu VIP\n\n"); 
		strcat(StringCat, "{00FFFF}/ColeteV {FFFFFF}- Use para colocar colete\n\n"); 
		strcat(StringCat, "{00FFFF}/JetpackV {FFFFFF}- Use para criar um jetpack\n\n"); 
		strcat(StringCat, "{00FFFF}/V {FFFFFF}- Use para falar no chat vip"); 
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{00FFFF}Comandos VIP", StringCat, "Fechar", #); 
		return 1; 
	} 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!"); 
	return 1; 
} 

CMD:corvip(playerid, params[]) 
{ 
	new StringCat[500]; 
	if(IsPlayerVIP(playerid)) 
	{ 
		strcat(StringCat, "{FF00FF}VIP\n"); 
		strcat(StringCat, "{FFFF00}VIP\n"); 
		strcat(StringCat, "{FFA500}VIP\n"); 
		strcat(StringCat, "{00FF00}VIP\n"); 
		strcat(StringCat, "{00FFFF}VIP\n"); 
		strcat(StringCat, "{0000FF}VIP\n"); 
		strcat(StringCat, "{B5B5B5}VIP\n"); 
		strcat(StringCat, "{FF0000}VIP"); 
		ShowPlayerDialog(playerid, DIALOG_COR_VIP, DIALOG_STYLE_LIST, "{00FF00}Cor VIP", StringCat, "Continuar", "Fechar"); 
		return 1; 
	} 
	else SendClientMessage(playerid, VERMELHO, "Você não tem permissão!"); 
	return 1; 
} 

@_CallBack: AtualizarChatBubble() 
{ 
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{ 
		if(IsPlayerVIP(i)) 
		{ 
			format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(i) ); 

			if ( gettime() > DOF2_GetInt(Str, "Vencimento") ) { 

				SendClientMessage(i, -1, "Seu VIP acaba de expirar!"); 
				RemoverV(i); 
				continue; 
			} 

			new cor = DOF2_GetInt(Str, "CorVIP"); 

			if( cor == 1) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0xFF00FFFF, 50.0, 10000); 
			} 
			else if(cor == 2) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0xFFFF00FF, 50.0, 10000); 
			} 
			else if(cor == 3) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0xFFA500FF, 50.0, 10000); 
			} 
			else if(cor == 4) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0x00FF00FF, 50.0, 10000); 
			} 
			else if(cor == 5) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0x00FFFFFF, 50.0, 10000); 
			} 
			else if(cor == 6) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0x0000FFFF, 50.0, 10000); 
			} 
			else if(cor == 7) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0xB5B5B5FF, 50.0, 10000); 
			} 
			else if(cor == 8) 
			{ 
				SetPlayerChatBubble(i, "VIP", 0xFF0000FF, 50.0, 10000); 
			} 
		} 
	} 
} 

@_CallBack: ChatVIP(COLOR, TextoVIP[], playerid) 
{ 
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{ 
		if(IsPlayerConnected(i)) 
		{ 
			if(IsPlayerVIP(i)) 
			{ 
				SendClientMessage(i, COLOR, TextoVIP); 
			} 
		} 
	} 
	return 1; 
} 

stock SetarV(playerid, dias) 
{ 
	format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 

	if( !IsPlayerVIP(playerid) ) { 

		DOF2_CreateFile(Str); 
		DOF2_SetInt(Str, "Vencimento", ( gettime() + (dias * 86400) ) ); 
		DOF2_SetInt(Str, "CorVIP", 1); 
		DOF2_SaveFile(); 
	} 
	else { 

		DOF2_SetInt(Str, "Vencimento", ( DOF2_GetInt(Str, "Vencimento") + (dias * 86400) ) ); 
		DOF2_SaveFile(); 
	} 
	return 1; 
} 

stock RemoverV(playerid) 
{ 
	format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 
	DOF2_RemoveFile(Str); 
	DOF2_SaveFile(); 
	return 1; 
} 

stock IsPlayerVIP(playerid) 
{ 
	format(Str, sizeof(Str), "/VIPs/%s.ini", PlayerName(playerid) ); 

	if(DOF2_FileExists(Str)) 
		return 1; 

	return 0; 
} 

stock PlayerName(playerid) 
{ 
	new Nome[MAX_PLAYER_NAME]; 
	GetPlayerName(playerid, Nome, 24); 
	return Nome; 
}