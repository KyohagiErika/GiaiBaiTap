program baitap_005;
const
	MAX_N = 1000;
	LINK = 'FIBISTR.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..MAX_N] of String;
var
	fin, fout: text;
	n, times : Integer;
	// checked: array[1..MAX_N] of Integer;
	S : String;
	F : vector;
procedure fibiInit();
var
	i: Integer;
begin
	F[1] := 'A';
	F[2] := 'B';
	for i := 3 to n do
		F[i] := F[i-1] + F[i-2];
end;
procedure Update(x, y : Integer);
var
	i: Integer;
	tmp : string;
begin
	tmp := '';
	for i := x to y do
		tmp := tmp + F[n][i];
	if S = tmp then
		times := times + 1;
end;
procedure Process();
var
	i, j: Integer;
begin
	assign(fin,LINK+IP);
	assign(fout,LINK+OP);
	reset(fin);
	rewrite(fout);
	while not eof(fin) do
	begin
		readln(fin,n,S);
		delete(S, 1, 1);
		fibiInit;
		times := 0;
		for i := 1 to (length(F[n])-length(S)+1) do
			Update(i,i+length(S)-1);
		writeln(fout,times);
	end;
	close(fin);
	close(fout);
end;
begin
	Process();
end.
