These sage scripts generate SIKE challenge instances according to the SIKE specification (see https://sike.org/files/SIDH-spec.pdf). 

Inside "generate_challenge.sage" are 6 sets of parameters: the two mini "prize money" instances $IKEp182 and $IKEp217, as well as the four instances currently in the SIKE specification. Additional parameters can be added by including a new e2 and e3 such that p=2^e2.3^e3-1 is prime. To generate a challenge instance, simply uncomment the parameters, make sure the three files are in your current sage directory, and run

load("generate_challenge.sage")

... and a challenge instance will be written to a new file. 

The instance is implicitly an instance of the Supersingular Computational Diffie-Hellman (SSCDH) problem. The SHA3-512 hash of the solution is provided. 

Questions/comments: craigco@microsoft.com
