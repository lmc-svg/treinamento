Class trans.BO.DetalhesPedido.Pedido.Response Extends Ens.Response
{

Property Message As %String(MAXLEN = 255);

Storage Default
{
<Data name="Pedido.ResponseDefaultData">
<Subscript>"Pedido.Response"</Subscript>
<Value name="1">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>Pedido.ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}