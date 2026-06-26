Class Prova.Data.LogSistema Extends (%Persistent, %XML.Adaptor)
{

Property Servico As %String(MAXLEN = 100);
Property Sistema As %String(MAXLEN = 100);
Property StatusProcesso As %String(MAXLEN = 255);
Property Status As %Boolean;
Property HorarioExecucao As %TimeStamp;

ClassMethod CriarLogMensagem(pServico As %String, pSistema As %String) As %Integer
{
    S objLog = ##class(Prova.Data.LogSistema).%New()
    S objLog.Servico = pServico
    S objLog.Sistema = pSistema
    S objLog.HorarioExecucao = $ZDateTime($Horolog, 3)
    S objLog.StatusProcesso = "Processo realizado com sucesso!"
    S objLog.Status = 1
    D objLog.%Save()
    QUIT objLog.%Id()
}

ClassMethod ConsultaLog(pStatus As %Boolean, pDataInicio As %TimeStamp, pDataFim As %TimeStamp)
{
    W "=== EXIBIÇÃO DE LOGS COMPILADOS ===", !
    &sql(
        DECLARE LogFiltroCursor CURSOR FOR
        SELECT ID, Servico, Sistema, StatusProcesso, HorarioExecucao
        FROM Prova_Data.LogSistema
        WHERE Status = :pStatus AND HorarioExecucao BETWEEN :pDataInicio AND :pDataFim
    )
    &sql(OPEN LogFiltroCursor)
    FOR {
        &sql(FETCH LogFiltroCursor INTO :id, :servico, :sistema, :proc, :horario)
        if SQLCODE '= 0 { quit }
        W "ID: ", id, " | Servico: ", servico, " | StatusProc: ", proc, " | Data: ", horario, !
    }
    &sql(CLOSE LogFiltroCursor)
    QUIT
}

/// 14 - Método de Classe: ConsultaLogPaginacaoJSON
ClassMethod ConsultaLogPaginacaoJSON(pStatus As %Boolean, pLastId As %Integer, pPageSize As %Integer, pDataFim As %TimeStamp) As %DynamicObject
{
    S jsonResult = ##class(%DynamicObject).%New()
    S jsonArray = ##class(%DynamicArray).%New()
    S contador = 0
    S proximoLastId = pLastId
    
    &sql(
        DECLARE LogPagCursor CURSOR FOR
        SELECT ID, Servico, Sistema, StatusProcesso, HorarioExecucao
        FROM Prova_Data.LogSistema
        WHERE Status = :pStatus AND ID > :pLastId AND HorarioExecucao <= :pDataFim
        ORDER BY ID ASC
    )
    &sql(OPEN LogPagCursor)
    FOR {
        &sql(FETCH LogPagCursor INTO :id, :servico, :sistema, :proc, :horario)
        IF SQLCODE '= 0 { quit }
        
        S itemJson = ##class(%DynamicObject).%New()
        S itemJson.ID = id
        S itemJson.Servico = servico
        S itemJson.Sistema = sistema
        S itemJson.StatusProcesso = proc
        S itemJson.HorarioExecucao = horario
        D jsonArray.%Push(itemJson)
        
        S contador = contador + 1
        S proximoLastId = id
        IF contador >= pPageSize { quit }
    }
    &sql(CLOSE LogPagCursor)
    
    S jsonResult.logs = jsonArray
    S jsonResult.totalRetornado = contador
    S jsonResult.ProximoLastId = proximoLastId
    QUIT jsonResult
}

Storage Default
{
<Data name="LogSistemaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Servico</Value>
</Value>
<Value name="3">
<Value>Sistema</Value>
</Value>
<Value name="4">
<Value>StatusProcesso</Value>
</Value>
<Value name="5">
<Value>Status</Value>
</Value>
<Value name="6">
<Value>HorarioExecucao</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.LogSistemaD</DataLocation>
<DefaultData>LogSistemaDefaultData</DefaultData>
<IdLocation>^Prova.Data.LogSistemaD</IdLocation>
<IndexLocation>^Prova.Data.LogSistemaI</IndexLocation>
<StreamLocation>^Prova.Data.LogSistemaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
}