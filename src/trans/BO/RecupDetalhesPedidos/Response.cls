Class trans.BO.RecupDetalhesPedidos.Response Extends Ens.Response
{

Property Endereco As %String(MAXLEN = 150);
Property CEP As %String(MAXLEN = 20);
Property Cidade As %String(MAXLEN = 50);
Property Estado As %String(MAXLEN = 50);
Property Email As %String(MAXLEN = 100);
Property NomeEmpresa As %String(MAXLEN = 100);
Property NomeContato As %String(MAXLEN = 100);
Property PesoKg As %Numeric(SCALE = 2);
Property Volumes As %Integer;

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Endereco</Value>
</Value>
<Value name="2">
<Value>CEP</Value>
</Value>
<Value name="3">
<Value>Cidade</Value>
</Value>
<Value name="4">
<Value>Estado</Value>
</Value>
<Value name="5">
<Value>Email</Value>
</Value>
<Value name="6">
<Value>NomeEmpresa</Value>
</Value>
<Value name="7">
<Value>NomeContato</Value>
</Value>
<Value name="8">
<Value>PesoKg</Value>
</Value>
<Value name="9">
<Value>Volumes</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}