Class Ecommerce.Data.Cliente Extends (%Persistent, %XML.Adaptor)
{

Property Nome As %String;

Property Idade As %Integer;

Property Sexo As %String;

Property CodigoCliente As %Integer;

Index IdxCodigoCliente On CodigoCliente [ Unique ];

Storage Default
{
<Data name="ClienteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>Idade</Value>
</Value>
<Value name="4">
<Value>Sexo</Value>
</Value>
<Value name="5">
<Value>CodigoCliente</Value>
</Value>
</Data>
<DataLocation>^Ecommerce.Data.ClienteD</DataLocation>
<DefaultData>ClienteDefaultData</DefaultData>
<IdLocation>^Ecommerce.Data.ClienteD</IdLocation>
<IndexLocation>^Ecommerce.Data.ClienteI</IndexLocation>
<StreamLocation>^Ecommerce.Data.ClienteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}