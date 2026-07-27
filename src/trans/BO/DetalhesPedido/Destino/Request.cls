Class trans.BO.DetalhesPedido.Destino.Request Extends Ens.Request
{

Property CodigoDestino As %String;
Property CEPInicial As %String(MAXLEN = 20);
Property CEPFinal As %String(MAXLEN = 20);
Property PrazoEntregaDias As %Integer;

Storage Default
{
<Data name="Destino.RequestDefaultData">
<Subscript>"Destino.Request"</Subscript>
<Value name="1">
<Value>CodigoDestino</Value>
</Value>
<Value name="2">
<Value>CEPInicial</Value>
</Value>
<Value name="3">
<Value>CEPFinal</Value>
</Value>
<Value name="4">
<Value>PrazoEntregaDias</Value>
</Value>
</Data>
<DefaultData>Destino.RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
