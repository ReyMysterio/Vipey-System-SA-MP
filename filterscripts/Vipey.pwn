///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// Vipey System 1.0 - Sistema de VIP By: ReyMysterio ///////////////////////////////////////
////////////////////////////              NÃO RETIRE OS CRÉDITOS!              ////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <a_samp>
#include <ZCMD>
#include <DOF2>
#include <sscanf2>
#include <timestamptodate>

//Defina aqui o diretório das contas do seu servidor
#define PASTA_CONTAS	"Diretorio/Contas"

//===== [ COLORS ] =====//
#define VERMELHO					0xFF0000FF
#define AZUL_BEST					0x1E90FFFF
#define VERDE						0x00FF00FF
#define COLOR_MAGENTA				0xFF00FFFF

//===== [ MACROS ] =====//
#define SendClientFormat(%0,%1,%2,%3); \
	format(Str, sizeof(Str), %2, %3); SendClientMessage(%0, %1, Str);

#define SendClientFormatToAll(%0,%1,%2); \
	format(Str, sizeof(Str), %1, %2); SendClientMessageToAll(%0, Str);

#define @_CallBack:%0(%1) \
	forward%0(%1); public%0(%1)

//===== [ DEFINES ] =====//
#define GMT_CONFIG					-3 //Coloque aqui o GMT que quer (GMT Atual "Brasilia")

//===== [ DIALOGS ] =====//
#define DIALOG_COR_VIP				5001

//===== [ NEWS ] =====//
new Str[128];
new Spawnou[MAX_PLAYERS] = 0;

new
	venvip,
	String[128]
;
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

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Spawnou[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(Spawnou[playerid] == 0)
	{
		if(IsPlayerVIP(playerid))
		{
			if(gettime() >= DadosV(playerid, 1))
			{
				RemoverV(playerid);
				SendClientMessage(playerid, VERMELHO, "Seu VIP expirou e já não tem mais acesso aos comandos exclusivo VIP!");
				return 1;
			}
			else
			{
				SendClientMessage(playerid, AZUL_BEST, "Você é um jogador VIP! Para ver o vencimento digite /Vencimento!");
				Spawnou[playerid] = 1;
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(IsPlayerVIP(playerid))
	{
		if(DadosV(playerid, 4) == 1)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FF00FF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 2)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FFFF00}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 3)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FFA500}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 4)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{00FF00}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 5)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{00FFFF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 6)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{0000FF}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 4) == 7)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{B5B5B5}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
		if(DadosV(playerid, 5) == 8)
		{
			format(Str, sizeof(Str), "%s: {FFFFFF}[%d] [{FF0000}VIP{FFFFFF}] %s", PlayerName(playerid), playerid, text);
			SendClientMessageToAll(GetPlayerColor(playerid), Str);
			return 0;
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_COR_VIP)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 1);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 1:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 2);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 2:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 3);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 3:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 4);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 4:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 5);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 5:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 6);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 6:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 7);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
				case 7:
				{
					format(String, sizeof(String), "VIPs/%s.ini", PlayerName(playerid));
					DOF2_SetInt(String, "CorVIP", 8);
					DOF2_SaveFile();
					SendClientMessage(playerid, VERDE, "Cor alterada com sucesso!");
				}
			}
		}
	}
	return 1;
}

CMD:setarvip(playerid, params[])
{
	new ID, dias;
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, VERMELHO, "Você não é um admin logado na RCON e não pode usar esse comando!");
	if(sscanf(params, "ud", ID, dias)) return SendClientMessage(playerid, VERMELHO, "Use: /SetarVIP (id-do-jogador) (Dias)");
	if(IsPlayerConnected(ID))
	{
		if(dias > 60) return SendClientMessage(playerid, VERMELHO, "Você não pode dar mais que 60 dias de VIP! Tente de novo!");
		SetarV(playerid, PlayerName(ID), dias);
		SendClientFormat(playerid, AZUL_BEST, "Você deu %d dias de VIP para o(a) jogador(a) %s[%d]", dias, PlayerName(ID), ID);
		SendClientFormat(ID, AZUL_BEST, "O(A) Administrador(a) da RCON %s deu %d dias de VIP para você!", PlayerName(playerid), dias);
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Jogador não conectado!");
	return 1;
}

CMD:setarvipoff(playerid, params[])
{
	new idName[64], dias;
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, VERMELHO, "Você não é um admin logado na RCON e não pode usar esse comando!");
	if(sscanf(params, "s[64]d", idName, dias)) return SendClientMessage(playerid, VERMELHO, "Use: /SetarVIPOff (nome-do-jogador) (Dias)");
	format(String, sizeof(String), PASTA_CONTAS, idName);	
	if(DOF2_FileExists(String))
	{
		if(dias > 60) return SendClientMessage(playerid, VERMELHO, "Você não pode dar mais que 60 dias de VIP! Tente de novo!");
		SetarV(playerid, idName, dias);
		SendClientFormat(playerid, AZUL_BEST, "Você deu %d dias de VIP para o(a) jogador(a) %s", dias, idName);
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Esse jogador não existe! Por favor verifique se o nome está correto!");
	return 1;	
}

