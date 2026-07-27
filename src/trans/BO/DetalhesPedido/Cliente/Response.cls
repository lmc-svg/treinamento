Class trans.BO.DetalhesPedido.Cliente.Response Extends Ens.Response
{

Property Message As %String(MAXLEN = 255);

Storage Default
{
<Data name="Cliente.ResponseDefaultData">
<Subscript>"Cliente.Response"</Subscript>
<Value name="1">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>Cliente.ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
