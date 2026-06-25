///Nome
///SobreNome
///Sexo
///Email
Class Treinamento.Data.Usuario Extends (%Persistent, %XML.Adaptor)
{

Property Perfil As Treinamento.Data.Perfil;
Property Nome As %String(MAXLEN = 30);
Property SobreNome As %String(MAXLEN = 30);
Property Sexo As %String(MAXLEN = 1);
Property Email As %String(MAXLEN = 100);


Storage Default
{
<Data name="UsuarioDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nome</Value>
</Value>
<Value name="3">
<Value>SobreNome</Value>
</Value>
<Value name="4">
<Value>Sexo</Value>
</Value>
<Value name="5">
<Value>Email</Value>
</Value>
<Value name="6">
<Value>Perfil</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.UsuarioD</DataLocation>
<DefaultData>UsuarioDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.UsuarioD</IdLocation>
<IndexLocation>^Treinamento.Data.UsuarioI</IndexLocation>
<StreamLocation>^Treinamento.Data.UsuarioS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
