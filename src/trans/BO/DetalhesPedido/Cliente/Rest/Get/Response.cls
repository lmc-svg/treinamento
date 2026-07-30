Class trans.BO.DetalhesPedido.Cliente.Rest.Get.Response Extends Ens.Response
{
Property Status As %Integer;
Property Contents As %String(MAXLEN = "");
Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
<Value name="2">
<Value>Contents</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}