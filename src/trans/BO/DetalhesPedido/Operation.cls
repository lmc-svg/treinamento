Class trans.BO.DetalhesPedido.Operation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Get.Request">
    <Method>Get</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Post.Request">
    <Method>Post</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Put.Request">
    <Method>Put</Method>
  </MapItem>
  <MapItem MessageType="trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request">
    <Method>Delete</Method>
  </MapItem>
</MapItems>
}

/// 1. CONSULTAR CLIENTE NO BANCO (GET)
Method Get(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Get.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Get.Response) As %Status
{
    Set status = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Response).%New()
    
    Set tNomeContato = pRequest.DATA
    
    Set tSQL = "SELECT Id, CodigoCliente, NomeEmpresa, NomeContato, Endereco, CEP, Cidade, Estado, EnderecoEmail FROM TRE_DATA.Cliente"
    If (tNomeContato '= "") {
        Set tSQL = tSQL _ " WHERE NomeContato LIKE '%" _ tNomeContato _ "%'"
    }
    
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tStatus = tStatement.%Prepare(tSQL)
    
    If $$$ISOK(tStatus) {
        Set tResultSet = tStatement.%Execute()
        Set tArr = []
        
        While tResultSet.%Next() {
            Set tObj = {}
            Set tObj.Id = tResultSet.%Get("Id")
            Set tObj.CodigoCliente = tResultSet.%Get("CodigoCliente")
            Set tObj.NomeEmpresa = tResultSet.%Get("NomeEmpresa")
            Set tObj.NomeContato = tResultSet.%Get("NomeContato")
            Set tObj.Endereco = tResultSet.%Get("Endereco")
            Set tObj.CEP = tResultSet.%Get("CEP")
            Set tObj.Cidade = tResultSet.%Get("Cidade")
            Set tObj.Estado = tResultSet.%Get("Estado")
            Set tObj.EnderecoEmail = tResultSet.%Get("EnderecoEmail")
            
            Do tArr.%Push(tObj)
        }
        
        If (tArr.%Size() > 0) {
            Set pResponse.Status = 0
            Set pResponse.Contents = tArr.%ToJSON()
        } Else {
            Set pResponse.Status = 1
            Set pResponse.Contents = "{""message"": ""Nenhum cliente encontrado.""}"
        }
    } Else {
        Set pResponse.Status = 2
        Set pResponse.Contents = "{""error"": ""Erro ao consultar no banco de dados.""}"
    }
    
    Quit status
}

/// 2. INCLUIR CLIENTE NO BANCO (POST)
Method Post(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Post.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Post.Response) As %Status
{
    Set status = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Response).%New()
    
    Try {
        Set tJSON = {}.%FromJSON(pRequest.DATA)
        Set tCliente = ##class(TRE.DATA.Cliente).%New()
        
        Set tCliente.CodigoCliente = tJSON.CodigoCliente
        Set tCliente.NomeEmpresa   = tJSON.NomeEmpresa
        Set tCliente.NomeContato   = tJSON.NomeContato
        Set tCliente.Endereco      = tJSON.Endereco
        Set tCliente.CEP           = tJSON.CEP
        Set tCliente.Cidade        = tJSON.Cidade
        Set tCliente.Estado        = tJSON.Estado
        Set tCliente.EnderecoEmail = tJSON.EnderecoEmail
        
        Set tSaveStatus = tCliente.%Save()
        
        If $$$ISOK(tSaveStatus) {
            Set pResponse.Status = 0
            Set pResponse.Contents = "{""message"": ""Cliente salvo no banco com sucesso!"", ""Id"": """ _ tCliente.%Id() _ """}"
        } Else {
            Set pResponse.Status = 1
            Set pResponse.Contents = "{""error"": ""Erro ao salvar dados do cliente.""}"
        }
    } Catch ex {
        Set pResponse.Status = 2
        Set pResponse.Contents = "{""error"": ""JSON de entrada invalido ou erro interno.""}"
    }
    
    Quit status
}

/// 3. ATUALIZAR CLIENTE NO BANCO (PUT)
Method Put(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Put.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Put.Response) As %Status
{
    Set status = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Response).%New()
    
    // Garante um valor padrão para o Status caso dê falha
    Set pResponse.Status = 0
    
    Try {
        Set tJSON = {}.%FromJSON(pRequest.DATA)
        Set tId = tJSON.Id
        
        If (tId '= "") && ##class(TRE.DATA.Cliente).%ExistsId(tId) {
            Set tCliente = ##class(TRE.DATA.Cliente).%OpenId(tId)
            
            If (tJSON.NomeEmpresa '= "") Set tCliente.NomeEmpresa = tJSON.NomeEmpresa
            If (tJSON.NomeContato '= "") Set tCliente.NomeContato = tJSON.NomeContato
            If (tJSON.Endereco '= "")    Set tCliente.Endereco    = tJSON.Endereco
            If (tJSON.CEP '= "")         Set tCliente.CEP         = tJSON.CEP
            If (tJSON.Cidade '= "")      Set tCliente.Cidade      = tJSON.Cidade
            If (tJSON.Estado '= "")      Set tCliente.Estado      = tJSON.Estado
            If (tJSON.EnderecoEmail '= "") Set tCliente.EnderecoEmail = tJSON.EnderecoEmail
            
            Set tSaveStatus = tCliente.%Save()
            
            If $$$ISOK(tSaveStatus) {
                Set pResponse.Status = 0
                Set pResponse.Contents = "{""message"": ""Cliente ID " _ tId _ " atualizado com sucesso!""}"
            } Else {
                Set pResponse.Status = 1
                Set pResponse.Contents = "{""error"": ""Erro ao atualizar registro no banco.""}"
            }
        } Else {
            Set pResponse.Status = 1
            Set pResponse.Contents = "{""message"": ""Cliente com o ID informado nao foi encontrado.""}"
        }
    } Catch ex {
        Set pResponse.Status = 2
        Set pResponse.Contents = "{""error"": ""JSON de entrada invalido ou erro interno.""}"
    }
    
    Quit status
}

/// 4. EXCLUIR CLIENTE DO BANCO (DELETE)
Method Delete(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response) As %Status
{
    Set status = $$$OK
    Set pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response).%New()
    
    Set tId = pRequest.DATA
    
    If (tId '= "") && ##class(TRE.DATA.Cliente).%ExistsId(tId) {
        Set tDelStatus = ##class(TRE.DATA.Cliente).%DeleteId(tId)
        
        If $$$ISOK(tDelStatus) {
            Set pResponse.Status = 0
            Set pResponse.Contents = "{""message"": ""Cliente ID " _ tId _ " excluido com sucesso!""}"
        } Else {
            Set pResponse.Status = 1
            Set pResponse.Contents = "{""error"": ""Erro ao excluir o registro no banco.""}"
        }
    } Else {
        Set pResponse.Status = 1
        Set pResponse.Contents = "{""message"": ""ID nao encontrado para exclusao.""}"
    }
    
    Quit status
}

}