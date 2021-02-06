function removeEfield(this,fieldname)
%removes external field of name _fieldname_
found = false;
tmp={};
if this.simulated == true
    this.efieldsChanged = true;
end
for i = 1:this.ne
    if strcmp(fieldname,this.Efields{i}.fieldname)
        this.Efields{i} = {};
        this.ne = this.ne-1;
        found = true;
    else
        tmp{end+1} = this.Efields{i};
    end
end
if found == false
    error(['there is no Efield named ' fieldname]);
end
this.Efields = tmp;
end