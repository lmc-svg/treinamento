Class Prova.Data.Candidato Extends (%Persistent, %XML.Adaptor)
{

Property Nome As %String(MAXLEN = 100);

Property Idade As %Integer;

Property Sexo As %String(MAXLEN = 20);

Property CodigoCandidato As %Integer;

/// Relacionamento Um-para-Muitos com Avaliações (Item 2)
Relationship Avaliacoes As Prova.Data.Avaliacao [ Cardinality = many, Inverse = Candidato ];

/// Relacionamento Muitos-para-Muitos com Cursos via Tabela Intermediária (Item 15)
Relationship InscricoesCursos As Prova.Data.CandidatoCurso [ Cardinality = many, Inverse = Candidato ];

/// 7 - Método de Instância: VerificaAprovacao
Method VerificaAprovacao() As %String
{
    set resultadoStr = ""
    set chave = ""
    
    for {
        set objAvaliacao = ..Avaliacoes.GetNext(.chave)
        quit:chave=""
        
        set status = "REPROVADO"
        if (objAvaliacao.Tipo = "Teorica") && (objAvaliacao.Nota >= 6) { set status = "APROVADO" }
        if (objAvaliacao.Tipo = "Pratica") && (objAvaliacao.Nota >= 7) { set status = "APROVADO" }
        
        set resultadoStr = resultadoStr _ objAvaliacao.NomeDisciplina _ ": " _ status _ " | "
    }
    quit resultadoStr
}

/// 8 - Método de Classe: AnalisaNome
ClassMethod AnalisaNome(pNomeCompleto As %String)
{
    set nomeSemEspacos = $Translate(pNomeCompleto, " ", "")
    set qtdCaracteres = $Length(nomeSemEspacos)
    set nomeComPipe = $Translate(pNomeCompleto, " ", "|")
    
    write "Qtd Caracteres (sem espacos): ", qtdCaracteres, !
    write "Nome formatado: ", nomeComPipe, !
    quit
}

/// 9 - Método de Classe: AnalisaDataNascimento
ClassMethod AnalisaDataNascimento(pDataEuropeia As %String)
{
    set dataH = $ZDateH(pDataEuropeia, 4)
    set dataIslamica = $ZDate(dataH, 18)
    set mesIslamico = $Piece(dataIslamica, " ", 2)
    
    write "Data em $Horolog..........: ", dataH, !
    write "Data no formato Islamico...: ", dataIslamica, !
    write "Nome do mes Islamico.......: ", mesIslamico, !
    quit
}

/// 10 - Método de Classe: BuscarCandidatoPorIdJSON
ClassMethod BuscarCandidatoPorIdJSON(pIdCandidato As %Integer) As %DynamicObject
{
    set jsonResult = ##class(%DynamicObject).%New()
    set objCandidato = ##class(Prova.Data.Candidato).%OpenId(pIdCandidato)
    if objCandidato = "" { quit jsonResult }
    
    set jsonResult.Nome = objCandidato.Nome
    set jsonResult.Idade = objCandidato.Idade
    set jsonResult.Sexo = objCandidato.Sexo
    set jsonResult.CodigoCandidato = objCandidato.CodigoCandidato
    
    set jsonArray = ##class(%DynamicArray).%New()
    set chave = ""
    for {
        set objAval = objCandidato.Avaliacoes.GetNext(.chave)
        quit:chave=""
        
        set oVO = ##class(Prova.VO.AvaliacaoVO).%New()
        set oVO.CodigoCandidato = objCandidato.CodigoCandidato
        set oVO.NomeCandidato = objCandidato.Nome
        set oVO.NomeDisciplina = objAval.NomeDisciplina
        set oVO.Tipo = objAval.Tipo
        set oVO.Nota = objAval.Nota
        
        set status = "REPROVADO"
        if (objAval.Tipo = "Teorica") && (objAval.Nota >= 6) { set status = "APROVADO" }
        if (objAval.Tipo = "Pratica") && (objAval.Nota >= 7) { set status = "APROVADO" }
        set oVO.Resultado = status
        
        do oVO.%JSONExportToString(.strJson)
        do jsonArray.%Push(##class(%DynamicObject).%FromJSON(strJson))
    }
    set jsonResult.avaliacoes = jsonArray
    quit jsonResult
}

/// 11 - Método de Classe: ConsultaCandidatoPaginacaoJSON
ClassMethod ConsultaCandidatoPaginacaoJSON(pNomeCandidato As %String, pLastId As %Integer, pPageSize As %Integer, pSexo As %String) As %DynamicObject
{
    set jsonResult = ##class(%DynamicObject).%New()
    set jsonArray = ##class(%DynamicArray).%New()
    set contador = 0
    set proximoLastId = pLastId
    set filtroNome = pNomeCandidato _ "%"
    
    &sql(
        DECLARE CandCursor CURSOR FOR
        SELECT ID FROM Prova_Data.Candidato
        WHERE ID > :pLastId AND Sexo = :pSexo AND Nome LIKE :filtroNome
        ORDER BY ID ASC
    )
    &sql(OPEN CandCursor)
    for {
        &sql(FETCH CandCursor INTO :id)
        if SQLCODE '= 0 { quit }
        
        do jsonArray.%Push(..BuscarCandidatoPorIdJSON(id))
        set contador = contador + 1
        set proximoLastId = id
        if contador >= pPageSize { quit }
    }
    &sql(CLOSE CandCursor)
    
    set jsonResult.candidatos = jsonArray
    set jsonResult.totalRegistros = contador
    set jsonResult.ProximoLastId = proximoLastId
    quit jsonResult
}

Storage Default
{
<Data name="CandidatoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Idade</Value>
</Value>
<Value name="4">
<Value>Sexo</Value>
</Value>
<Value name="5">
<Value>CodigoCandidato</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.CandidatoD</DataLocation>
<DefaultData>CandidatoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CandidatoD</IdLocation>
<IndexLocation>^Prova.Data.CandidatoI</IndexLocation>
<StreamLocation>^Prova.Data.CandidatoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}