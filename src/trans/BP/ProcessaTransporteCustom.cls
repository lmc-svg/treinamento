Class trans.BP.ProcessaTransporteCustom Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As trans.BP.ProcessaTransporte.Request, Output pResponse As trans.BP.ProcessaTransporte.Response) As %Status
{
    Set pResponse = ##class(trans.BP.ProcessaTransporte.Response).%New()
    QUIT $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}