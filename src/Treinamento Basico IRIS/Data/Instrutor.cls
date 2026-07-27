/// Nome
/// Matricula
Class Treinamento.Data.Instrutor Extends %Persistent
{

Property Nome As %String(MAXLEN = 100);

Property Matricula As %Integer;

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
<ExtentSize>1</ExtentSize>
<IdLocation>^Treinamento.Data.InstrutorD</IdLocation>
<IndexLocation>^Treinamento.Data.InstrutorI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Matricula">
<AverageFieldSize>4</AverageFieldSize>
<OutlierSelectivity>.999999:2306</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Nome">
<AverageFieldSize>10</AverageFieldSize>
<OutlierSelectivity>.999999:"Anderson"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.InstrutorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
