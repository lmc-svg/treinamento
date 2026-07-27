Class trans.BO.DetalhesPedido.Cliente.Request Extends Ens.Request
{

Property CodigoCliente As %String;
Property NomeEmpresa As %String(MAXLEN = 100);
Property NomeContato As %String(MAXLEN = 100);
Property Endereco As %String(MAXLEN = 150);
Property CEP As %String(MAXLEN = 20);
Property Cidade As %String(MAXLEN = 50);
Property Estado As %String(MAXLEN = 50);
Property EnderecoEmail As %String(MAXLEN = 100);

Storage Default
{
<Data name="Cliente.RequestDefaultData">
<Subscript>"Cliente.Request"</Subscript>
<Value name="1">
<Value>CodigoCliente</Value>
</Value>
<Value name="2">
<Value>NomeEmpresa</Value>
</Value>
<Value name="3">
<Value>NomeContato</Value>
</Value>
<Value name="4">
<Value>Endereco</Value>
</Value>
<Value name="5">
<Value>CEP</Value>
</Value>
<Value name="6">
<Value>Cidade</Value>
</Value>
<Value name="7">
<Value>Estado</Value>
</Value>
<Value name="8">
<Value>EnderecoEmail</Value>
</Value>
</Data>
<DefaultData>Cliente.RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
