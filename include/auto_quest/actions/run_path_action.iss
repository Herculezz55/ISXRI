#includeoptional "${LavishScript.HomeDirectory}/Scripts/RI/common/api.iss"

variable(global) RIApi RIApi

function run_path_action(jsonvalueref params)
{
    variable jsoniterator pathIterator
    params.Get["path"]:GetIterator[pathIterator]

    if !${RIApi(exists)}
    {
        echo "RIApi not available"
        
    }

    if !${RINav(exists)}
    {
        echo "RINav not available"
    }

    if ${pathIterator:First(exists)}
    {
        variable point3f nextLocation
        do
        {
            nextLocation:Set[${pathIterator.Value.Get[x]},${pathIterator.Value.Get[y]},${pathIterator.Value.Get[z]}]
            call RIApi.MoveTo "${Me.Name}" "${nextLocation}" 1
            call RIApi.WaitForMoveTo "${Me.Name}" "${nextLocation}" 1
           
        }
        while ${pathIterator:Next(exists)}
    }
}