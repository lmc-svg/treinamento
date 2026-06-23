/// Nome
/// Preco
/// Duracao
Class Treinamento.Data.Curso Extends (%Persistent, %XML.Adaptor)
{

Property Nome As %String(MAXLEN = 100);
Property Preco As %Numeric(MAXVAL = 999999.99, MINVAL = 0);
Property Duracao As %Integer;

Storage Default
{
<Data name="CursoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Preco</Value>
</Value>
<Value name="4">
<Value>Duracao</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.CursoD</DataLocation>
<DefaultData>CursoDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.CursoD</IdLocation>
<IndexLocation>^Treinamento.Data.CursoI</IndexLocation>
<StreamLocation>^Treinamento.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
