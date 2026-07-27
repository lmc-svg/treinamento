Class trans.BO.DetalhesPedido.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Request">
    <Method>Cliente</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesPedido.Destino.Request">
    <Method>Destino</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesPedido.Pedido.Request">
    <Method>Pedido</Method>
  </MapItem>
</MapItems>
}

Method Cliente(pRequest As trans.BO.DetalhesPedido.Cliente.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Response) As %Status
{
    Set tSC = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Response).%New()
    
    Set objCliente = ##class(TRE.DATA.Cliente).%New()
    Set objCliente.CodigoCliente = pRequest.CodigoCliente
    Set objCliente.NomeEmpresa   = pRequest.NomeEmpresa
    Set objCliente.NomeContato   = pRequest.NomeContato
    Set objCliente.Endereco      = pRequest.Endereco
    Set objCliente.CEP           = pRequest.CEP
    Set objCliente.Cidade        = pRequest.Cidade
    Set objCliente.Estado        = pRequest.Estado
    Set objCliente.EnderecoEmail = pRequest.EnderecoEmail
    
    Set tSC = objCliente.%Save()
    
    If $$$ISOK(tSC) {
        Set pResponse.Message = "Cliente " _ pRequest.NomeEmpresa _ " salvo com SUCESSO na tabela TRE.DATA.Cliente!"
    } Else {
        Set pResponse.Message = "Erro ao salvar cliente no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    Quit tSC
}

Method Destino(pRequest As trans.BO.DetalhesPedido.Destino.Request, Output pResponse As trans.BO.DetalhesPedido.Destino.Response) As %Status
{
    Set tSC = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Destino.Response).%New()
    
    Set objDestino = ##class(TRE.DATA.Destino).%New()
    Set objDestino.CodigoDestino    = pRequest.CodigoDestino
    Set objDestino.CEPInicial       = pRequest.CEPInicial
    Set objDestino.CEPFinal         = pRequest.CEPFinal
    Set objDestino.PrazoEntregaDias = pRequest.PrazoEntregaDias
    
    Set tSC = objDestino.%Save()
    
    If $$$ISOK(tSC) {
        Set pResponse.Message = "Destino " _ pRequest.CodigoDestino _ " salvo com SUCESSO na tabela TRE.DATA.Destino!"
    } Else {
        Set pResponse.Message = "Erro ao salvar destino no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    Quit tSC
}

Method Pedido(pRequest As trans.BO.DetalhesPedido.Pedido.Request, Output pResponse As trans.BO.DetalhesPedido.Pedido.Response) As %Status
{
    Set tSC = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Pedido.Response).%New()
    
    Set objPedido = ##class(TRE.DATA.Pedido).%New()
    Set objPedido.CodigoPedido        = pRequest.CodigoPedido
    Set objPedido.DataPedido          = pRequest.DataPedido
    Set objPedido.CodigoCliente       = pRequest.CodigoCliente
    Set objPedido.ValorPedido         = pRequest.ValorPedido
    Set objPedido.PesoKG              = pRequest.PesoKG
    Set objPedido.Volumes             = pRequest.Volumes
    Set objPedido.CodigoTransportadora = pRequest.CodigoTransportadora
    Set objPedido.DataPrevisaoEntrega = pRequest.DataPrevisaoEntrega
    
    Set tSC = objPedido.%Save()
    
    If $$$ISOK(tSC) {
        Set pResponse.Message = "Pedido " _ pRequest.CodigoPedido _ " salvo com SUCESSO na tabela TRE.DATA.Pedido!"
    } Else {
        Set pResponse.Message = "Erro ao salvar pedido no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    Quit tSC
}

}