CMD:removervip(playerid, params[])
{
	new ID;
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, VERMELHO, "Você não é um admin logado na RCON e não pode usar esse comando!");
	if(sscanf(params, "u", ID)) return SendClientMessage(playerid, VERMELHO, "Use: /RemoverVip (id-do-jogador)");
	if(IsPlayerConnected(ID))
	{
		if(IsPlayerVIP(ID))
		{
			RemoverV(ID);
			SendClientFormat(playerid, AZUL_BEST, "Você removeu o VIP do(a) jogador(a) %s[%d]!", PlayerName(ID), ID);
			SendClientFormat(ID, AZUL_BEST, "O(A) Administrador(a) da RCON %s removeu o seu VIP!", PlayerName(playerid));
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
	if(IsPlayerVIP(playerid))
	{
		new StringCat[256], Str2[128], data[6];
		TimestampToDate(DadosV(playerid, 1), data[0], data[1], data[2], data[3], data[4], data[5], GMT_CONFIG);
		format(Str, sizeof(Str), "{00FFFF}Nick: {FFFFFF}%s[{00FFFF}%d{FFFFFF}]\n\n", PlayerName(playerid), playerid); strcat(StringCat, Str);
		format(Str2, sizeof(Str2), "{00FFFF}Vencimento: {FFFFFF}%02d/%02d/%04d às %02d:%02d:%02d\n\n", data[2], data[1], data[0], data[3], data[4], data[5]); strcat(StringCat, Str2);
		strcat(StringCat, "Aproveite o seu VIP até o último minuto!\n{00FF00}Creditos: {FFFFFF}ReyMysterio\n");
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{FF0000}Vencimento", StringCat, "Fechar", #);
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
	return 1;
}

CMD:vips(playerid)
{
	new ContarVIPs;
	new StringCat[1000];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerVIP(playerid))
			{
				format(String, sizeof(String), "{00FFFF}%s {FFFFFF}[{00FFFF}%i{FFFFFF}]\n", PlayerName(i), i);
				strcat(StringCat, String);
				ContarVIPs++;
			}
		}
	}
	if(ContarVIPs == 0)
	{
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{FF0000}0 {FFFFFF}VIPs Online", "{FF0000}Nenhum VIP online!", "Fechar", #);
	}
	else if(ContarVIPs == 1)
	{
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "{00BFFF}1 {FFFFFF}VIP Online", StringCat, "Fechar", #);
	}
	else
	{
		format(String, sizeof(String), "{00BFFF}%d {FFFFFF}VIPs Online", ContarVIPs);
		ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, String, StringCat, "Fechar", #);
	}
	return 1;
}

CMD:coletev(playerid)
{
	if(IsPlayerVIP(playerid))
	{
		SendClientMessage(playerid, VERDE, "Colete criado com sucesso!");
		SetPlayerArmour(playerid, 100.0);
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
	return 1;
}

CMD:jetpackv(playerid)
{
	if(IsPlayerVIP(playerid))
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "Você não pode utilizar esse comando em um veículo!");
		SendClientMessage(playerid, VERDE, "Jetpack criado com sucesso!");
		SetPlayerSpecialAction(playerid, 2);
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
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
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
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
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
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
	else SendClientMessage(playerid, VERMELHO, "Você não é um jogador VIP e não tem acesso a esse comando!");
	return 1;
}

@_CallBack: AtualizarChatBubble()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerVIP(i))
		{
			if(DadosV(i, 4) == 1)
			{
				SetPlayerChatBubble(i, "VIP", 0xFF00FFFF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 2)
			{
				SetPlayerChatBubble(i, "VIP", 0xFFFF00FF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 3)
			{
				SetPlayerChatBubble(i, "VIP", 0xFFA500FF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 4)
			{
				SetPlayerChatBubble(i, "VIP", 0x00FF00FF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 5)
			{
				SetPlayerChatBubble(i, "VIP", 0x00FFFFFF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 6)
			{
				SetPlayerChatBubble(i, "VIP", 0x0000FFFF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 7)
			{
				SetPlayerChatBubble(i, "VIP", 0xB5B5B5FF, 50.0, 10000);
			}
			if(DadosV(i, 4) == 8)
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

stock SetarV(playerid, playerName[], dias)
{
	format(String, sizeof(String), "/VIP/%s.ini", playerName);
	if(!DOF2_FileExists(String))
	{
		venvip = (gettime() + (dias * 24 * 60 * 60));
		DOF2_CreateFile(String);
		DOF2_SetInt(String, "Vencimento", venvip);
		DOF2_SetInt(String, "CorVIP", 1);
		DOF2_SaveFile();
		return 1;
	}
	else SendClientMessage(playerid, VERMELHO, "Esse jogador já é VIP!");
	return 1;
}

stock RemoverV(playerid)
{
	new StringName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, StringName, sizeof(StringName));
	format(String, sizeof(String), "/VIPs/%s.ini", StringName);
	DOF2_RemoveFile(String);
	DOF2_SaveFile();
	return 1;
}

stock DadosV(playerid, ModID)
{
	if(ModID == 1)
	{
		new StringName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, StringName, sizeof(StringName));
		format(String, sizeof(String), "/VIPs/%s.ini", StringName);
		return DOF2_GetInt(String, "Vencimento");
	}
	if(ModID == 2)
	{
		new String3[128], StringName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, StringName, sizeof(StringName));
		format(String3, sizeof(String3), "/VIPs/%s.ini", StringName);
		return DOF2_GetInt(String3, "CorVIP");
	}
	return 1;
}

stock IsPlayerVIP(playerid)
{
	new StringName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, StringName, sizeof(StringName));
	format(String, sizeof(String), "/VIPs/%s.ini", StringName);
	if(DOF2_FileExists(String)) return 1;
	return 0;
}

stock PlayerName(playerid)
{
	new Nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Nome, 24);
	return Nome;
}

stock VipeyIsNumeric(const string[]) 
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
