program baitap_031;
const
	MAX_N = 10000;
	LINK = 'CANDY.';
	IP = 'INP';
	OP = 'OUT';
type
	matrix = array[0..MAX_N,0..MAX_N] of Integer;
	vector = array[1..MAX_N] of Integer;
var
	f: text;
	n, m, w, _trace, _x1, _x2: Integer;
	A, trace, x1, x2: vector;
	P: matrix;
procedure Input();
var
	i: Integer;
begin
	w := 0;
	assign(f,LINK+IP);
	reset(f);
	readln(f,n);
	for i := 1 to n do
	begin
		readln(f,A[i]);
		w := w + A[i];
	end;
	close(f);
	m := w div 2;
end;
procedure FindX1();
var
	i, j: Integer;
begin
	for i := 1 to n do
		P[i,0] := 0;
	for j := 1 to m do
		P[0,j] := 0;
	for i := 1 to n do
		for j := 1 to m do
			if A[i] > j then
				P[i,j] := P[i-1,j]
			else
				if (P[i-1,j-A[i]]+A[i]) > P[i-1,j] then
					P[i,j] := P[i-1,j-A[i]]+A[i]
				else
					P[i,j] := P[i-1,j];
	
end;
procedure FindPath(n, m : Integer);
var
	i, j, tmp: Integer;
begin
	_trace := 0;
	while (n <> 0) and (m <> 0) do
		if P[n,m] = P[n-1,m] then
			n := n - 1
		else
		begin
			_trace := _trace + 1;
			trace[_trace] := n;
			m := m - A[n];
			n := n - 1;
		end;
	i := 1;
	j := _trace;
	repeat
		tmp := trace[i];
		trace[i] := trace[j];
		trace[j] := tmp;
		i := i + 1;
		j := j - 1;
	until i >= j;
end;
procedure FindX2();
var
	i, j: Integer;
	ok: Boolean;
begin
	x1 := trace;
	_x1 := _trace;
	x1[_x1+1] := P[n,m];
	_x2 := 0;
	for i := 1 to n do
	begin
		ok := true;
		for j := 1 to _x1 do
			if i = x1[j] then
			begin
				ok := false;
				break;
			end;
		if ok then 
		begin
			_x2 := _x2 + 1;
			x2[_x2] := i;
		end;
	end;
	x2[_x2+1] := w - x1[_x1+1];
end;
procedure Process();
begin
	FindX1;
	FindPath(n,m);
	FindX2;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,_x1,' ',x1[_x1+1]);
	for i := 1 to _x1 do
		writeln(f,x1[i]);
	writeln(f,_x2,' ',x2[_x2+1]);
	for i := 1 to _x2 do
		writeln(f,x2[i]);
	close(f);
end;
begin
	Input;
	Process;
	Output;
end.	
