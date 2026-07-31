Class Ecommerce.BO.Msg.Response Extends Ens.Response
{

Property Nome As %String(MAXLEN = "");

Property TipoAvaliacao As %String(MAXLEN = "");

Property Indicador As %String(MAXLEN = "");

Property Score As %Integer;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Nome</Value>
</Value>
<Value name="2">
<Value>TipoAvaliacao</Value>
</Value>
<Value name="3">
<Value>Indicador</Value>
</Value>
<Value name="4">
<Value>Score</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}