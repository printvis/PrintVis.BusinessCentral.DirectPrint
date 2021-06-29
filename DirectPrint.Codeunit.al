codeunit 50100 "PTE Direct Print"
{
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforePrintDocument', '', false, false)]
    local procedure DirectPrintRepSel(TempReportSelections: Record "Report Selections" temporary; IsGUI: Boolean; RecVarToPrint: Variant; var IsHandled: Boolean)
    var
        DirectPrint: Record "PTE Direct Print";
    begin
        DirectPrint."Report ID" := TempReportSelections."Report ID";
        if not DirectPrint.IsValid() then
            exit;

        DirectPrint.SetRecordView(RecVarToPrint);
        IsHandled := StartSession(DirectPrint."Session Id", Codeunit::"PTE Direct Print Session", CompanyName, DirectPrint);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PVS Application Management", 'OnPrintCase', '', false, false)]

    local procedure DirectPrintCase(var inRecVariant: Variant; TableNo: Integer; in_ReportID: Integer; var isHandled: Boolean)
    var
        DirectPrint: Record "PTE Direct Print";
        RecRef: RecordRef;
    begin
        DirectPrint."Report ID" := in_ReportID;
        if not DirectPrint.IsValid() then
            exit;

        if inRecVariant.IsRecord then begin
            RecRef.Open(TableNo);
            RecRef.GetTable(inRecVariant);
            inRecVariant := RecRef;
        end;

        DirectPrint.SetRecordView(inRecVariant);
        IsHandled := StartSession(DirectPrint."Session Id", Codeunit::"PTE Direct Print Session", CompanyName, DirectPrint);
    end;
}

