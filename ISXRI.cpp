//
// ISXRI
//

// Version guideline: YYYYMMDD
// Add lettering to the end to indicate a new version on the same date, such as 20060305a, 20060305b, etc
// You can also use a standard version numbering system such as 1.00, 1.01, etc. 
// Be aware that for the versioning system, this text is simply compared to another version text from the 
// same extension to check for new versions -- if this version text comes before the compared text (in a 
// dictionary), then an update is available.  Equal text means the version is up to date.  After means this 
// is newer than the compared version.  With that said, use whatever version numbering system you'd like.

// need to pull this information from Github TAG and Release Date
#define EXTENSION_VERSION "6.97 10-16-24"
double EXTVER = 6.97;
#include "ISXRI.h"
//
//
//
//
//Begin ISXRI CustomCode
//
//
//
//

#include <string>
#include <utf8string.h>
#include "RIMovement.h"
#include "RunInstances.h"
#include "Auth.h"
//#include "RILooter.h"
#include "CloseRI.h"
//#include "CloseISXRI.h"
#include "CloseISXOgre.h"
#include "Updater.h"
#include "RelayGroup.h"
#include "RaidRelayGroup.h"
#include "OgrePlayNice.h"
#include "PotionReplenish.h"
#include "PoisonReplenish.h"
#include "Replenish.h"
#include "Detarget.h"
#include "Vexven.h"
#include "AggroControl.h"
#include "CoT.h"
#include "Depot.h"
#include "RoRDisguiseFlute.h"
// #include "RZ.h"
#include "AntiAFK.h"
#include "Evac.h"
#include "CombatBot.h"
#include "AbilityCheck.h"
// #include "AutoDeity.h"
#include "WriteLocs.h"
#include "ShareMissions.h"
#include "DeleteMissions.h"
#include "Balance.h"
#include "Collection.h"
#include "Ascension.h"
#include "RIGroupLogin.h"
#include "RICharList.h"

//#include "RIMovementUI.h"
#include "RILogin.h"
#include "ZoneReset.h"
#include "Repair.h"
#include "Flag.h"
#include "RIMobHud.h"
#include "Transmute.h"
#include "Extract.h"
#include "Salvage.h"
#include "RI.h"
#include "AutoTarget.h"
#include "Harvest.h"
#include "Agnostics.h"
#include "GetCharms.h"
#include "GetItems.h"
#include "HideEffects.h"
#include "RZo.h"
#include "RZ.h"
#include "RPG.h"
#include "RIInventory.h"
#include "RIInfuse.h"
#include "Overseer.h"

#include <windows.h>
#include <wininet.h>
#include <string>
#include <comdef.h>
#include <urlmon.h>

#pragma comment(lib, "wininet.lib")
#pragma comment(lib, "urlmon.lib")

#include <iostream>
#include <fstream>
#include <direct.h>
#include <nlohmann/json.hpp>

#pragma comment(lib, "urlmon.lib")

#include <urlmon.h>
#include <sstream>

using namespace std;
bool Authed = false;
bool boolUpdating = false;
bool boolNeedUpdate = false;
bool boolUpdated = false;
bool boolAnnouncedUpdate = false;
bool boolRenameWorked = false;
bool boolNewVersion = false;

HANDLE threadHandle;

#include <wincrypt.h>

//variables for updater
string ISX_Orig_Path;
string ISX_Orig_PathRename;
char filename[FILENAME_MAX] = "ISXRI.dll";

int CalcHash(FILE* f, char* md5sum)
{
	HCRYPTPROV hProv;
	HCRYPTHASH hHash;
	unsigned char buf[1024];
	unsigned char hsh[16];
	unsigned long sz;
	char byt[3];
	int rc, err, i;
	size_t fsz;

	rc = CryptAcquireContext(&hProv, NULL, MS_STRONG_PROV, PROV_RSA_FULL, 0);
	if (!rc) {
		err = GetLastError();
		if (err == 0x80090016) {
			//first time using crypto API, need to create a new keyset
			rc = CryptAcquireContext(&hProv, NULL, MS_STRONG_PROV, PROV_RSA_FULL, CRYPT_NEWKEYSET);
			if (!rc) {
				err = GetLastError();
				return 0;
			}
		}
	}

	CryptCreateHash(hProv, CALG_MD5, 0, 0, &hHash);
	while ((fsz = fread(buf, 1, 1024, f)) != 0) {
		CryptHashData(hHash, (unsigned char*)buf, fsz, 0);
	}
	sz = 16;
	CryptGetHashParam(hHash, HP_HASHVAL, hsh, &sz, 0);
	md5sum[0] = 0;
	for (i = 0; i < sz; i++) {
		sprintf(byt, "%.2X", hsh[i]);
		strcat(md5sum, byt);
	}
	CryptDestroyHash(hHash);
	CryptReleaseContext(hProv, 0);
	return 1;
}

string MD5(string fp)
{
	FILE* f;
	char md5sum[33];

	f = fopen(fp.c_str(), "rb");

	if (f)
	{
		CalcHash(f, md5sum);
		fclose(f);
		return md5sum;
	}
	else
	{
		return 0;
	}
}

vector<string> split(const char* str, char c = ' ')
{
	vector<string> result;

	do
	{
		const char* begin = str;

		while (*str != c && *str)
			str++;

		result.push_back(string(begin, str));
	} while (0 != *str++);

	return result;
}
bool FileExists(string file_path)
{
	ifstream file(file_path);
	if (!file.is_open())
		return false;
	else 
		return true;
}
void newupdatefunction(vector<string> ftd)
{
	char InnerspacePath[512];
	char InnerspaceScriptsPath[512];
	pISInterface->GetInnerSpacePath(InnerspacePath, sizeof(InnerspacePath));
	pISInterface->GetScriptsPath(InnerspaceScriptsPath, sizeof(InnerspaceScriptsPath));
	string ISXRIPath = InnerspacePath;
	string Dirs = InnerspaceScriptsPath;
	string QuestDir = InnerspaceScriptsPath;
	string InstanceDir = InnerspaceScriptsPath;
	Dirs += "\\RI";
	CreateDirectory(Dirs.c_str(), 0);
	QuestDir += "\\RI\\Quest";
	CreateDirectory(QuestDir.c_str(), 0);
	InstanceDir += "\\RI\\Instance";
	CreateDirectory(InstanceDir.c_str(), 0);
	ISXRIPath += "\\x64\\Extensions\\ISXDK35\\ISXRI.dll";
	
	HRESULT hRez;
	for (string i : ftd)
	{
		vector<string> both = split(i.c_str(), '|');
		string urlPath = both[0];
		string localPath = both[1];
		remove(localPath.c_str());
		DeleteUrlCacheEntry(urlPath.c_str());
		size_t lastindex = localPath.find_last_of("\\");
		string dirname = localPath.substr(0, lastindex);
		CreateDirectory(dirname.c_str(), 0);
		int i = 0;
		//printf("Updater Url: %s", urlPath.c_str());
		//printf("Updater Local: %s", localPath.c_str());
		do
		{
			hRez = URLDownloadToFile(NULL, urlPath.c_str(), localPath.c_str(), 0, NULL);
			Sleep(100);
		} 
		while (!SUCCEEDED(hRez) && i++ < 25);

		if (!SUCCEEDED(hRez)) {
			// download failed
			string failMessage = "ISXRI: Updater Failed for ";
			failMessage += localPath.c_str();
			failMessage += ", Please try again later";
			printf(failMessage.c_str());
		}
		else
		{
			// download succeeded
			string successMessage = "ISXRI: Successfully updated ";
			successMessage += localPath.c_str();
			printf(successMessage.c_str());
		}
	}
	printf("ISXRI: Done Checking for Updates");
}
void NewUpd()
{
	try {
		printf("ISXRI: Checking for Data Updates");
		char InnerspaceScriptsPath[512];
		pISInterface->GetScriptsPath(InnerspaceScriptsPath, sizeof(InnerspaceScriptsPath));

		HINTERNET hInternet = InternetOpen("MyUserAgent", INTERNET_OPEN_TYPE_DIRECT, NULL, NULL, 0);
		if (hInternet == NULL) {
			cerr << "InternetOpen failed: " << GetLastError() << endl;
			return;
		}

		HINTERNET hUrl = InternetOpenUrl(hInternet, "https://raw.githubusercontent.com/Eq2automation/ISXRI-Data/refs/heads/main/md5s.json", NULL, 0, INTERNET_FLAG_RELOAD, 0);
		if (hUrl == NULL) {
			cerr << "InternetOpenUrl failed: " << GetLastError() << endl;
			InternetCloseHandle(hInternet);
			return;
		}

		char buffer[999999];
		DWORD bytesRead;
		while (InternetReadFile(hUrl, buffer, sizeof(buffer), &bytesRead) && bytesRead != 0) {
			//cout.write(buffer, bytesRead);
		}

		InternetCloseHandle(hUrl);
		InternetCloseHandle(hInternet);

		string resultString = buffer;
		//printf(resultString.c_str());
		vector<string> filesToDownload;

		using json = nlohmann::json;

		using namespace nlohmann::literals;

		json j;
		try
		{
			j = json::parse(resultString);
		}
		catch (json::parse_error& ex)
		{
			cerr << "parse error at byte " << ex.byte << endl;
		}
		
		for (auto& el : j.items())
		{
			//printf("%s %s", el.key(), el.value().get_ref<string&>());
			string webFilePath = el.key();
			string webFileHash = el.value().get_ref<string&>();

			if (webFilePath.empty() || webFileHash.empty())
				return;

			string localFileHash;
			string fullPath = InnerspaceScriptsPath;
			fullPath += "\\";
			fullPath += webFilePath;
			replace(fullPath.begin(), fullPath.end(), '/', '\\');
			if (FileExists(fullPath))
			{
				
				//check the hash matches
				localFileHash = MD5(fullPath);
				/*string test = "";
				test += webFilePath;
				test += " ";
				test += localFileHash;
				test += "=";
				test += webFileHash;*/

				//printf("file exists: %s", test.c_str());
				transform(localFileHash.begin(), localFileHash.end(), localFileHash.begin(), ::tolower);
				if (localFileHash != webFileHash)
				{
					//printf("file hash doesn't match");
					filesToDownload.push_back("https://raw.githubusercontent.com/Eq2automation/ISXRI-Data/refs/heads/main/" + webFilePath + "|" + fullPath);
				}
			}
			else
			{
				//printf("file not exists: %s", webFilePath.c_str());
				//add file to filesToDownload string array
				filesToDownload.push_back("https://raw.githubusercontent.com/Eq2automation/ISXRI-Data/refs/heads/main/" + webFilePath + "|" + fullPath);
			}
		}
		/*for (auto& f : filesToDownload)
		{
			printf(f.c_str());
		}*/
		newupdatefunction(filesToDownload);

	}
	catch (exception e1) {
		// catch block catches the exception that is thrown from try block

		string error = e1.what();
		printf(error.c_str());
	}
	
}

DWORD WINAPI NewUpdaterThread(LPVOID lpParameter)
{
	NewUpd();
	return 0;
}

void NewUpdaterT()
{
	DWORD NewUpdaterThreadID;
	HANDLE threadHandle = CreateThread(0, 0, NewUpdaterThread, 0, 0, &NewUpdaterThreadID);

	CloseHandle(threadHandle);
}
void NewUpdater()
{
	NewUpdaterT();
}
#include <iostream>
#include <filesystem>
namespace fs = filesystem;

string GetQuestName(string questFile)
{
	string fail = "";
	ifstream file(questFile); // Open the file
	if (!file.is_open()) {
		fail += "Failed to open the file: ";
		fail += questFile;
		pISInterface->Print(fail.c_str());
		return questFile;
	}

	string firstLine;
	if (getline(file, firstLine)) {
		return firstLine;
	}
	else {
		{
			fail += "Failed to read the first line of ";
			fail += questFile;
			pISInterface->Print(fail.c_str());
			return questFile;
		}
	}

	file.close(); // Close the file
	return questFile;
}

void ScanQuests()
{
	//pISInterface->Print("ISXRI: Scanning Quest Folder");
	char InnerspaceScriptsPath[512];
	string path = pISInterface->GetScriptsPath(InnerspaceScriptsPath, sizeof(InnerspaceScriptsPath));
	path += "/RI/Quest/";
	//vector<fs::directory_entry> entries;
	pISInterface->ExecuteCommand("RI_CollectionString_RQQuests:Clear");
	for (const auto& entry : fs::recursive_directory_iterator(path)) {
		if (!entry.is_directory() && !fs::is_empty(entry.path()))
		{
			//entries.insert(make_pair(GetQuestName(entry.path().generic_string()), entry.path().generic_string()));
			string com = "RI_CollectionString_RQQuests:Set[\"" + GetQuestName(entry.path().generic_string()) + "\",\"" + entry.path().generic_string() + "\"]";
			//pISInterface->Print(com.c_str());
			pISInterface->ExecuteCommand(com.c_str());
		}
	}
	//pISInterface->Print("ISXRI: Scanning Quest Folder Complete");
}

void DetermineLowestSessionISXRI()
{
	string* strSessions = NULL;  //pointer to a string, intially set to nothing.
	long longSessionCount = pISInterface->GetSessionCount(); //count number of sessions
	strSessions = new string[longSessionCount]; //set our dynamic string array

	//first find and save my session name
	char charBuffer[1024];
	pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
	strSessions[0] = charBuffer;
	string strMySession = charBuffer;

	//get all the other sessions names
	for (long i = 1; i <= longSessionCount; i++)
	{
		string strSesh = "${Session[";
		strSesh += to_string(i);
		strSesh += "]}";
		pISInterface->DataParse(strSesh.c_str(), charBuffer, sizeof(charBuffer));
		strSessions[i] = charBuffer;
		//printf("Result: %s", strSessions[i].c_str());
	}

	//sort strSessions array alphabetically ascending
	string strTempSessionName;
	for (long i = 0; i <= longSessionCount; i++)
	{
		for (long j = 0; j <= longSessionCount; j++)
		{
			if (strSessions[i] < strSessions[j])
			{
				strTempSessionName = strSessions[i];
				strSessions[i] = strSessions[j];
				strSessions[j] = strTempSessionName;
			}
		}
	}

	//for testing print sessions
	/*for (long i = 0; i <= longSessionCount; i++)
	{
	printf("Result: %s", strSessions[i].c_str());
	}*/

	//if i am the lowest alphabetical session, call update
	if (strSessions[0] == strMySession)
	{
		boolNeedUpdate = true;
	}

	delete[] strSessions; //free memory pointed to by strSessions.
	strSessions = NULL; //clear strSessions to prevent using invalid memory reference.
}
/* time example */
#include <stdio.h>      /* printf */
#include <time.h>       /* time_t, struct tm, difftime, time, mktime */

double TimeSince()
{
	time_t rawtime;

	struct tm timeinfo;
	time(&rawtime);
	localtime_s(&timeinfo, &rawtime);

	return timeinfo.tm_hour * 3600 + timeinfo.tm_min * 60 + timeinfo.tm_sec;
}

//start updater functions


void CheckForAndLoadISXEQ2()
{
	//load extension
	pISInterface->ExecuteTimedCommand(1, "execute ${If[${Extension[ISXEQ2.dll](exists)},noop,extension ISXEQ2]}");
}
void ISXRIUnRegisterTLOs()
{
	pISInterface->RemoveTopLevelObject("Devel");
	pISInterface->RemoveTopLevelObject("PaidMem");
	pISInterface->RemoveTopLevelObject("ISXRIVersion");
	//pISInterface->RemoveTopLevelObject("Paid");
}

