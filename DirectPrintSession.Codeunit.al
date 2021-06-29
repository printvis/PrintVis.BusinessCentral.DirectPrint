codeunit 50101 "PTE Direct Print Session"
{
    TableNo = "PTE Direct Print";

    trigger OnRun()
    var
    begin
        Rec.Print();
    end;
}