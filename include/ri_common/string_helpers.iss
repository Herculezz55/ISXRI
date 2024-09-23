#ifndef _RI_STRING_HELPERS_
#define _RI_STRING_HELPERS_
objectdef RIStringHelpers
{

    ;;;
    ;;; Returns the last word in a string
    ;;; @param str The string to get the last word from
    ;;; @return The last word in the string
    static member:string GetLastWord(string str)
    {
        variable int tokenCount = ${str.Count[" "]}
        return ${str.Token[${tokenCount:Inc}, " "].Trim}
    }

    ;;;
    ;;; Checks if the given string appears to be a roman numeral
    ;;; @param value The string to check
    ;;; @return TRUE if the string appears to be a roman numeral, FALSE otherwise
    static member:bool IsRomanNumearl(string value)
    {
        variable int currentIndex
        for (currentIndex:Set[1] ; ${currentIndex} < ${value.Length} ; currentIndex:Inc)
        {
            if !${value.Mid[${currentIndex}, 1].Equal["i"]} && !${value.Mid[${currentIndex}, 1].Equal["v"]} && !${value.Mid[${currentIndex}, 1].Equal["x"]}
            {
                return FALSE
            }
        }

        return TRUE
    }

    ;;;
    ;;; Strips roman numerals from the end of a string, andy when working with spell names
    ;;; @param str The string to strip roman numerals from
    ;;; @return The string with roman numerals stripped from the end
    static member:string StripRomanNumerals(string str)
    {
        variable string lastWord = ${RIStringHelpers.GetLastWord[${str}]}


        if ${RIStringHelpers.IsRomanNumearl[${lastWord}]}
        {
            variable int baseStringLength
            baseStringLength:Set[${str.Length} - ${lastWord.Length}]
            return ${str.Mid[1, ${baseStringLength}].Trim}
        }
        
        return ${str}
    }
}
#endif