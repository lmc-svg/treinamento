Class trans.BS.DetalhesCliente Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, pMethod As %String = "") As %Status
{
    SET status = $$$OK
    SET tRequest = ##class(trans.BP.DetalhesCliente.msg.Request).%New()
    
    // Normaliza para maiúsculas (GET, POST, PUT, DELETE)
    SET tRequest.Metodo = $ZCONVERT(pMethod, "U")
    SET tRequest.DATA = pInput
    
    // Envia síncrono para o BP com o nome lógico correto
    SET status = ..SendRequestSync("ProcessCliente", tRequest, .tResponse)
    
    IF $$$ISOK(status) && $IsObject($Get(tResponse)) {
        SET pOutput = tResponse
    } ELSE {
        // Se der erro no BP/BO, retorna o status de erro para a API capturar
        If $$$ISERR(status) {
            QUIT status
        }
    }
    
    QUIT status
}

}