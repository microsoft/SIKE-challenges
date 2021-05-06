#####################################
# computes the public parameters 
# from e2 and e3 exactly as in the 
# SIKE specification 
#####################################

p=2^e2*3^e3-1
assert p == 2^e2*3^e3-1;
assert is_prime(p)

Fp=GF(p)
Fp2.<i> = GF(p^2, modulus=x^2+1)
A=6
E0=EllipticCurve(Fp2,[0,A,0,1,0])

#####################################
######### square roots Fp2 ##########
######### according to spec #########
#####################################

def square_root(s):
    assert is_square(s)
    if s != 0:
        if s != 1:
            r=sqrt(Fp2(s))
            r=r.polynomial().list()
            alpha=r[0]
            beta=r[1]
            if alpha == 0:
                if is_odd(Integer(beta)):
                    beta=-beta
            else:
                if is_odd(Integer(alpha)):
                    alpha=-alpha
                    beta=-beta
            assert (alpha+beta*i)^2 == s
            return alpha+beta*i
        else:
            return 1
    else:
        return 0

#####################################
########### P2 generator ############
#####################################

c=-1

while True:
    while True:
        c = c + 1
        X = i + c
        fX = X^3+A*X^2+X
        if is_square(fX):
            break
    P2=3^e3*E0(X,square_root(fX))
    T=2^(e2-1)*P2
    if (T[0]+3)^2 == 8 and T[1] == 0:
        break

#####################################
########### Q2 generator ############
#####################################

c=-1

while True:
    while True:
        c = c + 1
        X = i + c
        fX = X^3+A*X^2+X
        if is_square(fX):
            break
    Q2=3^e3*E0(X,square_root(fX))
    T=2^(e2-1)*Q2
    if T == E0(0,0):
        break

#####################################
########### P3 generator ############
#####################################

c=-1
while True:
    while True:
        c = c + 1
        fc = c^3+A*c^2+c
        if is_square(Fp(fc)):
            break
    P3=2^(e2-1)*E0(c,sqrt(Fp(fc)))
    if P3.order() == 3^e3:
        break

#####################################
########### Q3 generator ############
#####################################

c=-1
while True:
    while True:
        c = c + 1
        fc = c^3+A*c^2+c
        if not is_square(Fp(fc)):
            break
    Q3=2^(e2-1)*E0(c,square_root(Fp2(fc)))
    if Q3.order() == 3^e3:
        break

#####################################
############## the R's ##############
#####################################

R2 = P2-Q2
R3 = P3-Q3

#####################################
############## parsing ##############
############# everything ############
#####################################

xP2=P2[0].polynomial().list()
xP20 = xP2[0]; xP21 = xP2[1]
yP2=P2[1].polynomial().list()
yP20 = yP2[0]; yP21 = yP2[1]
xQ2=Q2[0].polynomial().list()
xQ20 = xQ2[0]; xQ21 = xQ2[1]
yQ2=Q2[1].polynomial().list()
yQ20 = yQ2[0]; yQ21 = yQ2[1]
xP3=P3[0].polynomial().list()
xP30 = xP3[0]; xP31 = 0
yP3=P3[1].polynomial().list()
yP30 = yP3[0]; yP31 = 0
xQ3=Q3[0].polynomial().list()
xQ30 = xQ3[0]; xQ31 = 0
yQ3=Q3[1].polynomial().list()
yQ30 = yQ3[0]; yQ31 = yQ3[1]
xR2=R2[0].polynomial().list()
xR20 = xR2[0]; xR21 = xR2[1]
yR2=R2[1].polynomial().list()
yR20 = yR2[0]; yR21 = yR2[1]
xR3=R3[0].polynomial().list()
xR30 = xR3[0]; xR31 = xR3[1]
yR3=R3[1].polynomial().list()
yR30 = yR3[0]; yR31 = yR3[1]

#####################################
######## Write to file ##############
#####################################

file.write("Public parameters \n \n")

file.write("p = ")
file.write(p.hex())
file.write("\n")
file.write("e2 = ")	
file.write(e2.hex())
file.write("\n")
file.write("e3 = ")
file.write(e3.hex())
file.write("\n")
file.write("xQ20 = ")
file.write(Integer(xQ20).hex())
file.write("\n")
file.write("xQ21 = ")
file.write(Integer(xQ21).hex())
file.write("\n")
file.write("yQ20 = ")	
file.write(Integer(yQ20).hex())
file.write("\n")
file.write("yQ21 = ")	
file.write(Integer(yQ21).hex())
file.write("\n")
file.write("xP20 = ")
file.write(Integer(xP20).hex())
file.write("\n")
file.write("xP21 = ")
file.write(Integer(xP21).hex())
file.write("\n")
file.write("yP20 = ")	
file.write(Integer(yP20).hex())
file.write("\n")
file.write("yP21 = ")	
file.write(Integer(yP21).hex())
file.write("\n")
file.write("xR20 = ")	
file.write(Integer(xR20).hex())
file.write("\n")
file.write("xR21 = ")	
file.write(Integer(xR21).hex())
file.write("\n")
file.write("xQ30 = ")
file.write(Integer(xQ30).hex())
file.write("\n")
file.write("xQ31 = ")
file.write(Integer(xQ31).hex())
file.write("\n")
file.write("yQ30 = ")	
file.write(Integer(yQ30).hex())
file.write("\n")
file.write("yQ31 = ")	
file.write(Integer(yQ31).hex())
file.write("\n")
file.write("xP30 = ")
file.write(Integer(xP30).hex())
file.write("\n")
file.write("xP31 = ")
file.write(Integer(xP31).hex())
file.write("\n")
file.write("yP30 = ")	
file.write(Integer(yP30).hex())
file.write("\n")
file.write("yP31 = ")	
file.write(Integer(yP31).hex())
file.write("\n")
file.write("xR30 = ")	
file.write(Integer(xR30).hex())
file.write("\n")
file.write("xR31 = ")	
file.write(Integer(xR31).hex())
file.write("\n")