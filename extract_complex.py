from schrodinger import structure
import sys, os, argparse

def main(argv):
   my_parser = argparse.ArgumentParser(description='List')
   my_parser.add_argument('Input',metavar='Input',type=str, help='input file from PIPER docking in .maegz format')
   my_parser.add_argument('Pose',metavar='Pose number',type=int, help='pose number of the lowest energy pose')


   args = my_parser.parse_args()

   fname = args.Input # just the name of file to load
   n = args.Pose # 1-based index
   st = structure.StructureReader.read(fname, index=n)
   modified_fname = fname.replace(".maegz","") + "_pose_" + str(n) + ".mae"
   with structure.StructureWriter(modified_fname) as writer:
      writer.append(st)

if __name__ == "__main__":
   main(sys.argv[1:])
