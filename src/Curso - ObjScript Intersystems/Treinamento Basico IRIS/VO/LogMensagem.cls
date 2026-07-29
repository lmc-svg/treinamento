/// Metodo
/// Classe
/// Inicio
/// Fim
/// Status
/// StatusProcesso
Class Treinamento.VO.LogMensagem Extends (%RegisteredObject, %XML.Adaptor, %JSON.Adaptor)
{

Property Metodo As %String(MAXLEN = 255);

Property Classe As %String(MAXLEN = 255);

Property Inicio As %TimeStamp;

Property Fim As %TimeStamp;

Property Status As %String(MAXLEN = 255);

Property StatusProcesso As %String(MAXLEN = 255);

}
