Class Ecommerce.BS.AvaliaCredito Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, pHint As %String = "") As %Status
{
    SET status = $$$OK
    
    SET tCodigoCliente = pInput
    SET tIndicador = pHint
    
    SET tRequest = ##class(Ecommerce.BP.Msg.Request).%New()
    SET tRequest.CodigoCliente = tCodigoCliente
    SET tRequest.Indicador = tIndicador
    
    SET status = ..SendRequestSync("Avalia Credito BP", tRequest, .pOutput)
    
    QUIT status
}

}