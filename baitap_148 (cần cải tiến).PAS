{
	do chưa nắm rõ quy hoạch động nên làm bằng quay lui (dạng sinh tập hợp con)
}
program baitap_148;
const
	MAX_N = 10000;
	LINK = 'INCSEQ.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..MAX_N] of Integer;
var
	f: text;
	n, _reslt, k: Integer;
	A, x, reslt : vector;
procedure Input();
var
	i: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n);
	for i := 1 to n do 
		read(f,A[i]);
	close(f);
end;
procedure Update(x : vector ; k : Integer);
var
	i: Integer;
	ok : Boolean;
begin
	ok := true;
	for i := 2 to k do
		if A[x[i]] <= A[x[i-1]] then
		begin
			ok := false;
			break;
		end;
	if ok and (k > _reslt) then
	begin
		_reslt := k;
		for i := 1 to k do
			reslt[i] := A[x[i]];
	end;
end;
procedure Process(k,i : Integer);
var
	j, xi: Integer;
	ok : Boolean;
begin
	if (i > k) then
		Update(x,k)
	else
		for xi := 1 to n do
		begin
			ok := true;
			for j := 1 to i-1 do
				if (xi <= x[j]) then
				begin
					ok := false;
					break;
				end;
			if ok then
			begin
				x[i] := xi;
				Process(k,i+1);
				x[i] := 0;
			end;
		end;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,_reslt);
	for i := 1 to _reslt do
		write(f,reslt[i],' ');
	close(f);
end;
begin
	Input;
	for k := 1 to n do Process(k,1);
	Output;
end.
