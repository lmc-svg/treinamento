Class trans.API.DetalhesPedido Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;
Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
   <Route Url="/" Method="GET" Call="GetCliente"/>
   <Route Url="/" Method="POST" Call="PostCliente"/>
   <Route Url="/" Method="PUT" Call="PutCliente"/>
   <Route Url="/" Method="DELETE" Call="DeleteCliente"/>
</Routes>
}

ClassMethod OnHandleCorsRequest(pUrl As %String) As %Status
{
    DO %response.SetHeader("Access-Control-Allow-Origin", "*")
    DO %response.SetHeader("Access-Control-Allow-Credentials", "true")
    DO %response.SetHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS")
    DO %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, Accept")
    QUIT $$$OK
}

ClassMethod ProcessaServico(pData As %String, pMethod As %String) As %Status
{
    SET status = $$$OK
    
    SET status = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tService)
    If $$$ISERR(status) || '$IsObject($Get(tService)) {
        SET %response.Status = "500 Internal Server Error"
        WRITE {"error": "Falha ao instanciar o Business Service. Verifique se a Produção está rodando."}.%ToJSON()
        QUIT $$$OK
    }
    
    SET status = tService.ProcessInput(pData, .tResponse, pMethod)
    
    If $$$ISOK(status) && $IsObject($Get(tResponse)) {
        If (tResponse.Status = 0) {
            SET %response.Status = "200 OK"
        } ElseIf (tResponse.Status = 1) {
            SET %response.Status = "400 Bad Request"
        } Else {
            SET %response.Status = "500 Internal Server Error"
        }
        
        If (tResponse.Contents '= "") {
            WRITE tResponse.Contents
        } Else {
            SET tObj = {}
            SET tObj.status = tResponse.Status
            WRITE tObj.%ToJSON()
        }
    } Else {
        SET %response.Status = "500 Internal Server Error"
        WRITE {"error": "Erro no processamento interno da Produção"}.%ToJSON()
    }
    
    QUIT $$$OK
}

ClassMethod GetCliente() As %Status
{
    Set tNomeContato = %request.Get("NomeContato")
    QUIT ..ProcessaServico($Get(tNomeContato), "Get")
}

ClassMethod PostCliente() As %Status
{
    SET tBody = ""
    If $IsObject(%request.Content) {
        SET tBody = %request.Content.Read()
    }
    QUIT ..ProcessaServico(tBody, "Post")
}

ClassMethod PutCliente() As %Status
{
    SET tBody = ""
    If $IsObject(%request.Content) {
        SET tBody = %request.Content.Read()
    }
    QUIT ..ProcessaServico(tBody, "Put")
}

ClassMethod DeleteCliente() As %Status
{
    SET tId = %request.Get("Id")
    QUIT ..ProcessaServico($Get(tId), "Delete")
}

}