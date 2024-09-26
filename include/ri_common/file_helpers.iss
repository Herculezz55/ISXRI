#ifndef _RI_file_helpers_
#define _RI_file_helpers_

objectdef FileHelpers
{
    static member:string GetDirectoryFromFilePath(string fullPathToFile)
    {
        variable int lastTokenNum = ${Math.Calc[${fullPathToFile.Count["/"]} + 1]}
        return ${fullPathToFile.ReplaceSubstring["${fullPathToFile.Token[${lastTokenNum}, "/"]}", ""]}
    }
}

#endif