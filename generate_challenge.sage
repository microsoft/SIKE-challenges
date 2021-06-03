import sys
import secrets
import hashlib
load("montgomery_arithmetic.sage")

# GENERATE PRIZE INSTANCES
#e2=91;  e3=57;      file=open('$IKEp182.txt','w')
#e2=110; e3=67;     file=open('$IKEp217.txt','w')

# GENERATE REAL SIKE INSTANCES
e2=216; e3=137;    file=open('SIKEp434.txt','w')
#e2=250; e3=159;    file=open('SIKEp503.txt','w')
#e2=305; e3=192;    file=open('SIKEp610.txt','w')
#e2=372; e3=239;    file=open('SIKEp751.txt','w')

#####################################
######### PUBLIC PARAMETERS #########
#####################################

load("public_params.sage")
Q2=E0(xQ20+xQ21*i,yQ20+yQ21*i)     
P2=E0(xP20+xP21*i,yP20+yP21*i)
R2=E0(xR20+xR21*i,yR20+yR21*i)
assert(R2==P2-Q2)
Q3=E0(xQ30+xQ31*i,yQ30+yQ31*i)
P3=E0(xP30+xP31*i,yP30+yP31*i)
R3=E0(xR30+xR31*i,yR30+yR31*i)
assert(R3==P3-Q3)

#####################################
############ SECRET KEYS ############
#####################################

k_Alice = Integer(secrets.randbits(e2))
k_Bob = Integer(secrets.randbits(floor(log(3^e3,2))))

#####################################
############ ALICE KEYGEN ###########
#####################################

A_Alice = A
xS=ladder3pt(P2[0],Q2[0],R2[0],k_Alice,A_Alice)
pts=[xS,P3[0],Q3[0],R3[0]]

if is_odd(e2):
    x_ker=pts[0]
    for i in range(0,e2-1):
        x_ker=xDBL(x_ker,A_Alice)
    A_Alice,pts=iso2(x_ker,pts)

for e in range(floor(e2/2)-1,0,-1):    
    x_ker=pts[0]
    for i in range(0,e):
        x_ker=xDBL(x_ker,A_Alice)
        x_ker=xDBL(x_ker,A_Alice)
    A_Alice,pts=iso4(x_ker,pts)

A_Alice,PK_Alice=iso4(pts[0],[pts[1],pts[2],pts[3]])

#####################################
###### PARSE, PRINT AND WRITE #######
#####################################

PA=PK_Alice[0].polynomial().list()
QA=PK_Alice[1].polynomial().list()
RA=PK_Alice[2].polynomial().list()
PA0 = PA[0]; PA1 = PA[1]
QA0 = QA[0]; QA1 = QA[1]
RA0 = RA[0]; RA1 = RA[1]

print("\nAlice's public key - PA0||PA1||QA0||QA1||RA0||RA1:\n")
print(Integer(PA0).hex())
print(Integer(PA1).hex())
print(Integer(QA0).hex())
print(Integer(QA1).hex())
print(Integer(RA0).hex())
print(Integer(RA1).hex())

file.write("\nAlice's public key - PA0||PA1||QA0||QA1||RA0||RA1:\n\n")
file.write(Integer(PA0).hex())
file.write("\n")
file.write(Integer(PA1).hex())
file.write("\n")
file.write(Integer(QA0).hex())
file.write("\n")
file.write(Integer(QA1).hex())
file.write("\n")
file.write(Integer(RA0).hex())
file.write("\n")
file.write(Integer(RA1).hex())
file.write("\n")

#####################################
############# BOB KEYGEN ############
#####################################

A_Bob = A
xS=ladder3pt(P3[0],Q3[0],R3[0],k_Bob,A_Bob)
pts=[xS,P2[0],Q2[0],R2[0]]

for e in range(e3-1,0,-1):
    x_ker=pts[0]
    for i in range(0,e):
        x_ker=xTPL(x_ker,A_Bob)
    A_Bob,pts=iso3(x_ker,A_Bob,pts)

A_Bob,PK_Bob=iso3(pts[0],A_Bob,[pts[1],pts[2],pts[3]])

