Class trans.BO.DetalhesPedido.Cliente.Rest.Delete.Request Extends Ens.Request
{
Property DATA As %String(MAXLEN = "");
Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>DATA</Value>
</Value>
<Value name="2">
<Value>Contents</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}