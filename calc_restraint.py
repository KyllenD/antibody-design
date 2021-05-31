from schrodinger import structure
from schrodinger.structutils import measure
import sys, os, argparse,math

def main(argv):
   my_parser = argparse.ArgumentParser(description='List')
   my_parser.add_argument('Input',metavar='input_structure',type=str,help='input file')
   my_parser.add_argument('Ligand_atom',metavar='ligand_atom1',type=int, help='atom index number')
   my_parser.add_argument('Receptor_atom',metavar='recptor_atom1',type=int,help='atom index number')
   my_parser.add_argument('Distance',metavar='dist',type=float,help='distance between interacting atoms')
   args = my_parser.parse_args()

   fname = args.Input # just the name of file to load

   st = structure.StructureReader.read(fname)
   a1 = st.atom[args.Ligand_atom]
   a2 = st.atom[args.Ligand_atom-1]
   a3 = st.atom[args.Receptor_atom]
   a4 = st.atom[args.Receptor_atom+1]

   angle1 = measure.measure_bond_angle(a3, a1, a2)
   angle2 = measure.measure_bond_angle(a1, a3, a4)

#===================================================================================================
# INPUTS
#===================================================================================================

   K = 8.314472*0.001  # Gas constant in kJ/mol/K
   V = 1.66            # standard volume in nm^3

   T      = 310.15      # Temperature in Kelvin
   r0     = args.Distance      # Distance in nm
   thA    = angle1       # Angle in degrees
   thB    = angle2     # Angle in degrees

   K_r    = 400     # force constant for distance (kJ/mol/nm^2)
   K_thA  = 40      # force constant for angle (kJ/mol/rad^2)
   K_thB  = 40      # force constant for angle (kJ/mol/rad^2)
   K_phiA = 4      # force constant for dihedral (kJ/mol/rad^2)
   K_phiB = 4      # force constant for dihedral (kJ/mol/rad^2)
   K_phiC = 4      # force constant for dihedral (kJ/mol/rad^2)
#=================================================================================================
# BORESCH FORMULA
#===================================================================================================

   thA = math.radians(thA)  # convert angle from degrees to radians --> math.sin() wants radians
   thB = math.radians(thB)  # convert angle from degrees to radians --> math.sin() wants radians

   arg =((8.0 * math.pi**2.0 * V) / (r0**2.0 * math.sin(thA) * math.sin(thB))
    *
    (( (K_r * K_thA * K_thB * K_phiA * K_phiB * K_phiC)**0.5 ) / ( (2.0 * math.pi * K * T)**(3.0) )))

   dG = - K * T * math.log(arg)

   modified_fname = "restraint_term.txt"
   f = open(modified_fname,"w")
   f.write("%8.3f kJ/mol" %(dG))
   f.close()

if __name__ == "__main__":
   main(sys.argv[1:])
