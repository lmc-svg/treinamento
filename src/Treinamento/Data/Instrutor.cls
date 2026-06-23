///Nome
///Matricula
Class Treinamento.Data.Instrutor Extends %RegisteredObject
{
Property Nome As %String(MAXLEN = 100);
Property Matricula As %String(MAXLEN = 10);

Storage Default
{
<Data name="InstrutorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Matricula</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.InstrutorD</DataLocation>
<DefaultData>InstrutorDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.InstrutorD</IdLocation>
<IndexLocation>^Treinamento.Data.InstrutorI</IndexLocation>
<Type>%Storage.Persistent</Type>
}
}
