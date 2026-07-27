Class TRE.DATA.Pedido Extends %Persistent
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
<Data name="PedidoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoPedido</Value>
</Value>
<Value name="3">
<Value>DataPedido</Value>
</Value>
<Value name="4">
<Value>CodigoCliente</Value>
</Value>
<Value name="5">
<Value>ValorPedido</Value>
</Value>
<Value name="6">
<Value>PesoKG</Value>
</Value>
<Value name="7">
<Value>Volumes</Value>
</Value>
<Value name="8">
<Value>CodigoTransportadora</Value>
</Value>
<Value name="9">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<DataLocation>^TRE.DATA.PedidoD</DataLocation>
<DefaultData>PedidoDefaultData</DefaultData>
<IdLocation>^TRE.DATA.PedidoD</IdLocation>
<IndexLocation>^TRE.DATA.PedidoI</IndexLocation>
<StreamLocation>^TRE.DATA.PedidoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
