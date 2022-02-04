#Lists mutations when comparing amino acid sequences of the same length
#Takes 2 positional args - original vs query sequence
import sys,os,argparse
my_parser= argparse.ArgumentParser(description='List')
my_parser.add_argument('Original_seq',type=str)
my_parser.add_argument('Mutant_seq',type=str)
args=my_parser.parse_args()
a=args.Original_seq
b=args.Mutant_seq
for j in range(0,len(a)):
     if a[j]!=b[j]:
             print(a[j]+str(j+1)+b[j])
