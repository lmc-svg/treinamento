Class Ecommerce.Data.ScoreCredito Extends (%Persistent, %XML.Adaptor)
{

Property CodigoCliente As %Integer;

Property Indicador As %String;

Property TipoAvaliacao As %String;

Property Score As %Integer;

Storage Default
{
<Data name="ScoreCreditoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoCliente</Value>
</Value>
<Value name="3">
<Value>Indicador</Value>
</Value>
<Value name="4">
<Value>TipoAvaliacao</Value>
</Value>
<Value name="5">
<Value>Score</Value>
</Value>
</Data>
<DataLocation>^Ecommerce.Data.ScoreCreditoD</DataLocation>
<DefaultData>ScoreCreditoDefaultData</DefaultData>
<IdLocation>^Ecommerce.Data.ScoreCreditoD</IdLocation>
<IndexLocation>^Ecommerce.Data.ScoreCreditoI</IndexLocation>
<StreamLocation>^Ecommerce.Data.ScoreCreditoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}