void ISXRIUnRegisterCommands()
{
	pISInterface->RemoveCommand("RI_AggroControl");
	pISInterface->RemoveCommand("RI_Auth");
	pISInterface->RemoveCommand("RI_CMD_ExecuteCommand");
	pISInterface->RemoveCommand("RI_CoT");
	pISInterface->RemoveCommand("RI");
	pISInterface->RemoveCommand("RI_RunInstances");
	pISInterface->RemoveCommand("RG");
	pISInterface->RemoveCommand("RIMovement");
	pISInterface->RemoveCommand("RIMovementUI");
	pISInterface->RemoveCommand("RIMUI");
	pISInterface->RemoveCommand("CloseRI");
	pISInterface->RemoveCommand("RI_Update");
	//pISInterface->RemoveCommand("RILooter");
	//pISInterface->RemoveCommand("OgrePlayNice");
	pISInterface->RemoveCommand("RI_Detarget");
	//pISInterface->RemoveCommand("Vexven");
	pISInterface->RemoveCommand("RI_RoRDisguiseFlute");
	pISInterface->RemoveCommand("RI_RoRDisguiseFluteEnd");
	pISInterface->RemoveCommand("RI_Depot");
	pISInterface->RemoveCommand("RZ");
	pISInterface->RemoveCommand("RZo");
	pISInterface->RemoveCommand("RI_AntiAFK");
	//pISInterface->RemoveCommand("ftperoni");
	pISInterface->RemoveCommand("RI_SessionName");
	pISInterface->RemoveCommand("RI_SessionCount");
	pISInterface->RemoveCommand("RI_ListAllSessions");
	pISInterface->RemoveCommand("RI_DetermineLowestSession");
	pISInterface->RemoveCommand("RI_Evac");
	pISInterface->RemoveCommand("RRG");
	pISInterface->RemoveCommand("RI_FDR");
	pISInterface->RemoveCommand("RI_CloseISXRI");
	pISInterface->RemoveCommand("RI_ZoneReset");
	pISInterface->RemoveCommand("RI_Ritual");
	pISInterface->RemoveCommand("RILC");
	//pISInterface->RemoveCommand("ArgTest");
	pISInterface->RemoveCommand("RI_Repair");
	pISInterface->RemoveCommand("RI_Flag");
	pISInterface->RemoveCommand("RIMobHud");
	pISInterface->RemoveCommand("RI_CMD_PauseCombatBots");
	pISInterface->RemoveCommand("RI_CMD_PauseRIMovement");
	pISInterface->RemoveCommand("RI_CMD_PauseRI");
	pISInterface->RemoveCommand("RI_CMD_ReloadBots"); 
	pISInterface->RemoveCommand("RI_CMD_EndBots");
	pISInterface->RemoveCommand("RI_CMD_AbilityEnableDisable");
	pISInterface->RemoveCommand("RI_CMD_AbilityTypeEnableDisable");
	pISInterface->RemoveCommand("RI_CMD_Assisting");
	pISInterface->RemoveCommand("RI_CMD_FoodDrinkConsume");
	pISInterface->RemoveCommand("RI_CMD_CancelAllMaintained");
	pISInterface->RemoveCommand("RI_CMD_Cast");
	pISInterface->RemoveCommand("RI_CMD_CastOn"); 
	pISInterface->RemoveCommand("RI_CMD_PotionConsume");
	pISInterface->RemoveCommand("RI_CMD_ChangeFaceNPC");
	pISInterface->RemoveCommand("RI_POTR");
	pISInterface->RemoveCommand("RI_AutoTarget");
	pISInterface->RemoveCommand("RI_CombatBot");
	pISInterface->RemoveCommand("RI_CB");
	pISInterface->RemoveCommand("RI_AbilityCheck");
	pISInterface->RemoveCommand("RI_POSR");
	pISInterface->RemoveCommand("RI_FoodDrinkReplenish");
	pISInterface->RemoveCommand("RI_PotionReplenish");
	pISInterface->RemoveCommand("RI_PoisonReplenish");
	pISInterface->RemoveCommand("RI_CMD_PoisonConsume");
	//pISInterface->RemoveCommand("RI_AutoDeity");
	pISInterface->RemoveCommand("RI_WriteLocs");
	pISInterface->RemoveCommand("RIW");
	pISInterface->RemoveCommand("RI_Harvest");
	pISInterface->RemoveCommand("RI_DeleteMissions");
	pISInterface->RemoveCommand("RI_ShareMissions");
	pISInterface->RemoveCommand("RI_Balance");
	pISInterface->RemoveCommand("RA");
	pISInterface->RemoveCommand("RI_CMD_Hidden_GetCharms");
	pISInterface->RemoveCommand("RI_CMD_Hidden_GetItems");
	pISInterface->RemoveCommand("RI_HideEffects");
	pISInterface->RemoveCommand("RI_Collection");
	pISInterface->RemoveCommand("RI_Transmute");
	pISInterface->RemoveCommand("RI_Extract");
	pISInterface->RemoveCommand("RI_Salvage");
	pISInterface->RemoveCommand("RI_Ascension");
	pISInterface->RemoveCommand("RQ");
	pISInterface->RemoveCommand("RPG");
	pISInterface->RemoveCommand("RI_Anaheed");
	pISInterface->RemoveCommand("RI_GroupLogin");
	pISInterface->RemoveCommand("RGL");
	pISInterface->RemoveCommand("RICharList");
	pISInterface->RemoveCommand("RI_Inventory");
	pISInterface->RemoveCommand("RI_Infuse");
	pISInterface->RemoveCommand("RII");
	pISInterface->RemoveCommand("RIT");
	pISInterface->RemoveCommand("RIS");
	pISInterface->RemoveCommand("RIE");
	pISInterface->RemoveCommand("RIF");
	pISInterface->RemoveCommand("RIO");
	pISInterface->RemoveCommand("RI_Overseer");
	
	pISInterface->RemoveCommand("MD5");
	pISInterface->RemoveCommand("RI_CMD_Hidden_AddTLO");
	pISInterface->RemoveCommand("RI_CMD_Hidden_RemoveTLO");
	pISInterface->RemoveCommand("RI_CMD_Hidden_RIS");
	pISInterface->RemoveCommand("RI_CMD_Hidden_ScanQuests");

	// pISInterface->RemoveCommand("CB");
}



void CloseISXRI(){
	//close extension
	char extunload[512] = "Execute Extension -unload isxri";
	//strcat_s(extunload, filename);

	//printf("Filename: %s", extunload);
	//printf("Filename: %s", filename);
	pISInterface->ExecuteTimedCommand(10, extunload);
	//pISInterface->ExecuteCommand("execute ${If[${Extension[" + filename + "](exists)},ext -unload ISXRI]}");
}
//update function

void updatefunction()
{
	printf("ISXRI: Updating ISXRI.dll");
	char InnerspacePath[512];
	char InnerspaceScriptsPath[512];
	pISInterface->GetInnerSpacePath(InnerspacePath, sizeof(InnerspacePath));
	pISInterface->GetScriptsPath(InnerspaceScriptsPath, sizeof(InnerspaceScriptsPath));
	//printf("Scripts: %s", InnerspaceScriptsPath);
	string ISXRIPath = InnerspacePath;
	ISXRIPath += "\\x64\\Extensions\\ISXDK35\\ISXRI.dll";
	Sleep(1000);
	//download
	HRESULT hRez = URLDownloadToFile(NULL, "https://raw.githubusercontent.com/Eq2automation/ISXRI-Data/refs/heads/main/ISXRI.dll", ISX_Orig_Path.c_str(), 0, NULL);

	if (hRez != 0){
		// download failed
		printf("ISXRI: Updater Failed, Please try again later");
		//pISInterface->Relay("ALL", "echo ISXRI: Updater Failed, Please try again later");
		ExitThread(0);
	}
	else
	{
		printf("ISXRI: Done Updating ISXRI.dll - Reloading");
		
		char relayecho[512] = "relay \"all other local\" -noredirect execute \\${If[\\${Extension[";
		char relayecho2[512] = "](exists)},echo ISXRI: Done Updating ISXRI.dll - Reloading]}";
		strcat_s(relayecho, filename);
		strcat_s(relayecho, relayecho2);
		pISInterface->ExecuteCommand(relayecho);
		//pISInterface->Relay("ALL", "echo ISXRI: Done Updating ISXRI.dll, Reloading");
		boolUpdating = false;
		//run isx script to unload and reload the extension and delete RIold.dll
		char relayecho3[512] = "relay \"all other local\" -noredirect execute \\${If[\\${Extension[";
		char relayecho4[512] = "](exists)},RI_CloseISXRI]}";
		strcat_s(relayecho3, filename);
		strcat_s(relayecho3, relayecho4);
		//printf("relayecho3: %s", relayecho3);
		pISInterface->ExecuteCommand(relayecho3);

		char charremove[512] = "rm \"";
		char charremove2[25] = "\"";

		string filenameoldstr = filename;
		string filenameoldstr2;
		//printf("filenameoldstr: %s", filenameoldstr);
		filenameoldstr.erase(filenameoldstr.end() - 4, filenameoldstr.end());
		filenameoldstr += "old.dll";
		//printf("filenameoldstr: %s", filenameoldstr);
		filenameoldstr2 = "x64\\\\Extensions\\\\ISXDK35\\\\" + filenameoldstr;
		//printf("filenameoldstr2: %s", filenameoldstr2);
		strcat_s(charremove, filenameoldstr2.c_str());
		strcat_s(charremove,charremove2);
		//printf("CharRemove: %s",charremove);
		pISInterface->ExecuteTimedCommand(2500, charremove);

		char charreload[512] = "relay \"all local\" -noredirect ext ";
	
		strcat_s(charreload, filename);
		pISInterface->ExecuteTimedCommand(5000, charreload);

		CloseISXRI();
		//Sleep(2500);
		//remove(charremove);
	}

	boolUpdated = true;
	boolNeedUpdate = false;
}

DWORD WINAPI updateThread(LPVOID lpParameter)
{
	updatefunction();
	return 0;
}

void update()
{
	DWORD updateThreadID;
	HANDLE threadHandle = CreateThread(0, 0, updateThread, 0, 0, &updateThreadID);

	CloseHandle(threadHandle);
}

//updater function
void updaterfunction()
{
	//printf("Updater");
	//declare variables
	/*HMODULE hm = NULL;

	//get module (dll) handle to pass into Getmodule filename, or error
	if (!GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
	GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
	"ISXRI.dll",
	&hm))
	{
	int ret = GetLastError();
	fprintf(stderr, "GetModuleHandle returned %d\n", ret);
	}

	//get pull path and name of dll
	GetModuleFileNameA(hm, path, sizeof(path));*/

	char InnerspacePath[512];
	pISInterface->GetInnerSpacePath(InnerspacePath, sizeof(InnerspacePath));
	string ISXRIPath = InnerspacePath;


	//strcat_s(ISXRIXMLPath, InnerspacePath);
	//printf("XML: %s", ISXRIPath);
	//strcat_s(ISXRIXMLPath, "\\Extensions\\ISXRI.xml");
	//string sfilename = filename;
	//ISXRIPath += "\\Extensions\\ISXDK35\\" + sfilename;
	ISXRIPath += "\\x64\\Extensions\\ISXDK35\\ISXRI.dll";

	//printf("Folder: %s", InnerspacePath);
	//printf("DLL: %s", ISXRIPath);

	//modify strings
	ISX_Orig_Path = ISXRIPath;
	ISX_Orig_PathRename = ISX_Orig_Path;
	ISX_Orig_PathRename.erase(ISX_Orig_PathRename.end() - 4, ISX_Orig_PathRename.end());
	ISX_Orig_PathRename += "old.dll";
	
	remove(ISX_Orig_PathRename.c_str());
	Sleep(1000);
	//printf("Result2: %s", ISX_Orig_Path);
	//printf("Result3: %s", ISX_Orig_PathRename);
	int result;
	result = rename(ISX_Orig_Path.c_str(), ISX_Orig_PathRename.c_str());
	if (result == 0)
	{
		//printf("ISXRI: Updating ISXRI.dll");
		boolRenameWorked = true;
		boolNeedUpdate = true;
	}
	else
	{
		boolUpdated = true;
		boolNeedUpdate = false;
	}
}


DWORD WINAPI updaterThread(LPVOID lpParameter)
{
	updaterfunction();
	return 0;
}

void updater()
{
	DWORD updaterThreadID;
	HANDLE threadHandle = CreateThread(0, 0, updaterThread, 0, 0, &updaterThreadID);

	CloseHandle(threadHandle);
}

