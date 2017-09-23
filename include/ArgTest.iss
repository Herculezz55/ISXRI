function main(... args)
{
	echo Args: ${args.Used}
	variable int count
	for(count:Set[1];${count}<=${args.Used};count:Inc)
	{
		echo ${count}: ${args[${count}]}
	}
	
}