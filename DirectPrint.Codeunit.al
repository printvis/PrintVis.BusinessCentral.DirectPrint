codeunit 50100 "PTE Direct Print"
{

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforePrintDocument', '', false, false)]
    local procedure MyProcedure(TempReportSelections: Record "Report Selections" temporary; IsGUI: Boolean; RecVarToPrint: Variant; var IsHandled: Boolean)
    var
        DirectPrint: Record "PTE Direct Print";
    begin
        DirectPrint."Report ID" := TempReportSelections."Report ID";
        if not DirectPrint.IsValid() then
            exit;

        DirectPrint.SetRecordVariant(RecVarToPrint);
        IsHandled := StartSession(DirectPrint."Session Id", Codeunit::"PTE Direct Print Session", CompanyName, DirectPrint);
    end;
}