#####################################
###### PARSE, PRINT AND WRITE #######
#####################################

PB=PK_Bob[0].polynomial().list()
QB=PK_Bob[1].polynomial().list()
RB=PK_Bob[2].polynomial().list()
PB0 = PB[0]; PB1 = PB[1]
QB0 = QB[0]; QB1 = QB[1]
RB0 = RB[0]; RB1 = RB[1]

print("\nBob's public key - PB0||PB1||QB0||QB1||RB0||RB1:\n")
print(Integer(PB0).hex())
print(Integer(PB1).hex())
print(Integer(QB0).hex())
print(Integer(QB1).hex())
print(Integer(RB0).hex())
print(Integer(RB1).hex())

file.write("\nBob's public key - PB0||PB1||QB0||QB1||RB0||RB1:\n\n")
file.write(Integer(PB0).hex())
file.write("\n")
file.write(Integer(PB1).hex())
file.write("\n")
file.write(Integer(QB0).hex())
file.write("\n")
file.write(Integer(QB1).hex())
file.write("\n")
file.write(Integer(RB0).hex())
file.write("\n")
file.write(Integer(RB1).hex())
file.write("\n")

#####################################
########### ALICE SHARED ############
#####################################

A_Alice = MontFromPoints(PK_Bob[0],PK_Bob[1],PK_Bob[2])
xS=ladder3pt(PK_Bob[0],PK_Bob[1],PK_Bob[2],k_Alice,A_Alice)

pts=[xS]

if is_odd(e2):
    x_ker=pts[0]
    for i in range(0,e2-1):
        x_ker=xDBL(x_ker,A_Alice)
    A_Alice,pts=iso2(x_ker,pts)

for e in range(floor(e2/2)-1,0,-1):    
    x_ker=pts[0]
    for i in range(0,e):
        x_ker=xDBL(x_ker,A_Alice)
        x_ker=xDBL(x_ker,A_Alice)
    A_Alice,pts=iso4(x_ker,pts)

A_Alice=2*(2*pts[0]^4-1)

shared_Alice=jInv(A_Alice)

#####################################
###### PARSE, PRINT AND WRITE #######
#####################################

j=shared_Alice.polynomial().list()
j0 = "% s" % j[0]
j1 = "% s" % j[1]
out_Alice= hashlib.sha3_512((j0+j1).encode())
print("\nSHA3-512 hash of Alice's shared secret - SHA3-512(j0||j1):\n") 
print(out_Alice.hexdigest())

file.write("\nSHA3-512 hash of Alice's shared secret - SHA3-512(j0||j1):\n\n")
file.write(out_Alice.hexdigest())
file.write("\n")

del j0; del j1; del shared_Alice; del A_Alice; del xS; del pts; del x_ker;

#####################################
############ BOB SHARED #############
#####################################

A_Bob=MontFromPoints(PK_Alice[0],PK_Alice[1],PK_Alice[2])
xS=ladder3pt(PK_Alice[0],PK_Alice[1],PK_Alice[2],k_Bob,A_Bob)

pts=[xS]

for e in range(e3-1,0,-1):
	x_ker=pts[0]
	for i in range(0,e):
		x_ker=xTPL(x_ker,A_Bob)
	A_Bob,pts=iso3(x_ker,A_Bob,pts)

A_Bob=(6-6*pts[0]^2+A_Bob*pts[0])*pts[0];
shared_Bob=jInv(A_Bob)

#####################################
###### PARSE, PRINT AND WRITE #######
#####################################

j=shared_Bob.polynomial().list()
j0 = "% s" % j[0]; j1 = "% s" % j[1]
out_Bob= hashlib.sha3_512((j0+j1).encode())
print("\nSHA3-512 hash of Bob's shared secret - SHA3-512(j0||j1):\n")
print(out_Bob.hexdigest())

file.write("\nSHA3-512 hash of Bob's shared secret - SHA3-512(j0||j1):\n\n")
file.write(out_Bob.hexdigest())
file.write("\n")

del j0; del j1; del shared_Bob; del A_Bob; del xS; del pts; del x_ker;

file.close()

