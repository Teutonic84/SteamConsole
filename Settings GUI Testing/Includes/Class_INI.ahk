/*
INI_Init(inifile)     ;prepares the global variables to be populated
INI_Load(inifile)     ;Reads all the settings into the global variables from the file
INI_Save(inifile)     ;Saves all the settings from the global variables into the file
*/

INI_Init(inifile = "inifile.ini"){
  global
  local key,temp
  inisections:=0

  loop,read,%inifile%
  {
    if regexmatch(A_Loopreadline,"\[(.*)?]")
      {
        inisections+= 1
        section%inisections%:=regexreplace(A_loopreadline,"(\[)(.*)?(])","$2")
        section%inisections%_keys:=0
      }
    else if regexmatch(A_LoopReadLine,"(\w+)=(.*)")
      {
        section%inisections%_keys+= 1
        key:=section%inisections%_keys
        section%inisections%_key%key%:=regexreplace(A_LoopReadLine,"(\w+)=(.*)","$1")
      }
  }
}

INI_Load(inifile="inifile.ini"){
  global
  local sec,var
  loop,%inisections%
    {
      sec:=A_index
      loop,% section%a_index%_keys
        {
          var:=section%sec% "_" section%sec%_key%A_index%,
          Stringreplace,var,var,%a_space%,,All
          iniread,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
        }
    }
}
;val%A_index%:=%var%

INI_Save(inifile="inifile.ini"){
  global
  local sec,var
  loop,%inisections%
    {
      sec:=A_index
      loop,% section%a_index%_keys
        {
          var:=section%sec% "_" section%sec%_key%A_index%
          Stringreplace,var,var,%a_space%,,All
          var:=%var%
          iniwrite,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
        }
    }
}
