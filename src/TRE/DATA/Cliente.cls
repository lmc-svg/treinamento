Class TRE.DATA.Cliente Extends %Persistent
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
<Data name="ClienteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CodigoCliente</Value>
</Value>
<Value name="3">
<Value>NomeEmpresa</Value>
</Value>
<Value name="4">
<Value>NomeContato</Value>
</Value>
<Value name="5">
<Value>Endereco</Value>
</Value>
<Value name="6">
<Value>CEP</Value>
</Value>
<Value name="7">
<Value>Cidade</Value>
</Value>
<Value name="8">
<Value>Estado</Value>
</Value>
<Value name="9">
<Value>EnderecoEmail</Value>
</Value>
</Data>
<DataLocation>^TRE.DATA.ClienteD</DataLocation>
<DefaultData>ClienteDefaultData</DefaultData>
<IdLocation>^TRE.DATA.ClienteD</IdLocation>
<IndexLocation>^TRE.DATA.ClienteI</IndexLocation>
<StreamLocation>^TRE.DATA.ClienteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
