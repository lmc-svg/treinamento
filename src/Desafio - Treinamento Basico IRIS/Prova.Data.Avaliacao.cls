Class Prova.Data.Avaliacao Extends (%Persistent, %XML.Adaptor)
{

Property CodigoCandidato As %Integer;
Property NomeDisciplina As %String(MAXLEN = 100);
Property Tipo As %String(MAXLEN = 50);
Property Nota As %Integer;

Relationship Candidato As Prova.Data.Candidato [ Cardinality = one, Inverse = Avaliacoes ];

ClassMethod ConsultaCandidato(pCodigoCandidato As %Integer)
{
    W "=== AVALIACOES DO CANDIDATO CODIGO: ", pCodigoCandidato, " ===", !
    &sql(
        DECLARE AvalCursor CURSOR FOR
        SELECT NomeDisciplina, Tipo, Nota 
        FROM Prova_Data.Avaliacao
        WHERE CodigoCandidato = :pCodigoCandidato
    )
    &sql(OPEN AvalCursor)
    FOR {
        &sql(FETCH AvalCursor INTO :disciplina, :tipo, :nota)
        IF SQLCODE '= 0 { quit }
        
        S status = "REPROVADO"
        IF (tipo = "Teorica") && (nota >= 6) { set status = "APROVADO" }
        IF (tipo = "Pratica") && (nota >= 7) { set status = "APROVADO" }
        
        W "Disciplina: ", disciplina, " | Tipo: ", tipo, " | Nota: ", nota, " -> [", status, "]", !
    }
    &sql(CLOSE AvalCursor)
    QUIT
}

Storage Default
{
<Data name="AvaliacaoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoCandidato</Value>
</Value>
<Value name="3">
<Value>NomeDisciplina</Value>
</Value>
<Value name="4">
<Value>Tipo</Value>
</Value>
<Value name="5">
<Value>Nota</Value>
</Value>
<Value name="6">
<Value>Candidato</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.AvaliacaoD</DataLocation>
<DefaultData>AvaliacaoDefaultData</DefaultData>
<IdLocation>^Prova.Data.AvaliacaoD</IdLocation>
<IndexLocation>^Prova.Data.AvaliacaoI</IndexLocation>
<StreamLocation>^Prova.Data.AvaliacaoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}