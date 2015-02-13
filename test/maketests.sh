output="srcoftests.jl"
echo "module tests" > $output
echo "using Targe2 " >> $output
echo "using Base.Test " >> $output
cat <<EOF >> $output
function run1(test,input)
    println("Input " * test)
    result=true;
    try
        XY,triconn,trigroups,edgeconn,edgegroups=Targe2.targe2mesher(input)
        Targe2.Export.vtkexport(test * ".vtk",triconn,XY,Targe2.Export.T3)
    catch
        result=false
    end
    return result
end
EOF
for n in t*
do
	echo "####################################################" >> $output
	echo "####################################################" >> $output
	echo "####################################################" >> $output
        echo "# $n" >> $output;
        echo "input=\"\"\"" >> $output;
        cat $n | grep -v print >> $output;
        echo "\"\"\""  >> $output;
        echo "thetest=\"$n\""  >> $output;
        echo "@test run1(thetest,input)"  >> $output;
	echo "####################################################" >> $output
	echo "####################################################" >> $output
	echo "####################################################" >> $output
done
echo "end # module tests" >> $output
