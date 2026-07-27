Class trans.BO.DetalhesPedido.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Request">
    <Method>Cliente</Method>
  </MapItem>
</MapItems>
}

Method Cliente(pRequest As trans.BO.DetalhesPedido.Cliente.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Response) As %Status
{
    Set tSC = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Response).%New()
    
    If pRequest.CodigoCliente '= "" {
        Set pResponse.Message = "Cliente " _ pRequest.NomeEmpresa _ " (Cod: " _ pRequest.CodigoCliente _ ") processado com sucesso!"
    } Else {
        Set pResponse.Message = "Aviso: Codigo do cliente nao informado."
    }

    Quit tSC
}

}
