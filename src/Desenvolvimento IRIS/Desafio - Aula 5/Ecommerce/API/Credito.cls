Class Ecommerce.API.Credito Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;
Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
   <Route Url="/credito/:CodigoCliente/:Indicador" Method="GET" Call="GetResultadoCredito"/>
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

ClassMethod GetResultadoCredito(pCodigoCliente As %Integer, pIndicador As %String) As %Status
{
    SET status = $$$OK
    
    SET status = ##class(Ens.Director).CreateBusinessService("AvaliaCredito", .tService)
    IF $$$ISERR(status) || '$IsObject($Get(tService)) {
        SET %response.Status = "500 Internal Server Error"
        WRITE {"error": "Falha ao instanciar o Business Service. Verifique se a Producao esta rodando."}.%ToJSON()
        QUIT $$$OK
    }
    
    SET status = tService.ProcessInput(pCodigoCliente, .tResponse, pIndicador)
    
    IF $$$ISOK(status) && $IsObject($Get(tResponse)) {
        SET %response.Status = "200 OK"
        
        SET tJSON = {}
        SET tJSON.Indicador = tResponse.Indicador
        SET tJSON.Resultado = tResponse.Resultado
        
        WRITE tJSON.%ToJSON()
    } ELSE {
        SET %response.Status = "500 Internal Server Error"
        WRITE {"error": "Erro no processamento interno da Producao"}.%ToJSON()
    }
    
    QUIT $$$OK
}

}