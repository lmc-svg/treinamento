///Nome
///Matricula
///Idade
Class Treinamento.Data.Aluno Extends %RegisteredObject
{
Property Nome As %String(MAXLEN = 100);
Property Matricula As %String(MAXLEN = 10);
Property Idade As %Integer;

Storage Default
{
<Data name="AlunoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Matricula</Value>
</Value>
<Value name="4">
<Value>Idade</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.AlunoD</DataLocation>
<DefaultData>AlunoDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.AlunoD</IdLocation>
<Type>%Storage.Persistent</Type>
}

}