/// 
Class trans.BP.ProcessaTransporte.Process Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='trans.BP.ProcessaTransporte.Request' response='trans.BP.ProcessaTransporte.Response' height='2000' width='2200' layout='manual' >
<context>
<property name='Volumes' type='%Integer' instantiate='0' />
<property name='Endereco' type='%String' instantiate='0' />
<property name='PesoKg' type='%String' instantiate='0' />
<property name='CEP' type='%String' instantiate='0' />
<property name='Cidade' type='%String' instantiate='0' />
<property name='Estado' type='%String' instantiate='0' />
<property name='Email' type='%String' instantiate='0' />
<property name='NomeEmpresa' type='%String' instantiate='0' />
<property name='NomeContato' type='%String' instantiate='0' />
<property name='Cep5n' type='%String' instantiate='0' />
<property name='AtendidoSpeedy' type='%Boolean' instantiate='0' />
<property name='PrazoEntregaDias' type='%Integer' instantiate='0' />
</context>
<sequence xpos='830' ypos='64' xend='972' yend='863' >
<call name='ChamaDetalhesPedido' target='Detalha Pedidos BO' async='1' xpos='1010' ypos='120' >
<request type='trans.BO.RecupDetalhesPedidos.Request' >
<assign property="callrequest.CodigoPedido" value="request.CodigoPedido" action="set" />
</request>
<response type='trans.BO.RecupDetalhesPedidos.Response' >
<assign property="context.Endereco" value="callresponse.Endereco" action="set" />
<assign property="context.PesoKg" value="callresponse.PesoKg" action="set" />
<assign property="context.CEP" value="callresponse.CEP" action="set" />
<assign property="context.Cidade" value="callresponse.Cidade" action="set" />
<assign property="context.Estado" value="callresponse.Estado" action="set" />
<assign property="context.Email" value="callresponse.Email" action="set" />
<assign property="context.NomeEmpresa" value="callresponse.NomeEmpresa" action="set" />
<assign property="context.NomeContato" value="callresponse.NomeContato" action="set" />
<assign property="context.Volumes" value="callresponse.Volumes" action="set" />
</response>
</call>
<sync name='AguardaDetalhesPedido' calls='ChamaDetalhesPedido' type='all' xpos='1009' ypos='229' />
<if name='Pedido Válido' condition='(context.PesoKg &apos;= "") &amp;&amp; (context.PesoKg &gt; 0)' xpos='1009' ypos='333' xend='972' yend='708' >
<true>
<assign name="DefineStatusPedidoValido" property="response.Status" value="1" action="set" xpos='1299' ypos='273' />
<assign name="DefineCep5n" property="context.Cep5n" value="$E(context.CEP,1,5)" action="set" xpos='1298' ypos='395' />
<call name='ChamaVerificaDestinoSpeedy' target='Detalhes Speedy BO' async='1' xpos='1298' ypos='512' >
<request type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response' >
<assign property="context.AtendidoSpeedy" value="callresponse.AtendidoSpeedy" action="set" />
</response>
</call>
<call name='ChamaRecupPrazoEntrega' target='Detalhes Speedy BO' async='1' xpos='1298' ypos='617' >
<request type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response' >
<assign property="context.PrazoEntregaDias" value="callresponse.PrazoEntregaDias" action="set" />
</response>
</call>
<sync name='AguardaDetalhesSpeedy' calls='ChamaVerificaDestinoSpeedy,ChamaRecupPrazoEntrega' type='all' xpos='1298' ypos='730' />
</true>
<false>
<assign name="DefineStatusPedidoInvalido" property="response.Status" value="0" action="set" xpos='972' ypos='503' />
</false>
</if>
</sequence>
</process>
}

}
