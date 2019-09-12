Release 700
Patchlevel  19
MaxSuspiciousMachtes  1000000000
Token 15  21  30
0:  "#ANYKW#"
1:  "#NOTINUSE#"
2:  "#EOF#"
3:  "#NL#"
4:  "#COMMENT1#"
5:  "#COMMENT2#"
6:  "("
7:  ")"
8:  "+"
9:  "*"
10: "="
11: ";"
12: "#STR_CONST#"
13: "#INT_CONST#"
14: "#ERROR#"
15: "#ID#"
16: "TRUE"
17: "FALSE"
18: "OR"
19: "AND"
20: "NOT"
21: "^.[8,0]"
22: "^:Variable"
23: "^:Constant"
24: "^:Assignment"
25: "^:LHS"
26: "^:RHS"
27: "^:Disjunction"
28: "^:Conjunction"
29: "^:Negation"

rule  VARIABLE
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  6
follow= 2 7 10 11 18 19
  ASTA  0 0 1
  MTCH  0 0 0 15
  ASTA  0 1 1
  RETN

rule  CONSTANT
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  5
follow= 2 7 11 18 19
  ASTA  0 0 2
  BRAN  0 0 2
  16  L1
  17  L2
L1:
  MTCH  0 0 0 16
L0:
  ASTA  0 1 2
  RETN
L2:
  MTCH  0 0 0 17
  GOTO  L0

rule  ASSIGNMENT
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  1
follow= 11
  ASTA  0 0 3
  PSHF  2 LHS
  CALL  LHS
  MTCH  0 0 0 10
  PSHF  4 RHS
  CALL  RHS
  ASTA  0 1 3
  RETN

rule  LHS
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  1
follow= 10
  ASTA  0 0 4
  PSHF  3 VARIABLE
  CALL  VARIABLE
  ASTA  0 1 4
  RETN

rule  RHS
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  3
follow= 2 7 11
  ASTA  0 0 5
  PSHF  5 DISJUNCTION
  CALL  DISJUNCTION
  ASTA  0 1 5
  RETN

rule  DISJUNCTION
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  3
follow= 2 7 11
  ASTA  0 0 6
  PSHF  6 CONJUNCTION
  CALL  CONJUNCTION
L3:
  BRAN  0 0 4
  2 L4
  7 L4
  11  L4
  18  L5
L5:
  MTCH  0 0 0 18
  PSHF  14  CONJUNCTION
  CALL  CONJUNCTION
  GOTO  L3
L4:
  ASTA  0 1 6
  RETN

rule  CONJUNCTION
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  4
follow= 2 7 11 18
  ASTA  0 0 7
  PSHF  7 FACTOR
  CALL  FACTOR
L7:
  BRAN  0 0 5
  2 L8
  7 L8
  11  L8
  18  L8
  19  L9
L9:
  MTCH  0 0 0 19
  PSHF  13  FACTOR
  CALL  FACTOR
  GOTO  L7
L8:
  ASTA  0 1 7
  RETN

rule  NEGATION
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  5
follow= 2 7 11 18 19
  ASTA  0 0 8
  MTCH  0 0 0 20
  PSHF  9 FACTOR
  CALL  FACTOR
  ASTA  0 1 8
  RETN

rule  FACTOR
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
fllwc=  5
follow= 2 7 11 18 19
  BRAN  1 1 5
  6 L15
  15  L14
  16  L13
  17  L13
  20  L12
L12:
  PSHF  8 NEGATION
  CALL  NEGATION
  RETN
L13:
  PSHF  10  CONSTANT
  CALL  CONSTANT
  RETN
L14:
  PSHF  11  VARIABLE
  CALL  VARIABLE
  RETN
L15:
  MTCH  0 0 0 6
  PSHF  12  RHS
  CALL  RHS
  MTCH  0 0 0 7
  RETN

rule  START
rflags= 0
role= 0
tc= 0
flgc= 0
phrase= ""
startrule= "true"
fllwc=  1
follow= 2
L16:
  BRAN  1 1 6
  6 L17
  15  L17
  15  L18
  16  L17
  17  L17
  20  L17
L18:
  PSHF  1 ASSIGNMENT
  CALL  ASSIGNMENT
  MTCH  0 0 0 11
  GOTO  L16
L17:
  PSHF  15  RHS
  CALL  RHS
  RETN
  RETN
  PSHF  0 START
  CALL  START
  STOP
