Class trans.BO.DetalhesSpeedy.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request">
    <Method>VerificaDestinoSpeedy</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request">
    <Method>RecupPrazoEntrega</Method>
  </MapItem>
</MapItems>
}

/// Exercício 4: Método VerificaDestinoSpeedy
Method VerificaDestinoSpeedy(pRequest As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request, Output pResponse As trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response) As %Status
{
    SET tSC = $SYSTEM.Status.OK()
    SET pResponse = ##class(trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response).%New()
    SET pResponse.AtendidoSpeedy = 0
    
    TRY
    {
        IF pRequest.Cep5n = "" {
            QUIT
        }
        
        SET tStatement = ##class(%SQL.Statement).%New()
        SET vQuery = "SELECT CodigoDestino FROM TRE_DATA.Destino WHERE ? BETWEEN CEPInicial AND CEPFinal"
        SET tStatus = tStatement.%Prepare(vQuery)
        
        IF $$$ISOK(tStatus) {
            SET tResult = tStatement.%Execute(pRequest.Cep5n)
            IF tResult.%Next() {
                SET pResponse.AtendidoSpeedy = 1
            }
        }
    }
    CATCH ex
    {
        $$$TRACE("Error VerificaDestinoSpeedy " _ ex.DisplayString())
        SET tSC = ex.AsStatus()
    }
    
    QUIT tSC
}

/// Exercício 6: Método RecupPrazoEntrega
Method RecupPrazoEntrega(pRequest As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request, Output pResponse As trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response) As %Status
{
    SET tSC = $SYSTEM.Status.OK()
    SET pResponse = ##class(trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response).%New()
    
    TRY
    {
        IF pRequest.Cep5n = "" {
            QUIT
        }
        
        SET tStatement = ##class(%SQL.Statement).%New()
        SET vQuery = "SELECT PrazoEntregaDias FROM TRE_DATA.Destino WHERE ? BETWEEN CEPInicial AND CEPFinal"
        SET tStatus = tStatement.%Prepare(vQuery)
        
        IF $$$ISOK(tStatus) {
            SET tResult = tStatement.%Execute(pRequest.Cep5n)
            IF tResult.%Next() {
                SET pResponse.PrazoEntregaDias = tResult.%GetData(1)
            }
        }
    }
    CATCH ex
    {
        $$$TRACE("Error RecupPrazoEntrega " _ ex.DisplayString())
        SET tSC = ex.AsStatus()
    }
    
    QUIT tSC
}

}