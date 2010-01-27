{
  SQLite3 complete API translation and simple wrapper for Delphi and FreePascal

  Version: 1.0 (January 6, 2010)
  Version of SQLite: 3.6.21

  ------------------------------------------------------------------------------

  SQLite is a software library that implements a self-contained, serverless,
  zero-configuration, transactional SQL database engine. The source code for
  SQLite is in the public domain and is thus free for use for any purpose,
  commercial or private. SQLite is the most widely deployed SQL database engine
  in the world.

  This SQLite3 API translation for Delphi and FreePascal is freeware. You are
  free to use it in any kind of application as well as redistribute the source
  code in original form, provided the distribution package is not modified.

  This translation is provided "as is". No warranty of any kind is expressed or
  implied. You use it at your own risk. The author will not be liable for data
  loss, damages, loss of profits or any other kind of loss while using or
  misusing this software.

  ------------------------------------------------------------------------------

  Copyright © 2010 IndaSoftware Inc. All rights reserved.

  http://www.indasoftware.com/
  http://www.indasoftware.com/fordev/sqlite3/
}

{
  Miscellaneous utility functions
}
unit SQLite3Utils;

{$WARN SYMBOL_DEPRECATED OFF}

interface

function StrToUTF8(const S: WideString): AnsiString;
function UTF8ToStr(const S: PAnsiChar; const Len: Integer = -1): WideString;
function QuotedStr(const S: WideString): WideString;
function FloatToSQLStr(Value: Extended): WideString;

implementation

uses SysUtils;

function StrToUTF8(const S: WideString): AnsiString;
begin
  Result := UTF8Encode(S);
end;

function UTF8ToStr(const S: PAnsiChar; const Len: Integer): WideString;
var
  UTF8Str: AnsiString;
begin
  if Len < 0 then
  begin
    Result := UTF8Decode(S);
  end
  else if Len > 0 then
  begin
    SetLength(UTF8Str, Len);
    Move(S^, UTF8Str[1], Len);
    Result := UTF8Decode(UTF8Str);
  end
  else Result := '';
end;

function QuotedStr(const S: WideString): WideString;
const
  Quote = #39;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = Quote then Insert(Quote, Result, I);
  Result := Quote + Result + Quote;
end;

function FloatToSQLStr(Value: Extended): WideString;
var
  SaveSeparator: Char;
begin
  SaveSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    Result := FloatToStr(Value);
  finally
    DecimalSeparator := SaveSeparator;
  end;
end;

end.
