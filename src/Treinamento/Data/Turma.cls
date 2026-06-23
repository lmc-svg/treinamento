Class Treinamento.Data.Turma Extends (%Persistent, %XML.Adaptor)
{

Property Instrutor As Treinamento.Data.Instrutor;

Property DataInicio As %Date;

Property Status As %String(MAXLEN = 20, VALUELIST = ",Ativa,Concluida,Cancelada");

Property Alunos As list Of Treinamento.Data.Aluno;

Property Curso As Treinamento.Data.Curso;

Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instrutor</Value>
</Value>
<Value name="3">
<Value>DataInicio</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Alunos</Value>
</Value>
<Value name="6">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
