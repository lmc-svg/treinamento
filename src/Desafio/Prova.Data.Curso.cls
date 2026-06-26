Class Prova.Data.Curso Extends (%Persistent, %XML.Adaptor)
{
Property NomeCurso As %String(MAXLEN = 100);
Property DuracaoHoras As %Integer;

Relationship Inscricoes As Prova.Data.CandidatoCurso [ Cardinality = many, Inverse = Curso ];

Storage Default
{
<Data name="CursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>NomeCurso</Value>
</Value>
<Value name="3">
<Value>DuracaoHoras</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.CursoD</DataLocation>
<DefaultData>CursoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CursoD</IdLocation>
<IndexLocation>^Prova.Data.CursoI</IndexLocation>
<StreamLocation>^Prova.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
}