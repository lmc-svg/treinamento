Class trans.BP.DetalhesCliente.ProcessaCliente Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As trans.BP.DetalhesCliente.msg.Request, Output pResponse As trans.BP.DetalhesCliente.msg.Response) As %Status
{
    Set status = $$$OK
    Set pResponse = ##class(trans.BP.DetalhesCliente.msg.Response).%New()
    
    Set tMetodo = $ZCONVERT(pRequest.Metodo, "U")
    Set tBORes = ""
    
    // 1. Decide qual Request enviar para a Operation
    If (tMetodo = "GET") {
        Set tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Get.Request).%New()
        Set tBOReq.Metodo = pRequest.Metodo
        Set tBOReq.DATA = pRequest.DATA
        Set status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "POST") {
        Set tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Post.Request).%New()
        Set tBOReq.Metodo = pRequest.Metodo
        Set tBOReq.DATA = pRequest.DATA
        Set status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "PUT") {
    Set tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Put.Request).%New()
    Set tBOReq.DATA = pRequest.DATA
    Set status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    ElseIf (tMetodo = "DELETE") {
        Set tBOReq = ##class(trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request).%New()
        Set tBOReq.Metodo = pRequest.Metodo
        Set tBOReq.DATA = pRequest.DATA
        Set status = ..SendRequestSync("Pedidos BO", tBOReq, .tBORes)
    }
    Else {
        Set pResponse.Status = 1
        Set pResponse.Contents = "{""error"": ""Metodo invalido""}"
        Quit status
    }

    If $$$ISOK(status) && $IsObject($Get(tBORes)) {
        Set pResponse.Status = tBORes.Status
        Set pResponse.Contents = tBORes.Contents
    } Else {
        Set pResponse.Status = 2
        Set pResponse.Contents = "{""error"": ""Erro no processamento da Operation""}"
    }
    
    Quit status
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}