Class trans.BO.DetalhesPedido.Cliente.Rest.Post.Request Extends Ens.Request
{
Property DATA As %String;
Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>DATA</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}