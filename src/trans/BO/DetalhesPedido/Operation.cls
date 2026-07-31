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

/// 1. CONSULTA CLIENTE NO BANCO (GET)
Method Get(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Get.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Get.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Response).%New()
    
    SET tNomeContato = pRequest.DATA
    
    SET tSQL = "SELECT Id, CodigoCliente, NomeEmpresa, NomeContato, Endereco, CEP, Cidade, Estado, EnderecoEmail FROM TRE_DATA.Cliente"
    IF (tNomeContato '= "") {
        SET tSQL = tSQL _ " WHERE NomeContato LIKE '%" _ tNomeContato _ "%'"
    }
    
    SET tStatement = ##class(%SQL.Statement).%New()
    SET tStatus = tStatement.%Prepare(tSQL)
    
    IF $$$ISOK(tStatus) {
        SET tResultSet = tStatement.%Execute()
        SET tArr = []
        
        WHILE tResultSet.%Next() {
            SET tObj = {}
            SET tObj.Id = tResultSet.%Get("Id")
            SET tObj.CodigoCliente = tResultSet.%Get("CodigoCliente")
            SET tObj.NomeEmpresa = tResultSet.%Get("NomeEmpresa")
            SET tObj.NomeContato = tResultSet.%Get("NomeContato")
            SET tObj.Endereco = tResultSet.%Get("Endereco")
            SET tObj.CEP = tResultSet.%Get("CEP")
            SET tObj.Cidade = tResultSet.%Get("Cidade")
            SET tObj.Estado = tResultSet.%Get("Estado")
            SET tObj.EnderecoEmail = tResultSet.%Get("EnderecoEmail")
            
            DO tArr.%Push(tObj)
        }
        
        IF (tArr.%Size() > 0) {
            SET pResponse.Status = 0
            SET pResponse.Contents = tArr.%ToJSON()
        } ELSE {
            SET pResponse.Status = 1
            SET pResponse.Contents = "{""message"": ""Nenhum cliente encontrado.""}"
        }
    } ELSE {
        SET pResponse.Status = 2
        SET pResponse.Contents = "{""error"": ""Erro ao consultar no banco de dados.""}"
    }
    
    QUIT status
}

/// 2. INCLUI CLIENTE NO BANCO (POST)
Method Post(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Post.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Post.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Response).%New()
    
    TRY {
        SET tJSON = {}.%FromJSON(pRequest.DATA)
        SET tCliente = ##class(TRE.DATA.Cliente).%New()
        
        SET tCliente.CodigoCliente = tJSON.CodigoCliente
        SET tCliente.NomeEmpresa   = tJSON.NomeEmpresa
        SET tCliente.NomeContato   = tJSON.NomeContato
        SET tCliente.Endereco      = tJSON.Endereco
        SET tCliente.CEP           = tJSON.CEP
        SET tCliente.Cidade        = tJSON.Cidade
        SET tCliente.Estado        = tJSON.Estado
        SET tCliente.EnderecoEmail = tJSON.EnderecoEmail
        
        SET tSaveStatus = tCliente.%Save()
        
        IF $$$ISOK(tSaveStatus) {
            SET pResponse.Status = 0
            SET pResponse.Contents = "{""message"": ""Cliente salvo no banco com sucesso!"", ""Id"": """ _ tCliente.%Id() _ """}"
        } ELSE {
            SET pResponse.Status = 1
            SET pResponse.Contents = "{""error"": ""Erro ao salvar dados do cliente.""}"
        }
    } Catch ex {
        SET pResponse.Status = 2
        SET pResponse.Contents = "{""error"": ""JSON de entrada invalido ou erro interno.""}"
    }
    
    QUIT status
}

/// 3. ATUALIZAR CLIENTE NO BANCO (PUT)
Method Put(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Put.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Put.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Response).%New()
    
    // Garante um valor padrão para o Status caso dê falha
    SET pResponse.Status = 0
    
    TRY {
        SET tJSON = {}.%FromJSON(pRequest.DATA)
        SET tId = tJSON.Id
        
        IF (tId '= "") && ##class(TRE.DATA.Cliente).%ExistsId(tId) {
            SET tCliente = ##class(TRE.DATA.Cliente).%OpenId(tId)
            
            IF (tJSON.NomeEmpresa '= "") SET tCliente.NomeEmpresa = tJSON.NomeEmpresa
            IF (tJSON.NomeContato '= "") SET tCliente.NomeContato = tJSON.NomeContato
            IF (tJSON.Endereco '= "")    SET tCliente.Endereco    = tJSON.Endereco
            IF (tJSON.CEP '= "")         SET tCliente.CEP         = tJSON.CEP
            IF (tJSON.Cidade '= "")      SET tCliente.Cidade      = tJSON.Cidade
            IF (tJSON.Estado '= "")      SET tCliente.Estado      = tJSON.Estado
            IF (tJSON.EnderecoEmail '= "") SET tCliente.EnderecoEmail = tJSON.EnderecoEmail
            
            SET tSaveStatus = tCliente.%Save()
            
            IF $$$ISOK(tSaveStatus) {
                SET pResponse.Status = 0
                SET pResponse.Contents = "{""message"": ""Cliente ID " _ tId _ " atualizado com sucesso!""}"
            } ELSE {
                SET pResponse.Status = 1
                SET pResponse.Contents = "{""error"": ""Erro ao atualizar registro no banco.""}"
            }
        } ELSE {
            SET pResponse.Status = 1
            SET pResponse.Contents = "{""message"": ""Cliente com o ID informado nao foi encontrado.""}"
        }
    } Catch ex {
        SET pResponse.Status = 2
        SET pResponse.Contents = "{""error"": ""JSON de entrada invalido ou erro interno.""}"
    }
    
    QUIT status
}

/// 4. EXCLUIR CLIENTE DO BANCO (DELETE)
Method Delete(pRequest As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request, Output pResponse As trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Response).%New()
    
    SET tId = pRequest.DATA
    
    IF (tId '= "") && ##class(TRE.DATA.Cliente).%ExistsId(tId) {
        SET tDelStatus = ##class(TRE.DATA.Cliente).%DeleteId(tId)
        
        IF $$$ISOK(tDelStatus) {
            SET pResponse.Status = 0
            SET pResponse.Contents = "{""message"": ""Cliente ID " _ tId _ " excluido com sucesso!""}"
        } ELSE {
            SET pResponse.Status = 1
            SET pResponse.Contents = "{""error"": ""Erro ao excluir o registro no banco.""}"
        }
    } ELSE {
        SET pResponse.Status = 1
        SET pResponse.Contents = "{""message"": ""ID nao encontrado para exclusao.""}"
    }
    
    QUIT status
}

}