{
  bài này do không có ý tưởng, phải viết bằng quay lui, cần cải tiến
}
program baitap_010;
const
	MAX_N = 10000;
	LINK = 'ACTIVITY.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..MAX_N] of Integer;
	edge = record
		x, y : Integer;
	end;
var
	f: text;
	n, _reslt, k: Integer;
	e: array[1..MAX_N] of edge;
	x, reslt: vector;
procedure Input();
var
	i: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n);
	for i := 1 to n do
		readln(f,e[i].x,e[i].y);
	close(f);
	_reslt := 0;
end;
procedure Update(x : vector ; k : Integer);
var
	i: Integer;
	ok : Boolean;
begin
	ok := true;
	for i := 2 to k do
		if not (e[x[i-1]].y <= e[x[i]].x) then
		begin
			ok := false;
			break;
		end;
	if ok and (k > _reslt) then
	begin
		_reslt := k;
		reslt := x;
	end;
end;
procedure Process(k, i : Integer);
var
	xi, j: Integer;
	ok : Boolean;
begin
	if (i > k) then
		Update(x,k)
	else
		for xi := 1 to n do
		begin
			ok := true;
			for j := 1 to i-1 do
				if (xi = x[j]) then
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
		writeln(f,reslt[i]);
	close(f);
end;
begin
	Input;
	for k := 1 to n do Process(k,1);
	Output;
end.
