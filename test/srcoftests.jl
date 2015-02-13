module tests
using Targe2 
using Base.Test 
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
####################################################
####################################################
####################################################
# t1
input="""
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2 
curve 3 line 0 -1 -2 2  
curve 4 circle center 0 1 radius 0.5
subregion 1  property 1 boundary 1 2 -3 hole -4
m-ctl-point constant 0.2

"""
thetest="t1"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t10
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
m-ctl-point 1 xy 0 , -1 near 0.5 influence 3 


"""
thetest="t10"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t100
input="""
! square with several advancing fronts
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 1 xy  100 , -100 near 0.3 influence 1
m-ctl-point 2 xy -100 , -100 near 0.3 influence 1
m-ctl-point 3 xy -100 , 0    near 0.3 influence 1
m-ctl-point 4 xy    0 , 100  near 0.3 influence 1

m-ctl-point 5 xy    0 , 0    near 0.3 influence 1
m-ctl-point 6 xy  -10 , 10   near 0.2 influence 1
m-ctl-point 7 xy  30 , -15   near 0.1 influence 1

"""
thetest="t100"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t101
input="""
! square with several advancing fronts
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

curve 5 line -10 10 30 -15

subregion 1 property 1 boundary 1 2 3 4 hole 5 -5
m-ctl-point constant 100
m-ctl-point 1 xy  100 , -100 near 0.1 influence 1
m-ctl-point 2 xy -100 , -100 near 0.05 influence 0.3
m-ctl-point 3 xy -100 , 0    near 0.1 influence 0.5
m-ctl-point 4 xy    0 , 100  near 0.1 influence 1

m-ctl-point 5 xy    0 , 0    near 0.3 influence 1
m-ctl-point 6 xy  -10 , 10   near 0.2 influence 1
m-ctl-point 7 xy  30 , -15   near 0.6 influence 1

m-ctl-point 8 xy  50 -50     near 0.06 influence 0.6

"""
thetest="t101"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t102
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -1 -1 -0.7 -1
curve 2 line -0.7 -1 -0.7 -0.7
curve 3 line -0.7 -0.7 -1 -0.7
curve 4 line -1 -0.7 -1 -1
curve 5 circle center -0.9 -0.9 radius 0.08
curve 6 circle center -0.9 -0.9 radius 0.075
curve 7 circle center -0.91 -0.903 radius 0.064

subregion 1 property 1 boundary 1 2 3 4 hole -5
subregion 1 property 1 boundary 6 hole -7
m-ctl-point constant 1
m-ctl-point 2 xy  1 , -1 near 0.0003 influence 0.002
m-ctl-point 1 xy -0.9 , -0.9 near 0.0007 influence 0.006

"""
thetest="t102"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t103
input="""

curve 1 line -1 -1 -0.7 -1
curve 2 line -0.7 -1 -0.7 -0.7
curve 3 line -0.7 -0.7 -1 -0.7
curve 4 line -1 -0.7 -1 -1
curve 5 circle center -0.9 -0.9 radius 0.08
curve 6 circle center -0.9 -0.9 radius 0.075
curve 7 circle center -0.91 -0.903 radius 0.05
curve 8 circle center -0.86 -0.86 radius 0.013
curve 9 circle center -0.77 -0.79 radius 0.05

subregion 1 property 1 boundary 6 hole -7 hole -8 
subregion 2 property 1 boundary 1 2 3 4 hole -5 hole -9

m-ctl-point constant 0.03
m-ctl-point 1 xy -0.86 -0.86 near 0.0001 influence 0.001
m-ctl-point 2 xy -0.96 -0.96 near 0.0001 influence 0.0001


"""
thetest="t103"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t104
input="""

curve 1 line -1 -1 -0.7 -1
curve 2 line -0.7 -1 -0.7 -0.7
curve 3 line -0.7 -0.7 -1 -0.7
curve 4 line -1 -0.7 -1 -1
curve 5 circle center -0.9 -0.9 radius 0.08
curve 6 circle center -0.9 -0.9 radius 0.075
curve 7 circle center -0.91 -0.903 radius 0.05
curve 8 circle center -0.86 -0.86 radius 0.013

subregion 1 property 1 boundary 6 hole -7 hole -8
subregion 2 property 1 boundary 1 2 3 4 hole -5

m-ctl-point constant 0.01


"""
thetest="t104"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t105
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0004 influence 0.02
m-ctl-point 1 xy -100 , -100 near 0.0004 influence 0.02

"""
thetest="t105"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t106
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.004 influence 0.2
m-ctl-point 1 xy -100 , -100 near 0.004 influence 0.2

"""
thetest="t106"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t107
input="""
!
!  Ementaler cheese
!
curve 56 LINE -1.418952,-1.535336  -1.872144,2.909428 
curve 57 LINE -1.872144,2.909428  2.834078,2.839707 
curve 58 LINE 2.834078,2.839707  2.712065,-1.709641 
curve 59 LINE 2.712065,-1.709641  -1.418952,-1.535336 

curve 61 CIRCLE center -1.296939,2.334224 , radius 0.261457
curve 70 CIRCLE center -0.965760,1.270966 , radius 0.296830
curve 84 CIRCLE center -1.070343,0.364583 , radius 0.414317
curve 88 CIRCLE center -1.018052,-1.186727 , radius 0.187732
curve 91 CIRCLE center -0.129099,-1.221588 , radius 0.296830
curve 86 CIRCLE center -0.669443,-0.628953 , radius 0.288525
curve 82 CIRCLE center 0.080067,-0.018887 , radius 0.331637
curve 93 CIRCLE center 0.707563,-0.698675 , radius 0.414317
curve 99 CIRCLE center 1.613946,-1.099575 , radius 0.348609
curve 97 CIRCLE center 2.380886,-1.029853 , radius 0.165360
curve 63 CIRCLE center -0.129099,1.985615 , radius 0.474159
curve 65 CIRCLE center 1.021311,2.072767 , radius 0.398239
curve 67 CIRCLE center 2.154290,2.299363 , radius 0.174304
curve 72 CIRCLE center 0.080067,0.870066 , radius 0.343782
curve 74 CIRCLE center 1.056172,1.218675 , radius 0.198738
curve 76 CIRCLE center 1.927694,1.375549 , radius 0.478624
curve 78 CIRCLE center 2.241442,0.312291 , radius 0.187732
curve 80 CIRCLE center 1.369920,0.399444 , radius 0.408036
curve 95 CIRCLE center 1.840542,-0.402357 , radius 0.223219

subregion 1 property 1 boundary -59 -58 -57 -56 hole -61 hole -70 hole -84 hole -88 hole -91 hole -86 hole -82 hole -93 hole -99 hole -97 hole -63 hole -65 hole -67 hole -72 hole -74 hole -76 hole -78 hole -80 hole -95
m-ctl-point constant 1

mc-p 1 2.34 -1. 0.00008,  0.006
mc-p 2 -1.3 2.28 0.00008,  0.01
mc-p 5  0.080067,0.870066 0.00008, 0.00343782
mc-p 7 1.9920,2.2799444 0.00008,  0.003
mc-p 8 -0.98 -1.2 0.000008,  0.001


"""
thetest="t107"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t108
input="""
!
!  Ementaler cheese
!
curve 56 LINE -141.8952,-153.5336  -187.2144,290.9428 
curve 57 LINE -187.2144,290.9428  283.4078,283.9707 
curve 58 LINE 283.4078,283.9707  271.2065,-170.9641 
curve 59 LINE 271.2065,-170.9641  -141.8952,-153.5336 

curve 61 CIRCLE center -129.6939,233.4224 , radius 26.1457
curve 70 CIRCLE center -96.5760,127.0966 , radius 29.6830
curve 84 CIRCLE center -107.0343,36.4583 , radius 41.4317
curve 88 CIRCLE center -101.8052,-118.6727 , radius 18.7732
curve 91 CIRCLE center -12.9099,-122.1588 , radius 29.6830
curve 86 CIRCLE center -66.9443,-62.8953 , radius 28.8525
curve 82 CIRCLE center 8.0067,-1.8887 , radius 33.1637
curve 93 CIRCLE center 70.7563,-69.8675 , radius 41.4317
curve 99 CIRCLE center 161.3946,-109.9575 , radius 34.8609
curve 97 CIRCLE center 238.0886,-102.9853 , radius 16.5360
curve 63 CIRCLE center -12.9099,198.5615 , radius 47.4159
curve 65 CIRCLE center 102.1311,207.2767 , radius 39.8239
curve 67 CIRCLE center 215.4290,229.9363 , radius 17.4304
curve 72 CIRCLE center 8.0067,87.0066 , radius 34.3782
curve 74 CIRCLE center 105.6172,121.8675 , radius 19.8738
curve 76 CIRCLE center 192.7694,137.5549 , radius 47.8624
curve 78 CIRCLE center 224.1442,31.2291 , radius 18.7732
curve 80 CIRCLE center 136.9920,39.9444 , radius 40.8036
curve 95 CIRCLE center 184.0542,-40.2357 , radius 22.3219

subregion 1 property 1 boundary -59 -58 -57 -56 hole -61 hole -70 hole -84 hole -88 hole -91 hole -86 hole -82 hole -93 hole -99 hole -97 hole -63 hole -65 hole -67 hole -72 hole -74 hole -76 hole -78 hole -80 hole -95
m-ctl-point constant 10

mc-p 1 234. -100.              0.006,   0.09
mc-p 2 -130. 228.              0.006,   0.09
mc-p 5  0.107,53.5375       0.0006,  0.003
mc-p 7 199.20,227.99444        0.006,   0.07
mc-p 8 -98.213125 -137.124318  0.0006,  0.002


"""
thetest="t108"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t109
input="""
!
!  Ementaler cheese
!
curve 56 LINE -141.8952,-153.5336  -187.2144,290.9428 
curve 57 LINE -187.2144,290.9428  283.4078,283.9707 
curve 58 LINE 283.4078,283.9707  271.2065,-170.9641 
curve 59 LINE 271.2065,-170.9641  -141.8952,-153.5336 

curve 61 CIRCLE center -129.6939,233.4224 , radius 26.1457
curve 70 CIRCLE center -96.5760,127.0966 , radius 29.6830
curve 84 CIRCLE center -107.0343,36.4583 , radius 41.4317
curve 88 CIRCLE center -101.8052,-118.6727 , radius 18.7732
curve 91 CIRCLE center -12.9099,-122.1588 , radius 29.6830
curve 86 CIRCLE center -66.9443,-62.8953 , radius 28.8525
curve 82 CIRCLE center 8.0067,-1.8887 , radius 33.1637
curve 93 CIRCLE center 70.7563,-69.8675 , radius 41.4317
curve 99 CIRCLE center 161.3946,-109.9575 , radius 34.8609
curve 97 CIRCLE center 238.0886,-102.9853 , radius 16.5360
curve 63 CIRCLE center -12.9099,198.5615 , radius 47.4159
curve 65 CIRCLE center 102.1311,207.2767 , radius 39.8239
curve 67 CIRCLE center 215.4290,229.9363 , radius 17.4304
curve 72 CIRCLE center 8.0067,87.0066 , radius 34.3782
curve 74 CIRCLE center 105.6172,121.8675 , radius 19.8738
curve 76 CIRCLE center 192.7694,137.5549 , radius 47.8624
curve 78 CIRCLE center 224.1442,31.2291 , radius 18.7732
curve 80 CIRCLE center 136.9920,39.9444 , radius 40.8036
curve 95 CIRCLE center 184.0542,-40.2357 , radius 22.3219

subregion 1 property 1 boundary -59 -58 -57 -56 hole -61 hole -70 hole -84 hole -88 hole -91 hole -86 hole -82 hole -93 hole -99 hole -97 hole -63 hole -65 hole -67 hole -72 hole -74 hole -76 hole -78 hole -80 hole -95
m-ctl-point constant 13.1313
mc-p 6 675.055512, -396.398876 0.3 1.3




"""
thetest="t109"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t11
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 2 property 2 boundary 4 5 -6
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
m-ctl-point 1 xy 0 , -1 near 0.5 influence 3 
m-ctl-point 1 xy 2,4.2 near 0.5 influence 1 


"""
thetest="t11"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t110
input="""
m-ctl-point constant 150

curve 2 LINE [-1032.206975,-1051.830681] [961.561630,-934.088441] 
curve 3 LINE [961.561630,-934.088441] [1008.658527,1032.206975] 
curve 4 LINE [1008.658527,1032.206975] [474.893703,1047.905940] 
curve 5 LINE [474.893703,1047.905940] [549.463789,243.333964] 
curve 6 LINE [549.463789,243.333964] [215.860774,310.054567] 
curve 7 LINE [215.860774,310.054567] [368.925687,745.700856] 
curve 8 LINE [368.925687,745.700856] [-27.473189,1036.131716] 
curve 9 LINE [-27.473189,1036.131716] [-596.560685,883.066803] 
curve 10 LINE [-596.560685,883.066803] [-247.258705,361.076204] 
curve 11 LINE [-247.258705,361.076204] [576.936978,-51.021638] 
curve 12 LINE [576.936978,-51.021638] [569.087496,-196.237067] 
curve 13 LINE [569.087496,-196.237067] [-176.613361,196.237067] 
curve 14 LINE [-176.613361,196.237067] [-773.174046,1043.981199] 
curve 15 LINE [-773.174046,1043.981199] [-1079.303871,945.862665] 
curve 16 LINE [-1079.303871,945.862665] [-883.066803,62.795862] 
curve 17 LINE [-883.066803,62.795862] [231.559740,-423.872066] 
curve 18 LINE [231.559740,-423.872066] [675.055512,-396.398876] 
curve 19 LINE [675.055512,-396.398876] [726.077150,153.064913] 
curve 20 LINE [726.077150,153.064913] [678.980253,902.690510] 
curve 21 LINE [678.980253,902.690510] [820.270942,875.217321] 
curve 22 LINE [820.270942,875.217321] [816.346201,-54.946379] 
curve 23 LINE [816.346201,-54.946379] [706.453443,-541.614306] 
curve 24 LINE [706.453443,-541.614306] [105.968016,-463.119479] 
curve 25 LINE [105.968016,-463.119479] [-678.980253,-74.570086] 
curve 26 LINE [-678.980253,-74.570086] [-1024.357492,94.193792] 
curve 27 LINE [-1024.357492,94.193792] [-977.260596,-235.484481] 
curve 28 LINE [-977.260596,-235.484481] [-290.430860,-565.162754] 
curve 29 LINE [-290.430860,-565.162754] [160.914395,-588.711202] 
curve 30 LINE [160.914395,-588.711202] [714.302925,-667.206029] 
curve 31 LINE [714.302925,-667.206029] [828.120425,-431.721548] 
curve 32 LINE [828.120425,-431.721548] [847.744131,-839.894649] 
curve 33 LINE [847.744131,-839.894649] [726.077150,-694.679219] 
curve 34 LINE [726.077150,-694.679219] [-286.506118,-592.635944] 
curve 35 LINE [-286.506118,-592.635944] [-1032.206975,-239.409222] 
curve 36 LINE [-1032.206975,-239.409222] [-1032.206975,-1051.830681] 

