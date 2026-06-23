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
<ExtentSize>1</ExtentSize>
<IdLocation>^Treinamento.Data.CursoD</IdLocation>
<IndexLocation>^Treinamento.Data.CursoI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Duracao">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:40</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Nome">
<AverageFieldSize>12</AverageFieldSize>
<OutlierSelectivity>.999999:"Obj Script"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Preco">
<AverageFieldSize>4</AverageFieldSize>
<OutlierSelectivity>.999999:1.5</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.CursoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
