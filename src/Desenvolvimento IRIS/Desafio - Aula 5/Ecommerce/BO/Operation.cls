Class Ecommerce.BO.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Ecommerce.BO.Msg.Request">
    <Method>RecupDadosCredito</Method>
  </MapItem>
</MapItems>
}

Method RecupDadosCredito(pRequest As Ecommerce.BO.Msg.Request, Output pResponse As Ecommerce.BO.Msg.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(Ecommerce.BO.Msg.Response).%New()
    
    SET tSQL = "SELECT c.Nome, s.TipoAvaliacao, s.Indicador, s.Score " _
               "FROM Ecommerce_Data.Cliente c " _
               "JOIN Ecommerce_Data.ScoreCredito s ON c.CodigoCliente = s.CodigoCliente " _
               "WHERE c.CodigoCliente = ? AND s.Indicador = ?"
               
    SET tStatement = ##class(%SQL.Statement).%New()
    SET tStatus = tStatement.%Prepare(tSQL)
    
    IF $$$ISOK(tStatus) {
        SET tResultSet = tStatement.%Execute(pRequest.CodigoCliente, pRequest.Indicador)
        IF tResultSet.%Next() {
            SET pResponse.Nome = tResultSet.%Get("Nome")
            SET pResponse.TipoAvaliacao = tResultSet.%Get("TipoAvaliacao")
            SET pResponse.Indicador = tResultSet.%Get("Indicador")
            SET pResponse.Score = tResultSet.%Get("Score")
        }
    }
    
    QUIT status
}

}