void checkverfunction()
{
	char charBuffer[512];
	pISInterface->DataParse("${Display.Window.IsForeground}", charBuffer, sizeof(charBuffer));
	//printf("Foreground: %s", charBuffer);
	string strForeground = charBuffer;
	if (strForeground != "TRUE")
	{
		//printf("Iamnotfore");
		//pISInterface->Relay("ALL", "if ${RI(exists)}{echo hello is1}");
		Sleep(100);
	}
	pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
	//printf("Result: %s", charBuffer);
	string strSessionName = charBuffer;
	if (strSessionName != "is1")
	{
		//printf("Iamnotis1");
		//pISInterface->Relay("ALL", "if ${RI(exists)}{echo hello is1}");
		Sleep(100);
	}

	printf("ISXRI: Checking Version: Current: %s", to_string(EXTVER));
	HINTERNET hOpen, hFile;
	string data2;

	hOpen = InternetOpen("UN/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
	if (!hOpen)
	{
		printf("ISXRI: Version check failed, Please try again later");
		ExitThread(0);
	}
	hFile = InternetOpenUrl(hOpen, "https://tfwapfktlsllzpjvqmnchmxzv40xnmgj.lambda-url.us-west-2.on.aws/V", NULL, 0, INTERNET_FLAG_RELOAD, 0);

	if (hFile)
	{
		CHAR data[12];
		DWORD dwRead;
		InternetReadFile(hFile, data, 12, &dwRead);
		data2 = data;
		InternetCloseHandle(hFile);
	}
	else
	{
		InternetCloseHandle(hFile);
		InternetCloseHandle(hOpen);
		printf("ISXRI: Version check failed, Please try again later");
		ExitThread(0);
	}

	InternetCloseHandle(hOpen);

	//format all our strings and get code and date and format date with words.
	string firstone = data2;
	string secondone;

	if (firstone.length() > 7)
	{
		firstone.erase(7, string::npos);
		secondone = data2;
		if (secondone.length() > 12)
			secondone.erase(12, string::npos);
		/*char buffer[1024];
		pISInterface->DataParse(firstone.c_str(), buffer, sizeof(buffer));
		printf("Firstone: %s", buffer);
		pISInterface->DataParse(secondone.c_str(), buffer, sizeof(buffer));
		printf("Secondone: %s", buffer);*/
	}

	if (firstone == "Version")
	{
		secondone.erase(0, 8);

		/*printf("Version seen");
		char buffer[1024];
		pISInterface->DataParse(secondone.c_str(), buffer, sizeof(buffer));
		printf("Secondeone:%s", buffer);*/
		double remoteversion = stod(secondone);

		if (remoteversion > EXTVER)
		{
			printf("ISXRI: New Version Available");
			//DetermineLowestSessionISXRI();
			boolNewVersion = true;
		}
		else
		{
			printf("ISXRI: Version's Match");
		}
		/*else
		{
		char buffer[1024];
		pISInterface->DataParse(secondone.c_str(), buffer, sizeof(buffer));
		printf("%s", buffer);

		string test = to_string(remoteversion);

		pISInterface->DataParse(test.c_str(), buffer, sizeof(buffer));
		printf("%s", buffer);
		}*/
	}
	else
	{
		printf("ISXRI: Version check failed, Please try again later");
	}
}

DWORD WINAPI checkverThread(LPVOID lpParameter)
{
	checkverfunction();
	return 0;
}

void checkver()
{
	DWORD checkverThreadID;
	HANDLE threadHandle = CreateThread(0, 0, checkverThread, 0, 0, &checkverThreadID);

	CloseHandle(threadHandle);
}


//end updater functions


char RI_Version[] = EXTENSION_VERSION;
bool userfailure = false;
bool combatbot = true;
//heroic = free
bool heroic = false;
//raid = paid
bool raid = false;
bool devel = false;
string fullexpirationdayewithword;
unsigned long ParentSet;
void dateformat(string secondone){
	secondone.erase(0, 7);
	string expirationdate = secondone;
	string expirationyear = expirationdate.erase(4, string::npos);
	expirationdate = secondone;
	string expirationday1 = expirationdate.erase(0, 4);
	string expirationday = expirationday1.erase(3, string::npos);
	int expday = stoi(expirationday);
	string expirationmonthword;

	//the below formulas are for non leapyear
	if (expday < 31)
	{
		expirationmonthword = "January";
		expday += 1;
		expirationday = to_string(expday);
	}
	else if (expday > 30 && expday < 59)
	{
		expirationmonthword = "February";
		expday -= 30;
		expirationday = to_string(expday);
	}
	else if (expday > 58 && expday < 90)
	{
		expirationmonthword = "March";
		expday -= 58;
		expirationday = to_string(expday);
	}
	else if (expday > 89 && expday < 120)
	{
		expirationmonthword = "April";
		expday -= 89;
		expirationday = to_string(expday);
	}
	else if (expday > 119 && expday < 151)
	{
		expirationmonthword = "May";
		expday -= 119;
		expirationday = to_string(expday);
	}
	else if (expday > 150 && expday < 181)
	{
		expirationmonthword = "June";
		expday -= 150;
		expirationday = to_string(expday);
	}
	else if (expday > 180 && expday < 212)
	{
		expirationmonthword = "July";
		expday -= 179;
		expirationday = to_string(expday);
	}
	else if (expday > 211 && expday < 243)
	{
		expirationmonthword = "August";
		expday -= 211;
		expirationday = to_string(expday);
	}
	else if (expday > 242 && expday < 273)
	{
		expirationmonthword = "September";
		expday -= 242;
		expirationday = to_string(expday);
	}
	else if (expday > 272 && expday < 304)
	{
		expirationmonthword = "October";
		expday -= 272;
		expirationday = to_string(expday);
	}
	else if (expday > 303 && expday < 334)
	{
		expirationmonthword = "November";
		expday -= 303;
		expirationday = to_string(expday);
	}
	else if (expday > 333)
	{
		expirationmonthword = "December";
		expday -= 333;
		expirationday = to_string(expday);
	}
	fullexpirationdayewithword = expirationmonthword + " " + expirationday + ", " + expirationyear;

	/*char jibberish[] = "${If[${Time.Hour}*9>100,\"I am a big number\",\"I am a small number\"]}";*/

	/*pISInterface->DataParse(firstone.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);

	pISInterface->DataParse(secondone.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);

	pISInterface->DataParse(expirationdate.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);

	pISInterface->DataParse(expirationyear.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);

	pISInterface->DataParse(expirationmonth.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);

	pISInterface->DataParse(expirationday.c_str(), buffer, sizeof(buffer));
	printf("Result: %s", buffer);*/
}
/*
/// EXAMPLE OF BASIC THREAD
DWORD WINAPI myThread(LPVOID lpParameter)
{
	//unsigned int& myCounter = *((unsigned int*)lpParameter);
	//while (myCounter < 0xFFFFFFFF) ++myCounter;
	//return 0;

	printf("Beggining of thread");
	Sleep(1000);
	printf("End of thread");
	return 0;
}

void testthread()
{
	DWORD myThreadID;
	HANDLE threadHandle = CreateThread(0, 0, myThread, 0, 0, &myThreadID);

	CloseHandle(threadHandle);
}
/// END EXAMPLE
*/

char Login[50] = "\0";
char Password[50] = "\0";

double LoggedInTime = 0;
double LastAuthTime = 0;
double LastGotLPTime = 0;
bool gotlp = false;
bool gettinglp = false;

void getlp(bool Failed){
	gettinglp = true;
	LastGotLPTime = TimeSince();
	/*char InnerspacePath[512];
	pISInterface->GetInnerSpacePath(InnerspacePath, sizeof(InnerspacePath));
	string ISXRIXMLPath = InnerspacePath;
	//strcat_s(ISXRIXMLPath, InnerspacePath);
	printf("XML: %s", ISXRIXMLPath);
	//strcat_s(ISXRIXMLPath, "\\Extensions\\ISXRI.xml");
	ISXRIXMLPath += "\\Extensions\\ISXRI.xml";
	printf("Folder: %s", InnerspacePath);
	printf("XML: %s", ISXRIXMLPath);*/
	unsigned int ident = pISInterface->OpenSettings("Extensions/ISXRI.xml");
	unsigned int ID = pISInterface->FindSet(ident, "Authentication");
	//printf("ident: %s", to_string(ident));
	//printf("ID: %s", to_string(ID));

	/*printf("Login:");
	printf(Login);
	printf("Password:");
	printf(Password);*/
	
	if ((pISInterface->GetSetting(ID, "Login", Login, sizeof(Login))) && (pISInterface->GetSetting(ID, "Password", Password, sizeof(Password))))
	{
		try
		{
			if (Failed)
			{
				bool ForeOrIS1 = false;
				char charBuffer[512];
				pISInterface->DataParse("${Display.Window.IsForeground}", charBuffer, sizeof(charBuffer));
				//printf("Foreground: %s", charBuffer);
				string strForeground = charBuffer;
				if (strForeground == "TRUE")
				{
					//printf("Iamnotfore");
					ForeOrIS1 = true;
				}
				pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
				//printf("Result: %s", charBuffer);
				string strSessionName = charBuffer;
				if (strSessionName == "is1")
				{
					//printf("Iamnotis1");
					ForeOrIS1 = true;
				}
				if (ForeOrIS1)
				{

					printf("ISXRI: Re-enter authentication information");
					char* k = (char*)"3rtZdjv7";
					const unsigned char* p = Auth;
					const char* c = (const char*)p;

					pISInterface->RunScriptFromBuffer("Auth", c, sizeof(Auth), 1, &k);
					pISInterface->ClearSet(ident);
					pISInterface->UnloadSet(ident);
					Sleep(5);
					pISInterface->ExecuteCommand("relay \"all other local\" -noredirect execute \\${If[\\${Extension[ISXRI.dll](exists)},ext -unload ISXRI]}");
					gettinglp = false;
					//unload ri on all
					//${If[${Extension[ISXRI.dll](exists)},ext -unload ISXRI,echo ISXRI: Extension not running on this session]}
					//pISInterface->Relay("ALL", "relay all -noredirect ${If[${Extension[ISXRI.dll](exists)},ext -unload ISXRI,echo ISXRI: Extension not running on this session]}");
					return;
				}
				else
				{
					pISInterface->ClearSet(ident);
					pISInterface->UnloadSet(ident);
					//bool boolDen = false;
					//pISInterface->UnloadExtension("ISXRI", boolDen);  <--- crashing clients
					// pISInterface->ExecuteCommand("ext -unload ISXRI");
				}
			}
			//printf("Either we got both Settings or We did not fail");
			/*printf("Login:");
			printf(Login);
			printf("Password:");
			printf(Password);*/

			pISInterface->ClearSet(ident);
			pISInterface->UnloadSet(ident);
			gotlp = true;
		}
		catch (const exception&)
		{
			return;
		}
	}
	else
	{
		printf("ISXRI: Missing authentication information");
		bool ForeOrIS1 = false;
		char charBuffer[512];
		pISInterface->DataParse("${Display.Window.IsForeground}", charBuffer, sizeof(charBuffer));
		//printf("Foreground: %s", charBuffer);
		string strForeground = charBuffer;
		if (strForeground == "TRUE")
		{
			//printf("Iamnotfore");
			ForeOrIS1 = true;
		}
		pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
		//printf("Result: %s", charBuffer);
		string strSessionName = charBuffer;
		if (strSessionName == "is1")
		{
			//printf("Iamnotis1");
			ForeOrIS1 = true;
		}
		if (ForeOrIS1)
		{
			//printf("we failed or did not get settings");
			/*printf("Login:");
			printf(Login);
			printf("Password:");
			printf(Password);*/
	
			//printf("ISXRI: Missing authentication information");
			//pISInterface->RunScript("Auth.iss");
			char* k = (char*)"3rtZdjv7";
			const unsigned char * p = Auth;
			const char * c = (const char *)p;

			pISInterface->RunScriptFromBuffer("Auth", c, sizeof(Auth), 1, &k);
			pISInterface->ClearSet(ident);
			pISInterface->UnloadSet(ident);
			Sleep(5);
			pISInterface->ExecuteCommand("relay \"all other local\" -noredirect execute \\${If[\\${Extension[ISXRI.dll](exists)},ext -unload ISXRI]}");
			gettinglp = false;
			return;
		}
		else
		{
			
			pISInterface->ClearSet(ident);
			pISInterface->UnloadSet(ident);
			//bool boolDen = false;
			//pISInterface->UnloadExtension("ISXRI",boolDen); <--- doesnt work crashes client
			// pISInterface->ExecuteCommand("ext -unload ISXRI");
		}
	}
	gettinglp = false;
}

bool authenticating = false;
int failure = 0;

void authfunction(){
	authenticating = true;
	LastAuthTime = TimeSince();
	
	HINTERNET hOpen, hFile;
	string data2;

	hOpen = InternetOpen("UN/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
	
	char a[] = "https://tfwapfktlsllzpjvqmnchmxzv40xnmgj.lambda-url.us-west-2.on.aws/L/";
	char b[] = "/";
	char URL[500] = "";
	strcat_s(URL, a);
	strcat_s(URL, Login);
	strcat_s(URL, b);
	strcat_s(URL, Password);
	
	hFile = InternetOpenUrl(hOpen, URL, NULL, 0, INTERNET_FLAG_RELOAD, 0);
	if (hFile)
	{
		CHAR data[20];
		DWORD dwRead;
		InternetReadFile(hFile, data, 20, &dwRead);
		data2 = data;
		InternetCloseHandle(hFile);
		InternetCloseHandle(hOpen);
		printf("ISXRI: Connecting to primary authentication server");
	}
	//format all our strings and get code and date and format date with words.
	string firstone = data2;
	string secondone;

	if (firstone.length() > 6)
	{
		firstone.erase(6, string::npos);
		secondone = data2;
		if (secondone.length() > 20)
			secondone.erase(20, string::npos);
		//printf("data: %s", secondone);
	}

	//printf("data: %s", firstone);
	if (firstone == "522145")
	{
		failure = 6;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Authentication Successful... Your access level set to Free... Refer to --> https://goo.gl/QWpxv6");
		printf("ISXRI: Version %s loaded", RI_Version);
		heroic = true;
		Authed = true;
		LoggedInTime = TimeSince();
	}
	else if (firstone == "522150")
	{
		failure = 6;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Authentication Successful... Your access level set to Paid... Your membership expires on %s", buffer);
		printf("ISXRI: Version %s loaded", RI_Version);
		raid = true;
		Authed = true;
		LoggedInTime = TimeSince();
	}
	/*else if (firstone == "522155")
	{
		failure = 6;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid... Your membership expires on %s", buffer);
		printf("ISXRI: Version %s loaded", RI_Version);
		heroic = true;
		raid = true;
		Authed = true;
		LoggedInTime = TimeSince();
	}*/
	else if (firstone == "522160")
	{
		failure = 6;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Authentication Successful... Your access level set to Devel... Your membership expires on %s", buffer);
		printf("ISXRI: Version %s loaded", RI_Version);
		//heroic = true;
		//raid = true;
		devel = true;
		Authed = true;
		LoggedInTime = TimeSince();
	}
	else if (firstone == "522140")
	{
		if (failure < 5)
		{
			failure++;
			printf("ISXRI: Authentication Failed... No such user exists or your password is incorrect, please visit http://www.isxri.com/ to subscribe");
			//need to add run script that will popup username and password fields to edit whats in the xml
			//also need to figure out how to wait here until that script completes
			gotlp = false;
			getlp(true);
			//Sleep(1000);
			authenticating = false;
			return;
		}
		else
		{
			failure = 6;
			printf("ISXRI: Unable to Authenticate after 5 tries... Please try again later");
			//list a url for them to click to contact
			CloseISXRI();
		}
	}
	else if (firstone == "522135")
	{
		failure = 6;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Authentication Failed... Your membership has expired on %s, please visit http://www.isxri.com/ to resubscribe", buffer);
		//list a url for them to click to renew
		CloseISXRI();
	}
	else if (firstone == "522130")
	{
		failure = 6;
		printf("ISXRI: Authentication Failed... You are trying to log in from more than 1 IP concurrently... Please wait 5 mins and try again... If your problem persists and you believe this is in error please contact Herculezz @ herculezz@isxri.com");
		//list a url for them to click to contact
		CloseISXRI();
	}
	else
	{
		//check backup auth server
		InternetCloseHandle(hFile);
		InternetCloseHandle(hOpen);
		string data2b;
		HINTERNET hOpen2, hFile2;
		hOpen2 = InternetOpen("UN/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);

		if (!hOpen && !hOpen2)
		{
			printf("ISXRI: Unable to contact Authentication server... Please check your internet connection... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
			CloseISXRI();
			ExitThread(0);
		}

		char a2[] = "https://tfwapfktlsllzpjvqmnchmxzv40xnmgj.lambda-url.us-west-2.on.aws/L/";
		char b2[] = "/";
		char URL2[500] = "";
		strcat_s(URL2, a2);
		strcat_s(URL2, Login);
		strcat_s(URL2, b2);
		strcat_s(URL2, Password);

		//printf("URL: %s", URL2);

		hFile2 = InternetOpenUrl(hOpen2, URL2, NULL, 0, INTERNET_FLAG_RELOAD, 0);

		if (hFile2)
		{
			CHAR datab[20];
			DWORD dwReadb;
			InternetReadFile(hFile2, datab, 20, &dwReadb);
			data2b = datab;
			InternetCloseHandle(hFile2);
			InternetCloseHandle(hOpen2);
			printf("ISXRI: Failed connection to primary authentication server, Connecting to secondary authentication server");
		}
		else
		{
			printf("ISXRI: Unable to contact Authentication server... Please check your internet connection... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
			InternetCloseHandle(hFile);
			InternetCloseHandle(hFile2);
			InternetCloseHandle(hOpen);
			InternetCloseHandle(hOpen2);
			CloseISXRI();
			ExitThread(0);
		}
		InternetCloseHandle(hOpen2);
		//format all our strings and get code and date and format date with words.
		string firstoneb = data2b;
		string secondoneb;
		//printf("data: %s", firstoneb);

		if (firstoneb.length() > 6)
		{
			firstoneb.erase(6, string::npos);
			secondoneb = data2b;
			if (secondoneb.length() > 20)
				secondoneb.erase(20, string::npos);
			//printf("data: %s", secondoneb);
		}

		//printf("data: %s", firstoneb);
		if (firstoneb == "522145")
		{
			failure = 6;
			dateformat(secondoneb);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Authentication Successful... Your access level set to Free... Refer to --> https://goo.gl/QWpxv6");
			printf("ISXRI: Version %s loaded", RI_Version);
			heroic = true;
			Authed = true;
			LoggedInTime = TimeSince();
		}
		else if (firstoneb == "522150")
		{
			failure = 6;
			dateformat(secondoneb);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Authentication Successful... Your access level set to Paid... Your membership expires on %s", buffer);
			printf("ISXRI: Version %s loaded", RI_Version);
			raid = true;
			Authed = true;
			LoggedInTime = TimeSince();
		}
		/*else if (firstoneb == "522155")
		{
			failure = 6;
			dateformat(secondoneb);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid... Your membership expires on %s", buffer);
			printf("ISXRI: Version %s loaded", RI_Version);
			//heroic = true;
			//raid = true;
			Authed = true;
			LoggedInTime = TimeSince();
		}*/
		else if (firstoneb == "522160")
		{
			failure = 6;
			dateformat(secondoneb);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid + Devel... Your membership expires on %s", buffer);
			printf("ISXRI: Version %s loaded", RI_Version);
			//heroic = true;
			//raid = true;
			devel = true;
			Authed = true;
			LoggedInTime = TimeSince();
		}
		else if (firstoneb == "522140")
		{
			if (failure < 5)
			{
				failure++;
				printf("ISXRI: Authentication Failed... No such user exists or your password is incorrect, please visit http://www.isxri.com/ to subscribe");
				//need to add run script that will popup username and password fields to edit whats in the xml
				//also need to figure out how to wait here until that script completes
				gotlp = false;
				getlp(true);
				//Sleep(1000);
				authenticating = false;
				return;
			}
			else
			{
				failure = 6;
				printf("ISXRI: Unable to Authenticate after 5 tries... Please try again later");
				//list a url for them to click to contact
				CloseISXRI();
			}
		}
		else if (firstoneb == "522135")
		{
			failure = 6;
			dateformat(secondoneb);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Authentication Failed... Your membership has expired on %s, please visit http://www.isxri.com/ to resubscribe", buffer);
			//list a url for them to click to renew
			CloseISXRI();
		}
		else if (firstoneb == "522130")
		{
			failure = 6;
			printf("ISXRI: Authentication Failed... You are trying to log in from more than 1 IP concurrently... Please wait 5 mins and try again... If your problem persists and you believe this is in error please contact Herculezz @ herculezz@isxri.com");
			//list a url for them to click to contact
			CloseISXRI();
		}
		else
		{
			if (failure < 5)
			{
				//printf("Failedtoconnect");
				failure++;
			}
			else
			{
				failure = 6;
				printf("ISXRI: Unable to contact Authentication server... Please check your internet connection... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
				//list a url for them to click to contact
				CloseISXRI();
			}
		}
	}
	//sleep for 1s
	//Sleep(1000);
	//}
	authenticating = false;
	//printf("done auth");
}


DWORD WINAPI AuthThread(LPVOID lpParameter)
{
	authfunction();
	return 0;
}

void auth()
{
	DWORD AuthThreadID;
	
	HANDLE threadHandle = CreateThread(0, 0, AuthThread, 0, 0, &AuthThreadID);
	
	CloseHandle(threadHandle);
	return;
}


int failcounter = 0;

void LoggedInfunction(){
	//printf("reauthing");
	HINTERNET hOpen, hFile;
	string data2;

	hOpen = InternetOpen("UN/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);

	char a[] = "https://tfwapfktlsllzpjvqmnchmxzv40xnmgj.lambda-url.us-west-2.on.aws/L/";
	char b[] = "/";
	char URL[500] = "";
	strcat_s(URL, a);
	strcat_s(URL, Login);
	strcat_s(URL, b);
	strcat_s(URL, Password);

	hFile = InternetOpenUrl(hOpen, URL, NULL, 0, INTERNET_FLAG_RELOAD, 0);

	if (hFile)
	{
		CHAR data[15];
		DWORD dwRead;
		InternetReadFile(hFile, data, 15, &dwRead);
		data2 = data;
		InternetCloseHandle(hFile);
		InternetCloseHandle(hOpen);
	}

	//format all our strings and get code and date and format date with words.
	string firstone = data2;
	string secondone;

	if (firstone.length() > 6)
	{
		firstone.erase(6, string::npos);
		secondone = data2;
		if (secondone.length() > 15)
			secondone.erase(15, string::npos);
	}
	if (firstone == "522145")
	{
		failcounter = 0;
		//dateformat(secondone);
		//char buffer[1024];
		//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		//printf("ISXRI: Authentication Successful... Your access level set to Heroic... Your membership expires on %s", buffer);
		//printf("ISXRI: Version %s loaded", RI_Version);
		heroic = true;
	}
	else if (firstone == "522150")
	{
		failcounter = 0;
		//dateformat(secondone);
		//char buffer[1024];
		//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		//printf("ISXRI: Authentication Successful... Your access level set to Raid... Your membership expires on %s", buffer);
		//printf("ISXRI: Version %s loaded", RI_Version);
		raid = true;
	}
	/*else if (firstone == "522155")
	{
		failcounter = 0;
		//dateformat(secondone);
		//char buffer[1024];
		//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		//printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid... Your membership expires on %s", buffer);
		//printf("ISXRI: Version %s loaded", RI_Version);
		heroic = TRUE;
		raid = TRUE;
	}*/
	else if (firstone == "522160")
	{
		failcounter = 0;
		//dateformat(secondone);
		//char buffer[1024];
		//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		//printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid + Devel... Your membership expires on %s", buffer);
		//printf("ISXRI: Version %s loaded", RI_Version);
		//heroic = TRUE;
		//raid = TRUE;
		devel = true;
	}
	else if (firstone == "522140")
	{
		failcounter = 0;
		printf("ISXRI: Authentication Error... No such user exists or your password is incorrect, please visit http://www.isxri.com/ to subscribe");
		//need to add run script that will popup username and password fields to edit whats in the xml
		//also need to figure out how to wait here until that script completes
		CloseISXRI();
	}
	else if (firstone == "522135")
	{
		failcounter = 0;
		dateformat(secondone);
		char buffer[1024];
		pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
		printf("ISXRI: Your membership has expired on %s, please visit http://www.isxri.com/ to resubscribe", buffer);
		//list a url for them to click to renew -done
		CloseISXRI();
	}
	else if (firstone == "522130")
	{
		failcounter = 0;
		printf("ISXRI: Authentication Error... You are trying to log in from more than 1 IP concurrently... Please wait 5 mins and try again... If your problem persists and you believe this is in error please contact Herculezz @ herculezz@isxri.com");
		//list a url for them to click to contact
		CloseISXRI();
	}
	else
	{
		//check backup auth server
		InternetCloseHandle(hFile);
		InternetCloseHandle(hOpen);
		string data2b;
		HINTERNET hOpen2, hFile2;
		hOpen2 = InternetOpen("UN/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);

		if (!hOpen && !hOpen2)
		{
			printf("ISXRI: Unable to contact Authentication server... Please check your internet connection... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
			CloseISXRI();
			ExitThread(0);
		}

		char a2[] = "https://tfwapfktlsllzpjvqmnchmxzv40xnmgj.lambda-url.us-west-2.on.aws/L/";
		char b2[] = "/";
		char URL2[500] = "";
		strcat_s(URL2, a2);
		strcat_s(URL2, Login);
		strcat_s(URL2, b2);
		strcat_s(URL2, Password);

		//printf("URL: %s", URL2);

		hFile2 = InternetOpenUrl(hOpen2, URL2, NULL, 0, INTERNET_FLAG_RELOAD, 0);

		if (hFile2)
		{
			InternetCloseHandle(hFile);
			InternetCloseHandle(hOpen);
			CHAR datab[20];
			DWORD dwReadb;
			InternetReadFile(hFile2, datab, 20, &dwReadb);
			data2b = datab;
			InternetCloseHandle(hFile2);
			InternetCloseHandle(hOpen2);
			//printf("ISXRI: Failed connection to primary authentication server, Connecting to secondary authentication server");
		}
		else
		{
			if (failcounter < 3)
			{
				failcounter++;
				InternetCloseHandle(hFile);
				InternetCloseHandle(hOpen);
				InternetCloseHandle(hFile2);
				InternetCloseHandle(hOpen2);
				ExitThread(0);
				return;
			}
			else
			{
				failcounter = 0;
				printf("ISXRI: Unable to contact Authentication server after 3 consecutive tries... Please check your internet connections... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
				//list a url for them to click to contact
				CloseISXRI();
				InternetCloseHandle(hFile);
				InternetCloseHandle(hOpen);
				InternetCloseHandle(hFile2);
				InternetCloseHandle(hOpen2);
				ExitThread(0);
				return;
			}
		}
		//format all our strings and get code and date and format date with words.
		string firstoneb = data2b;
		string secondoneb;
		//printf("data: %s", firstoneb);

		if (firstoneb.length() > 6)
		{
			firstoneb.erase(6, string::npos);
			secondoneb = data2b;
			if (secondoneb.length() > 20)
				secondoneb.erase(20, string::npos);
			//printf("data: %s", secondoneb);
		}

		//printf("data: %s", firstoneb);
		if (firstoneb == "522145")
		{
			failcounter = 0;
			//dateformat(secondoneb);
			//char buffer[1024];
			//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			//printf("ISXRI: Authentication Successful... Your access level set to Heroic... Your membership expires on %s", buffer);
			//printf("ISXRI: Version %s loaded", RI_Version);
			heroic = true;
			//Authed = true;
			LoggedInTime = TimeSince();
		}
		else if (firstoneb == "522150")
		{
			failcounter = 0;
			//dateformat(secondoneb);
			//char buffer[1024];
			//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			//printf("ISXRI: Authentication Successful... Your access level set to Raid... Your membership expires on %s", buffer);
			//printf("ISXRI: Version %s loaded", RI_Version);
			raid = true;
			//Authed = true;
			//LoggedInTime = TimeSince();
		}
		/*else if (firstoneb == "522155")
		{
			failcounter = 0;
			//dateformat(secondoneb);
			//char buffer[1024];
			//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			//printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid... Your membership expires on %s", buffer);
			//printf("ISXRI: Version %s loaded", RI_Version);
			heroic = true;
			raid = true;
			//Authed = true;
			//LoggedInTime = TimeSince();
		}*/
		else if (firstoneb == "522160")
		{
			failcounter = 0;
			//dateformat(secondoneb);
			//char buffer[1024];
			//pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			//printf("ISXRI: Authentication Successful... Your access level set to Heroic + Raid + Devel... Your membership expires on %s", buffer);
			//printf("ISXRI: Version %s loaded", RI_Version);
			//heroic = true;
			//raid = true;
			devel = true;
			//Authed = true;
			//LoggedInTime = TimeSince();
		}
		else if (firstone == "522140")
		{
			failcounter = 0;
			printf("ISXRI: Authentication Error... No such user exists or your password is incorrect, please visit http://www.isxri.com/ to subscribe");
			//need to add run script that will popup username and password fields to edit whats in the xml
			//also need to figure out how to wait here until that script completes
			CloseISXRI();
		}
		else if (firstone == "522135")
		{
			failcounter = 0;
			dateformat(secondone);
			char buffer[1024];
			pISInterface->DataParse(fullexpirationdayewithword.c_str(), buffer, sizeof(buffer));
			printf("ISXRI: Your membership has expired on %s, please visit http://www.isxri.com/ to resubscribe", buffer);
			//list a url for them to click to renew -done
			CloseISXRI();
		}
		else if (firstone == "522130")
		{
			failcounter = 0;
			printf("ISXRI: Authentication Error... You are trying to log in from more than 1 IP concurrently... Please wait 5 mins and try again... If your problem persists and you believe this is in error please contact Herculezz @ herculezz@isxri.com");
			//list a url for them to click to contact
			CloseISXRI();
		}
		else
		{
			if (failcounter < 3)
				failcounter++;
			else
			{
				failcounter = 0;
				printf("ISXRI: Unable to contact Authentication server after 3 consecutive tries... Please check your internet connections... If you believe this is in error please contact Herculezz @ herculezz@isxri.com");
				//list a url for them to click to contact
				CloseISXRI();
			}
		}
	}
	InternetCloseHandle(hFile);
	InternetCloseHandle(hOpen);
}

DWORD WINAPI LoggedInThread(LPVOID lpParameter)
{
	LoggedInfunction();
	return 0;
}

void LoggedIn()
{
	DWORD LoggedInThreadID;
	HANDLE threadHandle = CreateThread(0, 0, LoggedInThread, 0, 0, &LoggedInThreadID);

	CloseHandle(threadHandle);
}

/*
bool TLO_Devel(int argc, char *argv[], LSOBJECT &Dest)
{

if (devel)
return TRUE;
else
return FALSE;
}
*/

bool __cdecl TLO_ISXRIVersion(int argc, char* argv[], LSTYPEVAR& Dest)
{
	Dest.Float = (float)EXTVER;
	Dest.Type = pFloatType;
	return true;
}

bool __cdecl TLO_Devel(int argc, char *argv[], LSTYPEVAR &Dest)
{
	if (devel)
	{
		Dest.Ptr = "TRUE";
		Dest.Type = pBoolType;

		return true;
	}
	else
	{
		Dest.Ptr = "FALSE";
		Dest.Type = pBoolType;

		return false;
	}
	return false;
}
bool __cdecl TLO_PaidMem(int argc, char *argv[], LSTYPEVAR &Dest)
{
	if (raid || devel)
	{
		Dest.Ptr = "TRUE";
		Dest.Type = pBoolType;

		return true;
	}
	else
	{
		Dest.Ptr = "FALSE";
		Dest.Type = pBoolType;

		return false;
	}
	return false;
}


/// END OF TLOS
int __cdecl CMD_AddTLO(int argc, char *argv[])
{
	if (argc > 1)
	{
		/*char* tlo = argv[2];
		fLSTopLevelObject tlo2;
		tlo2 = fLSTopLevelObject(tlo);
		pISInterface->AddTopLevelObject(argv[1], fLSTopLevelObject(argv[2]));*/

		string tlo = argv[1];
		
		
	}
	return 1;
}
int __cdecl CMD_RemoveTLO(int argc, char *argv[])
{
	if (argc > 1)
	{
		if (pISInterface->IsTopLevelObject(argv[1]))
			pISInterface->RemoveTopLevelObject(argv[1]);
	}
	return 1;
}

int __cdecl CMD_AbilityTypeEnableDisable(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	 char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charEQ2BotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 2)
	{
		//cast argv[1] to an int for checking
		int intArg2 = atoi(argv[2]);

		//if intArg2 is 1 enable ability
		if (intArg2 == 1)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Enabling Type: %s", argv[1]);
				string a = argv[1];
				string ab = "OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_" + a + " FALSE";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Enabling Type: %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "THGBotDisableAbilityType \"" + a + "\" " + b;
				//printf("Result %s", ab);
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Enabling Type: %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "RI_Obj_CB:ModifyCastStackAbilityType[\"" + a + "\"," + b + "]";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
		}

		//else if intArg2 is 0 Disable ability
		else if (intArg2 == 0)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Disabling Type: %s", argv[1]);
				string a = argv[1];
				string ab = "OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_" + a + " TRUE";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Disabling Type: %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "THGBotDisableAbilityType \"" + a + "\" " + b;
				//printf("Result %s", ab);
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Disabling Type: %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "RI_Obj_CB:ModifyCastStackAbilityType[\"" + a + "\"," + b + "]";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_AbilityTypeEnableDisable string AbilityType=Hostile/NamedHostile/InCombatTargeted/Cure/Heal/Power/Res/Buff/OutOfCombatBuff string EnableDisable  1/TRUE == Enable 0/FALSE == Disable", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_AbilityTypeEnableDisable string AbilityType=Hostile/NamedHostile/InCombatTargeted/Cure/Heal/Power/Res/Buff/OutOfCombatBuff string EnableDisable 1/TRUE == Enable 0/FALSE == Disable");
	return 1;
}

int __cdecl CMD_ScanQuests(int argc, char* argv[])
{
	ScanQuests();
	return 1;
}

int __cdecl CMD_Cast(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 2)
	{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Casting Ability: %s", argv[1]);
				string a = argv[1];
				int intArg2 = atoi(argv[2]);
				string b = "";
				if (intArg2 = 0)
					b = "FALSE";
				if (intArg2 = 1)
					b = "TRUE";
				string ab = "OgreBotAtom a_CastFromUplink ALL \"" + a + "\" " + b;
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Casting Ability: %s", argv[1]);
				string a = argv[1];
				int intArg2 = atoi(argv[2]);
				string b = "";
				if (intArg2 = 0)
					b = "FALSE";
				if (intArg2 = 1)
					b = "TRUE";
				string ab = "THGBotCast \"" + a + "\" " + b;
				//printf("Result %s", ab);
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Casting Ability: %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "RI_Obj_CB:Cast[\"" + a + "\"," + b + "]";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
	}
	else if (argc > 1)
	{
		/*if (strOgreBotBuffer == "TRUE")
		{
			//printf("ISXRI: OgreBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string ab = "OgreBotAtom a_CastFromUplink ALL \"" + a + "\"";
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}*/
		if (strTHGBotBuffer == "TRUE")
		{
			//printf("ISXRI: THGBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string ab = "THGBotCast \"" + a + "\"";
			//printf("Result %s", ab);
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
		if (strEQ2BotBuffer == "TRUE")
		{
			printf("ISXRI: EQ2Bot: Currently does not have this feature");
		}
		if (strCombatBotBuffer == "TRUE")
		{
			//printf("ISXRI: CombatBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string ab = "RI_Obj_CB:Cast[\"" + a + "\"]";
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
	}
	else
		printf("ISXRI: Not Enough Args, Usage : RI_CMD_Cast string AbilityName int CancelCast  1 == Cancel 0 == Wait");
	return 1;
}


int __cdecl CMD_CastOn(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 3)
	{
		/*if (strOgreBotBuffer == "TRUE")
		{
			//printf("ISXRI: OgreBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string a2 = argv[2];
			int intArg2 = atoi(argv[3]);
			string b = "";
			if (intArg2 = 0)
				b = "FALSE";
			if (intArg2 = 1)
				b = "TRUE";
			string ab = "OgreBotAtom a_CastFromUplinkOnPlayer ALL \"" + a + "\" " + a2 + " " + b;
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}*/
		if (strTHGBotBuffer == "TRUE")
		{
			//printf("ISXRI: THGBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string a2 = argv[2];
			int intArg2 = atoi(argv[3]);
			string b = "";
			if (intArg2 = 0)
				b = "FALSE";
			if (intArg2 = 1)
				b = "TRUE";
			string ab = "THGBotCastOn \"" + a + "\" " + a2 + " " + b;
			//printf("Result %s", ab);
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
		if (strEQ2BotBuffer == "TRUE")
		{
			printf("ISXRI: EQ2Bot: Currently does not have this feature");
		}
		if (strCombatBotBuffer == "TRUE")
		{
			//printf("ISXRI: CombatBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string a2 = argv[2];
			string b = argv[3];
			string ab = "RI_Obj_CB:CastOn[\"" + a + "\"," + a2 + "," + b + "]";
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
	}
	else if (argc > 2)
	{
		/*if (strOgreBotBuffer == "TRUE")
		{
			//printf("ISXRI: OgreBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string b = argv[2];
			string ab = "OgreBotAtom a_CastFromUplinkOnPlayer ALL \"" + a + "\" " + b;
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}*/
		if (strTHGBotBuffer == "TRUE")
		{
			//printf("ISXRI: THGBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string b = argv[2];
			string ab = "THGBotCastOn \"" + a + "\" " + b;
			//printf("Result %s", ab);
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
		if (strEQ2BotBuffer == "TRUE")
		{
			printf("ISXRI: EQ2Bot: Currently does not have this feature");
		}
		if (strCombatBotBuffer == "TRUE")
		{
			//printf("ISXRI: CombatBot: Casting Ability: %s", argv[1]);
			string a = argv[1];
			string b = argv[2];
			string ab = "RI_Obj_CB:CastOn[\"" + a + "\"," + b + "]";
			pISInterface->ExecuteTimedCommand(1, ab.c_str());
		}
	}
	else
		printf("ISXRI: Not Enough Args, Usage : RI_CMD_CastOn string AbilityName string ToonName int CancelCast  1 == Cancel 0 == Wait");
	return 1;
}


/*
atom RI_Atom_ModifyCS(string Which, int OnOff)
{
switch ${Which.Upper}
{
case CA
{
if ${OnOff}==1
OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_ca TRUE
elseif ${OnOff}==0
OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_ca FALSE
else
echo ISXRI: 1=On 0=Off
break
}
case NamedCA
{
if ${OnOff}==1
OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_namedca TRUE
elseif ${OnOff}==0
OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_namedca FALSE
else
echo ISXRI: 1=On 0=Off
break
}
case Combat
{
break
}
case Heal
{
break
}
case PowerHeal
{
break
}
case Cure
{
break
}
case Res
{
break
}
case Buff
{
break
}
}
}
*/


int __cdecl CMD_ReloadBots(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//reload whichever bot is running
	/*if (strOgreBotBuffer == "TRUE")
	{
		//printf("ISXRI: Reloading OgreBot");
		pISInterface->ExecuteTimedCommand(1, "ogre reloadbot");
	}*/
	if (strTHGBotBuffer == "TRUE")
	{
		//printf("ISXRI: Reloading THGBot");
		pISInterface->ExecuteTimedCommand(1, "Endscript ${THGBotScriptName}");
		pISInterface->ExecuteTimedCommand(1000, "THGBot");
	}
	if (strEQ2BotBuffer == "TRUE")
	{
		//printf("ISXRI: Reloading EQ2Bot");
		pISInterface->ExecuteTimedCommand(1, "Endscript EQ2Bot");
		pISInterface->ExecuteTimedCommand(1000, "Run EQ2Bot");
	}
	if (strCombatBotBuffer == "TRUE")
	{
		//printf("ISXRI: Reloading CombatBot");
		pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:ReloadBot");
	}

	return 1;
}
int __cdecl CMD_EndBots(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//reload whichever bot is running
	/*if (strOgreBotBuffer == "TRUE")
	{
		//printf("ISXRI: Ending OgreBot");
		pISInterface->ExecuteTimedCommand(1, "Endscript Buffer:OgreBot");
	}*/
	if (strTHGBotBuffer == "TRUE")
	{
		//printf("ISXRI: Ending THGBot");
		pISInterface->ExecuteTimedCommand(1, "Endscript ${THGBotScriptName}");
	}
	if (strEQ2BotBuffer == "TRUE")
	{
		//printf("ISXRI: Ending EQ2Bot");
		pISInterface->ExecuteTimedCommand(1, "Endscript EQ2Bot");
	}
	if (strCombatBotBuffer == "TRUE")
	{
		//printf("ISXRI: Ending CombatBot");
		pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:EndBot");
	}

	return 1;
}
void CAM()
{
	char charMaintainedBuffer[10];
	pISInterface->DataParse("${Me.CountMaintained}", charMaintainedBuffer, sizeof(charMaintainedBuffer));
	int intMaintainedBuffer = atoi(charMaintainedBuffer);
	//printf("Result: %s", charMaintainedBuffer);
	int counter = 0;
	for (counter = 1; counter <= intMaintainedBuffer; counter++)
	{
		char buffer[10];
		_itoa_s(counter, buffer, _countof(buffer), 10);
		string b;
		b = buffer;
		string c = "${Me.Ability[${Me.Maintained[" + b + "].Name}](exists)}";
		//string d = "echo ${Me.Maintained[" + b + "].Name}";
		//printf("Result: %s", c);
		//pISInterface->ExecuteCommand(d.c_str());
		char charMaintainedAbilityExistsBuffer[10];
		pISInterface->DataParse(c.c_str(), charMaintainedAbilityExistsBuffer, sizeof(charMaintainedAbilityExistsBuffer));
		//printf("Result: %s", charMaintainedAbilityExistsBuffer);
		string strMaintainedAbilityExistsBuffer = charMaintainedAbilityExistsBuffer;
		if (strMaintainedAbilityExistsBuffer == "TRUE")
		{
			string a = "Me.Maintained[" + b + "]:Cancel";
			//printf("Result: %s", a.c_str());
			pISInterface->ExecuteCommand(a.c_str());
		}
	}
	return;
}
//need to recode this to use a thread and wait for 
int __cdecl CMD_CancelAllMaintained(int argc, char *argv[])
{
	//printf("Debug:Canceling Maintained");
	
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//determine whichever bot is running
	/*if (strOgreBotBuffer == "TRUE")
	{
		pISInterface->ExecuteTimedCommand(1, "Endscript Buffer:OgreBot");
	}*/
	if (strTHGBotBuffer == "TRUE")
	{
		
		CAM();
	}
	if (strEQ2BotBuffer == "TRUE")
	{
		
		CAM();
	}
	if (strCombatBotBuffer == "TRUE")
	{
		
		pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:CancelAllMaintained");
	}

	return 1;
}


int __cdecl CMD_FoodDrinkConsume(int argc, char *argv[])
{
	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);
		char charFoodBuffer[10];
		pISInterface->DataParse("${Me.Equipment[Food].AutoConsumeOn}", charFoodBuffer, sizeof(charFoodBuffer));
		string strFoodBuffer = charFoodBuffer;
		char charDrinkBuffer[10];
		pISInterface->DataParse("${Me.Equipment[Drink].AutoConsumeOn}", charDrinkBuffer, sizeof(charDrinkBuffer));
		string strDrinkBuffer = charDrinkBuffer;
		//if intArg is 1 turn food and drink on
		if (intArg == 1)
		{
			if (strFoodBuffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Equipment[Food]:ToggleAutoConsume");
			if (strDrinkBuffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Equipment[Drink]:ToggleAutoConsume");
		}

		//else if intArg is 0 turn food and drink off
		else if (intArg == 0)
		{
			if (strFoodBuffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Equipment[Food]:ToggleAutoConsume");
			if (strDrinkBuffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Equipment[Drink]:ToggleAutoConsume");
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_FoodDrinkConsume int OnOff  1 == On 0 = Off", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_FoodDrinkConsume int OnOff  1 == On 0 = Off");
	return 1;
}
int __cdecl CMD_PoisonConsume(int argc, char *argv[])
{
	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);
		char charPoison1Buffer[10];
		pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison1Name}\"].AutoConsumeOn}", charPoison1Buffer, sizeof(charPoison1Buffer));
		string strPoison1Buffer = charPoison1Buffer;
		char charPoison2Buffer[10];
		pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison2Name}\"].AutoConsumeOn}", charPoison2Buffer, sizeof(charPoison2Buffer));
		string strPoison2Buffer = charPoison2Buffer;
		char charPoison3Buffer[10];
		pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison3Name}\"].AutoConsumeOn}", charPoison3Buffer, sizeof(charPoison3Buffer));
		string strPoison3Buffer = charPoison3Buffer;
		char charPoison4Buffer[10];
		pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison4Name}\"].AutoConsumeOn}", charPoison4Buffer, sizeof(charPoison4Buffer));
		string strPoison4Buffer = charPoison4Buffer;
		char charPoison5Buffer[10];
		pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison3Name}\"].AutoConsumeOn}", charPoison5Buffer, sizeof(charPoison5Buffer));
		string strPoison5Buffer = charPoison5Buffer;
		//if intArg is 1 turn poison's on
		if (intArg == 1)
		{
			if (strPoison1Buffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison1Name}\"]:ToggleAutoConsume");
			if (strPoison2Buffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison2Name}\"]:ToggleAutoConsume");
			if (strPoison3Buffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison3Name}\"]:ToggleAutoConsume");
			if (strPoison4Buffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison4Name}\"]:ToggleAutoConsume");
			if (strPoison5Buffer == "FALSE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison5Name}\"]:ToggleAutoConsume");
		}

		//else if intArg is 0 turn poison's off
		else if (intArg == 0)
		{
			if (strPoison1Buffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison1Name}\"]:ToggleAutoConsume");
			if (strPoison2Buffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison2Name}\"]:ToggleAutoConsume");
			if (strPoison3Buffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison3Name}\"]:ToggleAutoConsume");
			if (strPoison4Buffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison4Name}\"]:ToggleAutoConsume");
			if (strPoison5Buffer == "TRUE")
				pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_Poison5Name}\"]:ToggleAutoConsume");
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_PoisonConsume int OnOff  1 == On 0 = Off", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_PoisonConsume int OnOff  1 == On 0 = Off");
	return 1;
}
int __cdecl CMD_PotionConsume(int argc, char *argv[])
{
	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);
		//char charArchetypeBuffer[20];
	//	pISInterface->DataParse("${Me.Archetype}", charArchetypeBuffer, sizeof(charArchetypeBuffer));
		//string strArchetypeBuffer = charArchetypeBuffer;
	//	printf("Archetype: %s", charArchetypeBuffer);


		//if intArg is 1 turn food and drink on
		if (intArg == 1)
		{
			//if (strArchetypeBuffer == "fighter")
		//	{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_PotionName}\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "FALSE")
				{
					//printf("TurnOn");
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name=-\"${RI_Var_String_PotionName}\"]:ToggleAutoConsume");
				}
			/*}
			if (strArchetypeBuffer == "priest")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Piety\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "FALSE")
				{
					//printf("TjrnOn");
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Piety\"]:ToggleAutoConsume");
				}
			}
			if (strArchetypeBuffer == "scout")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Deftness\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "FALSE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Deftness\"]:ToggleAutoConsume");
			}
			if (strArchetypeBuffer == "mage")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Intellect\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "FALSE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Intellect\"]:ToggleAutoConsume");
			}*/
		}

		//else if intArg is 0 turn food and drink off
		else if (intArg == 0)
		{
			//if (strArchetypeBuffer == "fighter")
			//{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[Query, Location==\"Inventory\" && Name==\"${RI_Var_String_PotionName}\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "TRUE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[Query, Location==\"Inventory\" && Name==\"${RI_Var_String_PotionName}\"]:ToggleAutoConsume");
			/*}
			if (strArchetypeBuffer == "priest")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Piety\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "TRUE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Piety\"]:ToggleAutoConsume");
			}
			if (strArchetypeBuffer == "scout")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Deftness\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "TRUE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Deftness\"]:ToggleAutoConsume");
			}
			if (strArchetypeBuffer == "mage")
			{
				char charPotionBuffer[10];
				pISInterface->DataParse("${Me.Inventory[\"Elixir of Intellect\"].AutoConsumeOn}", charPotionBuffer, sizeof(charPotionBuffer));
				string strPotionBuffer = charPotionBuffer;
				if (strPotionBuffer == "TRUE")
					pISInterface->ExecuteTimedCommand(1, "Me.Inventory[\"Elixir of Intellect\"]:ToggleAutoConsume");
			}*/
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_PotionConsume int OnOff  1 == On 0 = Off", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_PotionConsume int OnOff  1 == On 0 = Off");
	return 1;
}
int __cdecl CMD_Assisting(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);

		//if intArg2 is 1 enable assisting
		if (intArg == 1)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Enabling Assist");
				pISInterface->ExecuteTimedCommand(1, "OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_settings_assist TRUE");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Enabling Assist");
				if (argc > 2)
				{
					string a = argv[2];
					string ab = "THGBotChangeAssist " + a;
					pISInterface->ExecuteTimedCommand(1, ab.c_str());
				}
				else
				{
					pISInterface->ExecuteTimedCommand(1, "THGBotChangeAssist 1");
				}
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Enable Assist");
				if (argc > 2)
				{
					string a = argv[2];
					string ab = "RI_Obj_CB:Assist[1," + a + "]";
					pISInterface->ExecuteTimedCommand(1, ab.c_str());
				}
				else
				{
					pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:Assist[1]");
				}
			}
		}

		//else if intArg2 is 0 Disable assisting
		else if (intArg == 0)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Disabling Assist");
				pISInterface->ExecuteTimedCommand(1, "OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_settings_assist FALSE");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Disabling Assist");
				pISInterface->ExecuteTimedCommand(1, "THGBotChangeAssist 0");
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Disabling Assist");
				pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:Assist[0]");
			}
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_Assisting int OnOff  1 == On 2 = Off string AssistName(optional)", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_Assisting int OnOff  1 == On 2 = Off string AssistName(optional)");
	return 1;
}
int __cdecl CMD_AbilityEnableDisable(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 2)
	{
		//cast argv[1] to an int for checking
		int intArg2 = atoi(argv[2]);
		
		//if intArg2 is 1 enable ability
		if (intArg2 == 1)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Enabling %s", argv[1]);
				string a = argv[1];
				string ab = "OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem \"" + a + "\" TRUE";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Enabling %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "THGBotDisableAbility \"" + a + "\" " + b;
				//printf("Result %s", ab);
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Enabling %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[\"" + a + "\"," + b + "]";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
		}

		//else if intArg2 is 0 Disable ability
		else if (intArg2 == 0)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Disabling %s", argv[1]);
				string a = argv[1];
				string ab = "OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem \"" + a + "\" FALSE";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Disabling %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "THGBotDisableAbility \"" + a + "\" " + b;
				//printf("Result %s", ab);
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				printf("ISXRI: EQ2Bot: Currently does not have this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Disabling %s", argv[1]);
				string a = argv[1];
				string b = argv[2];
				string ab = "RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[\"" + a + "\"," + b + "]";
				pISInterface->ExecuteTimedCommand(1, ab.c_str());
			}
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_AbilityEnableDisable string AbilityName int EnableDisable  1 == Enable 0 == Disable", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_AbilityEnableDisable string AbilityName int EnableDisable  1 == Enable 0 == Disable");
	return 1;
}
int __cdecl CMD_PauseRIMovement(int argc, char *argv[])
{
	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);

		//if intArg is 1 pause whichever bot is running
		if (intArg == 1)
		{
			pISInterface->ExecuteTimedCommand(1, "RI_Var_Bool_RIMPaused:Set[TRUE]");
			pISInterface->ExecuteTimedCommand(1, "RI_Var_Bool_AutoRunning:Set[FALSE]");
			pISInterface->ExecuteTimedCommand(2, "UIElement[Pause@Titlebar@RIMovement]:SetText[Resume]");
			pISInterface->ExecuteTimedCommand(3, "Script[Buffer:RIMovement]:Pause");
			pISInterface->ExecuteTimedCommand(3, "press ${RI_Var_String_BackwardKey}");
			//stop holding any commonly held buttons
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_ForwardKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_BackwardKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_SwimUpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_JumpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_FlyUpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_FlyDownKey}");
		}
		//else if intArg is 0 unpause whichever bot is running
		else if (intArg == 0)
		{
			pISInterface->ExecuteTimedCommand(1, "RI_Var_Bool_RIMPaused:Set[FALSE]");
			pISInterface->ExecuteTimedCommand(2, "UIElement[Pause@Titlebar@RIMovement]:SetText[Pause]");
			pISInterface->ExecuteTimedCommand(3, "Script[Buffer:RIMovement]:Resume");
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_PauseRIMovement int PauseUnPause  1 == Pause 0 = UnPause", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_PauseRIMovement int PauseUnPause  1 == Pause 0 = UnPause");
	return 1;
}
int __cdecl CMD_PauseRI(int argc, char* argv[])
{
	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);

		//if intArg is 1 pause whichever bot is running
		if (intArg == 1)
		{
			pISInterface->ExecuteTimedCommand(1, "RI_Var_Bool_Paused:Set[TRUE]");
			pISInterface->ExecuteTimedCommand(2, "UIElement[Start@RI]:SetText[Resume]");
			pISInterface->ExecuteTimedCommand(3, "Script[Buffer:RunInstances]:Pause");
			pISInterface->ExecuteTimedCommand(3, "press ${RI_Var_String_BackwardKey}");
			//stop holding any commonly held buttons
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_ForwardKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_BackwardKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_SwimUpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_JumpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_FlyUpKey}");
			pISInterface->ExecuteTimedCommand(4, "press -release ${RI_Var_String_FlyDownKey}");
		}
		//else if intArg is 0 unpause whichever bot is running
		else if (intArg == 0)
		{
			pISInterface->ExecuteTimedCommand(1, "RI_Var_Bool_Paused:Set[FALSE]");
			pISInterface->ExecuteTimedCommand(2, "UIElement[Start@RI]:SetText[Pause]");
			pISInterface->ExecuteTimedCommand(3, "Script[Buffer:RunInstances]:Resume");
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_PauseRI int PauseUnPause  1 == Pause 0 = UnPause", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_PauseRI int PauseUnPause  1 == Pause 0 = UnPause");
	return 1;
}
int __cdecl CMD_ChangeFaceNPC(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);

		//if intArg is 1 pause whichever bot is running
		if (intArg == 1)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Turning on FaceNPC");
				//pISInterface->ExecuteTimedCommand(1, "");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Turning on FaceNPC");
				pISInterface->ExecuteTimedCommand(1, "THGBotChangeFaceNPC ON");
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				//printf("ISXRI: EQ2Bot Does Not Support This Feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Turning on FaceNPC");
				pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:FaceNPC[1]");
			}
		}

		//else if intArg is 0 unpause whichever bot is running
		else if (intArg == 0)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: OgreBot: Turning off FaceNPC");
				//pISInterface->ExecuteTimedCommand(1, "");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: THGBot: Turning off FaceNPC");
				pISInterface->ExecuteTimedCommand(1, "THGBotChangeFaceNPC OFF");
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				//printf("ISXRI: EQ2Bot Does not Support this feature");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: CombatBot: Turning off FaceNPC");
				pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:FaceNPC[0]");
			}
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_ChangeFaceNPC int OnOff  1 == On 0 = Off", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_ChangeFaceNPC int OnOff  1 == On 0 = Off");
	return 1;
}
int __cdecl CMD_PauseCombatBots(int argc, char *argv[])
{
	//first find which bot is running and save to str
	char charTHGBotBuffer[10];
	pISInterface->DataParse("${Script[${THGBotScriptName}](exists)}", charTHGBotBuffer, sizeof(charTHGBotBuffer));
	//char charOgreBotBuffer[10];
	//pISInterface->DataParse("${Script[Buffer:OgreBot](exists)}", charOgreBotBuffer, sizeof(charOgreBotBuffer));
	char charCombatBotBuffer[10];
	pISInterface->DataParse("${Script[${RI_Var_String_CombatBotScriptName}](exists)}", charCombatBotBuffer, sizeof(charCombatBotBuffer));
	char charEQ2BotBuffer[10];
	pISInterface->DataParse("${Script[EQ2Bot](exists)}", charEQ2BotBuffer, sizeof(charCombatBotBuffer));
	//string strOgreBotBuffer = charOgreBotBuffer;
	string strTHGBotBuffer = charTHGBotBuffer;
	string strCombatBotBuffer = charCombatBotBuffer;
	string strEQ2BotBuffer = charEQ2BotBuffer;

	//if we have more than 1 arg
	if (argc > 1)
	{
		//cast argv[1] to an int for checking
		int intArg = atoi(argv[1]);

		//if intArg is 1 pause whichever bot is running
		if (intArg == 1)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: Pausing OgreBot");
				pISInterface->ExecuteTimedCommand(1, "OgreBotAtom SetBotPauseStatus TRUE");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: Pausing THGBot");
				pISInterface->ExecuteTimedCommand(1, "THGBotPaused:Set[TRUE]");
				pISInterface->ExecuteTimedCommand(2, "UIElement[Start@THGBotUI]:SetText[Resume]");
				pISInterface->ExecuteTimedCommand(3, "Script[${THGBotScriptName}]:Pause");
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				//printf("ISXRI: Pausing EQ2Bot");
				pISInterface->ExecuteTimedCommand(1, "Script[EQ2Bot]:Pause");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: Pausing CombatBot");
				pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:Pause[1]");
			}
		}

		//else if intArg is 0 unpause whichever bot is running
		else if (intArg == 0)
		{
			/*if (strOgreBotBuffer == "TRUE")
			{
				//printf("ISXRI: UnPausing OgreBot");
				pISInterface->ExecuteTimedCommand(1, "OgreBotAtom SetBotPauseStatus FALSE");
			}*/
			if (strTHGBotBuffer == "TRUE")
			{
				//printf("ISXRI: UnPausing THGBot");
				pISInterface->ExecuteTimedCommand(1, "THGBotPaused:Set[FALSE]");
				pISInterface->ExecuteTimedCommand(2, "UIElement[Start@THGBotUI]:SetText[Pause]");
				pISInterface->ExecuteTimedCommand(3, "Script[${THGBotScriptName}]:Resume"); 
			}
			if (strEQ2BotBuffer == "TRUE")
			{
				//printf("ISXRI: UnPausing EQ2Bot");
				pISInterface->ExecuteTimedCommand(1, "Script[EQ2Bot]:Resume");
			}
			if (strCombatBotBuffer == "TRUE")
			{
				//printf("ISXRI: UnPausing CombatBot");
				pISInterface->ExecuteTimedCommand(1, "RI_Obj_CB:Pause[0]");
			}
		}
		else
			printf("ISXRI: Wrong Arg, %s Usage : RI_CMD_PauseCombatBots int PauseUnPause  1 == Pause 0 = UnPause", argv[1]);
	}
	else
		printf("ISXRI: No Args, Usage : RI_CMD_PauseCombatBots int PauseUnPause  1 == Pause 0 = UnPause");
	return 1;
}
int __cdecl CMD_RQ(int argc, char *argv[])
{
	string command;
	if (argc > 1)
	{
		command += "RIMUIObj:RQ[";
		command += argv[1];
		for (int i = 2; i < argc - 1; i++)
		{
			command += ",";
			command += argv[i];
		}
		if (argc > 2)
		{
			command += ",";
			command += argv[argc - 1];
		}
		command += "]";
	}
	else
		command += "RIMUIObj:RQ";

	pISInterface->ExecuteTimedCommand(1, command.c_str());

	return 1;
}

