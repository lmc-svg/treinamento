Class Ecommerce.BP.Process Extends Ens.BusinessProcessBPL
{

XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ecommerce.BP.Msg.Request' response='Ecommerce.BP.Msg.Response' height='2000' width='2000' >
<context>
	<property name='Nome' type='%String' />
	<property name='TipoAvaliacao' type='%String' />
	<property name='Indicador' type='%String' />
	<property name='Score' type='%Integer' />
	<property name='Resultado' type='%String' />
</context>
<sequence>
	<!-- 1. Chama a Operation síncrona -->
	<call name='ChamaDadosCreditoBO' target='Dados Credito BO' async='0' xpos='200' ypos='100' >
		<request type='Ecommerce.BO.Msg.Request' >
			<assign property='callrequest.CodigoCliente' value='request.CodigoCliente' action='set' />
			<assign property='callrequest.Indicador' value='request.Indicador' action='set' />
		</request>
		<response type='Ecommerce.BO.Msg.Response' >
			<assign property='context.Nome' value='callresponse.Nome' action='set' />
			<assign property='context.TipoAvaliacao' value='callresponse.TipoAvaliacao' action='set' />
			<assign property='context.Indicador' value='callresponse.Indicador' action='set' />
			<assign property='context.Score' value='callresponse.Score' action='set' />
		</response>
	</call>
	
	<!-- 2. Árvore de Decisão BPL -->
	<if name='If-TipoAvaliacao Cadastral?' condition='context.TipoAvaliacao = "Cadastral"' xpos='200' ypos='250' >
		<true>
			<if name='Score >= 6?' condition='context.Score &gt;= 6' xpos='100' ypos='400' >
				<true>
					<assign name='Aprovado Cadastral' property='context.Resultado' value='"APROVADO"' action='set' xpos='50' ypos='550' />
				</true>
				<false>
					<assign name='Reprovado Cadastral' property='context.Resultado' value='"REPROVADO"' action='set' xpos='150' ypos='550' />
				</false>
			</if>
		</true>
		<false>
			<if name='Score >= 7?' condition='context.Score &gt;= 7' xpos='300' ypos='400' >
				<true>
					<assign name='Aprovado Comportamental' property='context.Resultado' value='"APROVADO"' action='set' xpos='250' ypos='550' />
				</true>
				<false>
					<assign name='Reprovado Comportamental' property='context.Resultado' value='"REPROVADO"' action='set' xpos='350' ypos='550' />
				</false>
			</if>
		</false>
	</if>
	
	<!-- 3. Preenche a resposta final -->
	<assign name='Assign Final Indicador' property='response.Indicador' value='request.Indicador' action='set' xpos='200' ypos='700' />
	<assign name='Assign Final Resultado' property='response.Resultado' value='context.Resultado' action='set' xpos='200' ypos='800' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}