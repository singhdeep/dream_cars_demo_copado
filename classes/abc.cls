public class abc
{
//devOps testing1 12 April
public Account a {get; set;}

public abc()
{
a = new Account();
}
Public PageReference Save()
{
Insert a;
PageReference redirecturl = new PageReference('/' +a.id);
return redirecturl;
}
}