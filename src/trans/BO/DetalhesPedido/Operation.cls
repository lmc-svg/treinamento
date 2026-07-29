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
    SET tSC = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Response).%New()
    
    // Validação dos campos obrigatórios
    IF pRequest.CodigoCliente = "" { SET pResponse.Message = "Erro: O campo CodigoCliente nao foi preenchido!" Quit tSC }
    IF pRequest.NomeEmpresa   = "" { SET pResponse.Message = "Erro: O campo NomeEmpresa nao foi preenchido!" Quit tSC }
    IF pRequest.NomeContato   = "" { SET pResponse.Message = "Erro: O campo NomeContato nao foi preenchido!" Quit tSC }
    IF pRequest.Endereco      = "" { SET pResponse.Message = "Erro: O campo Endereco nao foi preenchido!" Quit tSC }
    IF pRequest.CEP           = "" { SET pResponse.Message = "Erro: O campo CEP nao foi preenchido!" Quit tSC }
    IF pRequest.Cidade        = "" { SET pResponse.Message = "Erro: O campo Cidade nao foi preenchido!" Quit tSC }
    IF pRequest.Estado        = "" { SET pResponse.Message = "Erro: O campo Estado nao foi preenchido!" Quit tSC }
    IF pRequest.EnderecoEmail = "" { SET pResponse.Message = "Erro: O campo EnderecoEmail nao foi preenchido!" Quit tSC }
    
    SET objCliente = ##class(TRE.DATA.Cliente).%New()
    SET objCliente.CodigoCliente = pRequest.CodigoCliente
    SET objCliente.NomeEmpresa   = pRequest.NomeEmpresa
    SET objCliente.NomeContato   = pRequest.NomeContato
    SET objCliente.Endereco      = pRequest.Endereco
    SET objCliente.CEP           = pRequest.CEP
    SET objCliente.Cidade        = pRequest.Cidade
    SET objCliente.Estado        = pRequest.Estado
    SET objCliente.EnderecoEmail = pRequest.EnderecoEmail
    
    SET tSC = objCliente.%Save()
    
    IF $$$ISOK(tSC) {
        SET pResponse.Message = "Cliente " _ pRequest.NomeEmpresa _ " salvo com SUCESSO na tabela TRE.DATA.Cliente!"
    } Else {
        SET pResponse.Message = "Erro ao salvar cliente no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    QUIT tSC
}

Method Destino(pRequest As trans.BO.DetalhesPedido.Destino.Request, Output pResponse As trans.BO.DetalhesPedido.Destino.Response) As %Status
{
    SET tSC = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Destino.Response).%New()
    
    // Validação dos campos obrigatórios
    IF pRequest.CodigoDestino    = "" { SET pResponse.Message = "Erro: O campo CodigoDestino nao foi preenchido!" Quit tSC }
    IF pRequest.CEPInicial       = "" { SET pResponse.Message = "Erro: O campo CEPInicial nao foi preenchido!" Quit tSC }
    IF pRequest.CEPFinal         = "" { SET pResponse.Message = "Erro: O campo CEPFinal nao foi preenchido!" Quit tSC }
    IF pRequest.PrazoEntregaDias = "" { SET pResponse.Message = "Erro: O campo PrazoEntregaDias nao foi preenchido!" Quit tSC }
    
    SET objDestino = ##class(TRE.DATA.Destino).%New()
    SET objDestino.CodigoDestino    = pRequest.CodigoDestino
    SET objDestino.CEPInicial       = pRequest.CEPInicial
    SET objDestino.CEPFinal         = pRequest.CEPFinal
    SET objDestino.PrazoEntregaDias = pRequest.PrazoEntregaDias
    
    SET tSC = objDestino.%Save()
    
    IF $$$ISOK(tSC) {
        SET pResponse.Message = "Destino " _ pRequest.CodigoDestino _ " salvo com SUCESSO na tabela TRE.DATA.Destino!"
    } Else {
        SET pResponse.Message = "Erro ao salvar destino no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    Quit tSC
}

Method Pedido(pRequest As trans.BO.DetalhesPedido.Pedido.Request, Output pResponse As trans.BO.DetalhesPedido.Pedido.Response) As %Status
{
    SET tSC = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Pedido.Response).%New()
    
    // Validação dos campos obrigatórios
    IF pRequest.CodigoPedido        = "" { SET pResponse.Message = "Erro: O campo CodigoPedido nao foi preenchido!" Quit tSC }
    IF pRequest.DataPedido          = "" { SET pResponse.Message = "Erro: O campo DataPedido nao foi preenchido!" Quit tSC }
    IF pRequest.CodigoCliente       = "" { SET pResponse.Message = "Erro: O campo CodigoCliente nao foi preenchido!" Quit tSC }
    IF pRequest.ValorPedido         = "" { SET pResponse.Message = "Erro: O campo ValorPedido nao foi preenchido!" Quit tSC }
    IF pRequest.PesoKG              = "" { SET pResponse.Message = "Erro: O campo PesoKG nao foi preenchido!" Quit tSC }
    IF pRequest.Volumes             = "" { SET pResponse.Message = "Erro: O campo Volumes nao foi preenchido!" Quit tSC }
    IF pRequest.CodigoTransportadora = "" { SET pResponse.Message = "Erro: O campo CodigoTransportadora nao foi preenchido!" Quit tSC }
    If pRequest.DataPrevisaoEntrega = "" { SET pResponse.Message = "Erro: O campo DataPrevisaoEntrega nao foi preenchido!" Quit tSC }
    
    SET objPedido = ##class(TRE.DATA.Pedido).%New()
    SET objPedido.CodigoPedido        = pRequest.CodigoPedido
    
    // Trata conversão de data se necessário
    TRY {
        IF pRequest.DataPedido [ "-" { SET objPedido.DataPedido = $zdh(pRequest.DataPedido, 3) }
        ELSEIF pRequest.DataPedido [ "/" { SET objPedido.DataPedido = $zdh(pRequest.DataPedido, 4) }
        ELSE { SET objPedido.DataPedido = pRequest.DataPedido }
    } Catch {
        SET objPedido.DataPedido = +$h
    }
    
    SET objPedido.CodigoCliente       = pRequest.CodigoCliente
    SET objPedido.ValorPedido         = pRequest.ValorPedido
    SET objPedido.PesoKG              = pRequest.PesoKG
    SET objPedido.Volumes             = pRequest.Volumes
    SET objPedido.CodigoTransportadora = pRequest.CodigoTransportadora
    
    TRY {
        IF pRequest.DataPrevisaoEntrega [ "-" { SET objPedido.DataPrevisaoEntrega = $zdh(pRequest.DataPrevisaoEntrega, 3) }
        ELSEIF pRequest.DataPrevisaoEntrega [ "/" { SET objPedido.DataPrevisaoEntrega = $zdh(pRequest.DataPrevisaoEntrega, 4) }
        ELSE { SET objPedido.DataPrevisaoEntrega = pRequest.DataPrevisaoEntrega }
    } Catch {
        SET objPedido.DataPrevisaoEntrega = +$h
    }
    
    SET tSC = objPedido.%Save()
    
    If $$$ISOK(tSC) {
        SET pResponse.Message = "Pedido " _ pRequest.CodigoPedido _ " salvo com SUCESSO na tabela TRE.DATA.Pedido!"
    } Else {
        SET pResponse.Message = "Erro ao salvar pedido no banco: " _ $system.Status.GetOneErrorText(tSC)
    }

    QUIT tSC
}

}