" Vim syntax file
" Language:     Nimrod
" Maintainer:   Kearn Holliday (thekearnman at gmail dot com)
" Updated: 2009-05-15
"
" Options to control nimrod syntax highlighting:
"
" For highlighted numbers:
"
   let nimrod_highlight_numbers = 1
"
" For highlighted builtin functions:
"
   let nimrod_highlight_builtins = 1
"
" For highlighted standard exceptions:
"
   let nimrod_highlight_exceptions = 1
"
" Highlight erroneous whitespace:
"
   let nimrod_highlight_space_errors = 1
"
" If you want all possible nimrod highlighting (the same as setting the
" preceding options):
"
"    let nimrod_highlight_all = 1
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn region nimrodBrackets       contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster

syn keyword nimrodStatement     addr as asm
syn keyword nimrodStatement     block break
syn keyword nimrodStatement     case cast const continue converter
syn keyword nimrodStatement     discard div
syn keyword nimrodStatement     elif else end enum except exception echo
syn keyword nimrodStatement     finally for from generic
syn keyword nimrodStatement     if implies import include isnot iterator
syn keyword nimrodStatement     lambda
syn keyword nimrodStatement     macro method mod
syn keyword nimrodStatement     nil notin
syn keyword nimrodStatement     object of out
syn keyword nimrodStatement     proc ptr
syn keyword nimrodStatement     raise ref return
syn keyword nimrodStatement     template try tuple type
syn keyword nimrodStatement     var
syn keyword nimrodStatement     when where while with without
syn keyword nimrodStatement     yield
syn match   nimrodFunction      "[a-zA-Z_][a-zA-Z0-9_]*" contained
syn match   nimrodClass         "[a-zA-Z_][a-zA-Z0-9_]*" contained
syn keyword nimrodRepeat        for while
syn keyword nimrodConditional   if elif else case of
syn keyword nimrodOperator      and in is not or xor shl shr
syn match   nimrodComment       "#.*$" contains=nimrodTodo,@Spell
syn keyword nimrodTodo          TODO FIXME XXX contained


