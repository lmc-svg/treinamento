Class trans.BO.RecupDetalhesPedidos.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="trans.BO.RecupDetalhesPedidos.Request">
    <Method>RecupDetalhesPedidos</Method>
  </MapItem>
</MapItems>
}

Method RecupDetalhesPedidos(pRequest As trans.BO.RecupDetalhesPedidos.Request, Output pResponse As trans.BO.RecupDetalhesPedidos.Response) As %Status
{
    SET tSC = $SYSTEM.Status.OK()
    SET pResponse = ##class(trans.BO.RecupDetalhesPedidos.Response).%New()

    TRY
    {
        IF pRequest.CodigoPedido = "" {
            QUIT
        }

        // Consulta unindo Pedido e Cliente
        SET vQuery = "SELECT T1.PesoKG, T1.Volumes, T2.Endereco, T2.CEP, T2.Cidade, T2.Estado, T2.EnderecoEmail, T2.NomeEmpresa, T2.NomeContato " _
                     "FROM TRE_DATA.Pedido T1, TRE_DATA.Cliente T2 " _
                     "WHERE T1.CodigoCliente = T2.CodigoCliente " _
                     "AND T1.CodigoPedido = ?"

        SET tStatement = ##class(%SQL.Statement).%New()
        SET tStatus = tStatement.%Prepare(vQuery)

        IF $$$ISOK(tStatus) {
            SET tResult = tStatement.%Execute(pRequest.CodigoPedido)

        IF tResult.%Next() {
            // $TRANSLATE troca qualquer vírgula por ponto no valor retornado do banco
            SET pResponse.PesoKg      = $TRANSLATE(tResult.%GetData(1), ",", ".")
            SET pResponse.Volumes     = tResult.%GetData(2)
            SET pResponse.Endereco    = tResult.%GetData(3)
            SET pResponse.CEP         = tResult.%GetData(4)
            SET pResponse.Cidade      = tResult.%GetData(5)
            SET pResponse.Estado      = tResult.%GetData(6)
            SET pResponse.Email       = tResult.%GetData(7)
            SET pResponse.NomeEmpresa = tResult.%GetData(8)
            SET pResponse.NomeContato = tResult.%GetData(9)
}
        }
    }
    CATCH ex
    {
        $$$TRACE("Error RecupDetalhesPedidos " _ ex.DisplayString())
        SET tSC = ex.AsStatus()
    }

    QUIT tSC
}

}