int __cdecl CMD_Evac(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Evac;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Evac", c, sizeof(Evac), 1, &k);
	return 1;
}
int __cdecl CMD_Transmute(int argc, char *argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)Transmute;
	pISInterface->RunScriptFromBuffer("RITransmute", buffer, sizeof(Transmute), argc, args);
	return 0;
}

int __cdecl CMD_Extract(int argc, char *argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)Extract;
	pISInterface->RunScriptFromBuffer("RIExtract", buffer, sizeof(Extract), argc, args);
	return 0;
}

int __cdecl CMD_Auth(int argc, char *argv[])
{
	char *k = (char*)"3rtZdjv7";
	const unsigned char * p = Auth;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Auth", c, sizeof(Auth), 1, &k);
	return 1;
}
int __cdecl CMD_Salvage(int argc, char *argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)Salvage;
	pISInterface->RunScriptFromBuffer("RISalvage", buffer, sizeof(Salvage), argc, args);
	return 0;
}

int __cdecl CMD_RIAutoTarget(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = AutoTarget;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIAutoTarget", c, sizeof(AutoTarget), 1, &k);
	pISInterface->ExecuteTimedCommand(1, "UIElement[RIAutoTarget]:Show");
	return 1;
}
int __cdecl CMD_RIMovement(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RIMovement;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIMovement", c, sizeof(RIMovement), 1, &k);
	return 1;
}
int __cdecl CMD_RICom(int argc, char *argv[])
{
	return 1;
}
/*int __cdecl CMD_RunInstances(int argc, char *argv[])
{
	//printf("Starting RI");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RunInstances;
	const char * c = (const char *)p;
	pISInterface->RunScriptFromBuffer("RunInstances", c, sizeof(RunInstances), argc, key);

	return 1;
}*/

