Class trans.BP.DetalhesCliente.ProcessaCliente Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As trans.BP.DetalhesCliente.msg.Request, Output pResponse As trans.BP.DetalhesCliente.msg.Response) As %Status
{
    SET status = $$$OK
    SET pResponse = ##class(trans.BP.DetalhesCliente.msg.Response).%New()
    
    SET tMetodo = $ZCONVERT(pRequest.Metodo, "U")
    SET tBORes = ""
    
    // 1. Decide qual Request enviar para a Operation
    IF (tMetodo = "GET") {
        SET tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Request).%New()
        SET tBOReq.Metodo = pRequest.Metodo
        SET tBOReq.DATA = pRequest.DATA
        SET status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "POST") {
        SET tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Request).%New()
        SET tBOReq.Metodo = pRequest.Metodo
        SET tBOReq.DATA = pRequest.DATA
        SET status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "PUT") {
    SET tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Request).%New()
    SET tBOReq.DATA = pRequest.DATA
    SET status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "DELETE") {
        SET tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request).%New()
        SET tBOReq.Metodo = pRequest.Metodo
        SET tBOReq.DATA = pRequest.DATA
        SET status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    Else {
        SET pResponse.Status = 1
        SET pResponse.Contents = "{""error"": ""Metodo invalido""}"
        QUIT status
    }

    If $$$ISOK(status) && $IsObject($Get(tBORes)) {
        SET pResponse.Status = tBORes.Status
        SET pResponse.Contents = tBORes.Contents
    } Else {
        SET pResponse.Status = 2
        SET pResponse.Contents = "{""error"": ""Erro no processamento da Operation""}"
    }
    
    QUIT status
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}