! hole
curve 49 LINE [-902.513897,-435.557983] [-340.309416,-656.030328] 
curve 50 LINE [-340.309416,-656.030328] [710.608763,-755.242884] 
curve 51 LINE [710.608763,-755.242884] [820.844935,-872.828134] 
curve 52 LINE [820.844935,-872.828134] [-961.306522,-964.691612] 
curve 53 LINE [-961.306522,-964.691612] [-902.513897,-435.557983] 

! hole
curve 58 LINE [-773.905029,75.202950] [-351.333034,192.788201] 
curve 55 LINE [-351.333034,192.788201] [622.419825,-332.670889] 
curve 56 LINE [622.419825,-332.670889] [254.965916,-354.718123] 
curve 57 LINE [254.965916,-354.718123] [-773.905029,75.202950] 

! hole
curve 47 LINE [-501.989136,843.181620] [-68.393524,916.672401] 
curve 43 LINE [-68.393524,916.672401] [214.545986,718.247291] 
curve 44 LINE [214.545986,718.247291] [107.984352,343.444304] 
curve 45 LINE [107.984352,343.444304] [-185.978775,409.586007] 
curve 46 LINE [-185.978775,409.586007] [-501.989136,843.181620] 

!hole
curve 38 LINE [-942.933827,850.530698] [-722.461482,850.530698] 
curve 39 LINE [-722.461482,850.530698] [-424.823815,255.255365] 
curve 40 LINE [-424.823815,255.255365] [-814.324959,133.995576] 
curve 41 LINE [-814.324959,133.995576] [-942.933827,850.530698] 

subreg 1 property 1 boundary --
2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 --
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 --
hole -- 
49 50 51 52 53 --
hole  --
58 55 56 57 --
hole --
47 43 44 45 46 --
hole --
38 39 40 41

"""
thetest="t110"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t111
input="""
! ==+MAP: NESTED SUBREGIONS, FIXED LINES AND POINTS


m-ctl-point constant 10
m-ctl-point 1 xy 44 60  near 1 influence 10

curve  1 line 200 110  190 130
curve  2 line 190 130  140 110
curve  3 line  140 110  150 90
curve  4 line  150 90 200 110 
curve  5 line  230 130 230 170
curve  6 line 230 170 138 148
curve  7 line 138 148 113 92
curve  8 line 113 92 187 67
curve  9 line 187 67  230 130
curve 10 line 230 170 225 190
curve 11 line 225 190 118 154
curve 12 line 118 154 113 120
curve 13 line 113 120 87 113
curve 14 line 87 113 41 146
curve 15 line 80 130 80 207
curve 16 line 80 207 60 198
curve 17 line 60 198 42 154
curve 18 line 42 154 80 130
curve 19 line 225 190 221 202
curve 20 line 221 202 150 180
curve 21 line 150 180 84 230
curve 22 line 84 230 10 200
curve 23 line 10 200 20 130
curve 24 line 20 130 10 71
curve 25 line 10 71 22 38
curve 26 line 22 38 38 13
curve 27 line 38 13 150 10
curve 28 line 150 10 190 42
curve 29 line 190 42 202 40
curve 30 line 202 40 243 83
curve 31 line 243 83  230 130
curve 32 line 22 38 78 40
curve 33 line 78 40 88 70
curve 34 line 10 71 52 95
curve 35 line 52 95 113 92
curve 36 line 140 42 113 63
curve 37 line 113 63 100 38
curve 38 line 140 42 125 20
curve 39 line 140 42 151 31
curve 40 line 151 31 175 45
curve 41 line 140 42 170 53


subregion 2 material 1 property 1 boundary 5 6 7 8 9 hole -1 -2 -3 -4

subregion 1 material 1 property 1 boundary 1 2 3 4

subregion 3 material 1 property 1 boundary 10 11 12 13 14 -14 -13 -12 -11 --
          19 20 21 22 23 24 34 35 -7 -6 hole -15 -16 -17 -18

subregion 4 material 1 property 1 boundary 15 16 17 18

subregion 5 material 1 property 1 boundary 31 -9 -8 -35 -34 25 32 33 --
        -33 -32 26 27 28 29 30  hole 41 -41 39 40 -40 -39 38 -38 36 37 -37 -36 

fixed-point 10013 xy 40 60
fixed-point 10014 xy 42 60
fixed-point 10015 xy 44 60
fixed-point 10016 xy 44 62
fixed-point 10017 xy 44 64



"""
thetest="t111"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t112
input="""
m-ctl-point constant 500

curve 2 LINE [-1032.206975,-1051.830681] [961.561630,-934.088441] 
curve 3 LINE [961.561630,-934.088441] [1008.658527,1032.206975] 
curve 4 LINE [1008.658527,1032.206975] [474.893703,1047.905940] 
curve 5 LINE [474.893703,1047.905940] [549.463789,243.333964] 
curve 6 LINE [549.463789,243.333964] [215.860774,310.054567] 
curve 7 LINE [215.860774,310.054567] [368.925687,745.700856] 
curve 8 LINE [368.925687,745.700856] [-27.473189,1036.131716] 
curve 9 LINE [-27.473189,1036.131716] [-596.560685,883.066803] 
curve 10 LINE [-596.560685,883.066803] [-247.258705,361.076204] 
curve 11 LINE [-247.258705,361.076204] [576.936978,-51.021638] 
curve 12 LINE [576.936978,-51.021638] [569.087496,-196.237067] 
curve 13 LINE [569.087496,-196.237067] [-176.613361,196.237067] 
curve 14 LINE [-176.613361,196.237067] [-773.174046,1043.981199] 
curve 15 LINE [-773.174046,1043.981199] [-1079.303871,945.862665] 
curve 16 LINE [-1079.303871,945.862665] [-883.066803,62.795862] 
curve 17 LINE [-883.066803,62.795862] [231.559740,-423.872066] 
curve 18 LINE [231.559740,-423.872066] [675.055512,-396.398876] 
curve 19 LINE [675.055512,-396.398876] [726.077150,153.064913] 
curve 20 LINE [726.077150,153.064913] [678.980253,902.690510] 
curve 21 LINE [678.980253,902.690510] [820.270942,875.217321] 
curve 22 LINE [820.270942,875.217321] [816.346201,-54.946379] 
curve 23 LINE [816.346201,-54.946379] [706.453443,-541.614306] 
curve 24 LINE [706.453443,-541.614306] [105.968016,-463.119479] 
curve 25 LINE [105.968016,-463.119479] [-678.980253,-74.570086] 
curve 26 LINE [-678.980253,-74.570086] [-1024.357492,94.193792] 
curve 27 LINE [-1024.357492,94.193792] [-977.260596,-235.484481] 
curve 28 LINE [-977.260596,-235.484481] [-290.430860,-565.162754] 
curve 29 LINE [-290.430860,-565.162754] [160.914395,-588.711202] 
curve 30 LINE [160.914395,-588.711202] [714.302925,-667.206029] 
curve 31 LINE [714.302925,-667.206029] [828.120425,-431.721548] 
curve 32 LINE [828.120425,-431.721548] [847.744131,-839.894649] 
curve 33 LINE [847.744131,-839.894649] [726.077150,-694.679219] 
curve 34 LINE [726.077150,-694.679219] [-286.506118,-592.635944] 
curve 35 LINE [-286.506118,-592.635944] [-1032.206975,-239.409222] 
curve 36 LINE [-1032.206975,-239.409222] [-1032.206975,-1051.830681] 

! hole
curve 49 LINE [-902.513897,-435.557983] [-340.309416,-656.030328] 
curve 50 LINE [-340.309416,-656.030328] [710.608763,-755.242884] 
curve 51 LINE [710.608763,-755.242884] [820.844935,-872.828134] 
curve 52 LINE [820.844935,-872.828134] [-961.306522,-964.691612] 
curve 53 LINE [-961.306522,-964.691612] [-902.513897,-435.557983] 

! hole
curve 58 LINE [-773.905029,75.202950] [-351.333034,192.788201] 
curve 55 LINE [-351.333034,192.788201] [622.419825,-332.670889] 
curve 56 LINE [622.419825,-332.670889] [254.965916,-354.718123] 
curve 57 LINE [254.965916,-354.718123] [-773.905029,75.202950] 

! hole
curve 47 LINE [-501.989136,843.181620] [-68.393524,916.672401] 
curve 43 LINE [-68.393524,916.672401] [214.545986,718.247291] 
curve 44 LINE [214.545986,718.247291] [107.984352,343.444304] 
curve 45 LINE [107.984352,343.444304] [-185.978775,409.586007] 
curve 46 LINE [-185.978775,409.586007] [-501.989136,843.181620] 

!hole
curve 38 LINE [-942.933827,850.530698] [-722.461482,850.530698] 
curve 39 LINE [-722.461482,850.530698] [-424.823815,255.255365] 
curve 40 LINE [-424.823815,255.255365] [-814.324959,133.995576] 
curve 41 LINE [-814.324959,133.995576] [-942.933827,850.530698] 

subreg 1 property 1 boundary --
2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 --
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 --
hole -- 
49 50 51 52 53 --
hole  --
58 55 56 57 --
hole --
47 43 44 45 46 --
hole --
38 39 40 41

"""
thetest="t112"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t113
input="""
! ==+MAP: NESTED SUBREGIONS, FIXED LINES AND POINTS


m-ctl-point constant 10
m-ctl-point 1 xy 40 60  near 1 influence 2 


curve  1 line 200 110  190 130
curve  2 line 190 130  140 110
curve  3 line  140 110  150 90
curve  4 line  150 90 200 110 
curve  5 line  230 130 230 170
curve  6 line 230 170 138 148
curve  7 line 138 148 113 92
curve  8 line 113 92 187 67
curve  9 line 187 67  230 130
curve 10 line 230 170 225 190
curve 11 line 225 190 118 154
curve 12 line 118 154 113 120
curve 13 line 113 120 87 113
curve 14 line 87 113 41 146
curve 15 line 80 130 80 207
curve 16 line 80 207 60 198
curve 17 line 60 198 42 154
curve 18 line 42 154 80 130
curve 19 line 225 190 221 202
curve 20 line 221 202 150 180
curve 21 line 150 180 84 230
curve 22 line 84 230 10 200
curve 23 line 10 200 20 130
curve 24 line 20 130 10 71
curve 25 line 10 71 22 38
curve 26 line 22 38 38 13
curve 27 line 38 13 150 10
curve 28 line 150 10 190 42
curve 29 line 190 42 202 40
curve 30 line 202 40 243 83
curve 31 line 243 83  230 130
curve 32 line 22 38 78 40
curve 33 line 78 40 88 70
curve 34 line 10 71 52 95
curve 35 line 52 95 113 92
curve 36 line 140 42 113 63
curve 37 line 113 63 100 38
curve 38 line 140 42 125 20
curve 39 line 140 42 151 31
curve 40 line 151 31 175 45
curve 41 line 140 42 170 53


subregion 2 material 1 property 1 boundary 5 6 7 8 9 hole -1 -2 -3 -4

subregion 1 material 1 property 1 boundary 1 2 3 4

subregion 3 material 1 property 1 boundary 10 11 12 13 14 -14 -13 -12 -11 --
          19 20 21 22 23 24 34 35 -7 -6 hole -15 -16 -17 -18

subregion 4 material 1 property 1 boundary 15 16 17 18

subregion 5 material 1 property 1 boundary 31 -9 -8 -35 -34 25 32 33 --
        -33 -32 26 27 28 29 30  hole 41 -41 39 40 -40 -39 38 -38 36 37 -37 -36 

fixed-point 10013 xy 40 60
fixed-point 10014 xy 42 60
fixed-point 10015 xy 44 60
fixed-point 10016 xy 44 62
fixed-point 10017 xy 44 64



"""
thetest="t113"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t12
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
m-ctl-point 1 xy 0 , -1 near 0.5 influence 3 
m-ctl-point 1 xy 5,7 near 0.05 influence 1 


"""
thetest="t12"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t13
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 0.3 influence 3 


"""
thetest="t13"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t14
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 0.3 influence 3 


"""
thetest="t14"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t15
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 0.1 influence 1 
m-ctl-point 2 xy 5,7 near 0.3 influence 1 
m-ctl-point 4 xy -2,8 near 0.3 influence 1 



"""
thetest="t15"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t16
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 0.01 influence 0.1 
m-ctl-point 2 xy 5,7 near 0.9 influence 0.74 
m-ctl-point 4 xy -2,8 near 1.3 influence 0.83 
m-ctl-point 4 xy 0,5 near 0.01 influence 0.03 
m-ctl-point 4 xy 0,5 near 0.01 influence 0.03 



"""
thetest="t16"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t17
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 0.01 influence 0.1 
m-ctl-point 2 xy 5,7 near 0.9 influence 4 
m-ctl-point 4 xy -2,8 near 1.3 influence 3 



"""
thetest="t17"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t18
input="""
curve 1 line 0 , -1 5,7
curve 2 line 5,7 -2,8
curve 3 line 0 , -1 -2,8
curve 4 line 0,2 2,4.2
curve 5 line 2,4.2 0,4.2
curve 6 line 0,2 0,4.2
subregion 1 property 1 boundary 1 2 -3 hole 6 -5 -4
! subregion 2 property 4 boundary 4 5 -6
m-ctl-point 1 xy 0 , -1 near 1 influence 6 
m-ctl-point 2 xy 5,7 near 0.9 influence 4 
m-ctl-point 4 xy -2,8 near 1.3 influence 3 
m-ctl-point 4 xy 0,5 near 0.001 influence 0.005 


"""
thetest="t18"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t19
input="""
!     
curve  1 line   -9 -9   7 6.5 
curve  2 line   7 6.5  5 9
curve  3 line   -9 -9   -8 7
curve  4 line   -8 7  5 9
curve  5 line   -3.5 2  -4 5
curve  6 line   -3 3  -4 5
curve  7 line   -3.5 2  -3 3
curve  8 line   0 3 3 3
curve  9 line   2 2.1  3 3
curve 10 line   2 2.1  0 3
subregion 2 property 2 boundary 1 2 -4 -3 hole 5 -6 -7 hole 8 -9 10
subregion 1 property 1 boundary 7 6 -5
m-ctl-point 1 xy -5,-5 near 1. influence 10 
m-ctl-point 2 xy 5,5   near 1. influence 10 
m-ctl-point 10 xy 0 3 near 0.2 influence 2
m-ctl-point 4  xy 2 2.1  near 0.2 influence 2
m-ctl-point 3  xy -3.5 2  near 0.2 influence 2


