table 50100 "PTE Direct Print"
{
    TableType = Temporary;

    fields
    {
        field(1; "Report ID"; Integer) { DataClassification = SystemMetadata; }
        field(2; "Session Id"; Integer) { DataClassification = SystemMetadata; }
    }

    keys { key(pk; "Report ID") { Clustered = true; } }

    procedure IsValid(): Boolean
    var
        Setup: Record "PTE Direct Print Setup";
    begin
        if "Report ID" = 0 then
            exit(false);

        if Setup.IsEmpty then
            exit(false);

        if not Setup.Get("Report ID", UserId) then
            if not Setup.Get("Report ID") then
                if not Setup.Get(0, UserId) then
                    exit(false);
        exit(true);
    end;

    procedure Print()
    begin
        Report.Print("Report ID", '', RecordVariant);
    end;

    procedure SetRecordVariant(var Value: Variant)
    begin
        RecordVariant := Value;
    end;

    var
        RecordVariant: Variant;

}