" strings
syn region nimrodString         matchgroup=Normal start=+[uU]\=`+ end=+`+ skip=+\\\\\|\\"+ contains=nimrodEscape,@Spell
syn region nimrodString         matchgroup=Normal start=+[uU]\="+ end=+"+ skip=+\\\\\|\\"+ contains=nimrodEscape,@Spell
syn region nimrodRawString      matchgroup=Normal start=+[uU]\=[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell
syn match  nimrodEscape         +\\[abfnrtv'"\\]+ contained
syn match  nimrodEscape         "\\\o\{1,3}" contained
syn match  nimrodEscape         "\\x\x\{2}" contained
syn match  nimrodEscape         "\(\\u\x\{4}\|\\U\x\{8}\)" contained
syn match  nimrodEscape         "\\$"

if exists("nimrod_highlight_all")
  let nimrod_highlight_numbers      = 1
  let nimrod_highlight_builtins     = 1
  let nimrod_highlight_exceptions   = 1
  let nimrod_highlight_space_errors = 1
endif

if exists("nimrod_highlight_numbers")
  " numbers (including longs and complex)
  syn match   nimrodNumber      "\<0x\x\+[Ll]\=\>"
  syn match   nimrodNumber      "\<\d\+[LljJ]\=\>"
  syn match   nimrodNumber      "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syn match   nimrodNumber      "\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
  syn match   nimrodNumber      "\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
endif

if exists("nimrod_highlight_builtins")
  " builtin functions, types and objects, not really part of the syntax
  syn keyword nimrodBuiltin int int8 int16 int32 int64 float float32 float64 bool
  syn keyword nimrodBuiltin char string cstring pointer range array openarray seq
  syn keyword nimrodBuiltin set Byte Natural Positive TObject PObject Conversion TResult TAddress
  syn keyword nimrodBuiltin BiggestInt BiggestFloat cchar cschar cshort cint
  syn keyword nimrodBuiltin clong clonglong cfloat cdouble clongdouble
  syn keyword nimrodBuiltin cstringArray TEndian PFloat32 PFloat64 PInt64 PInt32
  syn keyword nimrodBuiltin TGC_Strategy TFile TFileMode TFileHandle isMainModule
  syn keyword nimrodBuiltin CompileDate CompileTime NimrodVersion NimrodMajor
  syn keyword nimrodBuiltin NimrodMinor NimrodPatch cpuEndian hostOS hostCPU inf
  syn keyword nimrodBuiltin neginf nan QuitSuccess QuitFailure dbgLineHook stdin
  syn keyword nimrodBuiltin stdout stderr defined new high low sizeof succ pred
  syn keyword nimrodBuiltin inc dec newSeq len incl excl card ord chr ze ze64
  syn keyword nimrodBuiltin toU8 toU16 toU32 abs min max add repr
  syn match   nimrodBuiltin "\<contains\>"
  syn keyword nimrodBuiltin toFloat toBiggestFloat toInt toBiggestInt addQuitProc
  syn keyword nimrodBuiltin copy setLen newString zeroMem copyMem moveMem
  syn keyword nimrodBuiltin equalMem alloc alloc0 realloc dealloc setLen assert
  syn keyword nimrodBuiltin swap getRefcount getCurrentException Msg
  syn keyword nimrodBuiltin getOccupiedMem getFreeMem getTotalMem isNil seqToPtr
  syn keyword nimrodBuiltin find pop GC_disable GC_enable GC_fullCollect
  syn keyword nimrodBuiltin GC_setStrategy GC_enableMarkAnd Sweep
  syn keyword nimrodBuiltin GC_disableMarkAnd Sweep GC_getStatistics GC_ref
  syn keyword nimrodBuiltin GC_ref GC_ref GC_unref GC_unref GC_unref quit
  syn keyword nimrodBuiltin OpenFile OpenFile CloseFile EndOfFile readChar
  syn keyword nimrodBuiltin FlushFile readFile write readLine writeln writeln
  syn keyword nimrodBuiltin getFileSize ReadBytes ReadChars readBuffer writeBytes
  syn keyword nimrodBuiltin writeChars writeBuffer setFilePos getFilePos
  syn keyword nimrodBuiltin fileHandle countdown countup items lines
endif

if exists("nimrod_highlight_exceptions")
  " builtin exceptions and warnings
  syn keyword nimrodException E_Base EAsynch ESynch ESystem EIO EOS
  syn keyword nimrodException ERessourceExhausted EArithmetic EDivByZero
  syn keyword nimrodException EOverflow EAccessViolation EAssertionFailed
  syn keyword nimrodException EControlC EInvalidValue EOutOfMemory EInvalidIndex
  syn keyword nimrodException EInvalidField EOutOfRange EStackOverflow
  syn keyword nimrodException ENoExceptionToReraise EInvalidObjectAssignment
  syn keyword nimrodException EInvalidObject
endif

if exists("nimrod_highlight_space_errors")
  " trailing whitespace
  syn match   nimrodSpaceError   display excludenl "\S\s\+$"ms=s+1
  " mixed tabs and spaces
  syn match   nimrodSpaceError   display " \+\t"
  syn match   nimrodSpaceError   display "\t\+ "
endif

syn sync match nimrodSync grouphere NONE "):$"
syn sync maxlines=200
syn sync minlines=2000

if version >= 508 || !exists("did_nimrod_syn_inits")
  if version <= 508
    let did_nimrod_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink nimrodBrackets         Operator
  HiLink nimrodStatement        Statement
  HiLink nimrodFunction         Function
  HiLink nimrodConditional      Conditional
  HiLink nimrodRepeat           Repeat
  HiLink nimrodString           String
  HiLink nimrodRawString        String
  HiLink nimrodEscape           Special
  HiLink nimrodOperator         Operator
  HiLink nimrodPreCondit        PreCondit
  HiLink nimrodComment          Comment
  HiLink nimrodTodo             Todo
  HiLink nimrodDecorator        Define
  if exists("nimrod_highlight_numbers")
    HiLink nimrodNumber Number
  endif
  if exists("nimrod_highlight_builtins")
    HiLink nimrodBuiltin        Number
  endif
  if exists("nimrod_highlight_exceptions")
    HiLink nimrodException      Exception
  endif
  if exists("nimrod_highlight_space_errors")
    HiLink nimrodSpaceError     Error
  endif

  delcommand HiLink
endif

let b:current_syntax = "nimrod"