"""
thetest="t19"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t2
input="""
curve 1 line 100 99 103 101.5  dim 1.0 1.0
curve 2 line 103 101.5  98 102 dim 1.0 1.0
curve 3 line 100 99 98 102  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
mc-const 0.5
m-ctl-point 1 xy 100.4 100.7 near 0.01 influence 0.02 
"""
thetest="t2"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t20
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point 1 xy 0,0 near 0.1 influence  0.3 
"""
thetest="t20"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t21
input="""
curve 1 line 0 -1 3 1.5  dim 0.5 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 0.1
curve 3 line 0 -1 -2 2  dim 0.5 0.1
subregion 1 material 1 property 1 boundary 1 2 -3 
m-ctl-point 1 xy 0,0 near 0.06 influence 0.18 

"""
thetest="t21"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t22
input="""
curve 1 line -0.1,-0.1   0.1,-0.1  
curve 2 line  0.1,-0.1   0.1, 0.1  
curve 3 line  0.1, 0.1  -0.1, 0.1 
curve 4 line -0.1, 0.1  -0.1,-0.1 
curve 5 line -0.04, -0.02   0.00,-0.001  
curve 6 line  0.04, 0.02  0.00,-0.001  
curve 7 line  0.04, 0.02  0.00, 0.001  
curve 8 line -0.04, -0.02  0.00, 0.001  
subregion 1 property 1  boundary  1 2 3 4 hole     8 -7 6 -5
m-ctl-point 1 xy -0.1,-0.1 near 0.02 influence 0.2 
m-ctl-point 2 xy  0.1,-0.1 near 0.02 influence 0.2 
m-ctl-point 3 xy  0.1, 0.1 near 0.02 influence 0.2 
m-ctl-point 4 xy -0.1, 0.1 near 0.02 influence 0.2 
m-ctl-point 5 xy -0.04,-0.02 near 0.0001 influence 0.0012 
m-ctl-point 6 xy  0.04, 0.02 near 0.0001 influence 0.0012 
"""
thetest="t22"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t23
input="""
curve 1 line   -0.1,  3.2    -1.8, -1.5  
curve 2 line   3.8,  3.    2.8, -4.5  
curve 3 line      3.,  1.8    -0.1,  3.2 
curve 4 line   -1.8, -1.5    0.75,  0.7 
curve 5 line      3.,  1.8    3.8,  3.
curve 6 line   2.8, -4.5    0.75,  0.7 
subregion 1 property 1 boundary 1 4 -6 -2 -5 3
m-ctl-point 1 xy  -4,6 near 1.0 influence 1 
m-ctl-point 2 xy   4,-6 near 1.0 influence 1 
m-ctl-point 3 xy   0.75,  0.7 near 0.05 influence .250 
m-ctl-point 4 xy      3.,  1.8 near 0.005 influence .0250 

"""
thetest="t23"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t24
input="""
curve 1 line  0.1,0.1   2.8,-1.2  
curve 2 line  0.1,0.1   0.3,1.8  
curve 3 line  2.8,-1.2  1.99,1.0 
curve 4 line  3,2.4  1.99,1.0 
curve 5 line  3,2.4   0.3,1.8  
curve 6 line  0.98,1.3  0.89,1.25 
curve 7 line  0.78,0.7  0.58,1.3 
curve 8 line  0.75,0.17   1.8,1.5  
curve 9 line 0.89,1.25  0.58,1.3
curve 10 line  0.98,1.3   0.78,0.7 
curve 11 line  0.36,1.6   0.75,0.17 
curve 12 line  0.36,1.6   1.8,1.5 
subregion 2 property 2 boundary  1 3 -4 5 -2 hole     -8 -11 12 
subregion 1 property 1 boundary 8 -12 11 hole     -6 10 7 -9
m-ctl-point 3 xy  0.75,0.17 near 0.05 influence 0.250 
m-ctl-point 4 xy  1.8,1.5 near 0.05 influence 0.250 
m-ctl-point 7 xy  0.36,1.6 near 0.05 influence 0.250 
m-ctl-point 100 xy -10,-10 near 0.2 influence 0.63 
m-ctl-point 100 xy -10,10 near 0.2 influence 0.63 
m-ctl-point 100 xy  10,-10 near 0.2 influence 0.63 
m-ctl-point 100 xy  10,10 near 0.2 influence  0.63 
"""
thetest="t24"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t25
input="""
! @(#)AFRO.T9	2.5
! ==+square with rectangular tunnels, subreg,subreg(hole), uniform
curve 1 line   0,0    6.5,0  
curve 2 line   6.5,0    6.5,1.5  
curve 3 line   6.5,1.5    5,1.5 
curve 4 line   5,1.5   3,1.5 
curve 5 line  3,1.5    3,4  
curve 6 line   3,4    3.5,6.5 
curve 7 line   3.5,6.5    0,6.5 
curve 8 line   0,6.5    0,0  
curve 9 line   5,1.5    5,4
curve 10 line   5,4    3,4 
curve 11 line   6.5,1.5    6.5,6.5 
curve 12 line   6.5,6.5    3.5,6.5 
curve 13 line  2,3   2,1.5 
curve 14 line  2,1.5   1,1.5 
curve 15 line  1,1.5   1,3 
curve 16 line  1,3   2,3 
subregion 2 property 2     boundary  1 2 3 4 5 6 7 8   hole      13 14 15 16
subregion 1 property 1 boundary  -3 11 12 -6 -10 -9

m-ctl-point constant 0.2  

"""
thetest="t25"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t26
input="""
!
! nested subregions circle(triangle(circle~))
!
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
curve 4 circle center 0 1 radius 0.5
curve 5 circle center 0 0 radius 3.6
subregion 1  property 1 boundary 1 2 -3 hole -4
subregion 2 property 2 boundary 5 hole 3 -2 -1
m-ctl-point constant 0.2
m-ctl-point 4 xy      3 1.5 near 0.005 influence .0250 



"""
thetest="t26"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t27
input="""
!
! triangle with a fixed internal curve
!
curve 1 line 0 -1 3 1.5  
curve 2 line 3 1.5  -2 2 
curve 3 line 0 -1 -2 2  
curve 4 line 0 -1 1 1
curve 5 line 1 1 -.5 0.9 
subregion 1  property 1 boundary 1 2 -3 hole 4 5 -5 -4
m-ctl-point 1 xy 0,0 near 0.3 influence 3 

"""
thetest="t27"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t28
input="""
!
!  Ementaler cheese
!
curve 56 LINE -1.418952,-1.535336  -1.872144,2.909428 
curve 57 LINE -1.872144,2.909428  2.834078,2.839707 
curve 58 LINE 2.834078,2.839707  2.712065,-1.709641 
curve 59 LINE 2.712065,-1.709641  -1.418952,-1.535336 

curve 61 CIRCLE center -1.296939,2.334224 , radius 0.261457
curve 70 CIRCLE center -0.965760,1.270966 , radius 0.296830
curve 84 CIRCLE center -1.070343,0.364583 , radius 0.414317
curve 88 CIRCLE center -1.018052,-1.186727 , radius 0.187732
curve 91 CIRCLE center -0.129099,-1.221588 , radius 0.296830
curve 86 CIRCLE center -0.669443,-0.628953 , radius 0.288525
curve 82 CIRCLE center 0.080067,-0.018887 , radius 0.331637
curve 93 CIRCLE center 0.707563,-0.698675 , radius 0.414317
curve 99 CIRCLE center 1.613946,-1.099575 , radius 0.348609
curve 97 CIRCLE center 2.380886,-1.029853 , radius 0.165360
curve 63 CIRCLE center -0.129099,1.985615 , radius 0.474159
curve 65 CIRCLE center 1.021311,2.072767 , radius 0.398239
curve 67 CIRCLE center 2.154290,2.299363 , radius 0.174304
curve 72 CIRCLE center 0.080067,0.870066 , radius 0.343782
curve 74 CIRCLE center 1.056172,1.218675 , radius 0.198738
curve 76 CIRCLE center 1.927694,1.375549 , radius 0.478624
curve 78 CIRCLE center 2.241442,0.312291 , radius 0.187732
curve 80 CIRCLE center 1.369920,0.399444 , radius 0.408036
curve 95 CIRCLE center 1.840542,-0.402357 , radius 0.223219

subregion 1 property 1 boundary -59 -58 -57 -56 hole -61 hole -70 hole -84 hole -88 hole -91 hole -86 hole -82 hole -93 hole -99 hole -97 hole -63 hole -65 hole -67 hole -72 hole -74 hole -76 hole -78 hole -80 hole -95
m-ctl-point constant 0.1


"""
thetest="t28"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t29
input="""
!
!  machine part
!
curve 31 LINE [-13.000000,-6.000000] [-13.000000,-10.000000]
curve 15 LINE [-13.000000,-10.000000] [12.000000,-10.000000]
curve 16 LINE [12.000000,-10.000000] [12.000000,7.000000]
curve 17 LINE [12.000000,7.000000] [10.000000,7.000000]
curve 18 LINE [10.000000,7.000000] [9.000000,6.000000]
curve 19 LINE [9.000000,6.000000] [9.000000,-2.000000]
curve 20 LINE [9.000000,-2.000000] [8.000000,-3.000000]
curve 21 LINE [8.000000,-3.000000] [5.000000,-3.000000]
curve 22 LINE [5.000000,-3.000000] [4.000000,-2.000000]
curve 23 LINE [4.000000,-2.000000] [4.000000,2.000000]
curve 24 LINE [4.000000,2.000000] [2.000000,2.000000]
curve 25 LINE [2.000000,2.000000] [2.000000,-2.000000]
curve 26 LINE [2.000000,-2.000000] [1.000000,-3.000000]
curve 27 LINE [1.000000,-3.000000] [-1.000000,-4.000000]
curve 28 LINE [-1.000000,-4.000000] [-5.000000,-5.000000]
curve 29 LINE [-5.000000,-5.000000] [-11.000000,-6.000000]
curve 30 LINE [-11.000000,-6.000000] [-13.000000,-6.000000]

curve 39 CIRCLE center [-9.000000,-8.000000], radius 1.414214
curve 42 CIRCLE center [-5.000000,-8.000000], radius 1.414214
curve 43 CIRCLE center [-1.000000,-8.000000], radius 1.414214
curve 46 CIRCLE center [3.000000,-5.000000], radius 2.000000
curve 36 CIRCLE center [7.003925,-4.999440], radius 1.000000


subregion 1 property 1 boundary 31 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 hole -39 hole -42 hole -43 hole -46 hole -36
m-ctl-point constant 0.8
"""
thetest="t29"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t3
input="""
curve 1 line 0.1 0.1  2.8 -1.2
curve 2 line 0.1 0.1  0.3 1.8
curve 3 line 2.8 -1.2  1.99 1. 
curve 4 line 3 2.4  1.99 1. 
curve 5 line 3 2.4  0.3 1.8 
curve 6 line 0.98 1.3  0.89 1.25 
curve 7 line 0.78 0.7  0.58 1.3
curve 8 line 0.75 0.17  1.8 1.5 
curve 9 line 0.89 1.25  0.58 1.3 
curve 10 line 0.98 1.3  0.78 0.7 
curve 11 line 0.36 1.6  0.75 0.17 
curve 12 line 0.36 1.6  1.8 1.5 
subregion 2 property 2 boundary  1 3 -4 5 -2 hole     -8 -11 12
subregion 1 property 1 boundary 8 -12 11   hole     -6 10 7 -9
subregion 3 property 3 boundary 6 9 -7 -10
m-ctl-point 8 xy 0.78 0.7 near 0.05 influence 1.25 
m-ctl-point 11 xy 0.89 1.25 near 0.05 influence 1.25 
m-ctl-point 12 xy 1.99 1. near 0.05 influence 1.25 
m-ctl-point 1  xy -10,-10  near 0.5 influence 2.5 
m-ctl-point 2  xy -10, 10  near 0.5 influence 2.5 
m-ctl-point 3  xy  10,-10  near 0.5 influence 2.5 
m-ctl-point 4  xy  10, 10  near 0.5 influence 2.5 
"""
thetest="t3"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t30
input="""
!
! triangle with some fixed points
!
curve 1 line 0 -10 30 15  
curve 2 line 30 15  -20 20 
curve 3 line 0 -10 -20 20  
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point constant 1.5

fixed 334 xy 1 2
fixed 335 xy 2 3
fixed 333 xy 4 6

fixed 336 xy -5 0
fixed 337 xy -4 0.1
fixed 338 xy -3 0.2
fixed 339 xy -2 0.3
fixed 340 xy -1 0.4
fixed 341 xy  0 0.5

"""
thetest="t30"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t31
input="""
! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.12
m-ctl-point 4 xy      2.8 1.2 near 0.005 influence .0250 
m-ctl-point 3 xy      2.3 1.2 near 0.005 influence .0250 
m-ctl-point 2 xy      1.3 1. near 0.0025 influence .020 
m-ctl-point 1 xy      0.3 1.1 near 0.005 influence .0250 


"""
thetest="t31"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t32
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.1
m-ctl-point 1 xy      -0.3 1.1 near 0.005 influence .0250 

"""
thetest="t32"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t33
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.1
m-ctl-point 1 xy      -0.3 0.4 near 0.005 influence .020 

"""
thetest="t33"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t34
input="""
! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.1
m-ctl-point 1 xy      0.3 0.4 near 0.005 influence .0120 

"""
thetest="t34"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t35
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0.3 0.96 near 0.0025 influence .0120 

"""
thetest="t35"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t36
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0. 0.9 near 0.0025 influence .0120 

"""
thetest="t36"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t37
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
curve 4 circle center 0.000095 0.89938 radius 0.005
subregion 1 property 1 boundary 1 2 -3  hole -4
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0. 0.9 near 0.00125 influence .010 

"""
thetest="t37"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t38
input="""

! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
curve 4 circle center 0.000095 0.93 radius 0.005
curve 5 circle center 0.000095 0.90 radius 0.005
curve 6 circle center 0.000095 0.87 radius 0.005
subregion 1 property 1 boundary 1 2 -3  hole -4 hole -5 hole -6
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0. 0.9 near 0.00125 influence .010 

"""
thetest="t38"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t39
input="""
! graded mesh on a triangle
!
curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
curve 4 circle center 0.000095 0.93 radius 0.05
curve 5 circle center 0.000095 0.90 radius 0.018

curve 7 circle center 0.3 0.6 radius 0.007

subregion 2 property 2 boundary 5
subregion 1 property 1 boundary 1 2 -3  hole -4 hole -7
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0. 0.9 near 0.00125 influence .010 

