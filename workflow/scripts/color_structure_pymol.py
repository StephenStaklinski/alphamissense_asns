# open the file of new values (just 1 column of numbers, one for each alpha carbon)
inFile = open("/Users/staklins/Documents/siepel_lab/alphamissense_asns/avg_color_pymol_input.txt", 'r')

# create the global, stored array
stored.newB = []

# read the new B factors from file
for line in inFile.readlines(): stored.newB.append( float(line) )

# close the input file
inFile.close()

# clear out the old B Factors
select protA, /6gq3/A/A/
alter protA, b=0.0

# update the B Factors with new properties
alter protA and n. CA, b=stored.newB.pop(0)

# color the protein based on the new B Factors of the alpha carbons
minval = 0
maxval = 1
prot = "6GQ3"
cmd.spectrum("b", "blue_white_red", "%s and n. CA"%protA, minimum=minval, maximum=maxval)
