program baitap_023;
const
	LINK = 'C:\PascalFiles\OPT.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..100000] of Integer;
var
	f: text;
	a, b : string;
procedure Input();
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,a);
	readln(f,b);
	close(f);
end;
function Add(a, b : string) : string;
var
	i, n: Integer;
	tmp_a, tmp_b, _tmp : vector;
	tmp : string;
begin
	Add := '';
	while length(a) < length(b) do a := '0' + a;
	while length(b) < length(a) do b := '0' + b;
	n := length(a);
	for i := 1 to n do _tmp[i] := 0;
	for i := n downto 1 do
	begin
		val(a[i],tmp_a[i]);
		val(b[i],tmp_b[i]);
		_tmp[i] := _tmp[i] + tmp_a[i] + tmp_b[i];
		if (_tmp[i] > 9) and (i > 1) then
		begin
			_tmp[i] := _tmp[i] - 10;
			_tmp[i-1] := 1;
		end;
		str(_tmp[i],tmp);
		Add := tmp + Add;
	end;
end;
function lool(a, b : string): Integer;
begin
	while length(a) < length(b) do a := '0' + a;
	while length(b) < length(a) do b := '0' + b;
	if a > b then
		exit(1)
	else
		if a < b then
			exit(-1)
		else
			exit(0);
end;
function Minus(a, b : string): string;
var
	i, n, j: Integer;
	tmp_a, tmp_b, _tmp : vector;
	tmp : string;
begin
	while length(a) < length(b) do a := '0' + a;
	while length(b) < length(a) do b := '0' + b;
	if lool(a,b) = 0 then
		exit('0')
	else
		if lool(a,b) = -1 then
			exit('-'+Minus(b,a))
		else
		begin
			Minus := '';
			n := length(a);
			for i := 1 to n do
			begin
				val(a[i],tmp_a[i]);
				val(b[i],tmp_b[i]);
			end;
			for i := n downto 1 do
			begin
				if (tmp_a[i] < tmp_b[i]) then
				begin
					tmp_a[i] := tmp_a[i] + 10;
					tmp_b[i-1] := tmp_b[i-1] + 1;
					j := i-1;
					while (tmp_b[j] > 9) and (j > 1) do
					begin
						tmp_b[j] := 0;
						tmp_b[j-1] := tmp_b[j-1] + 1;
						j := j - 1;
					end;
				end;
				_tmp[i] := tmp_a[i] - tmp_b[i];
				str(_tmp[i],tmp);
				Minus := tmp + Minus;
			end;
		end;
end;
function SmallMul(a : string ; b : Integer): string;
var
	i: Integer;
begin
	SmallMul := '0';
	for i := 1 to b do
		SmallMul := Add(SmallMul,a);
end;
function Multiply(a, b : string): string;
var
	i, n, tmp: Integer;
	j : string;
begin
	if (a = '0') or (b = '0') then
		exit('0');
	n := length(b);
	Multiply := '0';
	j := '';
	for i := n downto 1 do
	begin
		val(b[i],tmp);
		Multiply := Add(Multiply,SmallMul(a,tmp)+j);
		j := j + '0';
	end;
end;
function Divide(a, b : string): string;
var
	i, j: Integer;
	tmp, _tmp : string;
begin
	if lool(a,b) = -1 then
		exit('0')
	else
		if lool(a,b) = 0 then
			exit('1')
		else
		begin
			Divide := '';
			i := 1;
			tmp := a[i];
			while (i <= length(a)) do
			begin
				j := 0;
				while lool(SmallMul(b,j),tmp) <= 0 do j := j + 1;
				j := j - 1;
				str(j,_tmp);
				Divide := Divide + _tmp;
				tmp := Minus(tmp,SmallMul(b,j));
				i := i + 1;
				tmp := tmp + a[i];
			end;
			while Divide[1] = '0' do delete(Divide,1,1);
		end;
end;
function ModCal(a, b : string): string;
var
	i, j: Integer;
	tmp : string;
begin
	if (a = '0') or (b = '0') then
		exit('0')
	else
		if lool(a,b) = 0 then
			exit('0')
		else
			if lool(a,b) = -1 then
				exit(b)
			else
			begin
				i := 1;
				tmp := a[i];
				while (i <= length(a)) do
				begin
					j := 0;
					while lool(SmallMul(b,j),tmp) <= 0 do j := j + 1;
					j := j - 1;
					tmp := Minus(tmp,SmallMul(b,j));
					i := i + 1;
					tmp := tmp + a[i];
				end;
				ModCal := tmp;
				while ModCal[1] = '0' do delete(ModCal,1,1);
			end;
end;
procedure Output();
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,Add(a,b));
	writeln(f,Minus(a,b));
	writeln(f,Multiply(a,b));
	writeln(f,Divide(a,b));
	writeln(f,ModCal(a,b));
	close(f);
end;
begin
	Input;
	Output;
end.
