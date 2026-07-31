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
    Do %response.SetHeader("Access-Control-Allow-Origin", "*")
    Do %response.SetHeader("Access-Control-Allow-Credentials", "true")
    Do %response.SetHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS")
    Do %response.SetHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, Accept")
    Quit $$$OK
}

ClassMethod ProcessaServico(pData As %String, pMethod As %String) As %Status
{
    Set status = $$$OK
    
    Set status = ##class(Ens.Director).CreateBusinessService("DetalhesCliente", .tService)
    If $$$ISERR(status) || '$IsObject($Get(tService)) {
        Set %response.Status = "500 Internal Server Error"
        Write {"error": "Falha ao instanciar o Business Service. Verifique se a Produção está rodando."}.%ToJSON()
        Quit $$$OK
    }
    
    Set status = tService.ProcessInput(pData, .tResponse, pMethod)
    
    If $$$ISOK(status) && $IsObject($Get(tResponse)) {
        If (tResponse.Status = 0) {
            Set %response.Status = "200 OK"
        } ElseIf (tResponse.Status = 1) {
            Set %response.Status = "400 Bad Request"
        } Else {
            Set %response.Status = "500 Internal Server Error"
        }
        
        If (tResponse.Contents '= "") {
            Write tResponse.Contents
        } Else {
            Set tObj = {}
            Set tObj.status = tResponse.Status
            Write tObj.%ToJSON()
        }
    } Else {
        Set %response.Status = "500 Internal Server Error"
        Write {"error": "Erro no processamento interno da Produção"}.%ToJSON()
    }
    
    Quit $$$OK
}

ClassMethod GetCliente() As %Status
{
    Set tNomeContato = %request.Get("NomeContato")
    Quit ..ProcessaServico($Get(tNomeContato), "Get")
}

ClassMethod PostCliente() As %Status
{
    Set tBody = ""
    If $IsObject(%request.Content) {
        Set tBody = %request.Content.Read()
    }
    Quit ..ProcessaServico(tBody, "Post")
}

ClassMethod PutCliente() As %Status
{
    Set tBody = ""
    If $IsObject(%request.Content) {
        Set tBody = %request.Content.Read()
    }
    Quit ..ProcessaServico(tBody, "Put")
}

ClassMethod DeleteCliente() As %Status
{
    Set tId = %request.Get("Id")
    Quit ..ProcessaServico($Get(tId), "Delete")
}

}