Class Ecommerce.BO.Msg.Request Extends Ens.Request
{

Property CodigoCliente As %Integer;

Property Indicador As %String(MAXLEN = "");

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>CodigoCliente</Value>
</Value>
<Value name="2">
<Value>Indicador</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}