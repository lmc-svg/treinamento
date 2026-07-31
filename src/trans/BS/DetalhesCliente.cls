Class trans.BS.DetalhesCliente Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, pMethod As %String = "") As %Status
{
    Set status = $$$OK
    Set tRequest = ##class(trans.BP.DetalhesCliente.msg.Request).%New()
    
    // Normaliza para maiúsculas (GET, POST, PUT, DELETE)
    Set tRequest.Metodo = $ZCONVERT(pMethod, "U")
    Set tRequest.DATA = pInput
    
    // Envia síncrono para o BP com o nome lógico correto
    Set status = ..SendRequestSync("ProcessCliente", tRequest, .tResponse)
    
    If $$$ISOK(status) && $IsObject($Get(tResponse)) {
        Set pOutput = tResponse
    } Else {
        // Se der erro no BP/BO, retorna o status de erro para a API capturar
        If $$$ISERR(status) {
            Quit status
        }
    }
    
    Quit status
}

}