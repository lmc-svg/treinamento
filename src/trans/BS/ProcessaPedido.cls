Class trans.BS.ProcessaPedido Extends EnsLib.SOAP.Service
{

/// O serviço SOAP NÃO usa adaptador de entrada!
Parameter ADAPTER = "";

Parameter SERVICENAME = "ProcessaPedidos";

Parameter LOCATION = "http://localhost:52773/csp/treinamento";

Parameter NAMESPACE = "http://tempuri.org";

Method ProcessaPedido(pCodigoPedido As %String) As trans.VO.ConfirmaPedido [ WebMethod ]
{
    SET pResponseVO = ##class(trans.VO.ConfirmaPedido).%New()
    SET status = ..OnProcessInput(pCodigoPedido, .pResponseVO)
    
    IF '$IsObject(pResponseVO) {
        SET pResponseVO = ##class(trans.VO.ConfirmaPedido).%New()
    }
    
    QUIT pResponseVO
}

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    SET status = $$$OK
    SET pOutput = ##class(trans.VO.ConfirmaPedido).%New()
    
    SET requestBP = ##class(trans.BP.ProcessaTransporte.Request).%New()
    SET requestBP.CodigoPedido = pInput
    
    SET status = ..SendRequestSync("ProcessaTransporteCustom", requestBP, .responseBP)
    
    IF $$$ISOK(status) && $IsObject($Get(responseBP)) {
    SET pOutput.Status = responseBP.Status
    SET pOutput.CodigoTransp = responseBP.CodigoTransp
    
    // Converte de Horolog para DD/MM/YYYY (opcional)
    IF responseBP.DataPrevisaoEntrega '= "" {
        SET pOutput.DataPrevisaoEntrega = $ZDATE(responseBP.DataPrevisaoEntrega, 4)
    }
}
    
    QUIT status
}

}