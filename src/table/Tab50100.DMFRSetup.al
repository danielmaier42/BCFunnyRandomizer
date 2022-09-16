table 50100 "DMFRSetup"
{
    Caption = 'DMFRSetup';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Module Active"; Boolean)
        {
            Caption = 'Module Active';
            DataClassification = ToBeClassified;
        }
        field(20; "Customer Active"; Boolean)
        {
            Caption = 'Customer Active';
            DataClassification = ToBeClassified;
        }
        field(21; "Customer Meme Active"; Boolean)
        {
            Caption = 'Customer Meme Active';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
