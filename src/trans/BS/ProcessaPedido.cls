Class trans.BS.ProcessaPedido Extends EnsLib.SOAP.Service
{

/// O serviço SOAP NÃO usa adaptador de entrada!
Parameter ADAPTER = "";

Parameter SERVICENAME = "ProcessaPedidos";

Parameter LOCATION = "http://localhost:52773/csp/treinamento";

Parameter NAMESPACE = "http://tempuri.org";

Method ProcessaPedido(pCodigoPedido As %String) As trans.VO.ConfirmaPedido [ WebMethod ]
{
    Set pResponseVO = ##class(trans.VO.ConfirmaPedido).%New()
    Set status = ..OnProcessInput(pCodigoPedido, .pResponseVO)
    
    If '$IsObject(pResponseVO) {
        Set pResponseVO = ##class(trans.VO.ConfirmaPedido).%New()
    }
    
    Quit pResponseVO
}

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    Set status = $$$OK
    Set pOutput = ##class(trans.VO.ConfirmaPedido).%New()
    
    Set requestBP = ##class(trans.BP.ProcessaTransporte.Request).%New()
    Set requestBP.CodigoPedido = pInput
    
    Set status = ..SendRequestSync("ProcessaTransporteCustom", requestBP, .responseBP)
    
    If $$$ISOK(status) && $IsObject($Get(responseBP)) {
    Set pOutput.Status = responseBP.Status
    Set pOutput.CodigoTransp = responseBP.CodigoTransp
    
    // Converte de Horolog para DD/MM/YYYY (opcional)
    If responseBP.DataPrevisaoEntrega '= "" {
        Set pOutput.DataPrevisaoEntrega = $ZDATE(responseBP.DataPrevisaoEntrega, 4)
    }
}
    
    Quit status
}

}