int __cdecl CMD_RunInstances(int argc, char *argv[])
{
	const unsigned char * p = RunInstances;
	const char * c = (const char *)p;

	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RunInstances", c, sizeof(RunInstances), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RunInstances", c, sizeof(RunInstances), argci, argvi);
	}
	return 1;
}

int __cdecl CMD_DeleteMissions(int argc, char *argv[])
{
	const unsigned char * p = DeleteMissions;
	const char * c = (const char *)p;

	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("DeleteMissions", c, sizeof(DeleteMissions), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("DeleteMissions", c, sizeof(DeleteMissions), argci, argvi);
	}
	return 1;
}
int __cdecl CMD_RA(int argc, char *argv[])
{
	const unsigned char * p = Agnostics;
	const char * c = (const char *)p;
		
	if (argc == 3)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], argv[2], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RA", c, sizeof(Agnostics), argci, argvi);
	}
	else if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RA", c, sizeof(Agnostics), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RA", c, sizeof(Agnostics), argci, argvi);
	}
	return 1;
}
int __cdecl CMD_ShareMissions(int argc, char *argv[])
{
	const unsigned char * p = ShareMissions;
	const char * c = (const char *)p;

	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("ShareMissions", c, sizeof(ShareMissions), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", (char*)NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("ShareMissions", c, sizeof(ShareMissions), argci, argvi);
	}
	return 1;
}

