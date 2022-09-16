page 50100 "DMFRSetup"
{
    Caption = 'DMFRSetup';
    PageType = Card;
    SourceTable = DMFRSetup;
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Module Active";"Module Active") 
                {
                    ApplicationArea = All;
                }
            }

            group(Customer)
            {
                field("Customer Active";"Customer Active")
                {
                    ApplicationArea = All;
                }

                field("Customer Meme Active";"Customer Meme Active")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TriggerActions)
            {
                ApplicationArea = All;
                Image = Action;
                Caption = 'Trigger Actions';
                Promoted = true;

                trigger OnAction();
                var 
                    DMFRMgmt: Codeunit DMFRManagement;
                begin 
                    DMFRMgmt.Initialize();
                    DMFRMgmt.RandomizeCustomerPictures();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin 
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
