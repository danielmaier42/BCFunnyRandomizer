codeunit 50101 "DMFRMemeApiConnector"
{
    procedure FetchRandomMeme(var Stream: InStream);
    var 
        JsonResponse: JsonObject;
        JsonTokenUrl: JsonToken;
        MemeUrl: Text;
        TempBlob: Codeunit "Temp Blob";
    begin
        JsonResponse := CallRESTWebService('get', 'https://meme-api.herokuapp.com/gimme');
        JsonResponse.Get('url', JsonTokenUrl);
        MemeUrl := JsonTokenUrl.AsValue().AsText();
        DownloadImageFromUrl(MemeUrl, Stream);
    end;

    local procedure DownloadImageFromUrl(ImageUrl: Text; var Stream: InStream)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        Client.Get(ImageUrl, Response);
        Response.Content.ReadAs(Stream);
    end;

    local procedure CallRESTWebService(pMethod: Text; pUri: Text): JsonObject
    var
        Client: HttpClient;
        Content: HttpContent;
        RequestContent: HttpContent;
        Headers: HttpHeaders;
        RequestHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        JsonResponse: JsonObject;
        ResponseStream: InStream;
        ApiErr: Label 'Api did return with status code %1';
    begin
        RequestContent.GetHeaders(RequestHeaders);
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'application/json');

        RequestMessage.Method := pMethod;
        RequestMessage.SetRequestUri(pUri);
        RequestMessage.GetHeaders(Headers);

        Client.Send(RequestMessage, ResponseMessage);

        if ResponseMessage.HttpStatusCode <> 200 then 
            Error(StrSubstNo(ApiErr, ResponseMessage.HttpStatusCode));

        ResponseMessage.Content.ReadAs(ResponseStream);
        JsonResponse.ReadFrom(ResponseStream);

        exit(JsonResponse);
    end;
}
