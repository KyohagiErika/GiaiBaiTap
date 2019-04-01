program baitap_010;
const
	MAX_N = 10000;
	LINK = 'ACTIVITY.';
	IP = 'INP';
	OP = 'OUT';
type
	matrix = array[1..MAX_N,1..MAX_N] of Integer;
	vector = array[1..MAX_N] of Integer;
	edge = record
		ad, u, v : Integer;
	end;
var
	f: text;
	n: Integer;
	e: array[1..MAX_N] of edge;
	trace: matrix;
	P: vector;
procedure Input();
var
	i: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n);
	for i := 1 to n do
	begin
		e[i].ad := i;
		readln(f,e[i].u,e[i].v);
	end;
	close(f);
end;
procedure Sort(x, y : Integer);
var
	lock, i, j: Integer;
	tmp: edge;
begin
	if (x >= y) then exit;
	lock := e[(x+y) div 2].u;
	i := x;
	j := y;
	repeat
		while e[i].u < lock do i := i + 1;
		while e[j].u > lock do j := j - 1;
		if (i <= j) then
		begin
			tmp := e[i];
			e[i] := e[j];
			e[j] := tmp;
			i := i + 1;
			j := j - 1;
		end;
	until i > j;
	Sort(x,j);
	Sort(i,y);
end;	
procedure Process();
var
	i, j, jmax : Integer;
begin
	for i := 1 to n do
	begin
		jmax := i;
		P[i] := 1;
		for j := 1 to i-1 do
			if (e[j].v <= e[i].u) and (P[i] < (P[j] + 1)) then
			begin
				jmax := j;
				P[i] := P[j] + 1;
			end;
		trace[i] := trace[jmax];
		trace[i][P[i]] := e[i].ad;
	end;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,P[n]);
	for i := 1 to P[n] do writeln(f,trace[n][i],' ');
	close(f);
end;
begin
	Input;
	Sort(1,n);
	Process;
	Output;
end.
