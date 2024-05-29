# $IKE challenges

This repository provides Sage scripts to generate SIKE challenge instances according to the SIKE specification (see https://sike.org/files/SIDH-spec.pdf). The secrets module requires that python3 be installed (this is automatically installed for the latest version of Sage). 

Inside "generate_challenge.sage" are 6 sets of parameters: the two mini prize instances $IKEp182 and $IKEp217, as well as the four instances currently in the SIKE specification. Additional parameters can be added by including a new e2 and e3 such that p=2^e2.3^e3-1 is prime. To generate a challenge instance, simply uncomment the corresponding parameters (leave all other parameters commented out), make sure the three files are in your current sage directory, and run

load("generate_challenge.sage")

... and a challenge instance will be written to a new file. 

The instance is implicitly an instance of the Supersingular Computational Diffie-Hellman (SSCDH) problem. The SHA3-512 hash of the solution is provided. 

Questions/comments: craigco@microsoft.com

# $IKEp182 and $IKEp217 cash prizes 

The files $IKEp182.txt and $IKEp217.txt define specific instances of the SSCDH problem. The first solution to the $IKEp182 instance will be awarded a cash prize of $5,000 USD. The first solution to the $IKEp217 instance will be awarded a cash prize of $50,000 USD. See https://www.microsoft.com/en-us/msrc/sike-cryptographic-challenge for further details. 

# $IKEp182 solved! 

CONGRATULATIONS to Aleksei Udovenko and Giuseppe Vitto, who successfully solved the $IKEp182 challenge on Saturday, August 28, 2021 and claimed the $5000 cash prize. See https://eprint.iacr.org/2021/1421.pdf for the details of their computation. 

# $IKEp217 solved! 

CONGRATULATIONS to Wouter Castryck and Thomas Decru, who successfully solved the $IKEp217 challenge on Friday, July 22, 2022 and claimed the $50000 cash prize. See https://eprint.iacr.org/2022/975.pdf for the details of their attack. 

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
