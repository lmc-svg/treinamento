Class trans.BP.ProcessaTransporte.Response Extends Ens.Response
{

Property Status As %String(MAXLEN = 100);

Property CodigoTransp As %String;

Property DataPrevisaoEntrega As %Date;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
<Value name="2">
<Value>CodigoTransp</Value>
</Value>
<Value name="3">
<Value>DataPrevisaoEntrega</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
