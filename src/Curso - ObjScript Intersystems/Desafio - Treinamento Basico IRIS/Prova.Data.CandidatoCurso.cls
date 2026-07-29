Class Prova.Data.CandidatoCurso Extends (%Persistent, %XML.Adaptor)
{
Relationship Candidato As Prova.Data.Candidato [ Cardinality = one, Inverse = InscricoesCursos ];
Relationship Curso As Prova.Data.Curso [ Cardinality = one, Inverse = Inscricoes ];

Storage Default
{
<Data name="CandidatoCursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Candidato</Value>
</Value>
<Value name="3">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Prova.Data.CandidatoCursoD</DataLocation>
<DefaultData>CandidatoCursoDefaultData</DefaultData>
<IdLocation>^Prova.Data.CandidatoCursoD</IdLocation>
<IndexLocation>^Prova.Data.CandidatoCursoI</IndexLocation>
<StreamLocation>^Prova.Data.CandidatoCursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
}