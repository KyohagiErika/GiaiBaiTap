program baitap_134;
const
	MAX = 1000;
	LINK = 'SCHOLAR.';
	IP = 'INP';
	OP = 'OUT';
type
	Studen = record
		sName : string[25];
		score : real;
	end;
var
	f : text;
	n, _reslt: Integer;
	A : array[1..MAX] of Studen;
procedure Input();
var
	i: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n);
	for i := 1 to n do
		with A[i] do
		begin
			readln(f,sName);
			readln(f,score);
		end;
	close(f);
end;
procedure Sort(x, y : Integer);
var
	i, j: Integer;
	lock : real;
	tmp : Studen;
begin
	if (x >= y) then exit;
	lock := A[(x+y) div 2].score;
	i := x;
	j := y;
	repeat
	 	while A[i].score > lock do i := i + 1;
	 	while A[j].score < lock do j := j - 1;
	 	if i <= j then
	 	begin
	 		tmp := A[i];
	 		A[i] := A[j];
	 		A[j] := tmp;
	 		i := i + 1;
	 		j := j - 1;
	 	end;
	until i > j; 
	Sort(x,j);
	Sort(i,y);
end;
procedure Process();
begin
	_reslt := 1;
	while ((_reslt + 1) <= n) and (A[_reslt+1].score = A[_reslt].score) do _reslt := _reslt + 1;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	for i := 1 to _reslt do
		writeln(f,A[i].sName);
	close(f);
end;
begin
	Input;
	Sort(1,n);
	Process;
	Output;
end.