"""
thetest="t39"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t4
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point 1 xy 0,0 near 0.5 influence 3 

"""
thetest="t4"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t40
input="""

! graded mesh on a triangle
!

curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2
curve 3 line 0 -1 -2 2  
curve 4 circle center 0.000095 0.93 radius 0.05
curve 5 circle center 0.000095 0.90 radius 0.013

curve 7 circle center 0.3 0.6 radius 0.007

subregion 2 property 2 boundary 5
subregion 1 property 1 boundary 1 2 -3  hole -4 hole -7
m-ctl-point constant 0.1
m-ctl-point 1 xy    0.3 0.6 near 0.005 influence .0120 
m-ctl-point 1 xy    0. 0.9 near 0.0013 influence .010 

"""
thetest="t40"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t41
input="""
! ==+GRADED ON A TRIANGLE - AROUND CORNERS

curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 8 
curve 3 line 0 -1 -2 8  
subregion 1 property 1 boundary 1 2 -3 

m-ctl-point constant 100
m-ctl-point 1 xy 0 -1   near 0.1 influence 0.1
m-ctl-point 2 xy 3 1.5  near 0.02 influence 0.1
m-ctl-point 3 xy  -2 8  near 0.01 influence 0.02
"""
thetest="t41"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t42
input="""
! ==+GRADED ON A TRIANGLE - AROUND CORNERS

curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 8 
curve 3 line 0 -1 -2 8  
subregion 1 property 1 boundary 1 2 -3 

m-ctl-point constant 1
m-ctl-point 1 xy 0 -1   near 0.1 influence 0.1
m-ctl-point 2 xy 3 1.5  near 0.02 influence 0.1
m-ctl-point 3 xy  -2 8  near 0.01 influence 0.02
"""
thetest="t42"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t43
input="""
! ==+GRADED ON A TRIANGLE - AROUND CORNERS

curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2 
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 

m-ctl-point constant 0.05
m-ctl-point 1 xy 0 -1   near 0.0005 influence 0.0005
m-ctl-point 2 xy 3 1.5  near 0.0001 influence 0.0005
m-ctl-point 3 xy  -2 2  near 0.00005 influence 0.0001
m-ctl-point 3 xy  0 0  near 0.5 influence 0.5
"""
thetest="t43"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t44
input="""
! ==+GRADED ON A TRIANGLE - AROUND CORNERS

curve 1 line 0 -1 3 1.5 
curve 2 line 3 1.5  -2 2 
curve 3 line 0 -1 -2 2  
subregion 1 property 1 boundary 1 2 -3 

m-ctl-point constant 1.5
m-ctl-point 1 xy 0 -1   near 0.00015 influence 0.0015
m-ctl-point 2 xy 3 1.5  near 0.00003 influence 0.00015
m-ctl-point 3 xy  -2 2  near 0.000015 influence 0.00003

"""
thetest="t44"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t45
input="""
!
! river bed
!
! island
curve 96 LINE  2.874135,-11.090293   1.867601,-10.290986 
curve 91 LINE  1.867601,-10.290986   3.466214,-9.906136 
curve 92 LINE  3.466214,-9.906136   4.887203,-10.054154 
curve 93 LINE  4.887203,-10.054154   5.212846,-10.409402 
curve 94 LINE  5.212846,-10.409402   4.768787,-10.823857 
curve 95 LINE  4.768787,-10.823857   2.874135,-11.090293 
! island
curve 87 LINE  5.686510,-10.705441   5.538490,-10.172570 
curve 88 LINE  5.538490,-10.172570   8.054825,-9.284452 
curve 89 LINE  8.054825,-9.284452   9.564626,-9.047621 
curve 84 LINE  9.564626,-9.047621   9.150171,-10.172570 
curve 85 LINE  9.150171,-10.172570   7.462746,-10.705441 
curve 86 LINE  7.462746,-10.705441   5.686510,-10.705441 
! island
curve 10 LINE  10.748784,-4.607029   11.400070,-4.310990 
curve 1 LINE  11.400070,-4.310990   11.784922,-5.672771 
curve 2 LINE  11.784922,-5.672771   11.459278,-6.975345 
curve 3 LINE  11.459278,-6.975345   10.837596,-7.833859 
curve 4 LINE  10.837596,-7.833859   10.423141,-7.863463 
curve 98 LINE  10.423141,-7.863463   10.156705,-6.797721 
curve 99 LINE  10.156705,-6.797721   10.748784,-4.607029 
! island
curve 82 LINE  5.508886,-0.255250   6.012153,0.336829 
curve 69 LINE  6.012153,0.336829   9.031755,1.076928 
curve 70 LINE  9.031755,1.076928   11.400070,0.544057 
curve 71 LINE  11.400070,0.544057   13.501950,-0.669705 
curve 72 LINE  13.501950,-0.669705   14.774920,-2.949208 
curve 73 LINE  14.774920,-2.949208   14.893336,-6.087226 
curve 74 LINE  14.893336,-6.087226   13.265119,-8.603561 
curve 75 LINE  13.265119,-8.603561   9.949477,-9.846928 
curve 76 LINE  9.949477,-9.846928   10.245517,-8.988413 
curve 77 LINE  10.245517,-8.988413   12.199377,-7.508216 
curve 78 LINE  12.199377,-7.508216   12.258585,-5.376732 
curve 79 LINE  12.258585,-5.376732   11.252050,-3.215644 
curve 80 LINE  11.252050,-3.215644   9.416606,-1.646635 
curve 81 LINE  9.416606,-1.646635   5.508886,-0.255250 
! river
curve 67 LINE  9.671409,4.567054   8.712973,8.424345 
curve 41 LINE  8.712973,8.424345   3.824327,7.955324 
curve 42 LINE  3.824327,7.955324   0.108235,8.171795 
curve 43 LINE  0.108235,8.171795   -5.447863,6.945124 
curve 44 LINE  -5.447863,6.945124   -6.097277,3.788250 
curve 45 LINE  -6.097277,3.788250   -6.241591,-0.685492 
curve 46 LINE  -6.241591,-0.685492   -3.553739,-2.850206 
curve 47 LINE  -3.553739,-2.850206   3.427463,-2.381184 
curve 48 LINE  3.427463,-2.381184   7.330314,-4.21026 
curve 49 LINE  7.330314,-4.21026   7.138421,-6.754635 
curve 50 LINE  7.138421,-6.754635   1.688658,-7.867615 
curve 51 LINE  1.688658,-7.867615   -4.528676,-7.368693 
curve 52 LINE  -4.528676,-7.368693   -8.827080,-11.436826 
curve 53 LINE  -8.827080,-11.436826   -4.490297,-12.664941 
curve 54 LINE  -4.490297,-12.664941   -3.300561,-11.551962 
curve 55 LINE  -3.300561,-11.551962   -0.230272,-11.743855 
curve 56 LINE  -0.230272,-11.743855   5.334626,-12.319533 
curve 57 LINE  5.334626,-12.319533   14.353599,-11.168176 
curve 58 LINE  14.353599,-11.168176   17.654160,-5.296248 
curve 59 LINE  17.654160,-5.296248   16.502800,-0.076758 
curve 60 LINE  16.502800,-0.076758   10.861146,2.878395 
curve 61 LINE  10.861146,2.878395   3.530832,2.571366 
curve 62 LINE  3.530832,2.571366   0.575679,1.957308 
curve 63 LINE  0.575679,1.957308   -0.191893,3.031909 
curve 64 LINE  -0.191893,3.031909   0.537300,4.144889 
curve 65 LINE  0.537300,4.144889   3.492453,4.144889 
curve 66 LINE  3.492453,4.144889   9.671409,4.567054 
subreg 1 property 1 boundary 67 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 hole 96 91 92 93 94 95 hole 87 88 89 84 85 86 hole 10 1 2 3 4 98 99 hole 82 69 70 71 72 73 74 75 76 77 78 79 80 81
m-ctl-point constant 0.4
"""
thetest="t45"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t46
input="""
!
! river bed - graded mesh
!
! island
curve 96 LINE  2.874135,-11.090293   1.867601,-10.290986 
curve 91 LINE  1.867601,-10.290986   3.466214,-9.906136 
curve 92 LINE  3.466214,-9.906136   4.887203,-10.054154 
curve 93 LINE  4.887203,-10.054154   5.212846,-10.409402 
curve 94 LINE  5.212846,-10.409402   4.768787,-10.823857 
curve 95 LINE  4.768787,-10.823857   2.874135,-11.090293 
! island
curve 87 LINE  5.686510,-10.705441   5.538490,-10.172570 
curve 88 LINE  5.538490,-10.172570   8.054825,-9.284452 
curve 89 LINE  8.054825,-9.284452   9.564626,-9.047621 
curve 84 LINE  9.564626,-9.047621   9.150171,-10.172570 
curve 85 LINE  9.150171,-10.172570   7.462746,-10.705441 
curve 86 LINE  7.462746,-10.705441   5.686510,-10.705441 
! island
curve 10 LINE  10.748784,-4.607029   11.400070,-4.310990 
curve 1 LINE  11.400070,-4.310990   11.784922,-5.672771 
curve 2 LINE  11.784922,-5.672771   11.459278,-6.975345 
curve 3 LINE  11.459278,-6.975345   10.837596,-7.833859 
curve 4 LINE  10.837596,-7.833859   10.423141,-7.863463 
curve 98 LINE  10.423141,-7.863463   10.156705,-6.797721 
curve 99 LINE  10.156705,-6.797721   10.748784,-4.607029 
! island
curve 82 LINE  5.508886,-0.255250   6.012153,0.336829 
curve 69 LINE  6.012153,0.336829   9.031755,1.076928 
curve 70 LINE  9.031755,1.076928   11.400070,0.544057 
curve 71 LINE  11.400070,0.544057   13.501950,-0.669705 
curve 72 LINE  13.501950,-0.669705   14.774920,-2.949208 
curve 73 LINE  14.774920,-2.949208   14.893336,-6.087226 
curve 74 LINE  14.893336,-6.087226   13.265119,-8.603561 
curve 75 LINE  13.265119,-8.603561   9.949477,-9.846928 
curve 76 LINE  9.949477,-9.846928   10.245517,-8.988413 
curve 77 LINE  10.245517,-8.988413   12.199377,-7.508216 
curve 78 LINE  12.199377,-7.508216   12.258585,-5.376732 
curve 79 LINE  12.258585,-5.376732   11.252050,-3.215644 
curve 80 LINE  11.252050,-3.215644   9.416606,-1.646635 
curve 81 LINE  9.416606,-1.646635   5.508886,-0.255250 
! river
curve 67 LINE  9.671409,4.567054   8.712973,8.424345 
curve 41 LINE  8.712973,8.424345   3.824327,7.955324 
curve 42 LINE  3.824327,7.955324   0.108235,8.171795 
curve 43 LINE  0.108235,8.171795   -5.447863,6.945124 
curve 44 LINE  -5.447863,6.945124   -6.097277,3.788250 
curve 45 LINE  -6.097277,3.788250   -6.241591,-0.685492 
curve 46 LINE  -6.241591,-0.685492   -3.553739,-2.850206 
curve 47 LINE  -3.553739,-2.850206   3.427463,-2.381184 
curve 48 LINE  3.427463,-2.381184   7.330314,-4.21026 
curve 49 LINE  7.330314,-4.21026   7.138421,-6.754635 
curve 50 LINE  7.138421,-6.754635   1.688658,-7.867615 
curve 51 LINE  1.688658,-7.867615   -4.528676,-7.368693 
curve 52 LINE  -4.528676,-7.368693   -8.827080,-11.436826 
curve 53 LINE  -8.827080,-11.436826   -4.490297,-12.664941 
curve 54 LINE  -4.490297,-12.664941   -3.300561,-11.551962 
curve 55 LINE  -3.300561,-11.551962   -0.230272,-11.743855 
curve 56 LINE  -0.230272,-11.743855   5.334626,-12.319533 
curve 57 LINE  5.334626,-12.319533   14.353599,-11.168176 
curve 58 LINE  14.353599,-11.168176   17.654160,-5.296248 
curve 59 LINE  17.654160,-5.296248   16.502800,-0.076758 
curve 60 LINE  16.502800,-0.076758   10.861146,2.878395 
curve 61 LINE  10.861146,2.878395   3.530832,2.571366 
curve 62 LINE  3.530832,2.571366   0.575679,1.957308 
curve 63 LINE  0.575679,1.957308   -0.191893,3.031909 
curve 64 LINE  -0.191893,3.031909   0.537300,4.144889 
curve 65 LINE  0.537300,4.144889   3.492453,4.144889 
curve 66 LINE  3.492453,4.144889   9.671409,4.567054 
subreg 1 property 1 boundary 67 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 hole 96 91 92 93 94 95 hole 87 88 89 84 85 86 hole 10 1 2 3 4 98 99 hole 82 69 70 71 72 73 74 75 76 77 78 79 80 81
m-ctl-point constant 1
m-ctl-point 1 xy [5.258806,0.], near 0.05 influence 0.270741
m-ctl-point 2 xy [11.480075,-4.144328],near 0.02  influence 0.177751
m-ctl-point 3 xy [11.160124,-7.841539],near 0.02  influence 0.150826
m-ctl-point 4 xy [9.702570,-9.512394], near 0.02 influence 0.150826
m-ctl-point 5 xy [5.365456,-10.436697],near 0.02  influence 0.128178
m-ctl-point 6 xy [1.703795,-10.258946], near 0.02 influence 0.146577
"""
thetest="t46"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t47
input="""
!
! square with a very strong gradation at one corner (1:200,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 1 xy -100 , -100 near .001 influence 0.005
"""
thetest="t47"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t48
input="""
!
! square with a very strong gradation at one corner (1:200,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 1 xy -100 , -100 near .005 influence 0.005
"""
thetest="t48"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t49
input="""
!
! square with a very strong gradation at one corner (1:200,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 1 xy -100 , -100 near .005 influence 0.15
m-ctl-point 2 xy  100 , -100 near .005 influence 0.15
m-ctl-point 3 xy -100 ,  100 near .005 influence 0.15
m-ctl-point 4 xy  100 ,  100 near .005 influence 0.15
"""
thetest="t49"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t5
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point 1 xy 0,0 near 1 influence 3 
m-ctl-point 2 xy 0,-1 near 0.1 influence 1
"""
thetest="t5"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t50
input="""
!
! square with a very strong gradation at two corners (1:40,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near .05 influence 0.1
m-ctl-point 1 xy -100 , -100 near .001 influence 0.015

"""
thetest="t50"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t51
input="""
!
! square with a very strong gradation at two corners (1:40,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near .02 influence 0.1
m-ctl-point 1 xy -100 , -100 near .02 influence 0.1
"""
thetest="t51"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t52
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0004 influence 0.001
m-ctl-point 1 xy -100 , -100 near 0.0004 influence 0.001
"""
thetest="t52"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t53
input="""
! ==+L-shaped quarter of a plate, uniform (121 mesh-control points)

curve 1 line 1 0  2 0  
curve 2 line 2 0  2 2 
curve 3 line 2 2  0 2 
curve 4 line 0 2  0 1 
curve 5 line 0 1  1 1 
curve 6 line 1 1  1 0 

subregion 1 property 1 boundary 1 2 3 4 5 6

m-ctl-point constant 0.2 

"""
thetest="t53"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t54
input="""
! ==+L-shaped quarter of a plate, uniform (1722 mesh-control points)

curve 1 line 1 0  2 0  
curve 2 line 2 0  2 2 
curve 3 line 2 2  0 2 
curve 4 line 0 2  0 1 
curve 5 line 0 1  1 1 
curve 6 line 1 1  1 0 

subregion 1 property 1 boundary 1 2 3 4 5 6

m-ctl-point constant 0.22 
"""
thetest="t54"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t55
input="""
! ==+L-SHAPED QUARTER OF A PLATE WITH A CRACK, GRADED

curve  1 line  1 0    2 0   
curve  2 line  2 0    2 2  
curve  3 line  2 2    0 2  
curve  4 line  0 2    0 1  
curve  5 line  0 1    1 1  
curve  6 line  1 1    1 0  
curve  7 line  1.05 1.05    1.065 1.062    ! crack
curve  8 line  1.065 1.062    1.08 1.08    ! crack
curve  9 line  1.08 1.08    1.062 1.065   ! crack
curve 10 line  1.062 1.065    1.05 1.05   ! crack

subregion 1 property 1    boundary 1 2 3 4 5 6 hole -7 -10 -9 -8

m-ctl constant 0.3
"""
thetest="t55"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t56
input="""
! ==+L-SHAPED QUARTER OF A PLATE WITH A CRACK, GRADED

curve  1 line  1 0    2 0   
curve  2 line  2 0    2 2  
curve  3 line  2 2    0 2  
curve  4 line  0 2    0 1  
curve  5 line  0 1    1 1  
curve  6 line  1 1    1 0  
curve  7 line  1.05 1.05    1.065 1.062    ! crack
curve  8 line  1.065 1.062    1.08 1.08    ! crack
curve  9 line  1.08 1.08    1.062 1.065   ! crack
curve 10 line  1.062 1.065    1.05 1.05   ! crack

subregion 1 property 1    boundary 1 2 3 4 5 6 hole -7 -10 -9 -8

m-ctl constant 0.33
"""
thetest="t56"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t57
input="""
! ==+L-SHAPED QUARTER OF A PLATE WITH A CRACK, GRADED

curve  1 line  1 0    2 0   
curve  2 line  2 0    2 2  
curve  3 line  2 2    0 2  
curve  4 line  0 2    0 1  
curve  5 line  0 1    1 1  
curve  6 line  1 1    1 0  
curve  7 line  1.05 1.05    1.065 1.062    ! crack
curve  8 line  1.065 1.062    1.08 1.08    ! crack
curve  9 line  1.08 1.08    1.062 1.065   ! crack
curve 10 line  1.062 1.065    1.05 1.05   ! crack

subregion 1 property 1    boundary 1 2 3 4 5 6 hole -7 -10 -9 -8

m-ctl constant 0.012

!                    alist         list
!=====================================================
! cdim  triangles   timing        timing   triangles/s
!=====================================================
! 0.03     8066      13.0          13.5     (620/597)
! 0.02    16862      31.0          34.0     (544/495)
! 0.015   32490      56.6          66.0     (574/493)
! 0.012   47700      93.0         110.0     (513/434)
! 0.01    74786     145.0                   (516/   )
!=====================================================

"""
thetest="t57"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t58
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point 1 xy 0,0 near 0.10 influence 3 

"""
thetest="t58"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t59
input="""
!
! Samples to test circular arcs
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0 0.000001
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.26

"""
thetest="t59"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t6
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point 1 xy 3 1.5 near 1 influence 3 
m-ctl-point 2 xy 0,-1 near 0.1 influence 0.5
"""
thetest="t6"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t60
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0 0.000001
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.2

"""
thetest="t60"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t61
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0.1 3
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.2


"""
thetest="t61"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t62
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc -3 0 3 0 center 0 -3
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 2 3

m-ctl-point constant 0.2

"""
thetest="t62"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t63
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc -3 0 3 0 center 0 -4 opposite
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 2 3

m-ctl-point constant 1

"""
thetest="t63"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t64
input="""
curve 11 LINE [3.300000,6.040000] [0.000000,6.040000] GID 766178277,
curve 13 LINE [0.000000,6.040000] [0.000000,4.53000] GID 766178340,
curve 14 LINE [0.000000,4.53000] [0.000000,3.02000] GID 766178343,
curve 15 LINE [0.000000,3.02000] [0.000000,1.51000] GID 766178344,
curve 16 LINE [0.000000,1.51000] [0.000000,0.0000] GID 766178345,
curve 1 LINE [0.000000,0.000000] [1.060000,0.000000] GID 766178129,
curve 2 LINE [1.060000,0.000000] [2.120000,0.000000] GID 766178132,
curve 3 LINE [2.120000,0.000000] [3.180000,0.000000] GID 766178136,
curve 4 LINE [3.180000,0.000000] [4.240000,0.000000] GID 766178137,
curve 5 LINE [4.240000,0.000000] [5.300000,0.000000] GID 766178140,
curve 7 LINE [5.300000,0.000000] [5.300000,4.040000] GID 766178183,
curve 8 arc 5.3 4.04 3.3 6.04 center 5.3 6.04 

subregion 1 property 1 --
boundary --
11 13 14 15 16 1 2 3 4 5 7 8

m-ctl-p constant 5
m-ctl-point 1 xy 3.3 6 NEAR 0.12 Influence 0.2 
m-ctl-point 2 xy 5.3 4 NEAR 0.12 Influence 0.2

"""
thetest="t64"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t65
input="""
curve 11 LINE [3.300000,6.040000] [0.000000,6.040000] GID 766178277,
curve 13 LINE [0.000000,6.040000] [0.000000,4.53000] GID 766178340,
curve 14 LINE [0.000000,4.53000] [0.000000,3.02000] GID 766178343,
curve 15 LINE [0.000000,3.02000] [0.000000,1.51000] GID 766178344,
curve 16 LINE [0.000000,1.51000] [0.000000,0.0000] GID 766178345,
curve 1 LINE [0.000000,0.000000] [1.060000,0.000000] GID 766178129,
curve 2 LINE [1.060000,0.000000] [2.120000,0.000000] GID 766178132,
curve 3 LINE [2.120000,0.000000] [3.180000,0.000000] GID 766178136,
curve 4 LINE [3.180000,0.000000] [4.240000,0.000000] GID 766178137,
curve 5 LINE [4.240000,0.000000] [5.300000,0.000000] GID 766178140,
curve 7 LINE [5.300000,0.000000] [5.300000,4.040000] GID 766178183,
curve 8 arc 5.3 4.04 3.3 6.04 center 5.3 6.04 

subregion 1 --
property 1 --
material 1 --
subsoil 1 --
thickness 0.13 --
group detail --
boundary --
11 --
13 --
14 --
15 --
16 --
1 --
2 --
3 --
4 --
5 --
7 --
8 --
0


m-ctl-p constant 5
m-ctl-point 1 xy 3.3 6 NEAR    0.21 Influence 0.2 
m-ctl-point 2 xy 5.3 4 NEAR    0.21 Influence 0.2
m-ctl-point 3 xy 3.4 5.3 NEAR  0.23 Influence 0.2
m-ctl-point 4 xy 3.9 4.6 NEAR  0.23 Influence 0.2
m-ctl-point 4 xy 4.6 4.15 NEAR 0.23 Influence 0.2

"""
thetest="t65"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t66
input="""
curve 11 LINE [3.300000,6.040000] [0.000000,6.040000] GID 766178277,
curve 13 LINE [0.000000,6.040000] [0.000000,4.53000] GID 766178340,
curve 14 LINE [0.000000,4.53000] [0.000000,3.02000] GID 766178343,
curve 15 LINE [0.000000,3.02000] [0.000000,1.51000] GID 766178344,
curve 16 LINE [0.000000,1.51000] [0.000000,0.0000] GID 766178345,
curve 1 LINE [0.000000,0.000000] [1.060000,0.000000] GID 766178129,
curve 2 LINE [1.060000,0.000000] [2.120000,0.000000] GID 766178132,
curve 3 LINE [2.120000,0.000000] [3.180000,0.000000] GID 766178136,
curve 4 LINE [3.180000,0.000000] [4.240000,0.000000] GID 766178137,
curve 5 LINE [4.240000,0.000000] [5.300000,0.000000] GID 766178140,
curve 7 LINE [5.300000,0.000000] [5.300000,4.040000] GID 766178183,
curve 8 arc 5.3 4.04 3.3 6.04 center 5.3 6.04 

subregion 1 --
property 1 --
material 1 --
subsoil 1 --
thickness 0.13 --
group detail --
boundary --
11 --
13 --
14 --
15 --
16 --
1 --
2 --
3 --
4 --
5 --
7 --
8 --
0


m-ctl-p constant 2
m-ctl-point 1 xy 3.2 6 NEAR    0.19 Influence 0.25 
m-ctl-point 2 xy 5.3 3.9 NEAR  0.19 Influence 0.25
m-ctl-point 3 xy 3.4 5.3 NEAR  0.2 Influence 0.2
m-ctl-point 4 xy 3.9 4.6 NEAR  0.3 Influence 0.2
m-ctl-point 4 xy 4.6 4.15 NEAR 0.2 Influence 0.2

"""
thetest="t66"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t67
input="""
! mesh-size control first (need it for the DISCRETIZED curve)
m-ctl-p constant 1
m-ctl-p 1 xy 5.3 4 near 0.1 influence 0.2

! now can define curves
curve 100 DISCRETIZED --
[0.000000,0.000000] --
[1.060000,0.000000] --
[2.120000,0.000000] --
[3.180000,0.000000] --
[4.240000,0.000000] --
[5.300000,0.000000]

curve 101 DISCRETIZED --
[0.000000,6.040000] --
[0.100000,4.53000] --
[0.1300000,3.02000] --
[0.100000,1.51000] --
[0.000000,0.0000]

curve 11 LINE [3.300000,6.040000] [0.000000,6.040000] GID 766178277,
curve 7 LINE [5.300000,0.000000] [5.300000,4.040000] GID 766178183,
curve 8 arc 5.3 4.04 3.3 6.04 center 5.3 6.04 

subregion 1 --
property 1 --
material 1 --
subsoil 1 --
thickness 0.13 --
group detail --
boundary --
7 --
8 --
11 --
101 --
100 --
0


 fixed 1316 xy 5.3 4.02 curve 7
 fixed 1316 xy 5.3 4. curve 7
 fixed 1316 xy 5.3 3.99 curve 7
! fixed 1316 xy 5.3 3.20 curve 7
! fixed 1316 xy 5.3 3.0 curve 7
! fixed 1316 xy 5.3 2.9 curve 7
!  fixed 1316 xy 5.3 2.50 curve 7
!  fixed 1315 xy 5.3 1.49 curve 7 
!  fixed 1315 xy 5.3 1.29 curve 7 
!  fixed 1315 xy 5.3 1.00 curve 7 
!  fixed 1315 xy 5.3 .80 curve 7 
!  fixed 1315 xy 5.3 .60 curve 7 
!  fixed 1314 xy 5.3 0.49 curve 7 
!  fixed 1314 xy 5.3 0.29 curve 7 

! fixed 1317 xy 2.82 6.15 curve 11
! fixed 1317 xy 2.52 6.15 curve 11

"""
thetest="t67"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t68
input="""
!
! square meshed as if for hp-extension
!
m-ctl-point constant 200

curve 1 discretized -100 -100 --
30 -100 --
95 -100 --
100 -100

curve 2 discretized 100 -100 --
100 -95 --
100 -30 --
100 100

curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4


"""
thetest="t68"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t69
input="""

m-ctl constant 2

curve  1 line  1 0    2 0   
curve  2 line  2 0    2 2  
curve  3 line  2 2    0 2  
curve  4 line  0 2    0 1  
curve  5 discretized 0 1    --
0.85 1 --
1 1  
curve  6 discretized 1 1 --
1 0.85 --
1 0  


subregion 1 property 1    boundary 1 2 3 4 5 6 



!                    alist         list
!=====================================================
! cdim  triangles   timing        timing   triangles/s
!=====================================================
! 0.03     8066      13.0          13.5     (620/597)
! 0.02    16862      31.0          34.0     (544/495)
! 0.015   32490      56.6          66.0     (574/493)
! 0.012   47700      93.0         110.0     (513/434)
! 0.01    74786     145.0                   (516/   )
!=====================================================

"""
thetest="t69"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t7
input="""
curve 1 line 0 -1 3 1.5  dim 1.0 1.0
curve 2 line 3 1.5  -2 2 dim 1.0 1.0
curve 3 line 0 -1 -2 2  dim 1.0 1.0
subregion 1  property 1 boundary 1 2 -3 
m-ctl-point 1 xy 3 1.5 near 1 influence 3 
m-ctl-point 2 xy 0,-1 near 0.001 influence 0.01
"""
thetest="t7"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t70
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0 0.000001
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.25


"""
thetest="t70"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t71
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0.1 3
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.2


"""
thetest="t71"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t72
input="""
!
! curved-side triangle
!
curve 1 arc 0 3 -3 0 center 3 0 
curve 2 arc 3 0 -3 0 center 0.1 3
curve 3 arc 3 0 0 3  center -3 0

subregion 1  property 1 boundary 1 -2 3

m-ctl-point constant 0.2


"""
thetest="t72"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t73
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc -3 0 3 0 center 0 -3
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 2 3

m-ctl-point constant 0.2

"""
thetest="t73"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t74
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc -3 0 3 0 center 0 -4 opposite
curve 3 line 3 0 0 3

subregion 1  property 1 boundary 1 2 3

m-ctl-point constant 1

"""
thetest="t74"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t75
input="""


m-ctl constant 5
m-ctl-point 1 xy 5 6 NEAR 0.1 Influence 0.001 
m-ctl-point 2 xy 7 6 NEAR 0.1 Influence 0.001 
m-ctl-point 3 xy 7 6.3 NEAR 0.15 Influence 0.001 
m-ctl-point 4 xy 6.7 6 NEAR 0.15 Influence 0.001 
m-ctl-point 5 xy 5.3 6 NEAR 0.15 Influence 0.001 
m-ctl-point 6 xy 5 6.3 NEAR 0.15 Influence 0.001 

curve 9 discretized [0.000000,8.000000] [0.000000,3.000000] 
curve 10 discretized [0.000000,3.000000] --
2.1213203 2.1213203 --
[3.000000,0.000000] 
curve 1 discretized [3.000000,0.000000] [11.000000,0.000000] 
curve 3 discretized [11.000000,0.000000][11,4] [11.000000,8.000000]
curve 4 discretized [11.000000,8.000000] [8,8] [7.000000,8.000000] 
curve 5 discretized [7.000000,8.000000] -- 
7 6.3 --
[7.000000,6.000000] 
curve 6 discretized [7.000000,6.000000] --
6.7 6 --
5.3 6 --
[5.000000,6.000000] 
curve 7 discretized [5.000000,6.000000] --
5 6.3 --
[5.000000,8.000000] 
curve 8 discretized [5.000000,8.000000] [2.5,8] [0.000000,8.000000] 

! curve 12 CIRCLE center [8.000000,2.500000], radius 1.500000 
! 3.5606602 1.4393398 6.9393398 9.0606602
curve 12 discretized 8 4 --
6.9393398 3.5606602 --
6.5 2.5 --
6.9393398 1.4393398 --
8 1 --
9.0606602 1.4393398 --
9.5 2.5 --
9.0606602 3.5606602 --
8 4

subregion 1 property 1 boundary 9 10 1 3 4 5 6 7 8  hole -12

"""
thetest="t75"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t76
input="""


m-ctl constant 5
m-ctl-point 1 xy 5 6 NEAR 0.3 Influence 0.25
m-ctl-point 2 xy 7 6 NEAR 0.3 Influence 0.25 

curve 9 line [0.000000,8.000000] [0.000000,3.000000] 
curve 10 line [0.000000,3.000000] --
[3.000000,0.000000] 
curve 1 line [3.000000,0.000000] [11.000000,0.000000] 
curve 3 line [11.000000,0.000000] [11.000000,8.000000]
curve 4 line [11.000000,8.000000] [7.000000,8.000000] 
curve 5 line [7.000000,8.000000] -- 
[7.000000,6.000000] 
curve 6 line [7.000000,6.000000] --
[5.000000,6.000000] 
curve 7 line [5.000000,6.000000] --
[5.000000,8.000000] 
curve 8 line [5.000000,8.000000] [0.000000,8.000000] 

! curve 12 CIRCLE center [8.000000,2.500000], radius 1.500000 
! 3.5606602 1.4393398 6.9393398 9.0606602
 curve 12 discretized 8 4 --
 6.9393398 3.5606602 --
 6.5 2.5 --
 6.9393398 1.4393398 --
 8 1 --
 9.0606602 1.4393398 --
 9.5 2.5 --
 9.0606602 3.5606602 --
 8 4

subregion 1 property 1 boundary 9 10 1 3 4 5 6 7 8  hole -12

"""
thetest="t76"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t77
input="""
!
! curved-side triangle
!
curve 1 line 0 3 -3 0  
curve 2 arc 3 0 -3 0 center 0.1 3
curve 3 line 3 0 0 3
curve 4 circle center 0 0.6 radius 1.0

subregion 1  property 1 boundary 1 -2 3 hole -4

m-ctl-point constant 0.3


"""
thetest="t77"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t78
input="""
!
! curved-side triangle
!
curve 4 circle center 0 0 radius 0.9
curve 5 circle center 0 0 radius 2.0

subregion 1  property 1 boundary 5 hole -4

m-ctl-point constant 0.3


"""
thetest="t78"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t79
input="""
!
! full circle with steep gradation at the boundary
!
curve 4 circle center 0 0 radius 0.9

subregion 1  property 1 boundary 4

m-ctl-point constant 0.3
! cos(x)*0.9, sin(x)*0.9:
! x
! 15   0.86933324   0.23293714
! 25   0.81567701   0.38035644
!
mc-p 1  {0.81567701 0.38035644}  0.0005 0.0015
"""
thetest="t79"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t8
input="""
!  DEFINICE HRANICNICH KRIVEK - VNEJSI OBRYS
CURVE 1 LINE 0,0 0.6,0 
CURVE 2 LINE 0.6,0 1.2,2.7 
CURVE 3 LINE 1.2,2.7 10.8,2.7 
CURVE 4 LINE 10.8,2.7 11.4,0  
CURVE 5 LINE 11.4,0 12,0 
CURVE 6 LINE 12,0 12,23.8  
CURVE 7 LINE 12,23.8 0,23.8 
CURVE 8 LINE 0,23.8 0,0 
!  DTTO - OTVORY
CURVE  9 LINE 9.6,3.3 8.1,3.3 
CURVE 10 LINE 8.1,3.3 8.1,6. 
CURVE 11 LINE 8.1,6. 9.6,6. 
CURVE 12 LINE 9.6,6. 9.6,3.3 
CURVE 13 LINE 9.6,6.6 8.1,6.6 
CURVE 14 LINE 8.1,6.6 8.1,9.3 
CURVE 15 LINE 8.1,9.3 9.6,9.3 
CURVE 16 LINE 9.6,9.3 9.6,6.6 
CURVE 17 LINE 9.6,9.9 8.1,9.9 
CURVE 18 LINE 8.1,9.9 8.1,12.6 
CURVE 19 LINE 8.1,12.6 9.6,12.6 
CURVE 20 LINE 9.6,12.6 9.6,9.9 
CURVE 21 LINE 9.6,13.2 8.1,13.2 
CURVE 22 LINE 8.1,13.2 8.1,15.9 
CURVE 23 LINE 8.1,15.9 9.6,15.9 
CURVE 24 LINE 9.6,15.9 9.6,13.2 
CURVE 25 LINE 9.6,16.5 8.1,16.5 
CURVE 26 LINE 8.1,16.5 8.1,19.3 
CURVE 27 LINE 8.1,19.3 9.6,19.3 
CURVE 28 LINE 9.6,19.3 9.6,16.5 
CURVE 29 LINE 9.6,19.8 8.1,19.8 
CURVE 30 LINE 8.1,19.8 8.1,22.6 
CURVE 31 LINE 8.1,22.6 9.6,22.6 
CURVE 32 LINE 9.6,22.6 9.6,19.8 
!  HRANICE OBLASTI - VNEJSI OBRYS (BOUNDARY) A OTVORY (HOLE)
SUBREGION 1 PROPERTY 1 BOUNDARY 1 2 3 4 5 6 7 8 hole  9 10 11 12 hole 13 14 15 16 hole 17 18 19 20 hole 21 22 23 24 hole 25 26 27 28 hole 29 30 31 32  
!  POCATECNI VELIKOST PRVKU
M-CTL-POINT constant 2
M-CTL-POINT 1 xy 0 0 near 0.012 influence 0.25
M-CTL-POINT 2 xy  12.6 0 near 0.012 influence 0.25
"""
thetest="t8"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t80
input="""
! triangle
curve 1 line 0 0 1 0  
curve 2 line 1 0 1 1
curve 3 line 1 1 0 0
subregion 1  property 1 boundary 1 2 3 
m-ctl-point constant 0.5
mc-p 1 0.6 0 0.001 0.005

"""
thetest="t80"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t81
input="""
!
! full circle with steep gradation at the boundary
!

curve 4 circle center 0 0 radius 0.9
curve 5 circle center 0 0 radius 2.0

subregion 1  property 1 boundary 4

m-ctl-point constant 0.3
! cos(x)*0.9, sin(x)*0.9:
! x
! 15   0.86933324   0.23293714
! 25   0.81567701   0.38035644
!

MC-T 0.816536 0.378509 0.816105 0.379437 0.815615 0.378704 0.001100 0.001024 0.001066
MC-T 0.816105 0.379437 0.815684 0.380342 0.815353 0.379577 0.001024 0.000998 0.001016
MC-T 0.815684 0.380342 0.815251 0.381269 0.814852 0.380287 0.000998 0.001023 0.001015
MC-T 0.816105 0.379437 0.815353 0.379577 0.815615 0.378704 0.001024 0.001016 0.001066
MC-T 0.815353 0.379577 0.815684 0.380342 0.814852 0.380287 0.001016 0.000998 0.001015
MC-T 0.814852 0.380287 0.815251 0.381269 0.814455 0.381139 0.001015 0.001023 0.001050
MC-T 0.815615 0.378704 0.815353 0.379577 0.814568 0.379144 0.001066 0.001016 0.001065
MC-T 0.815353 0.379577 0.814852 0.380287 0.814568 0.379144 0.001016 0.001015 0.001065
MC-T 0.814852 0.380287 0.814455 0.381139 0.813908 0.380294 0.001015 0.001050 0.001075
MC-T 0.814455 0.381139 0.815251 0.381269 0.814781 0.382273 0.001050 0.001023 0.001108
MC-T 0.816536 0.378509 0.815615 0.378704 0.816148 0.377608 0.001100 0.001066 0.001189
MC-T 0.815615 0.378704 0.814568 0.379144 0.815088 0.377996 0.001066 0.001065 0.001144
MC-T 0.814852 0.380287 0.813908 0.380294 0.814568 0.379144 0.001015 0.001075 0.001065
MC-T 0.813908 0.380294 0.814455 0.381139 0.813571 0.381604 0.001075 0.001050 0.001146
MC-T 0.814455 0.381139 0.814781 0.382273 0.813571 0.381604 0.001050 0.001108 0.001146
MC-T 0.816536 0.378509 0.816148 0.377608 0.816998 0.377510 0.001100 0.001189 0.001240
MC-T 0.816148 0.377608 0.815615 0.378704 0.815088 0.377996 0.001189 0.001066 0.001144
MC-T 0.815088 0.377996 0.814568 0.379144 0.813974 0.377993 0.001144 0.001065 0.001207
MC-T 0.813908 0.380294 0.813571 0.381604 0.812785 0.380406 0.001075 0.001146 0.001204
MC-T 0.816998 0.377510 0.816148 0.377608 0.817518 0.376384 0.001240 0.001189 0.001468
MC-T 0.816148 0.377608 0.815088 0.377996 0.815201 0.376557 0.001189 0.001144 0.001358
MC-T 0.815088 0.377996 0.813974 0.377993 0.815201 0.376557 0.001144 0.001207 0.001358
MC-T 0.813974 0.377993 0.814568 0.379144 0.813333 0.379237 0.001207 0.001065 0.001164
MC-T 0.813908 0.380294 0.812785 0.380406 0.813333 0.379237 0.001075 0.001204 0.001164
MC-T 0.812785 0.380406 0.813571 0.381604 0.812246 0.381611 0.001204 0.001146 0.001326
MC-T 0.813333 0.379237 0.814568 0.379144 0.813908 0.380294 0.001164 0.001065 0.001075
MC-T 0.816148 0.377608 0.815201 0.376557 0.817518 0.376384 0.001189 0.001358 0.001468
MC-T 0.813974 0.377993 0.813333 0.379237 0.812559 0.378225 0.001207 0.001164 0.001348
MC-T 0.812785 0.380406 0.812246 0.381611 0.811522 0.380336 0.001204 0.001326 0.001422
MC-T 0.812246 0.381611 0.813571 0.381604 0.813039 0.382961 0.001326 0.001146 0.001336
MC-T 0.813974 0.377993 0.812559 0.378225 0.813217 0.376830 0.001207 0.001348 0.001452
MC-T 0.812559 0.378225 0.813333 0.379237 0.812259 0.379381 0.001348 0.001164 0.001308
MC-T 0.814781 0.382273 0.814235 0.383433 0.813906 0.382568 0.001108 0.001282 0.001195
MC-T 0.814781 0.382273 0.813906 0.382568 0.813571 0.381604 0.001108 0.001195 0.001146
MC-T 0.813571 0.381604 0.813906 0.382568 0.813039 0.382961 0.001146 0.001195 0.001336
MC-T 0.813039 0.382961 0.813906 0.382568 0.814235 0.383433 0.001336 0.001195 0.001282
MC-T 0.814235 0.383433 0.813688 0.384592 0.813039 0.382961 0.001282 0.001535 0.001336
MC-T 0.812785 0.380406 0.811522 0.380336 0.812259 0.379381 0.001204 0.001422 0.001308
MC-T 0.811522 0.380336 0.812246 0.381611 0.811031 0.381616 0.001422 0.001326 0.001566
MC-T 0.812246 0.381611 0.813039 0.382961 0.811661 0.382701 0.001326 0.001336 0.001529
MC-T 0.813974 0.377993 0.813217 0.376830 0.815201 0.376557 0.001207 0.001452 0.001358
MC-T 0.813217 0.376830 0.812559 0.378225 0.811620 0.377241 0.001452 0.001348 0.001640
MC-T 0.812559 0.378225 0.812259 0.379381 0.811162 0.378712 0.001348 0.001308 0.001565
MC-T 0.812259 0.379381 0.813333 0.379237 0.812785 0.380406 0.001308 0.001164 0.001204
MC-T 0.811031 0.381616 0.812246 0.381611 0.811661 0.382701 0.001566 0.001326 0.001529
MC-T 0.811661 0.382701 0.813039 0.382961 0.812038 0.384182 0.001529 0.001336 0.001682
MC-T 0.811620 0.377241 0.812559 0.378225 0.811162 0.378712 0.001640 0.001348 0.001565
MC-T 0.811620 0.377241 0.811162 0.378712 0.809434 0.376880 0.001640 0.001565 0.002247
MC-T 0.811162 0.378712 0.812259 0.379381 0.811522 0.380336 0.001565 0.001308 0.001422
MC-T 0.811031 0.381616 0.811661 0.382701 0.810027 0.383099 0.001566 0.001529 0.001964
MC-T 0.818131 0.375050 0.817518 0.376384 0.816481 0.375076 0.001836 0.001468 0.001698
MC-T 0.811522 0.380336 0.811031 0.381616 0.809886 0.380304 0.001422 0.001566 0.001820
MC-T 0.813217 0.376830 0.811620 0.377241 0.812131 0.375677 0.001452 0.001640 0.001843
MC-T 0.811661 0.382701 0.812038 0.384182 0.810027 0.383099 0.001529 0.001682 0.001964
MC-T 0.812038 0.384182 0.813039 0.382961 0.813688 0.384592 0.001682 0.001336 0.001535
MC-T 0.812038 0.384182 0.813688 0.384592 0.813031 0.385980 0.001682 0.001535 0.001944
MC-T 0.816481 0.375076 0.817518 0.376384 0.815201 0.376557 0.001698 0.001468 0.001358
MC-T 0.811522 0.380336 0.809886 0.380304 0.811162 0.378712 0.001422 0.001820 0.001565
MC-T 0.809886 0.380304 0.811031 0.381616 0.810027 0.383099 0.001820 0.001566 0.001964
MC-T 0.813217 0.376830 0.812131 0.375677 0.814086 0.375318 0.001452 0.001843 0.001683
MC-T 0.812131 0.375677 0.811620 0.377241 0.809434 0.376880 0.001843 0.001640 0.002247
MC-T 0.809434 0.376880 0.811162 0.378712 0.809886 0.380304 0.002247 0.001565 0.001820
MC-T 0.818131 0.375050 0.816481 0.375076 0.817449 0.373289 0.001836 0.001698 0.002297
MC-T 0.813217 0.376830 0.814086 0.375318 0.815201 0.376557 0.001452 0.001683 0.001358
MC-T 0.818894 0.373380 0.818131 0.375050 0.817449 0.373289 0.002441 0.001836 0.002297
MC-T 0.814086 0.375318 0.812131 0.375677 0.813488 0.373708 0.001683 0.001843 0.002197
MC-T 0.817449 0.373289 0.816481 0.375076 0.815444 0.373957 0.002297 0.001698 0.002002
MC-T 0.818894 0.373380 0.817449 0.373289 0.819904 0.371157 0.002441 0.002297 0.003495
MC-T 0.814086 0.375318 0.813488 0.373708 0.815444 0.373957 0.001683 0.002197 0.002002
MC-T 0.813488 0.373708 0.812131 0.375677 0.811360 0.374203 0.002197 0.001843 0.002380
MC-T 0.813031 0.385980 0.812196 0.387735 0.810870 0.385733 0.001944 0.002625 0.002271
MC-T 0.816481 0.375076 0.815201 0.376557 0.815303 0.375227 0.001698 0.001358 0.001647
MC-T 0.815303 0.375227 0.815201 0.376557 0.814086 0.375318 0.001647 0.001358 0.001683
MC-T 0.815303 0.375227 0.814086 0.375318 0.815444 0.373957 0.001647 0.001683 0.002002
MC-T 0.815303 0.375227 0.815444 0.373957 0.816481 0.375076 0.001647 0.002002 0.001698
MC-T 0.812038 0.384182 0.813031 0.385980 0.810870 0.385733 0.001682 0.001944 0.002271
MC-T 0.817449 0.373289 0.815444 0.373957 0.816017 0.371214 0.002297 0.002002 0.003041
MC-T 0.813488 0.373708 0.811360 0.374203 0.812470 0.372200 0.002197 0.002380 0.002874
MC-T 0.811360 0.374203 0.812131 0.375677 0.809434 0.376880 0.002380 0.001843 0.002247
MC-T 0.816017 0.371214 0.815444 0.373957 0.813488 0.373708 0.003041 0.002002 0.002197
MC-T 0.817449 0.373289 0.816017 0.371214 0.819904 0.371157 0.002297 0.003041 0.003495
MC-T 0.810870 0.385733 0.812196 0.387735 0.809253 0.388251 0.002271 0.002625 0.003522
MC-T 0.812038 0.384182 0.810870 0.385733 0.810027 0.383099 0.001682 0.002271 0.001964
MC-T 0.813488 0.373708 0.812470 0.372200 0.816017 0.371214 0.002197 0.002874 0.003041
MC-T 0.812470 0.372200 0.811360 0.374203 0.809771 0.372996 0.002874 0.002380 0.003171
MC-T 0.810870 0.385733 0.809253 0.388251 0.808855 0.385186 0.002271 0.003522 0.002705
MC-T 0.809253 0.388251 0.812196 0.387735 0.811061 0.390102 0.003522 0.002625 0.003828
MC-T 0.809253 0.388251 0.811061 0.390102 0.809395 0.393548 0.003522 0.003828 0.006153
MC-T 0.810870 0.385733 0.808855 0.385186 0.810027 0.383099 0.002271 0.002705 0.001964
MC-T 0.809886 0.380304 0.810027 0.383099 0.808390 0.381683 0.001820 0.001964 0.002340
MC-T 0.809886 0.380304 0.808390 0.381683 0.807995 0.379852 0.001820 0.002340 0.002447
MC-T 0.808390 0.381683 0.810027 0.383099 0.807996 0.383436 0.002340 0.001964 0.002672
MC-T 0.809886 0.380304 0.807995 0.379852 0.809434 0.376880 0.001820 0.002447 0.002247
MC-T 0.807995 0.379852 0.808390 0.381683 0.806723 0.381837 0.002447 0.002340 0.003009
MC-T 0.808390 0.381683 0.807996 0.383436 0.806723 0.381837 0.002340 0.002672 0.003009
MC-T 0.807996 0.383436 0.810027 0.383099 0.808855 0.385186 0.002672 0.001964 0.002705
MC-T 0.807996 0.383436 0.808855 0.385186 0.806532 0.385576 0.002672 0.002705 0.003698
MC-T 0.807995 0.379852 0.806723 0.381837 0.806220 0.378837 0.002447 0.003009 0.003235
MC-T 0.807996 0.383436 0.806532 0.385576 0.806723 0.381837 0.002672 0.003698 0.003009
MC-T 0.806532 0.385576 0.808855 0.385186 0.809253 0.388251 0.003698 0.002705 0.003522
MC-T 0.809771 0.372996 0.811360 0.374203 0.809434 0.376880 0.003171 0.002380 0.002247
MC-T 0.807995 0.379852 0.806220 0.378837 0.809434 0.376880 0.002447 0.003235 0.002247
MC-T 0.812470 0.372200 0.809771 0.372996 0.812233 0.369555 0.002874 0.003171 0.004123
MC-T 0.806220 0.378837 0.806723 0.381837 0.804276 0.382444 0.003235 0.003009 0.004263
MC-T 0.821339 0.367970 0.819904 0.371157 0.816017 0.371214 0.005487 0.003495 0.003041
MC-T 0.812470 0.372200 0.812233 0.369555 0.816017 0.371214 0.002874 0.004123 0.003041
MC-T 0.812233 0.369555 0.809771 0.372996 0.807677 0.371335 0.004123 0.003171 0.004528
MC-T 0.806220 0.378837 0.804276 0.382444 0.803772 0.378348 0.003235 0.004263 0.004537
MC-T 0.804276 0.382444 0.806723 0.381837 0.806532 0.385576 0.004263 0.003009 0.003698
MC-T 0.812233 0.369555 0.807677 0.371335 0.808416 0.366717 0.004123 0.004528 0.006751
MC-T 0.807677 0.371335 0.809771 0.372996 0.806509 0.375272 0.004528 0.003171 0.003675
MC-T 0.806220 0.378837 0.803772 0.378348 0.806509 0.375272 0.003235 0.004537 0.003675
MC-T 0.806509 0.375272 0.803772 0.378348 0.802573 0.373925 0.003675 0.004537 0.006143
MC-T 0.806220 0.378837 0.806509 0.375272 0.809434 0.376880 0.003235 0.003675 0.002247
MC-T 0.803772 0.378348 0.804276 0.382444 0.800536 0.383116 0.004537 0.004263 0.006707
MC-T 0.806532 0.385576 0.809253 0.388251 0.806402 0.390264 0.003698 0.003522 0.005456
MC-T 0.806402 0.390264 0.809253 0.388251 0.809395 0.393548 0.005456 0.003522 0.006153
MC-T 0.806532 0.385576 0.806402 0.390264 0.803186 0.388778 0.003698 0.005456 0.006472
MC-T 0.806532 0.385576 0.803186 0.388778 0.804276 0.382444 0.003698 0.006472 0.004263
MC-T 0.803186 0.388778 0.806402 0.390264 0.804178 0.395942 0.006472 0.005456 0.009939
MC-T 0.806509 0.375272 0.809771 0.372996 0.809434 0.376880 0.003675 0.003171 0.002247
MC-T 0.823567 0.362957 0.821339 0.367970 0.815884 0.365537 0.009705 0.005487 0.006299
MC-T 0.807677 0.371335 0.806509 0.375272 0.802573 0.373925 0.004528 0.003675 0.006143
MC-T 0.806402 0.390264 0.809395 0.393548 0.804178 0.395942 0.005456 0.006153 0.009939
MC-T 0.812233 0.369555 0.808416 0.366717 0.815884 0.365537 0.004123 0.006751 0.006299
MC-T 0.802573 0.373925 0.803772 0.378348 0.800536 0.383116 0.006143 0.004537 0.006707
MC-T 0.800536 0.383116 0.804276 0.382444 0.803186 0.388778 0.006707 0.004263 0.006472
MC-T 0.809395 0.393548 0.806685 0.399073 0.804178 0.395942 0.006153 0.011228 0.009939
MC-T 0.808416 0.366717 0.807677 0.371335 0.802573 0.373925 0.006751 0.004528 0.006143
MC-T 0.803186 0.388778 0.804178 0.395942 0.797516 0.395924 0.006472 0.009939 0.014424
MC-T 0.804178 0.395942 0.806685 0.399073 0.802017 0.408372 0.009939 0.011228 0.023101
MC-T 0.821339 0.367970 0.816017 0.371214 0.816368 0.368569 0.005487 0.003041 0.004385
MC-T 0.816368 0.368569 0.816017 0.371214 0.812233 0.369555 0.004385 0.003041 0.004123
MC-T 0.821339 0.367970 0.816368 0.368569 0.815884 0.365537 0.005487 0.004385 0.006299
MC-T 0.815884 0.365537 0.816368 0.368569 0.812233 0.369555 0.006299 0.004385 0.004123
MC-T 0.815884 0.365537 0.808416 0.366717 0.813494 0.357818 0.006299 0.006751 0.013087
MC-T 0.823567 0.362957 0.815884 0.365537 0.813494 0.357818 0.009705 0.006299 0.013087
MC-T 0.803186 0.388778 0.797516 0.395924 0.800536 0.383116 0.006472 0.014424 0.006707
MC-T 0.797516 0.395924 0.804178 0.395942 0.802017 0.408372 0.014424 0.009939 0.023101
MC-T 0.813494 0.357818 0.808416 0.366717 0.799172 0.363696 0.013087 0.006751 0.013927
MC-T 0.827433 0.354055 0.823567 0.362957 0.813494 0.357818 0.020087 0.009705 0.013087
MC-T 0.802017 0.408372 0.797242 0.417618 0.797516 0.395924 0.023101 0.038178 0.014424
MC-T 0.802573 0.373925 0.800536 0.383116 0.792425 0.380586 0.006143 0.006707 0.013717
MC-T 0.802573 0.373925 0.792425 0.380586 0.799172 0.363696 0.006143 0.013717 0.013927
MC-T 0.792425 0.380586 0.800536 0.383116 0.797516 0.395924 0.013717 0.006707 0.014424
MC-T 0.808416 0.366717 0.802573 0.373925 0.799172 0.363696 0.006751 0.006143 0.013927
MC-T 0.813494 0.357818 0.799172 0.363696 0.806546 0.335005 0.013087 0.013927 0.045714
MC-T 0.827433 0.354055 0.813494 0.357818 0.806546 0.335005 0.020087 0.013087 0.045714
MC-T 0.835128 0.335501 0.827433 0.354055 0.806546 0.335005 0.050084 0.020087 0.045714
MC-T 0.797242 0.417618 0.788206 0.434432 0.755872 0.426894 0.038178 0.070401 0.096851
MC-T 0.788206 0.434432 0.778815 0.451051 0.755872 0.426894 0.070401 0.103585 0.096851
MC-T 0.792425 0.380586 0.797516 0.395924 0.782947 0.398062 0.013717 0.014424 0.031544
MC-T 0.782947 0.398062 0.797516 0.395924 0.797242 0.417618 0.031544 0.014424 0.038178
MC-T 0.792425 0.380586 0.782947 0.398062 0.771332 0.370461 0.013717 0.031544 0.044362
MC-T 0.806546 0.335005 0.799172 0.363696 0.771332 0.370461 0.045714 0.013927 0.044362
MC-T 0.799172 0.363696 0.792425 0.380586 0.771332 0.370461 0.013927 0.013717 0.044362
MC-T 0.771332 0.370461 0.782947 0.398062 0.755872 0.426894 0.044362 0.031544 0.096851
MC-T 0.755872 0.426894 0.782947 0.398062 0.797242 0.417618 0.096851 0.031544 0.038178
MC-T 0.835128 0.335501 0.806546 0.335005 0.846865 0.304662 0.050084 0.045714 0.107184
MC-T 0.857464 0.273414 0.846865 0.304662 0.798615 0.275565 0.156470 0.107184 0.144774
MC-T 0.755872 0.426894 0.778815 0.451051 0.751584 0.495098 0.096851 0.103585 0.176411
MC-T 0.771332 0.370461 0.755872 0.426894 0.700918 0.369256 0.044362 0.096851 0.157090
MC-T 0.806546 0.335005 0.771332 0.370461 0.758347 0.321248 0.045714 0.044362 0.107980
MC-T 0.806546 0.335005 0.758347 0.321248 0.798615 0.275565 0.045714 0.107980 0.144774
MC-T 0.758347 0.321248 0.771332 0.370461 0.700918 0.369256 0.107980 0.044362 0.157090
MC-T 0.751584 0.495098 0.721864 0.537506 0.671903 0.480952 0.176411 0.220317 0.215297
MC-T 0.846865 0.304662 0.806546 0.335005 0.798615 0.275565 0.107184 0.045714 0.144774
MC-T 0.857464 0.273414 0.798615 0.275565 0.805722 0.164040 0.156470 0.144774 0.238388
MC-T 0.798615 0.275565 0.758347 0.321248 0.711556 0.255265 0.144774 0.107980 0.205872
MC-T 0.700918 0.369256 0.755872 0.426894 0.671903 0.480952 0.157090 0.096851 0.215297
MC-T 0.758347 0.321248 0.700918 0.369256 0.711556 0.255265 0.107980 0.157090 0.205872
MC-T 0.755872 0.426894 0.751584 0.495098 0.671903 0.480952 0.096851 0.176411 0.215297
MC-T 0.671903 0.480952 0.721864 0.537506 0.570073 0.696431 0.215297 0.220317 0.278892
MC-T 0.700918 0.369256 0.671903 0.480952 0.525808 0.358457 0.157090 0.215297 0.262359
MC-T 0.857464 0.273414 0.805722 0.164040 0.889302 0.138352 0.156470 0.238388 0.252218
MC-T 0.889302 0.138352 0.805722 0.164040 0.900000 0.000000 0.252218 0.238388 0.277805
MC-T 0.805722 0.164040 0.798615 0.275565 0.711556 0.255265 0.238388 0.144774 0.205872
MC-T 0.711556 0.255265 0.700918 0.369256 0.525808 0.358457 0.205872 0.157090 0.262359
MC-T 0.805722 0.164040 0.711556 0.255265 0.670273 0.039392 0.238388 0.205872 0.275671
MC-T 0.525808 0.358457 0.671903 0.480952 0.570073 0.696431 0.262359 0.215297 0.278892
MC-T 0.711556 0.255265 0.525808 0.358457 0.670273 0.039392 0.205872 0.262359 0.275671
MC-T 0.900000 0.000000 0.805722 0.164040 0.670273 0.039392 0.277805 0.238388 0.275671
MC-T -0.899554 -0.028314 -0.865629 -0.246345 -0.671707 -0.129893 0.298834 0.298874 0.298536
MC-T -0.865629 -0.246345 -0.779672 -0.449568 -0.671707 -0.129893 0.298874 0.298879 0.298536
MC-T 0.900000 0.000000 0.670273 0.039392 0.857464 -0.273414 0.277805 0.275671 0.291755
MC-T 0.570073 0.696431 0.330548 0.837101 0.266524 0.609167 0.278892 0.292022 0.290060
MC-T 0.725714 -0.532296 0.857464 -0.273414 0.511361 -0.300758 0.295735 0.291755 0.293601
MC-T 0.570073 0.696431 0.266524 0.609167 0.525808 0.358457 0.278892 0.290060 0.262359
MC-T 0.266524 0.609167 0.330548 0.837101 0.046427 0.898802 0.290060 0.292022 0.295830
MC-T 0.046427 0.898802 -0.246203 0.865670 -0.110832 0.518095 0.295830 0.297354 0.295909
MC-T -0.246203 0.865670 -0.513724 0.738978 -0.110832 0.518095 0.297354 0.298093 0.295909
MC-T -0.513724 0.738978 -0.726111 0.531754 -0.496560 0.388028 0.298093 0.298491 0.297902
MC-T -0.726111 0.531754 -0.859686 0.266346 -0.496560 0.388028 0.298491 0.298715 0.297902
MC-T -0.859686 0.266346 -0.899554 -0.028314 -0.671707 -0.129893 0.298715 0.298834 0.298536
MC-T -0.779672 -0.449568 -0.590544 -0.679160 -0.424491 -0.447469 0.298879 0.298831 0.298372
MC-T -0.590544 -0.679160 -0.337019 -0.834517 -0.424491 -0.447469 0.298831 0.298708 0.298372
MC-T -0.337019 -0.834517 -0.046938 -0.898775 -0.067238 -0.600752 0.298708 0.298479 0.297926
MC-T -0.046938 -0.898775 0.247866 -0.865195 -0.067238 -0.600752 0.298479 0.298071 0.297926
MC-T 0.247866 -0.865195 0.515107 -0.738014 0.237681 -0.502234 0.298071 0.297311 0.296766
MC-T 0.515107 -0.738014 0.725714 -0.532296 0.511361 -0.300758 0.297311 0.295735 0.293601
MC-T 0.511361 -0.300758 0.857464 -0.273414 0.670273 0.039392 0.293601 0.291755 0.275671
MC-T 0.046427 0.898802 -0.110832 0.518095 0.266524 0.609167 0.295830 0.295909 0.290060
MC-T -0.513724 0.738978 -0.496560 0.388028 -0.110832 0.518095 0.298093 0.297902 0.295909
MC-T -0.779672 -0.449568 -0.424491 -0.447469 -0.671707 -0.129893 0.298879 0.298372 0.298536
MC-T -0.337019 -0.834517 -0.067238 -0.600752 -0.424491 -0.447469 0.298708 0.297926 0.298372
MC-T 0.247866 -0.865195 0.237681 -0.502234 -0.067238 -0.600752 0.298071 0.296766 0.297926
MC-T 0.237681 -0.502234 0.515107 -0.738014 0.511361 -0.300758 0.296766 0.297311 0.293601
MC-T 0.670273 0.039392 0.525808 0.358457 0.366672 0.068021 0.275671 0.262359 0.288312
MC-T 0.670273 0.039392 0.366672 0.068021 0.511361 -0.300758 0.275671 0.288312 0.293601
MC-T 0.366672 0.068021 0.525808 0.358457 0.223121 0.338648 0.288312 0.262359 0.290031
MC-T 0.223121 0.338648 0.525808 0.358457 0.266524 0.609167 0.290031 0.262359 0.290060
MC-T 0.223121 0.338648 0.266524 0.609167 -0.110832 0.518095 0.290031 0.290060 0.295909
MC-T 0.366672 0.068021 0.223121 0.338648 0.058587 0.134831 0.288312 0.290031 0.294364
MC-T 0.366672 0.068021 0.058587 0.134831 0.187140 -0.173736 0.288312 0.294364 0.294905
MC-T 0.058587 0.134831 0.223121 0.338648 -0.110832 0.518095 0.294364 0.290031 0.295909
MC-T 0.366672 0.068021 0.187140 -0.173736 0.511361 -0.300758 0.288312 0.294905 0.293601
MC-T 0.187140 -0.173736 0.058587 0.134831 -0.083774 -0.109582 0.294905 0.294364 0.296571
MC-T 0.187140 -0.173736 -0.083774 -0.109582 0.019441 -0.341254 0.294905 0.296571 0.296881
MC-T -0.083774 -0.109582 0.058587 0.134831 -0.251324 0.154230 0.296571 0.294364 0.296972
MC-T 0.187140 -0.173736 0.019441 -0.341254 0.237681 -0.502234 0.294905 0.296881 0.296766
MC-T 0.237681 -0.502234 0.019441 -0.341254 -0.067238 -0.600752 0.296766 0.296881 0.297926
MC-T 0.019441 -0.341254 -0.083774 -0.109582 -0.181516 -0.323773 0.296881 0.296571 0.297578
MC-T -0.083774 -0.109582 -0.251324 0.154230 -0.356110 -0.123779 0.296571 0.296972 0.297780
MC-T -0.251324 0.154230 0.058587 0.134831 -0.110832 0.518095 0.296972 0.294364 0.295909
MC-T 0.019441 -0.341254 -0.181516 -0.323773 -0.067238 -0.600752 0.296881 0.297578 0.297926
MC-T -0.067238 -0.600752 -0.181516 -0.323773 -0.424491 -0.447469 0.297926 0.297578 0.298372
MC-T -0.424491 -0.447469 -0.181516 -0.323773 -0.356110 -0.123779 0.298372 0.297578 0.297780
MC-T -0.181516 -0.323773 -0.083774 -0.109582 -0.356110 -0.123779 0.297578 0.296571 0.297780
MC-T -0.356110 -0.123779 -0.251324 0.154230 -0.527077 0.110987 0.297780 0.296972 0.298072
MC-T -0.356110 -0.123779 -0.527077 0.110987 -0.671707 -0.129893 0.297780 0.298072 0.298536
MC-T -0.356110 -0.123779 -0.671707 -0.129893 -0.424491 -0.447469 0.297780 0.298536 0.298372
MC-T -0.527077 0.110987 -0.251324 0.154230 -0.496560 0.388028 0.298072 0.296972 0.297902
MC-T -0.527077 0.110987 -0.496560 0.388028 -0.859686 0.266346 0.298072 0.297902 0.298715
MC-T -0.671707 -0.129893 -0.527077 0.110987 -0.859686 0.266346 0.298536 0.298072 0.298715
MC-T 0.511361 -0.300758 0.187140 -0.173736 0.237681 -0.502234 0.293601 0.294905 0.296766
MC-T -0.496560 0.388028 -0.251324 0.154230 -0.110832 0.518095 0.297902 0.296972 0.295909
"""
thetest="t81"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t82
input="""
! triangle
curve 1 line 0 0 1 0  
curve 2 line 1 0 1 1
curve 3 line 1 1 0 0
subregion 1  property 1 boundary 1 2 3 
m-ctl-point constant 0.5
mc-p 1 0 0 0.0001 0.0001

"""
thetest="t82"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t83
input="""
!
! curved-side triangle
!
curve 4 circle center 0 0 radius 0.9
curve 5 circle center 0 0 radius 2.0

subregion 1  property 1 boundary 5 hole -4

m-ctl-point constant 0.25


"""
thetest="t83"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t84
input="""
!
!  Ementaler cheese
!
curve 56 LINE -1.418952,-1.535336  -1.872144,2.909428 
curve 57 LINE -1.872144,2.909428  2.834078,2.839707 
curve 58 LINE 2.834078,2.839707  2.712065,-1.709641 
curve 59 LINE 2.712065,-1.709641  -1.418952,-1.535336 

curve 61 CIRCLE center -1.296939,2.334224 , radius 0.261457
curve 70 CIRCLE center -0.965760,1.270966 , radius 0.296830
curve 84 CIRCLE center -1.070343,0.364583 , radius 0.414317
curve 88 CIRCLE center -1.018052,-1.186727 , radius 0.187732
curve 91 CIRCLE center -0.129099,-1.221588 , radius 0.296830
curve 86 CIRCLE center -0.669443,-0.628953 , radius 0.288525
curve 82 CIRCLE center 0.080067,-0.018887 , radius 0.331637
curve 93 CIRCLE center 0.707563,-0.698675 , radius 0.414317
curve 99 CIRCLE center 1.613946,-1.099575 , radius 0.348609
curve 97 CIRCLE center 2.380886,-1.029853 , radius 0.165360
curve 63 CIRCLE center -0.129099,1.985615 , radius 0.474159
curve 65 CIRCLE center 1.021311,2.072767 , radius 0.398239
curve 67 CIRCLE center 2.154290,2.299363 , radius 0.174304
curve 72 CIRCLE center 0.080067,0.870066 , radius 0.343782
curve 74 CIRCLE center 1.056172,1.218675 , radius 0.198738
curve 76 CIRCLE center 1.927694,1.375549 , radius 0.478624
curve 78 CIRCLE center 2.241442,0.312291 , radius 0.187732
curve 80 CIRCLE center 1.369920,0.399444 , radius 0.408036
curve 95 CIRCLE center 1.840542,-0.402357 , radius 0.223219

subregion 1 property 1 boundary -59 -58 -57 -56 hole -61 hole -70 hole -84 hole -88 hole -91 hole -86 hole -82 hole -93 hole -99 hole -97 hole -63 hole -65 hole -67 hole -72 hole -74 hole -76 hole -78 hole -80 hole -95

m-ctl-point constant 0.1313
"""
thetest="t84"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t86
input="""

m-ctl constant 1.


curve 9 line [0.000000,8.000000] [0.000000,3.000000] 
curve 10 line [0.000000,3.000000] --
[3.000000,0.000000] 
curve 1 line [3.000000,0.000000] [11.000000,0.000000] 
curve 3 line [11.000000,0.000000] [11.000000,8.000000]
curve 4 line [11.000000,8.000000] [7.000000,8.000000] 
curve 5 line [7.000000,8.000000] -- 
[7.000000,6.000000] 
curve 6 line [7.000000,6.000000] --
[5.000000,6.000000] 
curve 7 line [5.000000,6.000000] --
[5.000000,8.000000] 
curve 8 line [5.000000,8.000000] [0.000000,8.000000] 

curve 12 CIRCLE center [8.000000,2.500000], radius 1.500000 
! 3.5606602 1.4393398 6.9393398 9.0606602
!  curve 12 discretized 8 4 --
!  6.9393398 3.5606602 --
!  6.5 2.5 --
!  6.9393398 1.4393398 --
!  8 1 --
!  9.0606602 1.4393398 --
!  9.5 2.5 --
!  9.0606602 3.5606602 --
!  8 4

subregion 1 property 1 boundary 9 10 1 3 4 5 6 7 8  hole -12

"""
thetest="t86"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t87
input="""

m-ctl constant 1

curve 17 LINE [15.000000,2.000000] [-5.000000,2.000000] GID 769297021,
curve 18 LINE [-5.000000,2.000000] [-5.000000,-2.000000] GID 769297023,
curve 15 LINE [-5.000000,-2.000000] [15.000000,-2.000000] GID 769297014,
curve 16 LINE [15.000000,-2.000000] [15.000000,2.000000] GID 769297018,

curve 20 LINE [12.000000,1.000000] [12.000000,-1.000000] GID 769297035,
curve 21 LINE [12.000000,-1.000000] [-1.000000,0.000000] GID 769297042,
curve 22 LINE [-1.000000,0.000000] [12.000000,1.000000] GID 769297045,

subregion 1 property 1 boundary 17 18 15 16 hole 20 21 22

"""
thetest="t87"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t88
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0004 influence 0.001
m-ctl-point 1 xy -100 , -100 near 0.0004 influence 0.001

"""
thetest="t88"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t89
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0004 influence 0.003
m-ctl-point 1 xy -100 , -100 near 0.0004 influence 0.003

"""
thetest="t89"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t9
input="""
!  DEFINICE HRANICNICH KRIVEK - VNEJSI OBRYS
CURVE 1 LINE 0,0 0.6,0 
CURVE 2 LINE 0.6,0 1.2,2.7 
CURVE 3 LINE 1.2,2.7 10.8,2.7 
CURVE 4 LINE 10.8,2.7 11.4,0  
CURVE 5 LINE 11.4,0 12,0 
CURVE 6 LINE 12,0 12,23.8  
CURVE 7 LINE 12,23.8 0,23.8 
CURVE 8 LINE 0,23.8 0,0 
!  DTTO - OTVORY
CURVE  9 LINE 9.6,3.3 8.1,3.3 
CURVE 10 LINE 8.1,3.3 8.1,6. 
CURVE 11 LINE 8.1,6. 9.6,6. 
CURVE 12 LINE 9.6,6. 9.6,3.3 
CURVE 13 LINE 9.6,6.6 8.1,6.6 
CURVE 14 LINE 8.1,6.6 8.1,9.3 
CURVE 15 LINE 8.1,9.3 9.6,9.3 
CURVE 16 LINE 9.6,9.3 9.6,6.6 
CURVE 17 LINE 9.6,9.9 8.1,9.9 
CURVE 18 LINE 8.1,9.9 8.1,12.6 
CURVE 19 LINE 8.1,12.6 9.6,12.6 
CURVE 20 LINE 9.6,12.6 9.6,9.9 
CURVE 21 LINE 9.6,13.2 8.1,13.2 
CURVE 22 LINE 8.1,13.2 8.1,15.9 
CURVE 23 LINE 8.1,15.9 9.6,15.9 
CURVE 24 LINE 9.6,15.9 9.6,13.2 
CURVE 25 LINE 9.6,16.5 8.1,16.5 
CURVE 26 LINE 8.1,16.5 8.1,19.3 
CURVE 27 LINE 8.1,19.3 9.6,19.3 
CURVE 28 LINE 9.6,19.3 9.6,16.5 
CURVE 29 LINE 9.6,19.8 8.1,19.8 
CURVE 30 LINE 8.1,19.8 8.1,22.6 
CURVE 31 LINE 8.1,22.6 9.6,22.6 
CURVE 32 LINE 9.6,22.6 9.6,19.8 
!  HRANICE OBLASTI - VNEJSI OBRYS (BOUNDARY) A OTVORY (HOLE)
SUBREGION 1 PROPERTY 1 BOUNDARY 1 2 3 4 5 6 7 8 hole  9 10 11 12 hole 13 14 15 16 hole 17 18 19 20 hole 21 22 23 24 hole 25 26 27 28 hole 29 30 31 32  
!  POCATECNI VELIKOST PRVKU
M-CTL-POINT constant 0.6
"""
thetest="t9"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t90
input="""
!
! square with a very strong gradation at two corners 
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0007 influence 0.009
m-ctl-point 1 xy -100 , -100 near 0.0007 influence 0.009

"""
thetest="t90"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t91
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 100
m-ctl-point 2 xy  100 , -100 near 0.0004 influence 0.01
m-ctl-point 1 xy -100 , -100 near 0.0004 influence 0.01

"""
thetest="t91"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t94
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 50
m-ctl-point 2 xy  100 , 0 near 0.0007 influence 0.001
m-ctl-point 1 xy -100 , 0 near 0.0007 influence 0.001

"""
thetest="t94"
@test run1(thetest,input)
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
# t96
input="""
!
! square with a very strong gradation at two corners (1:500,000)
!
curve 1 line -100 -100 100 -100
curve 2 line 100 -100 100 100
curve 3 line 100 100 -100 100
curve 4 line -100 100 -100 -100

subregion 1 property 1 boundary 1 2 3 4
m-ctl-point constant 10
m-ctl-point 3 xy  100 , -100 near 0.17 influence 0.2
m-ctl-point 2 xy  100 , 100 near 0.17 influence 0.2
m-ctl-point 4 xy  -100 , 100 near 0.17 influence 0.2
m-ctl-point 5 xy  0 , 0 near 0.017 influence 0.2
m-ctl-point 1 xy -100 , -100 near 0.00027 influence 0.001

"""
thetest="t96"
@test run1(thetest,input)
####################################################
####################################################
####################################################
end # module tests
