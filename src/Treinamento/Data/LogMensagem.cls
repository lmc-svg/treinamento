Class Treinamento.Data.LogMensagem Extends (%Persistent, %XML.Adaptor)
{

Property Metodo As %String(MAXLEN = 255);
Property Classe As %String(MAXLEN = 255);
Property Inicio As %TimeStamp;
Property Fim As %TimeStamp;
Property Status As %String(MAXLEN = 255);
Property StatusProcesso As %String(MAXLEN = 255);
Property ListaLog As list Of %String(MAXLEN = 255);

ClassMethod CriarEntrada(pMetodo As %String, pClasse As %String) As %Integer
{
    S objLog = ##class(Treinamento.Data.LogMensagem).%New()
    S objLog.Metodo = pMetodo
    S objLog.Classe = pClasse
    S objLog.Inicio = $ZDateTime($Horolog, 3)
    S objLog.Status = "PROCESSANDO"
    S st = objLog.%Save()
    ;
    IF (st <= 0) Quit 0
    QUIT objLog.%Id()
}

ClassMethod Finalizar(pIdLog As %Integer, pStatusProcesso As %String, pStatusCode As %String) As %Status
{
    S objLog = ##class(Treinamento.Data.LogMensagem).%OpenId(pIdLog)
    IF objLog = "" Quit 0
    
    S objLog.Fim = $ZDateTime($Horolog, 3)
    S objLog.StatusProcesso = pStatusProcesso
    S objLog.Status = pStatusCode
    
    DO objLog.ListaLog.Insert("Processo finalizado com o status: "_pStatusProcesso_" (Code: "_pStatusCode_")")
    
    QUIT objLog.%Save()
}

ClassMethod ConsultaLog(pStatus As %String, pDataInicio As %TimeStamp, pDataFim As %TimeStamp)
{
    W !,"=== RESULTADO DA CONSULTA ===", !
    
    &sql(
        DECLARE LogCursor CURSOR FOR
        SELECT ID, Metodo, Classe, Inicio, StatusProcesso
        FROM Treinamento_Data.LogMensagem
        WHERE Status = :pStatus AND Inicio BETWEEN :pDataInicio AND :pDataFim
    )
    
    &sql(OPEN LogCursor)
    FOR {
        &sql(FETCH LogCursor INTO :id, :metodo, :classe, :inicio, :statusProc)
        QUIT:SQLCODE'=0
        
        W "ID: ", id, " | Classe: ", classe, " | Metodo: ", metodo, " | Inicio: ", inicio, " | Processo: ", statusProc, !
    }
    &sql(CLOSE LogCursor)
    
    W "=============================", !
    QUIT
}

ClassMethod ConsultaLogPaginacao(pStatus As %String, pLastId As %Integer, pPagSize As %Integer, pDataFim As %TimeStamp) As %ListOfObjects
{
    ; Criei a lista de obj vazia que vai carregar dados de retorno
    SET listaRetorno = ##class(%ListOfObjects).%New()
    SET contador = 0
    
    &sql(
        DECLARE PagCursor CURSOR FOR
        SELECT ID, Metodo, Classe, Inicio, StatusProcesso, Status
        FROM Treinamento_Data.LogMensagem
        WHERE Status = :pStatus AND ID > :pLastId AND Inicio <= :pDataFim
        ORDER BY ID ASC
    )
    
    &sql(OPEN PagCursor)
    FOR {
        &sql(FETCH PagCursor INTO :id, :metodo, :classe, :inicio, :statusProc, :statusReg)
        if SQLCODE '= 0 { quit }
        
        ; INSTANCIA O VO AQUI
        S oVO = ##class(Treinamento.VO.LogMensagem).%New()
        S oVO.Metodo = metodo
        S oVO.Classe = classe
        S oVO.Inicio = inicio
        S oVO.StatusProcesso = statusProc
        S oVO.Status = statusReg
        ;
        DO listaRetorno.Insert(oVO)
        
        S contador = contador + 1
        IF contador >= pPagSize { quit }
    }
    &sql(CLOSE PagCursor)
    
    ; Retorna a lista cheia p/ rotina
    QUIT listaRetorno
}

Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Metodo</Value>
</Value>
<Value name="3">
<Value>Classe</Value>
</Value>
<Value name="4">
<Value>Inicio</Value>
</Value>
<Value name="5">
<Value>Fim</Value>
</Value>
<Value name="6">
<Value>Status</Value>
</Value>
<Value name="7">
<Value>StatusProcesso</Value>
</Value>
<Value name="8">
<Value>ListaLog</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<ExtentSize>2</ExtentSize>
<IdLocation>^Treinamento.Data.LogMensagemD</IdLocation>
<IndexLocation>^Treinamento.Data.LogMensagemI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Classe">
<AverageFieldSize>26.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Fim">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2026-06-24 10:51:48"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Inicio">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2026-06-24 10:51:47"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="ListaLog">
<AverageFieldSize>85</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Metodo">
<AverageFieldSize>17.5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Status">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="StatusProcesso">
<AverageFieldSize>37</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