int __cdecl CMD_Update(int argc, char *argv[])
{
	NewUpdater();
	updater();

	return 1;
}

int __cdecl CMD_CloseISXRI(int argc, char *argv[])
{
	CloseISXRI();

	return 1;
}
int __cdecl CMD_POTR(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = PotionReplenish;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("PotionReplenish", c, sizeof(PotionReplenish), 1, &k);
	return 1;
}
int __cdecl CMD_PoisonReplenish(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = PoisonReplenish;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("PoisonReplenish", c, sizeof(PoisonReplenish), 1, &k);
	return 1;
}
/*int __cdecl CMD_RZ(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RZ;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RZ", c, sizeof(RZ), 1, &k);
	return 1;
}*/
/*int __cdecl CMD_RZ(int argc, char *argv[])
{
	const unsigned char * p = RZ;
	const char * c = (const char *)p;
	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RZ", c, sizeof(RZ), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RZ", c, sizeof(RZ), argci, argvi);
	}
	return 1;
}*/

int __cdecl CMD_RZo(int argc, char *argv[])
{
	char* args[10];
	/*if (argc > 1024)
	{
		printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
		return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)RZo;
	pISInterface->RunScriptFromBuffer("RZo", buffer, sizeof(RZo), argc, args);
	return 0;
}
int __cdecl CMD_RZ(int argc, char *argv[])
{
	char* args[10];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)RZ;
	pISInterface->RunScriptFromBuffer("RZ", buffer, sizeof(RZ), argc, args);
	return 0;
}
int __cdecl CMD_RIO(int argc, char* argv[])
{
	char* args[10];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char* buffer = (const char*)Overseer;
	pISInterface->RunScriptFromBuffer("RIOverseer", buffer, sizeof(Overseer), argc, args);
	return 0;
}
int __cdecl CMD_RIInventory(int argc, char *argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)RIInventory;
	pISInterface->RunScriptFromBuffer("RIInventory", buffer, sizeof(RIInventory), argc, args);
	return 0;
}
int __cdecl CMD_RIInfuse(int argc, char* argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char* buffer = (const char*)RIInfuse;
	pISInterface->RunScriptFromBuffer("RIInfuse", buffer, sizeof(RIInfuse), argc, args);
	return 0;
}
int __cdecl CMD_RPG(int argc, char *argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)RPG;
	pISInterface->RunScriptFromBuffer("RPG", buffer, sizeof(RPG), argc, args);
	return 0;
}
int __cdecl CMD_RGL(int argc, char *argv[])
{
	char* args[10];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)RIGroupLogin;
	pISInterface->RunScriptFromBuffer("RIGroupLogin", buffer, sizeof(RIGroupLogin), argc, args);
	return 0;
}

int __cdecl CMD_Ascension(int argc, char *argv[])
{
	char* args[10];
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)Ascension;
	pISInterface->RunScriptFromBuffer("RIAscension", buffer, sizeof(Ascension), argc, args);
	return 0;
}
int __cdecl CMD_Harvest(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Harvest;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIHarvest", c, sizeof(Harvest), 1, &k);
	return 1;
}
int __cdecl CMD_AntiAFK(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = AntiAFK;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("AntiAFK", c, sizeof(AntiAFK), 1, &k);
	return 1;
}
int __cdecl CMD_CombatBot(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = CombatBot;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("CombatBot", c, sizeof(CombatBot), 1, &k);
	return 1;
}
int __cdecl CMD_AbilityCheck(int argc, char* argv[])
{
	char* args[1024];
	/*if (argc > 1024)
	{
	printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
	return 0;
	}*/
	//printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char* buffer = (const char*)AbilityCheck;
	pISInterface->RunScriptFromBuffer("AbilityCheck", buffer, sizeof(AbilityCheck), argc, args);
	return 0;
}
int __cdecl CMD_CloseRI(int argc, char *argv[])
{
	printf("ISXRI: Closing RI");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = CloseRI;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("CloseRI", c, sizeof(CloseRI), 1, &k);
	return 1;
}
/*int __cdecl CMD_RILooter(int argc, char *argv[])
{
	printf("ISXRI: Starting RILooter");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RILooter;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RILooter", c, sizeof(RILooter), 1, &k);
	return 1;
}*/
void vCMD_RIS()
{
	//printf("ISXRI: Starting RI");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RI;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RI", c, sizeof(RI), 1, &k);
}
int __cdecl CMD_RIS(int argc, char *argv[])
{
	//printf("ISXRI: Starting RI");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RI;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RI", c, sizeof(RI), 1, &k);

	return 1;
}
int __cdecl CMD_Replenish(int argc, char *argv[])
{
	printf("ISXRI: Starting Replenish");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Replenish;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Replenish", c, sizeof(Replenish), 1, &k);

	return 1;
}
int __cdecl CMD_RelayGroup(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RelayGroup;
	const char * c = (const char *)p;

	printf("ISXRI: Starting RelayGroup");
	pISInterface->RunScriptFromBuffer("RelayGroup", c, sizeof(RelayGroup), 1, &k);

	return 1;
}
int __cdecl CMD_RaidRelayGroup(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RaidRelayGroup;
	const char * c = (const char *)p;

	printf("ISXRI: Starting RaidRelayGroup");
	pISInterface->RunScriptFromBuffer("RaidRelayGroup", c, sizeof(RaidRelayGroup), 1, &k);

	return 1;
}
/*int __cdecl CMD_OgrePlayNice(int argc, char *argv[])
{
	printf("ISXRI: Starting OgrePlayNice");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = OgrePlayNice;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("OgrePlayNice", c, sizeof(OgrePlayNice), 1, &k);
	return 1;
}*/
int __cdecl CMD_Detarget(int argc, char *argv[])
{
	printf("ISXRI: Starting Detarget");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = DeTarget;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("DeTarget", c, sizeof(DeTarget), 1, &k);
	return 1;
}
int __cdecl CMD_Vexven(int argc, char *argv[])
{
	printf("ISXRI: Starting Vexven");
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Vexven;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Vexven", c, sizeof(Vexven), 1, &k);
	return 1;
}

