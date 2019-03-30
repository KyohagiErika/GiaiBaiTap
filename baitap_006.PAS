program baitap_006;
const
	MAX_N = 1000;
type
	vector = array[1..MAX_N] of Integer;
	matrix = array[1..MAX_N,1..MAX_N] of Integer;
var
	n,_reslt : integer;
	c: matrix;
	x: vector;
	reslt : array[1..MAX_N] of string;
	checked: array[1..MAX_N] of Boolean;
procedure Input();
begin
	readln(n);
end;
procedure Setup();
var
	i,j: Integer;
begin
	_reslt := 0;
	n := 2*n;
	for i := 1 to n do 
		for j := 1 to n do 
			if (i <> j) then
				c[i,j] := i+j;
	for i := 1 to n do
		checked[i] := false;
end;
function Prime(numb : integer): Boolean;
var
	i: Integer;
begin
	if numb <= 1 then
		exit(false)
	else
		if numb = 2 then
			exit(true)
		else
			for i := 2 to round(sqrt(numb)) do
				if (numb mod i) = 0 then
					exit(false);
	exit(true);
end;
procedure Update(x:vector;k:Integer);
var
	i: Integer;
	tmp : string;
begin
	_reslt := _reslt + 1;
	reslt[_reslt] := '';
	for i := 1 to k do
	begin
		str(x[i],tmp);
		reslt[_reslt] := reslt[_reslt] + tmp + ' ';
	end;
end;
procedure Process(i :Integer);
var
	xi, j: Integer;
	ok : Boolean;
begin
	if (i = 1) then
	begin
		x[i] := 1;
		checked[x[i]] := true;
		Process(i+1);
	end
	else
		for xi := 1 to n do
			if (not checked[xi]) and (Prime(c[x[i-1],xi])) then
			begin
				x[i] := xi;
				checked[x[i]] := true;
				ok := true;
				for j := 1 to n do
					if not checked[j] then
					begin
						ok := false;
						break;
					end;
				if ok and (Prime(c[x[i],1])) then
					Update(x,i)
				else
					Process(i+1);
				checked[x[i]] := false;
				x[i] := 0;
			end;
end;
procedure Output();
var
	i: Integer;
begin
	writeln(_reslt);
	for i := 1 to _reslt do
		writeln(reslt[i]);
end;
begin
	Input;
	Setup;
	Process(1);
	Output;
end.
