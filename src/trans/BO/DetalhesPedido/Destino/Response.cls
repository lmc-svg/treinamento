Class trans.BO.DetalhesPedido.Destino.Response Extends Ens.Response
{

Property Message As %String(MAXLEN = 255);

Storage Default
{
<Data name="Destino.ResponseDefaultData">
<Subscript>"Destino.Response"</Subscript>
<Value name="1">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>Destino.ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
