Class Treinamento.Data.Turma Extends (%Persistent, %XML.Adaptor)
{
Property Instrutor As Treinamento.Data.Instrutor;
Property DataInicio As %Date;
Property Status As %String(MAXLEN = 20, VALUELIST = ",Ativa,Concluida,Cancelada,Incompleta");
Property Alunos As list Of Treinamento.Data.Aluno;
Property Curso As Treinamento.Data.Curso;
Method VerificaStatus(nomeCurso As %String) As %String
{
    If (..Curso '= "") && (..Curso.Nome = nomeCurso) {
        Quit ..Status
    }
    Quit "Curso nao encontrado nesta turma"
}
ClassMethod ImprimeTurma(nomeCurso As %String)
{
    Set turmaId = ""
    ;
    &sql(
        SELECT ID INTO :turmaId 
        FROM Treinamento_Data.Turma 
        WHERE Curso->Nome = :nomeCurso
    )
    ;
    If SQLCODE '= 0 {
        Write "Nenhuma turma encontrada para o curso: ", nomeCurso, !
        Quit
    }
    ;
    Set turma = ##class(Treinamento.Data.Turma).%OpenId(turmaId)
    ;
    If turma '= "" {
        Write !,"=========================================",!
        Write "ALUNOS DA TURMA: ", nomeCurso, !
        Write "Status da Turma: ", turma.Status, !
        Write "=========================================",!
        ;
        ;
        For i = 1:1:turma.Alunos.Count() {
            Set aluno = turma.Alunos.GetAt(i)
            Write "Matricula: ", aluno.Matricula, " | Nome: ", aluno.Nome, " | Idade: ", aluno.Idade, !
        }
        Write "=========================================",!
    }
    ;
    Quit
}

Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instrutor</Value>
</Value>
<Value name="3">
<Value>DataInicio</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Alunos</Value>
</Value>
<Value name="6">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}