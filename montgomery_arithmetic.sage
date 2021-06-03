#####################################
# all the Montgomery point and 
# isogeny arithmetic exactly as
# in the SIKE specification
#####################################

#####################################
########## Montgomery xADD ##########
#####################################

def xADD(xP,xQ,xR):
    return (xP*xQ-1)^2/(xP-xQ)^2/xR

#####################################
########## Montgomery xDBL ##########
#####################################

def xDBL(x,a):
	return (x^2-1)^2/(4*x*(x^2+a*x+1))

#####################################
########## Montgomery xTPL ##########
#####################################

def xTPL(x,a):
	return (x^4-6*x^2-4*a*x-3)^2*x/(3*x^4+4*a*x^3+6*x^2-1)^2

#####################################
########## 3 point ladder ###########
#####################################

def ladder3pt(xP,xQ,xR,k,A):
    bits=k.bits()
    R0=xQ
    R1=xP
    R2=xR
    for i in range(0,len(bits)-1):
        if bits[i] == 1:
            R1=xADD(R0,R1,R2)
        else:
            R2=xADD(R0,R2,R1)
        R0=xDBL(R0,A)
    R1=xADD(R0,R1,R2)
    return R1

#####################################
############# 2-isogeny #############
#####################################

def iso2(alpha,pts):
    image_pts=[]
    for x in pts:
        image_pts.append(x*(alpha*x-1)/(x-alpha))
    return 2*(1-2*alpha^2),image_pts

#####################################
############# 3-isogeny #############
#####################################

def iso3(beta,a,pts):
    image_pts=[]
    for x in pts:
        image_pts.append(x*(beta*x-1)^2/(x-beta)^2)
    return (6-6*beta^2+a*beta)*beta,image_pts

#####################################
############# 4-isogeny #############
#####################################

def iso4(alpha,pts):
    image_pts=[]
    for x in pts:
        image_pts.append(x*(alpha^2*x-2*alpha+x)*(alpha*x-1)^2/((alpha^2-2*alpha*x+1)*(alpha-x)^2))
    return 2*(2*alpha^4-1),image_pts

#####################################
############ j-invariant ############
#####################################

def jInv(a):
    return 256*(a^2-3)^3/(a^2-4)

#####################################
##### Montgomery a from points ######
### cpfk in SIKE spec (sec 1.2.1) ###
#####################################

def MontFromPoints(xP,xQ,xR):
    return (1-xP*xQ-xP*xR-xQ*xR)^2/(4*xP*xQ*xR)-xP-xQ-xR