int __cdecl CMD_RoRDisguiseFlute(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RoRDisguiseFlute;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RoRDisguiseFlute", c, sizeof(RoRDisguiseFlute), 1, &k);
	return 1;
}
int __cdecl CMD_RoRDisguiseFluteEnd(int argc, char* argv[])
{
	char charScriptRunning[10];
	pISInterface->DataParse("${Script[Buffer:RoRDisguiseFlute](exists)}", charScriptRunning, sizeof(charScriptRunning));
	string strScriptRunning = charScriptRunning;
	if (strScriptRunning == "TRUE")
	{
		pISInterface->ExecuteTimedCommand(1, "endscript Buffer:RoRDisguiseFlute");
	}
	return 1;
}
int __cdecl CMD_CoT(int argc, char* argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char* p = CoT;
	const char* c = (const char*)p;

	pISInterface->RunScriptFromBuffer("CoT", c, sizeof(CoT), 1, &k);
	return 1;
}
int __cdecl CMD_AggroControl(int argc, char *argv[])
{
	const unsigned char * p = AggroControl;
	const char * c = (const char *)p;
	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("AggroControl", c, sizeof(AggroControl), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("AggroControl", c, sizeof(AggroControl), argci, argvi);
	}
	return 1;
}
int __cdecl CMD_Depot(int argc, char *argv[])
{
	if (argc == 2)
	{
		pISInterface->ExecuteCommand("TimedCommand 1 echo ISXRI: Starting Depot, Depositing all into: ${Actor[argv[1]].Name}");
		pISInterface->ExecuteCommand("TimedCommand 1 eq2ex container deposit_all ${Actor[argv[1]].ID} 0");
		pISInterface->ExecuteCommand("TimedCommand 5 eq2ex container deposit_all ${Actor[argv[1]].ID} 0");
		pISInterface->ExecuteCommand("TimedCommand 10 echo ISXRI: Ending Depot");
	}
	else
	{
		pISInterface->ExecuteCommand("TimedCommand 1 echo ISXRI: Starting Depot, Depositing all into: ${Actor[Depot].Name}");
		pISInterface->ExecuteCommand("TimedCommand 1 eq2ex container deposit_all ${Actor[Depot].ID} 0");
		pISInterface->ExecuteCommand("TimedCommand 5 eq2ex container deposit_all ${Actor[Depot].ID} 0");
		pISInterface->ExecuteCommand("TimedCommand 10 echo ISXRI: Ending Depot");
	}
	
	
	/*char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Depot;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Depot", c, sizeof(Depot), 1, &k);*/
	return 1;
}
int __cdecl CMD_ExecuteCommand(int argc, char *argv[])
{
	//declaration
	string a;
	string b;
	//for loop the amount of argc, copy each argv to a
	for (int i = 1; i < argc; i++)
	{
		b = argv[i];
		if (b.find(" ") != string::npos)
			// there is a space on the string 
			// do something 
		{
			a += "\"" + b + "\" ";
		}
		else
			a += b + " ";
		
	}

	//print the results
	//printf("Result: %s", a.c_str());

	if (argc>1)
		pISInterface->ExecuteCommand(a.c_str());
	return 1;
}
int __cdecl CMD_RIMovementUI(int argc, char *argv[])
{
	pISInterface->ExecuteCommand("RIMUIObj:RIMUILoad");
	return 1;
}
int __cdecl CMD_RILogin(int argc, char *argv[])
{
	const unsigned char * p = RILogin;
	const char * c = (const char *)p;
	if (argc == 3)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], argv[2], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RILogin", c, sizeof(RILogin), argci, argvi);
	}
	else if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RILogin", c, sizeof(RILogin), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RILogin", c, sizeof(RILogin), argci, argvi);
	}
	return 1;
}
/*#include "ArgTest.h"
int __cdecl CMD_ArgTest(int argc, char *argv[])
{
	char* args[1024];
	if (argc > 1024)
	{
		printf("ISXRI: You have exceeded the max amount of arguments please enter less than 1024 arguments");
		return 0;
	}
	printf("ISXRI:Argument Count: %d", argc);
	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)ArgTest;
	pISInterface->RunScriptFromBuffer("ArgTest", buffer, sizeof(ArgTest), argc, args);
	return 0;
}
*/
/*int __cdecl CMD_RIAutoDeity(int argc, char *argv[])
{
	const unsigned char * p = AutoDeity;
	const char * c = (const char *)p;
	if (argc == 3)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], argv[2], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RIAutoDeity", c, sizeof(AutoDeity), argci, argvi);
	}
	else if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RIAutoDeity", c, sizeof(AutoDeity), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RIAutoDeity", c, sizeof(AutoDeity), argci, argvi);
	}
	return 1;
}*/
int __cdecl CMD_Flag(int argc, char *argv[])
{
	const unsigned char * p = Flag;
	const char * c = (const char *)p;
	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("Flag", c, sizeof(Flag), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("Flag", c, sizeof(Flag), argci, argvi);
	}
	return 1;
}
int __cdecl CMD_ZoneReset(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = ZoneReset;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("ZoneReset", c, sizeof(ZoneReset), 1, &k);
	return 1;
}
int __cdecl CMD_RICharList(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RICharList;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RICharList", c, sizeof(RICharList), 1, &k);
	return 1;
}
int __cdecl CMD_Repair(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Repair;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("Repair", c, sizeof(Repair), 1, &k);
	return 1;
}
int __cdecl CMD_RIMobHud(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = RIMobHud;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIMobHud", c, sizeof(RIMobHud), 1, &k);
	return 1;
}
int __cdecl CMD_RIWriteLocs(int argc, char *argv[])
{
	char* args[10];

	args[0] = (char*)"3rtZdjv7";
	for (int i = 1; i < argc; i++)
	{
		args[i] = argv[i];
	}
	const char * buffer = (const char *)WriteLocs;
	pISInterface->RunScriptFromBuffer("RIWriteLocs", buffer, sizeof(WriteLocs), argc, args);
	return 0;
}
/*int __cdecl CMD_RIWriteLocs(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = WriteLocs;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIWriteLocs", c, sizeof(WriteLocs), 1, &k);
	return 1;
}*/
int __cdecl CMD_RIBalance(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = Balance;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("RIBalance", c, sizeof(Balance), 1, &k);
	return 1;
}
int __cdecl CMD_GC(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = GetCharms;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("GetCharms", c, sizeof(GetCharms), 1, &k);
	return 1;
}
int __cdecl CMD_GI(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = GetItems;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("GetItems", c, sizeof(GetItems), 1, &k);
	return 1;
}
int __cdecl CMD_HideEffects(int argc, char *argv[])
{
	char* k = (char*)"3rtZdjv7";
	const unsigned char * p = HideEffects;
	const char * c = (const char *)p;

	pISInterface->RunScriptFromBuffer("HideEffects", c, sizeof(HideEffects), 1, &k);
	return 1;
}
int __cdecl CMD_Collection(int argc, char *argv[])
{
	const unsigned char * p = Collection;
	const char * c = (const char *)p;
	if (argc == 2)
	{
		char* argvi[] = { (char*)"3rtZdjv7", argv[1], NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RICollection", c, sizeof(Collection), argci, argvi);
	}
	else
	{
		char* argvi[] = { (char*)"3rtZdjv7", NULL };
		int argci = sizeof(argvi) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("RICollection", c, sizeof(Collection), argci, argvi);
	}
	return 1;
}

/*int __cdecl CMD_ParamTest(int argci, char *argvi[])
{
	const unsigned char * p = ParamTest;
	const char * c = (const char *)p;
	if (argci == 2)
	{
		char* argv[] = { "3rtZdjv7", argvi[1], NULL };
		int argc = sizeof(argv) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("ParamTest", c, sizeof(ParamTest), argc, argv);
	}
	else
	{
		char* argv[] = { "3rtZdjv7", NULL };
		int argc = sizeof(argv) / sizeof(char*) - 1;
		pISInterface->RunScriptFromBuffer("ParamTest", c, sizeof(ParamTest), argc, argv);
	}
	//our password
	//char b[] = "3rtZdjv7";
	//char* dummy_args[] = { "3rtZdjv7" , NULL};
	//copy b to a and add a space
//	argv = dummy_args;
	
	//argc++;
	//argc++;
	//strcat_s(a, b);
	//strcat_s(a, '\0');

	//for loop the amount of argc, copy each argv to a and a space
	//for (int j = 1; j < argc; j++)
	//{
	//	strcat_s(a, argv[j]);
		//strcat_s(a, '\0');
	//}
	//print the results
	//printf("Result: %s", a);

	//create a pointer to a to pass to RunScriptFromBuffer
	//char *z[]= { *argv };

//	const unsigned char * p = ParamTest;
//	const char * c = (const char *)p;

	
	return 1;
}
/*  TEST FUNCTIONS FOR UPDATER DETERMINING SESSION TO UPDATE ON
void SessionNameISXRI(){

//GetSessionName is not implemented yet.
//char charSessionName[512];
//bool boolGotSessionName = pISInterface->GetSessionName(2, charSessionName, sizeof(charSessionName));
/*if (boolGotSessionName)
{
char charBuffer[1024];
pISInterface->DataParse(charSessionName, charBuffer, sizeof(charBuffer));
printf("Result: %s", charBuffer);
}
else
{
printf("Result: Failed");
}

char charBuffer[1024];
pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
printf("Result: %s", charBuffer);
}
void SessionCountISXRI(){
unsigned long longSessionCount;
longSessionCount = pISInterface->GetSessionCount();
string strSessionCount = to_string(longSessionCount);
printf("Result: %s", strSessionCount.c_str());
}
void ListAllSessionsISXRI(){
//first list my session
char charBuffer[1024];
pISInterface->DataParse("${Session}", charBuffer, sizeof(charBuffer));
printf("Result: %s", charBuffer);

string* strSessions = NULL;  // pointer to a string, intially to nothing.
unsigned long longSessionCount;
longSessionCount = pISInterface->GetSessionCount();
strSessions = new string[longSessionCount];
for (long i = 1; i <= longSessionCount; i++)
{
string strSesh = "${Session[";
strSesh += to_string(i);
strSesh += "]}";
char charBuffer[1024];
pISInterface->DataParse(strSesh.c_str(), charBuffer, sizeof(charBuffer));
strSessions[i] = charBuffer;
printf("Result: %s", strSessions[i].c_str());
}

delete[] strSessions;  //free memory pointed to by strSessions.
strSessions = NULL; //clear strSessions to prevent using invalid memory reference.
}

int __cdecl CMD_ListAllSessionsISXRI(int argc, char *argv[])
{
//printf("Starting ");
ListAllSessionsISXRI();

return 1;
}
int __cdecl CMD_SessionNameISXRI(int argc, char *argv[])
{
//printf("Starting ");
SessionNameISXRI();

return 1;
}
int __cdecl CMD_SessionCountISXRI(int argc, char *argv[])
{
//printf("Starting ");
SessionCountISXRI();

return 1;
}
int __cdecl CMD_DetermineLowestSessionISXRI(int argc, char *argv[])
{
//printf("Starting ");
DetermineLowestSessionISXRI();

return 1;
}
*/
void RegisterCommandsAfterAuth()
{
	CheckForAndLoadISXEQ2();
	vCMD_RIS();
	ScanQuests();
	pISInterface->AddCommand("CloseRI", CMD_CloseRI, true, false);
	pISInterface->AddCommand("RIMovement", CMD_RIMovement, true, false);
	pISInterface->AddCommand("RI_CMD_ExecuteCommand", CMD_ExecuteCommand, true, false);
	pISInterface->AddCommand("RIMovementUI", CMD_RIMovementUI, true, false);
	pISInterface->AddCommand("RIMUI", CMD_RIMovementUI, true, false);
	pISInterface->AddCommand("RI_AntiAFK", CMD_AntiAFK, true, false);
	pISInterface->AddCommand("RI_FDR", CMD_Replenish, true, false);
	pISInterface->AddCommand("RI_FoodDrinkReplenish", CMD_Replenish, true, false);
	pISInterface->AddCommand("RI_PotionReplenish", CMD_POTR, true, false);
	pISInterface->AddCommand("RI_POTR", CMD_POTR, true, false);
	pISInterface->AddCommand("RI_PoisonReplenish", CMD_PoisonReplenish, true, false);
	pISInterface->AddCommand("RI_POSR", CMD_PoisonReplenish, true, false);
	pISInterface->AddCommand("RI_CloseISXRI", CMD_CloseISXRI, true, false);
	pISInterface->AddCommand("RI_ZoneReset", CMD_ZoneReset, true, false);
	pISInterface->AddCommand("RI_AggroControl", CMD_AggroControl, true, false);
	pISInterface->AddCommand("RI_Depot", CMD_Depot, true, false);
	pISInterface->AddCommand("RI_Evac", CMD_Evac, true, false);
	pISInterface->AddCommand("RILC", CMD_RILogin, true, false);
	pISInterface->AddCommand("RI_Repair", CMD_Repair, true, false);
	pISInterface->AddCommand("RI_Flag", CMD_Flag, true, false);
	pISInterface->AddCommand("RIMobHud", CMD_RIMobHud, true, false);
	pISInterface->AddCommand("RI_CMD_PauseCombatBots", CMD_PauseCombatBots, true, false);
	pISInterface->AddCommand("RI_CMD_PauseRIMovement", CMD_PauseRIMovement, true, false);
	pISInterface->AddCommand("RI_CMD_PauseRI", CMD_PauseRI, true, false);
	pISInterface->AddCommand("RI_CMD_ReloadBots", CMD_ReloadBots, true, false);
	pISInterface->AddCommand("RI_CMD_EndBots", CMD_EndBots, true, false);
	pISInterface->AddCommand("RI_CMD_AbilityEnableDisable", CMD_AbilityEnableDisable, true, false);
	pISInterface->AddCommand("RI_CMD_AbilityTypeEnableDisable", CMD_AbilityTypeEnableDisable, true, false);
	pISInterface->AddCommand("RI_CMD_Assisting", CMD_Assisting, true, false);
	//pISInterface->AddCommand("RI_CMD_DynamicAssist", CMD_DynamicAssist, true, false);
	pISInterface->AddCommand("RI_CMD_FoodDrinkConsume", CMD_FoodDrinkConsume, true, false);
	pISInterface->AddCommand("RI_CMD_PotionConsume", CMD_PotionConsume, true, false);
	pISInterface->AddCommand("RI_CMD_PoisonConsume", CMD_PoisonConsume, true, false);
	pISInterface->AddCommand("RI_CMD_CancelAllMaintained", CMD_CancelAllMaintained, true, false);
	pISInterface->AddCommand("RI_CMD_Cast", CMD_Cast, true, false);
	pISInterface->AddCommand("RI_CMD_CastOn", CMD_CastOn, true, false);
	pISInterface->AddCommand("RI_CMD_ChangeFaceNPC", CMD_ChangeFaceNPC, true, false);
	
	pISInterface->AddCommand("RI_AutoTarget", CMD_RIAutoTarget, true, false);
	//pISInterface->AddCommand("RI_AutoDeity", CMD_RIAutoDeity, true, false);
	
	pISInterface->AddCommand("RI_Harvest", CMD_Harvest, true, false);
	pISInterface->AddCommand("RI_DeleteMissions", CMD_DeleteMissions, true, false);
	pISInterface->AddCommand("RI_ShareMissions", CMD_ShareMissions, true, false);
	pISInterface->AddCommand("RI_Balance", CMD_RIBalance, true, false);
	pISInterface->AddCommand("RI_HideEffects", CMD_HideEffects, true, false);
	pISInterface->AddCommand("RI_Collection", CMD_Collection, true, false);
	pISInterface->AddCommand("RI_Transmute", CMD_Transmute, true, false);
	pISInterface->AddCommand("RI_Extract", CMD_Extract, true, false);
	pISInterface->AddCommand("RI_Salvage", CMD_Salvage, true, false);
	pISInterface->AddCommand("RI_Ascension", CMD_Ascension, true, false);
	pISInterface->AddCommand("RICharList", CMD_RICharList, true, false);
	pISInterface->AddCommand("RI_CombatBot", CMD_CombatBot, true, false);
	pISInterface->AddCommand("RI_CB", CMD_CombatBot, true, false);
	pISInterface->AddCommand("RI_AbilityCheck", CMD_AbilityCheck, true, false);
	pISInterface->AddCommand("RI_GroupLogin", CMD_RGL, true, false);
	pISInterface->AddCommand("RGL", CMD_RGL, true, false);
	pISInterface->AddCommand("RI_Auth", CMD_Auth, true, false);
	pISInterface->AddCommand("RIO", CMD_RIO, true, false);
	pISInterface->AddCommand("RI_Overseer", CMD_RIO, true, false);

	if (devel || raid)
	{
		pISInterface->AddCommand("RI", CMD_RICom, true, false);
		pISInterface->AddCommand("RQ", CMD_RQ, true, false);
		pISInterface->AddCommand("RA", CMD_RA, true, false);
		pISInterface->AddCommand("RIW", CMD_RIWriteLocs, true, false);
		pISInterface->AddCommand("RI_WriteLocs", CMD_RIWriteLocs, true, false);
		pISInterface->AddCommand("RII", CMD_RIInventory, true, false);
		pISInterface->AddCommand("RIT", CMD_Transmute, true, false);
		pISInterface->AddCommand("RIS", CMD_Salvage, true, false);
		pISInterface->AddCommand("RIE", CMD_Extract, true, false);
		pISInterface->AddCommand("RIF", CMD_RIInfuse, true, false);
		pISInterface->AddCommand("RI_Inventory", CMD_RIInventory, true, false);
		pISInterface->AddCommand("RI_Infuse", CMD_RIInfuse, true, false);
		pISInterface->AddCommand("RI_RunInstances", CMD_RunInstances, true, false);
		pISInterface->AddCommand("RG", CMD_RelayGroup, true, false);
		//pISInterface->AddCommand("RILooter", CMD_RILooter, true, false);
		//pISInterface->AddCommand("OgrePlayNice", CMD_OgrePlayNice, true, false);
		pISInterface->AddCommand("RI_Detarget", CMD_Detarget, true, false);
		//pISInterface->AddCommand("Vexven", CMD_Vexven, true, false);
		pISInterface->AddCommand("RI_RoRDisguiseFlute", CMD_RoRDisguiseFlute, true, false);
		pISInterface->AddCommand("RI_RoRDisguiseFluteEnd", CMD_RoRDisguiseFluteEnd, true, false);
		pISInterface->AddCommand("RI_CoT", CMD_CoT, true, false);
		pISInterface->AddCommand("RZ", CMD_RZ, true, false);
		pISInterface->AddCommand("RZo", CMD_RZo, true, false);
		pISInterface->AddCommand("RRG", CMD_RaidRelayGroup, true, false);
		pISInterface->AddCommand("RPG", CMD_RPG, true, false);
		//*/
	}

	//hidden command
	pISInterface->AddCommand("RI_CMD_Hidden_GetCharms", CMD_GC, true, true);
	pISInterface->AddCommand("RI_CMD_Hidden_GetItems", CMD_GI, true, true);
	pISInterface->AddCommand("RI_CMD_Hidden_AddTLO", CMD_AddTLO, true, true);
	pISInterface->AddCommand("RI_CMD_Hidden_RemoveTLO", CMD_RemoveTLO, true, true);
	pISInterface->AddCommand("RI_CMD_Hidden_RIS", CMD_RIS, true, true);
	pISInterface->AddCommand("RI_CMD_Hidden_ScanQuests", CMD_ScanQuests, true, true);
	//end hidden commands

	//if (combatbot)
	//{
	
	//}
	/*pISInterface->AddCommand("RI_SessionName", CMD_SessionNameISXRI, true, false);
	pISInterface->AddCommand("RI_SessionCount", CMD_SessionCountISXRI, true, false);
	pISInterface->AddCommand("RI_ListAllSessions", CMD_ListAllSessionsISXRI, true, false);
	pISInterface->AddCommand("RI_DetermineLowestSession", CMD_DetermineLowestSessionISXRI, true, false);*/

	//if (heroic)
	//{
	//pISInterface->RemoveCommand("RI");
	
	//}
	//if (raid)
	//{
	

	//pISInterface->AddCommand("ArgTest", CMD_ArgTest, true, false);
	//}
	//if (devel)
	//{
	//}
}

void RegisterTopLevelObjectsAfterAuth()
{
	pISInterface->AddTopLevelObject("Devel", TLO_Devel);
	pISInterface->AddTopLevelObject("PaidMem", TLO_PaidMem);
	pISInterface->AddTopLevelObject("ISXRIVersion", TLO_ISXRIVersion);
	
	//pISInterface->AddTopLevelObject("QuestDirs", TLO_QuestDirs);
	
	/**/
}
bool Loaded = false;
bool VerChecked = false;
bool NewUpdaterB = false;
bool LoadMessageDisplayed = false;
double CurrTime;
void ISXRIPulseNoAuth()
{
	if (!LoadMessageDisplayed)
	{
		printf("ISXRI: Loading version %s", RI_Version);
		printf("ISXRI: For support goto http://forums.isxri.com or visit us on IRC @ #isxri");
		// printf("ISXRI: Authenticating ISXRI");
		LoadMessageDisplayed = true;
	}
	/*
	if (!gotlp)
	{
		//printf("!gotlp if statement");
		if (!gettinglp && pISInterface->GetScriptRuntime("Buffer:Auth") == 0)
		{
			CurrTime = TimeSince();
			if ((CurrTime - LastGotLPTime) > 1)
				getlp(false);
		}
	}
	else if (!Authed)
	{
		//printf("!Authed if statement");
		if (!authenticating)
		{
			//printf("!authenticating if statement");
			if (gotlp && pISInterface->GetScriptRuntime("Buffer:Auth") == 0)
			{
				//printf("!gotlp");

				//Sleep(500);
				//authenticate
				if (!authenticating)
				{
					CurrTime = TimeSince();
					//string test = to_string(CurrTime);
					//printf("%s", test);
					if ((CurrTime - LastAuthTime) > 1)
						auth();
				}
				//Sleep(500);
			}
		}
	}
	else
	{
		/*if (!VerChecked)
		{
			//printf("checking ver");
			//Sleep(500);
			//checkver
			checkver();

			//mark version checked
			VerChecked = true;
			//Sleep(500);
		}
		else if (boolNewVersion)
		{
			updater();
			boolNewVersion = false;
		}
		else if (!boolUpdated && boolNeedUpdate)
		{
			if (!boolAnnouncedUpdate)
			{
				printf("ISXRI: Updating ISXRI.dll");
				pISInterface->ExecuteCommand("relay \"all other\" -noredirect execute \\${If[\\${Extension[ISXRI.dll](exists)},echo ISXRI: Updating ISXRI.dll]}");
				//pISInterface->ExecuteCommand("relay \"all other\" echo ISXRI: Updating ISXRI.dll");
				boolAnnouncedUpdate = true;
			}
			else if (boolRenameWorked)
			{
				if (!boolUpdating)
				{
					boolUpdating = true;
					update();
				}
			}
		}
		else if (!Loaded)
		*/
		if (!Loaded)
		{
			//Sleep(500);
			//register TLO's
			RegisterTopLevelObjectsAfterAuth();


			//register commands
			RegisterCommandsAfterAuth();

			//set loaded true
			Loaded = true;
			//Sleep(500);
		}
		/*
		// Removed the logincheck every 5 mins, need to decide do i want 1 hour or 1 day and change ips to 2? -- changed back to 5mins and fixed it so it does in seperate thread
		//and probably make a DotNetAPP to do the checking so it doesnt freeze the clients, same with Auth and updater.  --- Used CreateThread
		CurrTime = TimeSince();
		if ((CurrTime - LoggedInTime) > 300)//300 = 5 mins, 240 = 4 mins, 360 = 6 mins, 3600= 1 hour, 900=15mins
		{
			//printf("5 mins");
			LoggedIn();
			LoggedInTime = TimeSince();
		}

		}		*/
}
void ISXRIPulseAuth()
{
	try
	{
		if (!LoadMessageDisplayed)
		{
			printf("ISXRI: Loading version %s", RI_Version);
			printf("ISXRI: For support goto http://forums.isxri.com or visit us on IRC @ #isxri");
			printf("ISXRI: Authenticating ISXRI");
			LoadMessageDisplayed = true;
		}
		if (!gotlp)
		{
			//printf("!gotlp if statement");
			if (!gettinglp && pISInterface->GetScriptRuntime("Buffer:Auth") == 0)
			{
				CurrTime = TimeSince();
				if ((CurrTime - LastGotLPTime) > 1)
					getlp(false);
			}
		}
	    if (!Authed)
		{
			//printf("!Authed if statement");
			if (!authenticating)
			{
				//printf("!authenticating if statement");
				if (gotlp && pISInterface->GetScriptRuntime("Buffer:Auth") == 0)
				{
					//printf("!gotlp");

					//Sleep(500);
					//authenticate
					if (!authenticating)
					{
						//printf("!authenticating");
						CurrTime = TimeSince();
						//string test = to_string(CurrTime);
						//printf("%s", test);
						if ((CurrTime - LastAuthTime) > 1)
						{
							//printf("auth()");
							auth();
						}
					}
					//Sleep(500);
				}
			}
		}
		else
		{
			if (!NewUpdaterB)
			{
				//printf("checking ver");
				//Sleep(500);
				//checkver
				NewUpdater();

				//mark version checked
				NewUpdaterB = true;
				//Sleep(500);
			}
			if (!VerChecked)
			{
				//printf("checking ver");
				//Sleep(500);
				//checkver
				checkver();

				//mark version checked
				VerChecked = true;
				//Sleep(500);
			}
			else if (boolNewVersion)
			{
				updater();
				boolNewVersion = false;
			}
			else if (!boolUpdated && boolNeedUpdate)
			{
				if (!boolAnnouncedUpdate)
				{
					printf("ISXRI: Updating ISXRI.dll");
					pISInterface->ExecuteCommand("relay \"all other local\" -noredirect execute \\${If[\\${Extension[ISXRI.dll](exists)},echo ISXRI: Updating ISXRI.dll]}");
					//pISInterface->ExecuteCommand("relay \"all other\" echo ISXRI: Updating ISXRI.dll");
					boolAnnouncedUpdate = true;
				}
				else if (boolRenameWorked)
				{
					if (!boolUpdating)
					{
						boolUpdating = true;
						update();
					}
				}
			}
			else if (!Loaded)
			{
				//Sleep(500);
				//register TLO's
				RegisterTopLevelObjectsAfterAuth();
				//pISInterface->AddTopLevelObject("CoA", TLO_CoA);
				//register commands
				RegisterCommandsAfterAuth();

				//set loaded true
				Loaded = true;
				//Sleep(500);
			}
			// Removed the logincheck every 5 mins, need to decide do i want 1 hour or 1 day and change ips to 2? -- changed back to 5mins and fixed it so it does in seperate thread
			//and probably make a DotNetAPP to do the checking so it doesnt freeze the clients, same with Auth and updater.  --- Fixed, Used CreateThread
			CurrTime = TimeSince();
			if ((CurrTime - LoggedInTime) > 300)//300 = 5 mins, 240 = 4 mins, 360 = 6 mins, 3600= 1 hour, 900=15mins
			{
				//printf("5 mins");
				LoggedIn();
				LoggedInTime = TimeSince();
			}
		}
	}
	catch (exception e1) {
		// catch block catches the exception that is thrown from try block

		string error = e1.what();
		printf(error.c_str());
	}
}

void ISXRIShutdown()
{
	// LogOut();
	ISXRIUnRegisterCommands();
	ISXRIUnRegisterTLOs();
	/*DWORD *gecThreadP;
	GetExitCodeThread(threadHandle,gecThreadP);
	DWORD gecThread = *gecThreadP;
	TerminateThread(threadHandle,gecThread);*/
	printf("ISXRI: Version %s unloaded", RI_Version);
}


//*
//
//
//
// END ISXRI CustomCode
//
//
//
//




#pragma comment(lib,"isxdk.lib")
// The mandatory pre-setup function.  Our name is "ISXRI", and the class is ISXRI.
// This sets up a "ModulePath" variable which contains the path to this module in case we want it,
// and a "PluginLog" variable, which contains the path and filename of what we should use for our
// debug logging if we need it.  It also sets up a variable "pExtension" which is the pointer to
// our instanced class.
ISXPreSetup("ISXRI",ISXRI);

// Basic LavishScript datatypes, these get retrieved on startup by our initialize function, so we can
// use them in our Top-Level Objects or custom datatypes
LSType *pStringType=0;
LSType *pIntType=0;
LSType *pUintType=0;
LSType *pBoolType=0;
LSType *pFloatType=0;
LSType *pTimeType=0;
LSType *pByteType=0;
LSType *pIntPtrType=0;
LSType *pBoolPtrType=0;
LSType *pFloatPtrType=0;
LSType *pBytePtrType=0;

ISInterface *pISInterface=0;
HISXSERVICE hPulseService;
HISXSERVICE hMemoryService;
HISXSERVICE hHTTPService;
HISXSERVICE hTriggerService;
HISXSERVICE hSystemService;

// Forward declarations of callbacks
void __cdecl PulseService(bool Broadcast, unsigned int MSG, void *lpData);
void __cdecl MemoryService(bool Broadcast, unsigned int MSG, void *lpData);
void __cdecl TriggerService(bool Broadcast, unsigned int MSG, void *lpData);
void __cdecl HTTPService(bool Broadcast, unsigned int MSG, void *lpData);
void __cdecl SystemService(bool Broadcast, unsigned int MSG, void *lpData);

// The constructor of our class.  General initialization cannot be done yet, because we're not given
// the pointer to the Inner Space interface until it is ready for us to initialize.  Just set the
// pointer we have to the interface to 0.  Initialize data members, too.
ISXRI::ISXRI(void)
{
}

// Free any remaining resources in the destructor.  This is called when the DLL is unloaded, but
// Inner Space calls the "Shutdown" function first.  Most if not all of the shutdown process should
// be done in Shutdown.
ISXRI::~ISXRI(void)
{
}

// Initialize is called by Inner Space when the extension should initialize.
bool ISXRI::Initialize(ISInterface *p_ISInterface)
{
	/* 
	 * Most of the functionality in Initialize is completely optional and could be removed or
	 * changed if so desired.  The defaults are simply a suggestion that can be easily followed.
	 */

	//GetFileNameAndPath();
	
	__try // exception handling. See __except below.
	{
		
		// Keep a global copy of the ISInterface pointer, which is for calling Inner Space API
		pISInterface=p_ISInterface;
		
		// Register the extension to make launching and updating the extension easy
		RegisterExtension();

		// retrieve basic LavishScript data types for use in ISXRI data types
		pStringType=pISInterface->FindLSType((char*)"string");
		pIntType=pISInterface->FindLSType((char*)"int");
		pUintType=pISInterface->FindLSType((char*)"uint");
		pBoolType=pISInterface->FindLSType((char*)"bool");
		pFloatType=pISInterface->FindLSType((char*)"float");
		pTimeType=pISInterface->FindLSType((char*)"time");
		pByteType=pISInterface->FindLSType((char*)"byte");
		pIntPtrType=pISInterface->FindLSType((char*)"intptr");
		pBoolPtrType=pISInterface->FindLSType((char*)"boolptr");
		pFloatPtrType=pISInterface->FindLSType((char*)"floatptr");
		pBytePtrType=pISInterface->FindLSType((char*)"byteptr");

		// Connect to commonly used Inner Space services
		ConnectServices();
		
		// Register LavishScript extensions (commands, aliases, data types, objects)
		RegisterCommands();
		//RegisterAliases();
		//RegisterDataTypes();
		//RegisterTopLevelObjects();

		// Register (create) our own services
		//RegisterServices();

		// Register any text triggers built into ISXRI
		//RegisterTriggers();

		return true;
	}

	// Exception handling sample.  Exception handling should at LEAST be used in functions that
	// are suspected of causing user crashes.  This will help users report the crash and hopefully
	// enable the extension developer to locate and fix the crash condition.
	__except(EzCrashFilter(GetExceptionInformation(),"Crash in initialize routine")) 
	{
		TerminateProcess(GetCurrentProcess(),0);
		return 0;
	}
	/* 
	 * EzCrashFilter takes printf-style formatting after the first parameter.  The above
	 * could look something like this:
	__except(EzCrashFilter(GetExceptionInformation(),"Crash in initialize routine (%s:%d)",__FILE__,__LINE__)) 
	{
		TerminateProcess(GetCurrentProcess(),0);
		return 0;
	}
	 * of course, the FILE and LINE macros would be the location of the exception handler, not the
	 * actual crash, but you should get the idea that extra parameters can be used as if EzCrashFilter
	 * was printf.
	 *
	 * EzCrashFilter will automatically produce a crash log (CrashLog.txt) and open it in notepad for
	 * non-breakpoint exceptions (and hopefully the user will report the crash to the extension developer).  
	 * Your exception handler (the part within the {} under __except) should simply terminate the process 
	 * and return from the function as in the sample.  The return will not be hit, but the compiler will 
	 * whine without it because it doesn't automatically know that the function will not return.  
	 */

}

// shutdown sequence
void ISXRI::Shutdown()
{
	//close scripts
	CMD_CloseRI(0, 0);
	// Disconnect from services we connected to
	DisconnectServices();

	// Unregister (destroy) services we created
	//UnRegisterServices();

	// Remove LavishScript extensions (commands, aliases, data types, objects)
	UnRegisterTopLevelObjects();
	//UnRegisterDataTypes();
	//UnRegisterAliases();
	UnRegisterCommands();
	//LogOut();
	ISXRIShutdown();
}

/*
 * Note that Initialize and Shutdown are the only two REQUIRED functions in your ISXInterface class.
 * All others are for suggested breakdown of routines, and for example purposes.
 */

void ISXRI::RegisterExtension()
{
	// add this extension to, or update this extension's info in, InnerSpace.xml.
	// This accomplishes a few things.  A) The extension can be loaded by name (ISXRI)
	// no matter where it resides on the system.  B) A script or extension can
	// check a repository to determine if there is an update available (and update
	// if necessary)

	unsigned int ExtensionSetGUID=pISInterface->GetExtensionSetGUID("ISXRI");
	if (!ExtensionSetGUID)
	{
		ExtensionSetGUID=pISInterface->CreateExtensionSet("ISXRI");
		if (!ExtensionSetGUID)
			return;
	}
	pISInterface->SetSetting(ExtensionSetGUID,"Filename",ModuleFileName);
	pISInterface->SetSetting(ExtensionSetGUID,"Path",ModulePath);
	pISInterface->SetSetting(ExtensionSetGUID,"Version",RI_Version);
}

void ISXRI::ConnectServices()
{
	// connect to any services.  Here we connect to "Pulse" which receives a
	// message every frame (after the frame is displayed) and "Memory" which
	// wraps "detours" and memory modifications
	hPulseService=pISInterface->ConnectService(this,"Pulse",PulseService);
	hMemoryService=pISInterface->ConnectService(this,"Memory",MemoryService);

	// The HTTP service handles URL retrieval
	hHTTPService=pISInterface->ConnectService(this,"HTTP",HTTPService);

	// The Triggers service handles trigger-related functions, including the
	// ability to pass text TO the trigger parser, as well as the ability to
	// add triggers.
	hTriggerService=pISInterface->ConnectService(this,"Triggers",TriggerService);

	// The System service provides general system-related services, including
	// a diagnostics message that allows the extension to insert diagnostic
	// information for the "diagnostics" command, and extension crash logs.
	hSystemService=pISInterface->ConnectService(this,"System",SystemService);
}

void ISXRI::RegisterCommands()
{
	// add any commands
	//pISInterface->AddCommand("ISXRI",CMD_ISXRI,true,false);
	pISInterface->AddCommand("RI_Update", CMD_Update, true, false);
#define COMMAND(name,cmd,parse,hide) pISInterface->AddCommand(name,cmd,parse,hide);
#include "Commands.h"
#undef COMMAND
}
void ISXRI::RegisterAliases()
{
	// add any aliases
}

void ISXRI::RegisterDataTypes()
{
	// add any datatypes
	// pMyType = new MyType;
	// pISInterface->AddLSType(*pMyType);

#define DATATYPE(_class_,_variable_,_inherits_) _variable_ = new _class_; pISInterface->AddLSType(*_variable_); _variable_->SetInheritance(_inherits_);
#include "DataTypeList.h"
#undef DATATYPE
}

void ISXRI::RegisterTopLevelObjects()
{
	// add any Top-Level Objects
	//pISInterface->AddTopLevelObject("ISXRI",TLO_ISXRI);
#define TOPLEVELOBJECT(name,funcname) pISInterface->AddTopLevelObject(name,funcname);
#include "TopLevelObjects.h"
#undef TOPLEVELOBJECT
}
void ISXRI::RegisterServices()
{
	// register any services.  Here we demonstrate a service that does not use a
	// callback
	// set up a 1-way service (broadcast only)
//	hISXRIService=pISInterface->RegisterService(this,"ISXRI Service",0);
	// broadcast a message, which is worthless at this point because nobody will receive it
	// (nobody has had a chance to connect)
//	pISInterface->ServiceBroadcast(this,hISXRIService,ISXSERVICE_MSG+1,0);

#define SERVICE(_name_,_callback_,_variable_) _variable_=pISInterface->RegisterService(this,_name_,_callback_);
#include "Services.h"
#undef SERVICE
}

void ISXRI::RegisterTriggers()
{
	// add any Triggers
}

void ISXRI::DisconnectServices()
{
	// gracefully disconnect from services
	if (hPulseService)
		pISInterface->DisconnectService(this,hPulseService);
	if (hMemoryService)
	{
		pISInterface->DisconnectService(this,hMemoryService);
		// memory modifications are automatically undone when disconnecting
		// also, since this service accepts messages from clients we should reset our handle to
		// 0 to make sure we dont try to continue using it
		hMemoryService=0; 
	}
	if (hHTTPService)
	{
		pISInterface->DisconnectService(this,hHTTPService);
	}
	if (hTriggerService)
	{
		pISInterface->DisconnectService(this,hTriggerService);
	}
	if (hSystemService)
	{
		pISInterface->DisconnectService(this,hSystemService);
	}
}

void ISXRI::UnRegisterCommands()
{
	// remove commands
//	pISInterface->RemoveCommand("ISXRI");
	

	
#define COMMAND(name,cmd,parse,hide) pISInterface->RemoveCommand(name);
#include "Commands.h"
#undef COMMAND
}
void ISXRI::UnRegisterAliases()
{
	// remove aliases
}
void ISXRI::UnRegisterDataTypes()
{
	// remove data types
#define DATATYPE(_class_,_variable_,_inherits_) pISInterface->RemoveLSType(*_variable_); delete _variable_;
#include "DataTypeList.h"
#undef DATATYPE

}
void ISXRI::UnRegisterTopLevelObjects()
{
	// remove Top-Level Objects
	//	pISInterface->RemoveTopLevelObject("ISXRI");


#define TOPLEVELOBJECT(name,funcname) pISInterface->RemoveTopLevelObject(name);
#include "TopLevelObjects.h"
#undef TOPLEVELOBJECT
}

void ISXRI::UnRegisterServices()
{
	// shutdown our own services
//	if (hISXRIService)
//		pISInterface->ShutdownService(this,hISXRIService);

#define SERVICE(_name_,_callback_,_variable_) _variable_=pISInterface->ShutdownService(this,_variable_);
#include "Services.h"
#undef SERVICE
}

void __cdecl PulseService(bool Broadcast, unsigned int MSG, void *lpData)
{
	if (MSG == PULSE_PULSE)
	{
		/*
		 * "OnPulse"
		 * This message is received by the extension before each frame is
		 * displayed by the game.  This is the place to put any repeating
		 * tasks.
		 */
		//ISXRIPulseNoAuth();
		ISXRIPulseAuth();
	}
}

void __cdecl MemoryService(bool Broadcast, unsigned int MSG, void *lpData)
{
	// no messages are currently associated with this service (other than
	// system messages such as client disconnect), so do nothing.
}

void __cdecl TriggerService(bool Broadcast, unsigned int MSG, void *lpData)
{
	// no messages are currently associated with this service (other than
	// system messages such as client disconnect), so do nothing.
}

void __cdecl SystemService(bool Broadcast, unsigned int MSG, void *lpData)
{
	if (MSG==SYSTEMSERVICE_DIAGNOSTICS)
	{
		// Diagnostics sample
		/*
		FILE *file=(FILE*)lpData;
		fprintf(file,"ISXRI version %s\n",EXTENSION_VERSION);
		fprintf(file,"------------------------------------\n",EXTENSION_VERSION);
		fprintf(file,"Any ISXRI diagnostic information here\n");
		fprintf(file,"\n");// extra spacing for making the crash log look nice
		/**/
	}
}

void __cdecl HTTPService(bool Broadcast, unsigned int MSG, void *lpData)
{
	switch(MSG)
	{
#define pReq ((HttpFile*)lpData)
	case HTTPSERVICE_FAILURE:
		// HTTP request failed to retrieve document
		printf("ISXRI URL %s failed",pReq->URL);
		break;
	case HTTPSERVICE_SUCCESS:
		// HTTP request successfully retrieved document
		printf("ISXRI URL %s -- %d bytes",pReq->URL,pReq->Size);
		// Retrieved data buffer is pReq->pBuffer and is null-terminated
		break;
#undef pReq
	}
}

