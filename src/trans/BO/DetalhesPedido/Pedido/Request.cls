Class trans.BO.DetalhesPedido.Pedido.Request Extends Ens.Request
{

Property CodigoPedido As %String;
Property DataPedido As %Date;
Property CodigoCliente As %String;
Property ValorPedido As %Numeric(SCALE = 2);
Property PesoKG As %Numeric(SCALE = 2);
Property Volumes As %Integer;
Property CodigoTransportadora As %String;
Property DataPrevisaoEntrega As %Date;

Storage Default
{
<Data name="Pedido.RequestDefaultData">
<Subscript>"Pedido.Request"</Subscript>
<Value name="1">
<Value>CodigoPedido</Value>
</Value>
<Value name="2">
<Value>DataPedido</Value>
</Value>
<Value name="3">
<Value>CodigoCliente</Value>
</Value>
<Value name="4">
<Value>ValorPedido</Value>
</Value>
<Value name="5">
<Value>PesoKG</Value>
</Value>
<Value name="6">
<Value>Volumes</Value>
</Value>
<Value name="7">
<Value>CodigoTransportadora</Value>
</Value>
<Value name="8">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<DefaultData>Pedido.RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}