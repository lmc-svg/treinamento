Class trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request Extends Ens.Request
{

Property Cep5n As %String(MAXLEN = 5);

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>Cep5n</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
