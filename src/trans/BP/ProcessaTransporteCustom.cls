Class trans.BP.ProcessaTransporteCustom Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As trans.BP.ProcessaTransporte.Request, Output pResponse As trans.BP.ProcessaTransporte.Response) As %Status
{
    SET status = $$$OK

    TRY {
        SET pResponse = ##class(trans.BP.ProcessaTransporte.Response).%New()

        SET callrequest = ##class(trans.BO.RecupDetalhesPedidos.Request).%New()
        SET callrequest.CodigoPedido = pRequest.CodigoPedido
        SET callresponse = ##class(trans.BO.RecupDetalhesPedidos.Response).%New()
        SET status = ..ChamaDetalhesPedido(callrequest, .callresponse)
        IF $$$ISERR(status) Quit

        IF (callresponse.CEP = "") {
            SET pResponse.Status = 0
            QUIT
        } ELSE {
            SET pResponse.Status = 1
        }

        SET cep = callresponse.CEP
        SET pesoKg = callresponse.PesoKg
        SET Cep5n = $Piece(cep, "-", 1)
        SET callrequestSpeedy = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request).%New()
        SET callrequestSpeedy.Cep5n = Cep5n
        SET callresponseSpeedy = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response).%New()

        SET status = ..ChamaVerificaDestinoSpeedy(callrequestSpeedy, .callresponseSpeedy)
        IF $$$ISERR(status) Quit

        SET AtendidoSpeedy = callresponseSpeedy.AtendidoSpeedy
        SET callrequestPrazo = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request).%New()
        SET callrequestPrazo.Cep5n = Cep5n
        SET callresponsePrazo = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response).%New()
        SET status = ..ChamaRecupPrazoEntrega(callrequestPrazo, .callresponsePrazo)
        IF $$$ISERR(status) Quit

        SET PrazoEntregaDias = callresponsePrazo.PrazoEntregaDias

        IF ((AtendidoSpeedy = 1) && (pesoKg <= 50)) {
            // Speedy
            SET pResponse.CodigoTransp = 1
            // a) DataPrevisaoEntrega = Data Atual + PrazoEntregaDias
            SET pResponse.DataPrevisaoEntrega = $Piece($Horolog, ",", 1) + PrazoEntregaDias
        } ELSE {
            // Flex
            SET pResponse.CodigoTransp = 2
            // b) DataPrevisaoEntrega = Data Atual + 5
            SET pResponse.DataPrevisaoEntrega = $Piece($Horolog, ",", 1) + 5
        }

    } Catch ex {
        // Captura o status da exceção e relança
        SET status = ex.AsStatus()
    }

    QUIT status
}

Method ChamaDetalhesPedido(pRequest As trans.BO.RecupDetalhesPedidos.Request, Output pResponse As trans.BO.RecupDetalhesPedidos.Response) As %Status
{
    SET status = ..SendRequestSync("Detalha Pedidos BO", pRequest, .pResponse)
    QUIT status
}

Method ChamaVerificaDestinoSpeedy(pRequest As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request, Output pResponse As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response) As %Status
{
    SET status = ..SendRequestSync("Detalhes Speedy BO", pRequest, .pResponse)
    QUIT status
}

Method ChamaRecupPrazoEntrega(pRequest As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request, Output pResponse As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response) As %Status
{
    SET status = ..SendRequestSync("Detalhes Speedy BO", pRequest, .pResponse)
    QUIT status
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}