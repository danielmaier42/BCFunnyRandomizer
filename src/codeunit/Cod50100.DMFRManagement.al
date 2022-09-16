codeunit 50100 "DMFRManagement"
{
    var 
        DMFRSetup: Record DMFRSetup;

    procedure Initialize();
    begin 
        DMFRSetup.Get();
        DMFRSetup.TestField("Module Active");
    end;

    procedure RandomizeCustomerPictures();
    var
        Customer: Record Customer;
    begin 
        DMFRSetup.TestField("Customer Active");
        DMFRSetup.TestField("Customer Meme Active");

        Customer.Reset();
        if Customer.FindSet() then 
            repeat 
                RandomizeCustomerPicture(Customer);
            until Customer.Next() = 0;
    end;

    local procedure RandomizeCustomerPicture(var Customer: Record Customer);
    var
        DMFRMemeApiConnector: Codeunit DMFRMemeApiConnector;
        Stream: InStream;
    begin 
        DMFRMemeApiConnector.FetchRandomMeme(Stream);
        Customer.Image.ImportStream(Stream, 'Meme');
        Customer.Modify();
    end;
}