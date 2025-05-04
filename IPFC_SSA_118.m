%This program is developed using MATLAB 7.0.7 software for finding the load
%flow solution of a given power system network with ipfc. The parameters of ipfc namely   and  , the buses p and q between which ipfc is installed are given in the code as the input. The output of this code is the Load Flow Solution for a given power system with ipfc. When  =0 and  =0 the code gives us the Load Flow Solution for a given power system without ipfc.
clc
clear
basemva = 100;  
accuracy = 0.00001;  
maxiter = 100;
r=0.01;
gammad=-90;




gamma=(pi/180)*gammad;
p=71;
q=72; 
s=73;
    if p==q
    fprintf('ERROR!!\n\n ipfc cannot be connected to the same bus\n') 
    %if the ipfc is added to the same bus i.e which is an error, then this message is printed
    fprintf('Hence the power flow solution is calculated for without ipfc\n\n\nPress Enter to continue\n')
    pause
    end
  %                   118-BUS TEST SYSTEM 
%        Bus Bus  Voltage Angle   ---Load---- -------Generator-----    Qsh
%        No  code Mag.    Degree  MW    Mvar  MW  Mvar Qmin Qmax   
busdata=[
    1		2		1.0		0		51.00		27.00		0		0		-5.0	15.0	0
2		0		1.0		0		20.00		9.00		0		0		0		0		0
3		0		1.0		0		39.00		10.00		0		0		0		0		0
4		2		1.0		0		39.00		12.00		0		0		-300.0	300.0	0
5		0		1.0		0		0.00		0.00		0		0		0		0		0
6		2		1.0		0		52.00		22.00		0		0		-13		50.0	0
7		0		1.0		0		19.00		2.00		0		0		0		0		0
8		2		1.0		0		28.00		0.00		0		0		-300.0	300.0	0
9		0		1.0		0		0.00		0.00		0		0		0		0		0
10		2		1.		0		0.00		0.00		450.00		0		-147	200		0
11		0		1.0		0		70.00		23.00		0		0		0		0		0
12		2		0.99	0		47.00		10.00		85		0		-35		120		0
13		0		1.0		0		34.00		16.00		0		0		0		0		0
14		0		1.0		0		14.00		1.00		0		0		0		0		0
15		2		1.0		0		90.00		30.00		0		0		-10.0	30.0	0
16		0		1.0		0		25.00		10.00		0		0		0		0		0
17		0		1.0		0		11.00		3.00		0		0		0		0		0
18		2		1.0		0		60.00		34.00		0		0		-16.0	50.0	0
19		2		1.0		0		45.00		25.00		0		0		-8.0	24.0	0
20		0		1.0		0		18.00		3.00		0		0		0		0		0
21		0		1.0		0		14.00		8.00		0		0		0		0		0
22		0		1.0		0		10.00		5.00		0		0		0		0		0
23		0		1.0		0		7.00		3.00		0		0		0		0		0
24		2		1.0		0		13.00		0.00		0		0		-300.0	300.0	0
25		2		1.050	0		0.00		0.00		220		0		-47		140		0
26		2		1.		0		0.00		0.00		314		0		-1000	1000	0
27		2		1.0		0		71.00		13.00		0		0		-300.0	300.0	0
28		0		1.0		0		17.00		7.00		0		0		0		0		0
29		0		1.0		0		24.00		4.00		0		0		0		0		0
30		0		1.0		0		0.00		0.00		0		0		0		0		0
31		2		1.		0		43.00		27.00		7.000		0		-300.0	300.0	0
32		2		1.0		0		59.00		23.00		0		0		-14		40.0	0
33		0		1.0		0		23.00		9.00		0		0		0		0		0
34		0		1.0		0		59.00		26.00		0		0		0		0		0
35		0		1.0		0		33.00		9.00		0		0		0		0		0
36		0		1.0		0		31.00		17.00		0		0		-8.0	24.0	0
37		0		1.0		0		0.00		0.00		0		0		0		0		0
38		0		1.0		0		0.00		0.00		0		0		0		0		0
39		0		1.0		0		27.00		11.00		0		0		0		0		0
40		2		1.0		0		66.00		23.00		0		0		-300	300		0
41		0		1.0		0		37.00		10.00		0		0		0		0		0
42		2		1.0		0		96.00		23.00		0		0		-300	300		0
43		0		1.0		0		18.00		7.00		0		0		0		0		0
44		0		1.0		0		16.00		8.00		0		0		0		0		0
45		0		1.0		0		53.00		22.00		0		0		0		0		0
46		2		1.		0		28.00		10.00		19		0		-100	100		0
47		0		1.0		0		34.00		0.00		0		0		0		0		0
48		0		1.0		0		20.00		11.00		0		0		0		0		0
49		2		1.		0		87.00		30.00		204		0		-85		210		0
50		0		1.0		0		17.00		4.00		0		0		0		0		0
51		0		1.0		0		17.00		8.00		0		0		0		0		0
52		0		1.0		0		18.00		5.00		0		0		0		0		0
53		0		1.0		0		23.00		11.00		0		0		0		0		0
54		2		1.		0		113.00		32.00		48		0		-300.0	300.0	0
55		0		1.0		0		63.00		22.00		0		0		-8		23		0
56		0		1.0		0		84.00		18.00		0		0		-8		23		0
57		0		1.0		0		12.00		3.00		0		0		0		0		0
58		0		1.0		0		12.00		3.00		0		0		0		0		0
59		2		0.985	0		277.00		113.00		155.0	0		-60		180		0
60		0		1.0		0		78.00		3.00		0		0		0		0		0
61		2		0.995	0		0.00		0.00		160		0		-100	300		0
62		2		1.0		0		77.00		14.00		0		0		-20		20		0
63		0		1.0		0		0.00		0.00		0		0		0		0		0
64		0		1.0		0		0.00		0.00		0		0		0		0		0
65		2		1.		0		0.00		0.00		391		0		-67		200		0
66		2		1.050	0		39.00		18.00		392		0		-67		200		0
67		0		1.0		0		28.00		7.00		0		0		0		0		0
68		0		1.0		0		0.00		0.00		0		0		0		0		0
69		1		1.		0		0.000		0.000		0		0		0		0		0
70		2		1.0		0		66.00		20.00		0		0		-10		32.0	0
71		0		1.0		0		0.00		0.00		0		0		0		0		0
72		2		1.0		0		12.00		0.00		0		0		-100.0	100.0	0
73		2		1.0		0		6.00		0.00		0		0		-100.0	100.0	0
74		2		1.0		0		68.00		27.00		0		0		-6.0	9.0		0
75		0		1.0		0		47.00		11.00		0		0		0		0		0
76		2		1.0		0		68.00		36.00		0		0		-8.0	23.0	0
77		2		1.0		0		61.00		28.00		0		0		-20		70.0	0
78		0		1.0		0		71.00		26.00		0		0		0		0		0
79		0		1.0		0		39.00		32.00		0		0		0		0		0
80		2		1.040	0		130.00		26.00		477		0		-165	280		0
81		0		1.0		0		0.00		0.00		0		0		0		0		0
82		0		1.0		0		54.00		27.00		0		0		0		0		0
83		0		1.0		0		20.00		10.00		0		0		0		0		0
84		0		1.0		0		11.00		7.00		0		0		0		0		0
85		2		1.0		0		24.00		15.00		0		0		-8		23		0
86		0		1.0		0		21.00		10.00		0		0		0.0		0.0		0
87		2		1.		0		0.00		0.00		4.0		0	  -100.0	1000.0	0
88		0		1.0		0		48.00		10.00		0		0		0		0		0
89		2		1.		0		0.00		0.00		607		0		-210	300		0
90		2		1.0		0		163.00		48.00		0		0		-300	300		0
91		2		1.0		0		10.00		0.00		0		0		-100	100.0	0
92		2		1.0		0		65.00		10.00		0		0		-3		9		0
93		0		1.0		0		12.00		7.00		0		0		0		0		0
94		0		1.0		0		30.00		16.00		0		0		0		0		0
95		0		1.0		0		42.00		31.00		0		0		0		0		0
96		0		1.0		0		38.00		15.00		0		0		0		0		0
97		0		1.0		0		15.00		9.00		0		0		0		0		0
98		0		1.0		0		34.00		8.00		0		0		0		0		0
99		2		1.0		0		42.00		0.00		0		0		-100	100		0
100		2		1.		0		37.00		18.00		252		0		-50		155		0
101		0		1.0		0		22.00		15.00		0		0		0		0		0
102		0		1.0		0		5.00		3.00		0		0		0		0		0
103		2		1.		0		23.00		16.00		40		0		-15		40		0
104		2		1.0		0		38.00		25.00		0		0		-8		23		0
105		2		1.0		0		31.00		26.00		0		0		-8		23		0
106		0		1.0		0		43.00		16.00		0		0		0		0		0
107		0		1.0		0		50.00		12.00		0		0		0		0		0
108		0		1.0		0		2.00		1.00		0		0		0		0		0
109		0		1.0		0		8.00		3.00		0		0		0		0		0
110		2		1.0		0		39.00		30.00		0		0		-8		23		0
111		2		1.		0		0.00		0.00		36		0		-100.0	1000.0	0
112		2		1.0		0		68.00		13.00		0		0		-100.0	1000.0	0
113		2		1.0		0		6.00		0.00		0		0		-100.0	200.0	0
114		0		1.0		0		8.00		3.00		0		0		0		0		0
115		0		1.0		0		22.00		7.00		0		0		0		0		0
116		2		1.0		0		184.00		0.00		0		0		-1000	1000	0
117		0		1.0		0		20.00		8.00		0		0		0		0		0
118		0		1.0		0		33.00		15.00		0		0		0		0		0
       ];


%% UPDATING THE GENERATION DATA
generator_no=[
    1
4
6
8
10
12
15
18
19
24
25
26
27
31
32
34
36
40
42
46
49
54
55
56
59
61
62
65
66
69
70
72
73
74
76
77
80
85
87
89
90
91
92
99
100
103
104
105
107
110
111
112
113
116
];

gp = [
88.6906   
81.4512   
35.8488   
50.4145  
344.8706   
10.0800   
26.5140
5.0800   
25.3278   
26.4483  
185.2537  
298.5720   
99.8416   
55.4216
27.7374   
25.0800   
55.5082   
27.9728   
29.1874   
85.0201  
114.9275
94.6754   
75.6096   
56.9032  
194.6765  
126.3940   
99.8417  
382.1825
80.0800   
30.0800   
30.6070   
17.8443   
17.6940   
47.6741   
25.0800
25.8016  
215.3228   
60.8666   
10.3320  
539.2366   
50.0716   
31.3736
10.0800   
10.0800  
351.4406  
122.7399   
71.3176   
29.0826   
99.8416
79.8943   
68.9426   
52.9504   
55.1215   
58.7153

];


for i=1:length(generator_no)
        busdata(generator_no(i),7)=gp(i);
end

%% LINE DATA

%                                        Line code
%         Bus bus   R      X     1/2 B   = 1 for lines
%         nl  nr  p.u.   p.u.   p.u.     > 1 or < 1 tr. tap at bus nl
linedata=[
         1	2	0.03030	0.09990	0.02540	1
        1	3	0.01290	0.04240	0.01082	1
        4	5	0.00176	0.00798	0.00210	1
        3	5	0.02410	0.10800	0.02840	1
        5	6	0.01190	0.05400	0.01426	1
        6	7	0.00459	0.02080	0.00550	1
        8	9	0.00244	0.03050	1.16200	1
        8	5	0.00000	0.02670	0.00000	0.98
        9	10	0.00258	0.03220	1.23000	1
        4	11	0.02090	0.06880	0.01748	1
        5	11	0.02030	0.06820	0.01738	1
        11	12	0.00595	0.01960	0.00502	1
        2	12	0.01870	0.06160	0.01572	1
        3	12	0.04840	0.16000	0.04060	1
        7	12	0.00862	0.03400	0.00874	1
        11	13	0.02225	0.07310	0.01876	1
        12	14	0.02150	0.07070	0.01816	1
        13	15	0.07440	0.24440	0.06268	1
        14	15	0.05950	0.19500	0.05020	1
        12	16	0.02120	0.08340	0.02140	1
        15	17	0.01320	0.04370	0.04440	1
        16	17	0.04540	0.18010	0.04660	1
        17	18	0.01230	0.05050	0.01298	1
        18	19	0.01119	0.04930	0.01142	1
        19	20	0.02520	0.11700	0.02980	1
        15	19	0.01200	0.03940	0.01010	1
        20	21	0.01830	0.08490	0.02160	1
        21	22	0.02090	0.09700	0.02460	1
        22	23	0.03420	0.15900	0.04040	1
        23	24	0.01350	0.04920	0.04980	1
        23	25	0.01560	0.08000	0.08640	1
        26	25	0.00000	0.03820	0.00000	0.96
        25	27	0.03180	0.16300	0.17640	1
        27	28	0.01913	0.08550	0.02160	1
        28	29	0.02370	0.09430	0.02380	1
        30	17	0.00000	0.03880	0.00000	0.96
        8	30	0.00431	0.05040	0.51400	1
        26	30	0.00799	0.08600	0.90800	1
        17	31	0.04740	0.15630	0.03990	1
        29	31	0.01080	0.03310	0.00830	1
        23	32	0.03170	0.11530	0.11730	1
        31	32	0.02980	0.09850	0.02510	1
        27	32	0.02290	0.07550	0.01926	1
        15	33	0.03800	0.12440	0.03194	1
        19	34	0.07520	0.24700	0.06320	1
        35	36	0.00224	0.01020	0.00268	1
        35	37	0.01100	0.04970	0.01318	1
        33	37	0.04150	0.14200	0.03660	1
        34	36	0.00871	0.02680	0.00568	1
        34	37	0.00256	0.00940	0.00984	1
        %38	37	0.00000	0.03750	0.00000	0.93
        37	39	0.03210	0.10600	0.02700	1
        37	40	0.05930	0.16800	0.04200	1
        30	38	0.00464	0.05400	0.42200	1
        39	40	0.01840	0.06050	0.01552	1
        40	41	0.01450	0.04870	0.01222	1
        40	42	0.05550	0.18300	0.04660	1
        41	42	0.04100	0.13500	0.03440	1
        43	44	0.06080	0.24540	0.06068	1
        34	43	0.04130	0.16810	0.04226	1
        44	45	0.02240	0.09010	0.02240	1
        45	46	0.04000	0.13560	0.03320	1
        46	47	0.03800	0.12700	0.03160	1
        46	48	0.06010	0.18900	0.04720	1
        47	49	0.01910	0.06250	0.01604	1
        42	49	0.03570	0.16150	0.02150	1
        45	49	0.06840	0.18600	0.04440	1
        48	49	0.01790	0.05050	0.01258	1
        49	50	0.02670	0.07520	0.01874	1
        49	51	0.04860	0.13700	0.03420	1
        51	52	0.02030	0.05880	0.01396	1
        52	53	0.04050	0.16350	0.04058	1
        53	54	0.02630	0.12200	0.03100	1
        49	54	0.03970	0.14500	0.01830	1
        54	55	0.01690	0.07070	0.02020	1
        54	56	0.00275	0.00955	0.00732	1
        55	56	0.00488	0.01510	0.00374	1
        56	57	0.03430	0.09660	0.02420	1
        50	57	0.04740	0.13400	0.03320	1
        56	58	0.03430	0.09660	0.02420	1
        51	58	0.02550	0.07190	0.01788	1
        54	59	0.05030	0.22930	0.05980	1
        56	59	0.04070	0.12240	0.01380	1
        55	59	0.04739	0.21580	0.05646	1
        59	60	0.03170	0.14500	0.03760	1
        59	61	0.03280	0.15000	0.03880	1
        60	61	0.00264	0.01350	0.01456	1
        60	62	0.01230	0.05610	0.01468	1
        61	62	0.00824	0.03760	0.00980	1
        63	59	0.00000	0.03860	0.00000	0.96
        63	64	0.00172	0.02000	0.21600	1
        64	61	0.00000	0.02680	0.00000	0.98
        38	65	0.00901	0.09860	1.04600	1
        64	65	0.00269	0.03020	0.38000	1
        49	66	0.00900	0.04590	0.00620	1
        62	66	0.04820	0.21800	0.05780	1
        62	67	0.02580	0.11700	0.03100	1
        65	66	0.00000	0.03700	0.00000	0.93
        66	67	0.02240	0.10150	0.02682	1
        65	68	0.00138	0.01600	0.63800	1
        47	69	0.08440	0.27780	0.07092	1
        49	69	0.09850	0.32400	0.08280	1
        68	69	0.00000	0.03700	0.00000	0.935
        69	70	0.03000	0.12700	0.12200	1
        24	70	0.00221	0.41150	0.10198	1
        70	71	0.00882	0.03550	0.00878	1
        24	72	0.04880	0.19600	0.04880	1
        71	72	0.04460	0.18000	0.04444	1
        71	73	0.00866	0.04540	0.01178	1
        70	74	0.04010	0.13230	0.03368	1
        70	75	0.04280	0.14100	0.03600	1
        69	75	0.04050	0.12200	0.12400	1
        74	75	0.01230	0.04060	0.01034	1
        76	77	0.04440	0.14800	0.03680	1
        69	77	0.03090	0.10100	0.10380	1
        75	77	0.06010	0.19990	0.04978	1
        77	78	0.00376	0.01240	0.01264	1
        78	79	0.00546	0.02440	0.00648	1
        77	80	0.01080	0.03320	0.00280	1
        79	80	0.01560	0.07040	0.01870	1
        68	81	0.00175	0.02020	0.80800	1
        81	80	0.00000	0.03700	0.00000	0.935
        77	82	0.02980	0.08530	0.08174	1
        82	83	0.01120	0.03665	0.03796	1
        83	84	0.06250	0.13200	0.02580	1
        83	85	0.04300	0.14800	0.03480	1
        84	85	0.03020	0.06410	0.01234	1
        85	86	0.03500	0.12300	0.02760	1
        86	87	0.02828	0.20740	0.04450	1
        85	88	0.02000	0.10200	0.02760	1
        85	89	0.02390	0.17300	0.04700	1
        88	89	0.01390	0.07120	0.01934	1
        89	90	0.01630	0.06510	0.01760	1
        90	91	0.02540	0.08360	0.02140	1
        89	92	0.00790	0.03830	0.01180	1
        91	92	0.03870	0.12720	0.03268	1
        92	93	0.02580	0.08480	0.02180	1
        92	94	0.04810	0.15800	0.04060	1
        93	94	0.02230	0.07320	0.01876	1
        94	95	0.01320	0.04340	0.01110	1
        80	96	0.03560	0.18200	0.04940	1
        82	96	0.01620	0.05300	0.05440	1
        94	96	0.02690	0.08690	0.02300	1
        80	97	0.01830	0.09340	0.02540	1
        80	98	0.02380	0.10800	0.02860	1
        80	99	0.04540	0.20600	0.05460	1
        92	100	0.06480	0.29500	0.04720	1
        94	100	0.01780	0.05800	0.06040	1
        95	96	0.01710	0.05470	0.01474	1
        96	97	0.01730	0.08850	0.02400	1
        98	100	0.03970	0.17900	0.04760	1
        99	100	0.01800	0.08130	0.02160	1
        100	101	0.02770	0.12620	0.03280	1
        92	102	0.01230	0.05590	0.01464	1
        101	102	0.02460	0.11200	0.02940	1
        100	103	0.01600	0.05250	0.05360	1
        100	104	0.04510	0.20400	0.05410	1
        103	104	0.04660	0.15840	0.04070	1
        103	105	0.05350	0.16250	0.04080	1
        100	106	0.06050	0.22900	0.06200	1
        104	105	0.00994	0.03780	0.00986	1
        105	106	0.01400	0.05470	0.01434	1
        105	107	0.05300	0.18300	0.04720	1
        105	108	0.02610	0.07030	0.01844	1
        106	107	0.05300	0.18300	0.04720	1
        108	109	0.01050	0.02880	0.00760	1
        103	110	0.03906	0.18130	0.04610	1
        109	110	0.02780	0.07620	0.02020	1
        110	111	0.02200	0.07550	0.02000	1
        110	112	0.02470	0.06400	0.06200	1
        17	113	0.00913	0.03010	0.00768	1
        32	113	0.06150	0.20300	0.05180	1
        32	114	0.01350	0.06120	0.01628	1
        27	115	0.01640	0.07410	0.01972	1
        114	115	0.00230	0.01040	0.00276	1
        68	116	0.00034	0.00405	0.16400	1
        12	117	0.03290	0.14000	0.03580	1
        75	118	0.01450	0.04810	0.01198	1
        76	118	0.01640	0.05440	0.01356	1   
           
]; 
G(1)=0.40; G(2)=0.20; G(3)=0.40;
       %  This program obtains the Bus Admittance Matrix for power flow solution
j=sqrt(-1);
i = sqrt(-1);
nl = linedata(:,1);
nr = linedata(:,2);
R = linedata(:,3);
X = linedata(:,4);
Bc = j*linedata(:,5);
a = linedata(:, 6);
nbr=length(linedata(:,1));
nbus = max(max(nl), max(nr));
Z = R + j*X ;
y= ones(nbr,1)./Z;        %branch admittance;
% Here RR & XX takes the right value accordingly when ipfc is inserted
% between p and q bus, RR and XX corresponds to the transmission line
%resistance and reactance between p and q bus., i.e.,where the ipfc is
%embedded in the power system
%Here starts the logic
RR = 0;XX = 0;
for k=1:nbr    
    if nl(k)==p && nr(k)==q
        RR=linedata(k,3);
        XX=linedata(k,4);
    elseif nr(k)==p && nl(k)==q
        RR=linedata(k,3);
        XX=linedata(k,4);
    else 
    end
end

%Here Ends the logic
for n = 1:nbr
if a(n) <= 0 
    a(n) = 1;
else 
end
ZZ=(RR^2+XX^2);
Zi=1/(ZZ);
W=XX*cos(gamma)-RR*sin(gamma);
% initialize Ybus to zero
Ybus=zeros(nbus,nbus);     
% formation of the off diagonal elements
for k=1:nbr
       Ybus(nl(k),nr(k))=Ybus(nl(k),nr(k))-y(k)/a(k);
       Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
end
end
% formation of the diagonal elements
for  n=1:nbus
     for k=1:nbr
         if nl(k)==n
                 Ybus(n,n) = Ybus(n,n)+y(k)/(a(k)^2) + Bc(k);
         elseif nr(k)==n
                 Ybus(n,n) = Ybus(n,n)+y(k) +Bc(k);
         else, end
     end
end
clear Pgg
% Power flow solution by Newton-Raphson method
ns=0;
ng=0;
Vm=0;
delta=0;
yload=0;
deltad=0;
nbus = length(busdata(:,1));
%=========================================================================
for k=1:nbus
    kb(k)=busdata(k,2);
end
ii=0;
jj=0;
ij=0;
ii1=0;
jj1=0;
ij1=0;
t=1;
for z=1:nbus
    Pq(z)=0;
end
for k=1:nbus
    pq(k)=0;
end
for k=1:nbus
 if kb(k)==0
    PQ=k;
    Pq(k)=PQ;   
 end    
end 
for z=1:nbus
    if Pq(z)~=0       
        pq(t)=Pq(z);
        t=t+1;
    else
    end
end

RR1 = 0; XX1 = 0;
for k=1:nbr    
    if nl(k)==p && nr(k)==s
        RR1=linedata(k,3);
        XX1=linedata(k,4);
    elseif nr(k)==p && nl(k)==s
        RR1=linedata(k,3);
        XX1=linedata(k,4);
    else 
    end
end
ZZ1=(RR1^2+XX1^2);
Zi1=1/(ZZ1);
W1=XX1*cos(gamma)-RR1*sin(gamma);
%--------------------------------------------------------------------------
%-------Modifying jacobian matrix
%i.e for taking ll,lk,lm,nn
if (kb(q)==0)
for k=1:nbus
    ii=ii+1;
    if pq(k)==q
        jj=ii;
    end
end
end 
ii=0;
if (kb(p)==0)
for k=1:nbus
    ii=ii+1;
    if pq(k)==p
        ij=ii;
    end
end
end 
ij;
jj;
if (kb(s)==0)
for k=1:nbus
    ii1=ii1+1;
    if pq(k)==q
        jj1=ii1;
    end
end
end 
ii1=0;
if (kb(p)==0)
for k=1:nbus
    ii1=ii1+1;
    if pq(k)==p
        ij1=ii1;
    end
end
end 
ij1;
jj1;
%--------------------------------------------------------------------------
for k=1:nbus
   n=busdata(k,1);
   kb(n)=busdata(k,2);
   Vm(n)=busdata(k,3);
   delta(n)=busdata(k, 4);
   Pd(n)=(1.16)*busdata(k,5);  %  increase the load 
   Qd(n)=(1.16)*busdata(k,6);
   Pg(n)=busdata(k,7);
   Qg(n) = busdata(k,8);
   Qmin(n)=busdata(k, 9);
   Qmax(n)=busdata(k, 10);
   Qsh(n)=busdata(k, 11);
if Vm(n) <= 0  
        Vm(n) = 1.0;
        V(n) = 1 + j*0;
  else
        delta(n) = pi/180*delta(n);
         V(n) = Vm(n)*(cos(delta(n)) + j*sin(delta(n)));        
         P(n)=(Pg(n)-Pd(n))/basemva;
         Q(n)=(Qg(n)-Qd(n)+ Qsh(n))/basemva;
         S(n) = P(n) + j*Q(n);
   end
end 
for k=1:nbus
 if kb(k) == 1
    ns = ns+1;
 else end
 if kb(k) == 2 
    ng = ng+1;
 else, end
 ngs(k) = ng;
 nss(k) = ns;
end
 Ym=abs(Ybus);
 t = angle(Ybus);
 m=2*nbus-ng-2*ns;
 maxerror = 1; 
 converge=1;
 iter = 0;
% Start of iterations
 clear A  DC   J  DX
 while maxerror >= accuracy & iter <= maxiter % Test for max. power mismatch
for i=1:m
 for k=1:m
   A(i,k)=0;      %Initializing Jacobian matrix;
 end
end 
 
iter = iter+1;
 for n=1:nbus
 nn=n-nss(n);
 lm=nbus+n-ngs(n)-nss(n)-ns;
 J11=0;
 J22=0;
 J33=0;
 J44=0;
  hii=0;
  hij=0;
  hji=0;
  hjj=0;
  nii=((G(1)*(-8*RR*r*Vm(p)^4*cos(gamma)*Zi1)+(4*Vm(p)^4*XX*sin(gamma)*Zi)-(4*RR*r^2*Vm(p)^4*Zi))+G(2)*((-6*RR*r*Vm(p)^3*cos(gamma)*Zi1)+(3*Vm(p)^3*XX*sin(gamma)*Zi)-(3*RR*r^2*Vm(p)^3*Zi))+G(3)*((-4*RR*r*Vm(p)^2*cos(gamma)*Zi1)+(2*Vm(p)^2*XX*sin(gamma)*Zi)-(2*RR*r^2*Vm(p)^2*Zi)));
  nij=0;
  nji=((G(1)*(3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(RR*cos(delta(p)+gamma-delta(q))+XX*sin(delta(p)+gamma-delta(q))));
  njj=((G(1)*(r*Vm(p)^3*Vm(q)*Zi)+G(2)*(r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(RR*cos(delta(p)+gamma-delta(q))+XX*sin(delta(p)+gamma-delta(q))));
  jii=0;
  jij=0;
  jji=0;
  jjj=0;
  lii=((G(1)*(-3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(-2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(-r*Vm(p)*Vm(q)*Zi))*(XX*cos(gamma)-RR*sin(gamma)));
  lij=((G(1)*(-r*Vm(p)^3*Vm(q)*Zi)+G(2)*(-r*Vm(p)^2*Vm(q)*Zi)+G(3)*(-r*Vm(p)*Vm(q)*Zi))*(XX*cos(gamma)-RR*sin(gamma)));
  lji=((G(1)*(3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(XX*cos(delta(p)+gamma-delta(q))-RR*sin(delta(p)+gamma-delta(q))));
  ljj=((G(1)*(r*Vm(p)^3*Vm(q)*Zi)+G(2)*(r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(XX*cos(delta(p)+gamma-delta(q))-RR*sin(delta(p)+gamma-delta(q))));
  J1111=0;
  J2222=0;
  J3333=0;
  J4444=0;
  hii1=0;
  hij1=0;
  hji1=0;
  hjj1=0;
  nii1=((G(1)*(-8*RR*r*Vm(p)^4*cos(gamma)*Zi1)+(4*Vm(p)^4*XX*sin(gamma)*Zi)-(4*RR*r^2*Vm(p)^4*Zi))+G(2)*((-6*RR*r*Vm(p)^3*cos(gamma)*Zi1)+(3*Vm(p)^3*XX*sin(gamma)*Zi)-(3*RR*r^2*Vm(p)^3*Zi))+G(3)*((-4*RR*r*Vm(p)^2*cos(gamma)*Zi1)+(2*Vm(p)^2*XX*sin(gamma)*Zi)-(2*RR*r^2*Vm(p)^2*Zi)));
  nij1=0;
  nji1=((G(1)*(3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(RR*cos(delta(p)+gamma-delta(q))+XX*sin(delta(p)+gamma-delta(q))));
  njj1=((G(1)*(r*Vm(p)^3*Vm(q)*Zi)+G(2)*(r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(RR*cos(delta(p)+gamma-delta(q))+XX*sin(delta(p)+gamma-delta(q))));
  jii1=0;
  jij1=0;
  jji1=0;
  jjj1=0;
  lii1=((G(1)*(-3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(-2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(-r*Vm(p)*Vm(q)*Zi))*(XX*cos(gamma)-RR*sin(gamma)));
  lij1=((G(1)*(-r*Vm(p)^3*Vm(q)*Zi)+G(2)*(-r*Vm(p)^2*Vm(q)*Zi)+G(3)*(-r*Vm(p)*Vm(q)*Zi))*(XX*cos(gamma)-RR*sin(gamma)));
  lji1=((G(1)*(3*r*Vm(p)^3*Vm(q)*Zi)+G(2)*(2*r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(XX*cos(delta(p)+gamma-delta(q))-RR*sin(delta(p)+gamma-delta(q))));
  ljj1=((G(1)*(r*Vm(p)^3*Vm(q)*Zi)+G(2)*(r*Vm(p)^2*Vm(q)*Zi)+G(3)*(r*Vm(p)*Vm(q)*Zi))*(XX*cos(delta(p)+gamma-delta(q))-RR*sin(delta(p)+gamma-delta(q))));
 for i=1:nbr
     if nl(i) == n | nr(i) == n
        if nl(i) == n,  l = nr(i); end        
        if nr(i) == n,  l = nl(i); end  
             J11=J11+ Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
             J33=J33+ Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
        if kb(n)~=1
            J22=J22+ Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
            J44=J44+ Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
        else, end        
        if kb(n) ~= 1  & kb(l) ~=1
           lk = nbus+l-ngs(l)-nss(l)-ns;
           ll = l -nss(l);
              % off diagonalelements of J1
           A(nn, ll) =-Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
              if kb(l) == 0  % off diagonal elements of J2
                  A(nn, lk) =Vm(n)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
              end              
              if kb(n) == 0  % off diagonal elements of J3
                  A(lm, ll) =-Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n)+delta(l));
              end              
              if kb(n) == 0 & kb(l) == 0  % off diagonal elements of  J4
                 A(lm, lk) =-Vm(n)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
              end                
      %modifying Jacobian elements starts here
   if kb(p)==2 & kb(q)==2 %if ipfc is connected between PV-PV bus
       %if ipfc is connected between pv-pv bus,only H-matrix gets affected
       % modifying the off-diagonal elements of H-matrix starts here
       if nn==(p-1) & ll==(q-1)
           A(nn,ll)=A(nn,ll)+hij;
           A(ll,nn)=A(ll,nn)+hji;
       end
       %modifying the off-diagonal elements of H-matrix ends here
   elseif (kb(p)==2 & kb(q)==0) | (kb(p)==0 & kb(q)==2)  % if ipfc is connected between PV-PQ bus or PQ-PV bus
       %if ipfc is connected between pv-pq bus, some of the elements in
       %H,N,J,L matrices does not get affected      
       %modifying the off-diagonal elements of H-matrix starts here      
       if nn==(p-1) & ll==(q-1)
           A(nn,ll)=A(nn,ll)+hij;
           A(ll,nn)=A(ll,nn)+hji;
       end
       %modifying the off-diagonal elements of H-matrix ends here
       %modifying the off-diagonal elements of N-matrix starts here
       if nn==(p-1) & lk==(nbus-1+jj)
           A(nn,lk)=A(nn,lk)+nij;
       end
       %modifying the off-diagonal elements of N-matrix ends here
       %modifying the off-diagonal elements of J-matrix starts here
       if lm==(nbus-1+jj) & ll==(p-1)
           A(lm,ll)=A(lm,ll)+jji;
       end
       %modifying the off-diagonal elements of J-matrix ends here
       %ends modifying the off-diagonal elements when ipfc is connected
       %between pv-pq bus & pq-pv bus as well
   elseif kb(p)==2 & kb(q)==2 %if ipfc is connected between PQ-PQ bus
       %modifying the off-diagonal elements of H-matrix starts here
        if nn==(p-1) & ll==(q-1)
           A(nn,ll)=A(nn,ll)+hij;
           A(ll,nn)=A(ll,nn)+hji;
        end
       %modifying the off-diagonal elements of H-matrix ends here
       %modifying the off-diagonal elements of N-matrix starts here
       if nn==(p-1) & lk==(nbus-1+jj)
           A(nn,lk)=A(nn,lk)+nij;
       end
       if nn==(q-1) & lk==(nbus-1+ij)
           A(nn,lk)=A(nn,lk)+nji;
       end
       %modifying the off-diagonal elements of N-matrix ends here
       %modifying the off-diagonal elements of J-matrix starts here
       if lm==(nbus-1+ij) &  ll==(q-1)
           A(lm,ll)=A(lm,ll)+jij;
       end
       if lm==(nbus-1+jj) & ll==(p-1)
           A(lm,ll)=A(lm,ll)+jji;
       end
       %modifying the off-diagonal elements of L-matrix starts here
       if lm==(nbus-1+ij) & lk==(nbus-1+jj)
           A(lm,lk)=A(lm,lk)+lij;
       end
       if lm==(nbus-1+jj) & lk==(nbus-1+ij)
           A(lm,lk)=A(lm,lk)+lji;
       end
       %modifying the off-diagonal elements of L-matrix ends here       
       else end        
         else end 
      else , end    
  end
   for i=1:nbr
     if nl(i) == n | nr(i) == n
        if nl(i) == n,  l = nr(i); end        
        if nr(i) == n,  l = nl(i); end  
             J1111=J1111+ Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
             J3333=J3333+ Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
        if kb(n)~=1
            J2222=J2222+ Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
            J4444=J4444+ Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
        else, end        
        if kb(n) ~= 1  & kb(l) ~=1
           lk = nbus+l-ngs(l)-nss(l)-ns;
           ll = l -nss(l);
              % off diagonalelements of J1
           A(nn, ll) =-Vm(n)*Vm(l)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
              if kb(l) == 0  % off diagonal elements of J2
                  A(nn, lk) =Vm(n)*Ym(n,l)*cos(t(n,l)- delta(n) + delta(l));
              end              
              if kb(n) == 0  % off diagonal elements of J3
                  A(lm, ll) =-Vm(n)*Vm(l)*Ym(n,l)*cos(t(n,l)- delta(n)+delta(l));
              end              
              if kb(n) == 0 & kb(l) == 0  % off diagonal elements of  J4
                 A(lm, lk) =-Vm(n)*Ym(n,l)*sin(t(n,l)- delta(n) + delta(l));
              end                
      %modifying Jacobian elements starts here
   if kb(p)==2 & kb(s)==2 %if ipfc is connected between PV-PV bus
       %if ipfc is connected between pv-pv bus,only H-matrix gets affected
       % modifying the off-diagonal elements of H-matrix starts here
       if nn==(p-1) & ll==(s-1)
           A(nn,ll)=A(nn,ll)+hij1;
           A(ll,nn)=A(ll,nn)+hji1;
       end
       %modifying the off-diagonal elements of H-matrix ends here
   elseif (kb(p)==2 & kb(s)==0) | (kb(p)==0 & kb(s)==2)  % if ipfc is connected between PV-PQ bus or PQ-PV bus
       %if ipfc is connected between pv-pq bus, some of the elements in
       %H,N,J,L matrices does not get affected      
       %modifying the off-diagonal elements of H-matrix starts here      
       if nn==(p-1) && ll==(s-1)
           A(nn,ll)=A(nn,ll)+hij1;
           A(ll,nn)=A(ll,nn)+hji1;
       end
       %modifying the off-diagonal elements of H-matrix ends here
       %modifying the off-diagonal elements of N-matrix starts here
       if nn==(p-1) & lk==(nbus-1+jj1)
           A(nn,lk)=A(nn,lk)+nij1;
       end
       %modifying the off-diagonal elements of N-matrix ends here
       %modifying the off-diagonal elements of J-matrix starts here
       if lm==(nbus-1+jj1) & ll==(p-1)
           A(lm,ll)=A(lm,ll)+jji1;
       end
       %modifying the off-diagonal elements of J-matrix ends here
       %ends modifying the off-diagonal elements when ipfc is connected
       %between pv-pq bus & pq-pv bus as well
   elseif kb(p)==2 & kb(s)==2 %if ipfc is connected between PQ-PQ bus
       %modifying the off-diagonal elements of H-matrix starts here
        if nn==(p-1) & ll==(s-1)
           A(nn,ll)=A(nn,ll)+hij1;
           A(ll,nn)=A(ll,nn)+hji1;
        end
       %modifying the off-diagonal elements of H-matrix ends here
       %modifying the off-diagonal elements of N-matrix starts here
       if nn==(p-1) & lk==(nbus-1+jj1)
           A(nn,lk)=A(nn,lk)+nij1;
       end
       if nn==(s-1) && lk==(nbus-1+ij1)
           A(nn,lk)=A(nn,lk)+nji1;
       end
       %modifying the off-diagonal elements of N-matrix ends here
       %modifying the off-diagonal elements of J-matrix starts here
       if lm==(nbus-1+ij1) &&  ll==(s-1)
           A(lm,ll)=A(lm,ll)+jij1;
       end
       if lm==(nbus-1+jj1) && ll==(p-1)
           A(lm,ll)=A(lm,ll)+jji1;
       end
       %modifying the off-diagonal elements of L-matrix starts here
       if lm==(nbus-1+ij1) & lk==(nbus-1+jj1)
           A(lm,lk)=A(lm,lk)+lij1;
       end
       if lm==(nbus-1+jj1) & lk==(nbus-1+ij1)
           A(lm,lk)=A(lm,lk)+lji1;
       end
       %modifying the off-diagonal elements of L-matrix ends here       
       else end        
         else end 
      else , end    
   end
  
   Qaipfc=(r*Vm(p)*Vm(s)*Zi1)*(XX1*cos(delta(p)+gamma-delta(s))-RR1*sin(delta(p)+gamma-delta(s)));
   Pbipfc=(r*Vm(p)*Vm(s)*Zi1)*(RR1*cos(delta(p)+gamma-delta(s))-XX1*sin(delta(p)+gamma-delta(s))); 
   Qbipfc=(r*Vm(p)*Vm(s)*Zi1)*(XX1*sin(delta(p)+gamma-delta(s))+RR1*cos(delta(p)+gamma-delta(s)));
   Paipfc= (r*Vm(p)*Vm(s)*Zi1)*(XX1*cos(delta(p)+gamma-delta(s))-RR1*sin(delta(p)+gamma-delta(s)));
   Qaipfc1=(r*Vm(p)*Vm(s)*Zi1)*(XX1*cos(delta(p)+gamma-delta(s))-RR1*sin(delta(p)+gamma-delta(s)));
   Pbipfc1=(r*Vm(p)*Vm(s)*Zi1)*(RR1*cos(delta(p)+gamma-delta(s))-XX1*sin(delta(p)+gamma-delta(s))); 
   Qbipfc1=(r*Vm(p)*Vm(s)*Zi1)*(XX1*sin(delta(p)+gamma-delta(s))+RR1*cos(delta(p)+gamma-delta(s)));
   Paipfc1= (r*Vm(p)*Vm(s)*Zi1)*(XX1*cos(delta(p)+gamma-delta(s))-RR1*sin(delta(p)+gamma-delta(s)));
   
% Qaipfc=(-r*Vm(p)^2)*Zi*W;
%    Pbipfc=(r*Vm(p)*Vm(q)*Zi)*(RR*cos(delta(p)+gamma-delta(q))+XX*sin(delta(p)+gamma-delta(q))); 
%    Qbipfc=(r*Vm(p)*Vm(q)*Zi)*(XX*cos(delta(p)+gamma-delta(q))-RR*sin(delta(p)+gamma-delta(q)));
%    Paipfc= (r*Vm(p)*Vm(q)*Zi)*(XX*sin(delta(p)+gamma-delta(q))-RR*cos(delta(p)+gamma-delta(q)))+(RR*r^2*Vm(p)^2*Zi)+(r*Vm(p)^2*XX*sin(gamma)*Zi)+(-RR*r*Vm(p)^2*cos(gamma)*Zi);
%    Qaipfc1=(-r*Vm(p)^2)*Zi1*W1;
%    Pbipfc1=(r*Vm(p)*Vm(s)*Zi1)*(RR1*cos(delta(p)+gamma-delta(s))+XX1*sin(delta(p)+gamma-delta(s))); 
%    Qbipfc1=(r*Vm(p)*Vm(s)*Zi1)*(XX1*cos(delta(p)+gamma-delta(s))-RR1*sin(delta(p)+gamma-delta(s)));
%    Paipfc1= (r*Vm(p)*Vm(s)*Zi1)*(XX1*sin(delta(p)+gamma-delta(s))-RR1*cos(delta(p)+gamma-delta(s)))+(RR1*r^2*Vm(p)^2*Zi1)+(r*Vm(p)^2*XX1*sin(gamma)*Zi1)+(-RR1*r*Vm(p)^2*cos(gamma)*Zi1);
    
   Pk = Vm(n)^2*Ym(n,n)*cos(t(n,n))+J33;
   Qk = -Vm(n)^2*Ym(n,n)*sin(t(n,n))-J11;
   Pk1 = Vm(n)^2*Ym(n,n)*cos(t(n,n))+J3333;
   Qk1 = -Vm(n)^2*Ym(n,n)*sin(t(n,n))-J1111;
   
   if kb(n) == 1 
       P(n)=Pk;
       Q(n) = Qk;
   end   % Swing bus P   
     if kb(n) == 2 
         Q(n)=Qk;
         if Qmax(n) ~= 0
           Qgc = Q(n)*basemva + Qd(n) - Qsh(n);
           if iter <= 7                  % Between the 2th & 6th iterations
              if iter > 2                % the Mvar of generator buses are
                if Qgc  < Qmin(n),       % tested. If not within limits Vm(n)
                Vm(n) = Vm(n) + 0.01;    % is changed in steps of 0.01 pu to
                elseif Qgc  > Qmax(n),   % bring the generator Mvar within
                Vm(n) = Vm(n) - 0.01;end % the specified limits.
              else, end
           else,end
         else,end
     end
   if kb(n) ~= 1
       A(nn,nn) = J11;  %diagonal elements of J1
       DC(nn)=P(n)-Pk;
       %modifying the daigonal elements of H-matrix starts here
       %This modification of H-matrix doesnot depend whether ipfc is
       %connected between what type of bus.       
       if nn==(p-1)
           A(nn,nn)=A(nn,nn)+hii;
       end
       if nn==(q-1)
           A(nn,nn)=A(nn,nn)+hjj;
       end
       %modifying the daigonal elements of H-matrix starts here
       %This modification of H-matrix doesnot depend whether ipfc is
       %connected between what type of bus.       
       if nn==(p-1)
           A(nn,nn)=A(nn,nn)+hii1;
       end
       if nn==(s-1)
           A(nn,nn)=A(nn,nn)+hjj1;
       end
       %modification of diagonal elements of H-matrix ends here       
   end   
   if kb(n)~=1
       if n==p
           DC(nn)=DC(nn)+Paipfc;
       elseif n==q
           DC(nn)=DC(nn)+Pbipfc;
       end
   end
   if kb(n)~=1
       if n==p
           DC(nn)=DC(nn)+Paipfc1;
       elseif n==s
           DC(nn)=DC(nn)+Pbipfc1;
       end
   end   
 if kb(n) == 0
     A(nn,lm) = 2*Vm(n)*Ym(n,n)*cos(t(n,n))+J22;  %diagonal elements of J2
     A(lm,nn)= J33;                               %diagonal elements of J3
     A(lm,lm) =-2*Vm(n)*Ym(n,n)*sin(t(n,n))-J44;  %diagonal of elements of J4     
     if (kb(p)==2 & kb(q)==0) | (kb(p)==0 & kb(q)==2)%if ipfc is connected between PV-PQ bus
         %modifying the diagonal elements of N-matrix starts here
         if nn==(q-1) & lm==(nbus-1+jj)
             A(nn,lm)=A(nn,lm)+njj;
         end
         %modifying the diagonal elements of N-matrix ends here
         %modifying the diagonal elements of J-matrix starts here
         if lm==(nbus-1+jj) & nn==(q-1)
             A(lm,nn)=A(lm,nn)+jjj;
         end
         %modifying the diagonal elements of J-matrix ends here
         %modifying the diagonal elements of L-matrix starts here
         if lm==(nbus-1+jj)
             A(lm,lm)=A(lm,lm)+ljj;
         end
         %modifying the diagonal elements of L-matrix ends here
     elseif kb(p)==0 & kb(q)==0 %if ipfc is connected between PQ-PQ bus
         %modifying the diagonal elements of N-matrix starts here
         if nn==(p-1) & lm==(nbus-1+ij)
             A(nn,lm)=A(nn,lm)+nii;
         end
         if nn==(q-1) & lm==(nbus-1+jj)
             A(nn,lm)=A(nn,lm)+njj;
         end
         %modifying the diagonal elements of N-matrix ends here
         %modifying the diagonal elements of J-matrix starts here
         if lm==(nbus-1+ij) & nn==(p-1)
             A(lm,nn)=A(lm,nn)+jii;
         end
         if lm==(nbus-1+jj) & nn==(q-1)
             A(lm,nn)=A(lm,nn)+jjj;
         end
         %modifying the diagonal elements of J-matrix ends here
         %modifying the diagonal elements of L-matrix starts here
         if lm==(nbus-1+ij)
             A(lm,lm)=A(lm,lm)+lii;
         end
         if lm==(nbus-1+jj)
             A(lm,lm)=A(lm,lm)+ljj;
         end
         %modifying the diagonal elements of L-matrix ends here
     else end         
     if (kb(p)==2 & kb(s)==0) | (kb(p)==0 & kb(s)==2)%if ipfc is connected between PV-PQ bus
         %modifying the diagonal elements of N-matrix starts here
         if nn==(s-1) & lm==(nbus-1+jj1)
             A(nn,lm)=A(nn,lm)+njj1;
         end
         %modifying the diagonal elements of N-matrix ends here
         %modifying the diagonal elements of J-matrix starts here
         if lm==(nbus-1+jj1) & nn==(s-1)
             A(lm,nn)=A(lm,nn)+jjj1;
         end
         %modifying the diagonal elements of J-matrix ends here
         %modifying the diagonal elements of L-matrix starts here
         if lm==(nbus-1+jj1)
             A(lm,lm)=A(lm,lm)+ljj1;
         end
         %modifying the diagonal elements of L-matrix ends here
     elseif kb(p)==0 & kb(s)==0 %if ipfc is connected between PQ-PQ bus
         %modifying the diagonal elements of N-matrix starts here
         if nn==(p-1) & lm==(nbus-1+ij1)
             A(nn,lm)=A(nn,lm)+nii1;
         end
         if nn==(s-1) & lm==(nbus-1+jj1)
             A(nn,lm)=A(nn,lm)+njj1;
         end
         %modifying the diagonal elements of N-matrix ends here
         %modifying the diagonal elements of J-matrix starts here
         if lm==(nbus-1+ij1) & nn==(p-1)
             A(lm,nn)=A(lm,nn)+jii1;
         end
         if lm==(nbus-1+jj1) & nn==(s-1)
             A(lm,nn)=A(lm,nn)+jjj1;
         end
         %modifying the diagonal elements of J-matrix ends here
         %modifying the diagonal elements of L-matrix starts here
         if lm==(nbus-1+ij1)
             A(lm,lm)=A(lm,lm)+lii1;
         end
         if lm==(nbus-1+jj1)
             A(lm,lm)=A(lm,lm)+ljj1;
         end
         %modifying the diagonal elements of L-matrix ends here
     else end    
     if n==p
             DC(lm)=Q(n)+Qaipfc1-Qk1;
         elseif n==s
             DC(lm)=Q(n)+Qbipfc1-Qk1;
         else
             DC(lm)=Q(n)-Qk1;
         end
    end
 end
 DX=A\DC';
for n=1:nbus
  nn=n-nss(n);
  lm=nbus+n-ngs(n)-nss(n)-ns;
    if kb(n) ~= 1
    delta(n) = delta(n)+DX(nn); end
    if kb(n) == 0
    Vm(n)=Vm(n)+DX(lm); end
end
maxerror=max(abs(DC));
     if iter == maxiter & maxerror > accuracy 
   fprintf('\nWARNING: Iterative solution did not converged after ')
   fprintf('%g', iter), fprintf(' iterations.\n\n')
   fprintf('Press Enter to terminate the iterations and print the results \n')
   converge = 0; pause, else, end   
 end 
if converge ~= 1
   tech= ('                      ITERATIVE SOLUTION DID NOT CONVERGE'); else, 
   tech=('                   Power Flow Solution by Newton-Raphson Method');
end   
V = Vm.*cos(delta)+j*Vm.*sin(delta);
deltad=180/pi*delta;
i=sqrt(-1);
k=0;
for n = 1:nbus
     if kb(n) == 1
     k=k+1;
     S(n)= P(n)+j*Q(n);
     Pg(n) = P(n)*basemva + Pd(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     Pgg(k)=Pg(n);
     Qgg(k)=Qg(n);
     elseif  kb(n) ==2
     k=k+1;
     S(n)=P(n)+j*Q(n);
     Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
     Pgg(k)=Pg(n);
     Qgg(k)=Qg(n);
  end
yload(n) = (Pd(n)- j*Qd(n)+j*Qsh(n))/(basemva*Vm(n)^2);
end
busdata(:,3)=Vm'; busdata(:,4)=deltad';
Pgt = sum(Pg);  Qgt = sum(Qg); Pdt = sum(Pd); Qdt = sum(Qd); Qsht = sum(Qsh); 
    
%This program is used in conjunction with lfgauss or lf Newton
%for the computation of line flow and line losses.
SLT = 0;
count=1
fprintf('\n')
fprintf('                           Line Flow and Losses \n\n')
fprintf('     --Line--  Power at bus & line flow    --Line loss--  Transformer\n')
fprintf('     from  to    MW      Mvar     MVA       MW      Mvar      tap\n') 
for n = 1:nbus
busprt = 0;

   for L = 1:nbr
       
       if busprt == 0
       fprintf('   \n'), fprintf('%6g', n), fprintf('      %9.3f', P(n)*basemva)
       fprintf('%9.3f', Q(n)*basemva), fprintf('%9.3f\n', abs(S(n)*basemva)) 
       busprt = 1;
       else, end
       if nl(L)==n   
       k = nr(L);
       nl(L);
       if (nl(L)==p & k==q) & r~=0
           In=((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma)))-a(L)*V(q))*y(L)/a(L)^2+Bc(L)/a(L)^2*((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma))));
           Ik=(V(q)-(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))/a(L))*y(L)+Bc(L)*V(q);
           Snk=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(In)*basemva;
           Skn=V(q)*conj(Ik)*basemva;
           
           SL=Snk+Skn;
           SLT=SLT+SL;
       elseif (nl(L)==q & k==p) & r~=0
           In=(V(q)-a(L)*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma))))*y(L)/a(L)^2+Bc(L)/a(L)^2*V(q);
           Ik=((V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))-V(q)/a(L))*y(L)+Bc(L)*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)));
           Snk=V(n)*conj(In)*basemva;
           Skn=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(Ik)*basemva;
           SL=Snk+Skn;
           SLT=SLT+SL;
       else
         if (nl(L)==p & k==s) & r~=0
           In=((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma)))-a(L)*V(s))*y(L)/a(L)^2+Bc(L)/a(L)^2*((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma))));
           Ik=(V(s)-(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))/a(L))*y(L)+Bc(L)*V(s);
           Snk=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(In)*basemva;
           Skn=V(s)*conj(Ik)*basemva;
           SL=Snk+Skn;
           SLT=SLT+SL;
       elseif (nl(L)==s & k==p) & r~=0
           In=(V(s)-a(L)*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma))))*y(L)/a(L)^2+Bc(L)/a(L)^2*V(s);
           Ik=((V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))-V(s)/a(L))*y(L)+Bc(L)*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)));
           Snk=V(n)*conj(In)*basemva;
           Skn=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(Ik)*basemva;
           SL=Snk+Skn;
           SLT=SLT+SL;
       else
       In = (V(n) - a(L)*V(k))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(n);
       Ik = (V(k) - V(n)/a(L))*y(L) + Bc(L)*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       end          
       end      
       elseif nr(L)==n 
           k = nl(L);
           nr(L);
           if (nr(L)==q & k==p) & r~=0
               In=(V(q)-((V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))/a(L)))*y(L)+Bc(L)*V(q);
               Ik=((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma)))-a(L)*V(q))*y(L)/a(L)^2+Bc(L)/a(L)^2*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)));
               Snk=V(q)*conj(In)*basemva;
               Skn=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(Ik)*basemva;
               SL=Snk+Skn;
               SLT=SLT+SL;
          elseif (nr(L)==p & k==q) & r~=0
              In=((V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)))-V(q)/a(L))*y(L)+Bc(L)*(V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)));
              Ik=(V(q)-a(L)*(V(p)+r*V(p)*(cos(pi+gamma)+j*sin(pi+gamma))))*y(L)/a(L)^2+Bc(L)/a(L)^2*V(q);
              Snk=(V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)))*conj(In)*basemva;
              Skn=V(q)*conj(Ik)*basemva;
              SL=Snk+Skn;
              SLT=SLT+SL;
           else,end
               if (nr(L)==s & k==p) & r~=0
               In=(V(s)-((V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))/a(L)))*y(L)+Bc(L)*V(s);
               Ik=((V(p)+r*V(p)*(cos(gamma)+j*sin(gamma)))-a(L)*V(s))*y(L)/a(L)^2+Bc(L)/a(L)^2*(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)));
               Snk=V(s)*conj(In)*basemva;
               Skn=(V(p)+V(p)*r*(cos(gamma)+j*sin(gamma)))*conj(Ik)*basemva;
               SL=Snk+Skn;
               SLT=SLT+SL;
               
          elseif (nr(L)==p & k==s) & r~=0
              In=((V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)))-V(s)/a(L))*y(L)+Bc(L)*(V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)));
              Ik=(V(s)-a(L)*(V(p)+r*V(p)*(cos(pi+gamma)+j*sin(pi+gamma))))*y(L)/a(L)^2+Bc(L)/a(L)^2*V(s);
              Snk=(V(p)+V(p)*r*(cos(pi+gamma)+j*sin(pi+gamma)))*conj(In)*basemva;
              Skn=V(s)*conj(Ik)*basemva;
              
              SL=Snk+Skn;
              SLT=SLT+SL;
               else,end
       In = (V(n) - V(k)/a(L))*y(L) + Bc(L)*V(n);
       Ik = (V(k) - a(L)*V(n))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(k);
       Snk = V(n)*conj(In)*basemva;
       Skn = V(k)*conj(Ik)*basemva;
       Pline(count)=real(Snk)/100;
       Pr(count)=real(Snk)/100;
       Qr(count)=imag(Snk)/100;
       count=count+1;
       SL  = Snk + Skn;
       SLT = SLT + SL;
       Ploss(count)=real(SLT);
               end
           if nl(L)==n | nr(L)==n
         fprintf('%12g', k),
         fprintf('%9.3f', real(Snk)), fprintf('%9.3f', imag(Snk))
         fprintf('%9.3f', abs(Snk)),
         fprintf('%9.3f', real(SL)),
             if nl(L) ==n & a(L) ~= 1
             fprintf('%9.3f', imag(SL)), fprintf('%9.3f\n', a(L))
             else, fprintf('%9.3f\n', imag(SL))
             end
         else, end
  end
end
SLT = SLT/2
%NRPL=sum(SLT);
fprintf('   \n'), fprintf('    Total loss                         ')
fprintf('%9.3f', real(SLT)), fprintf('%9.3f\n', imag(SLT))
clear Ik In SL SLT Skn Snk 
%clear A DC DX  J11 J22 J33 J44 Qk delta lk ll lm
%clear A DC DX  J11 J22 J33  Qk delta lk ll lm 
      % Prints the power flow solution on the screen
    %  This program prints the power flow solution in a tabulated form
%  on the screen.
 
disp(tech)
fprintf('                      Maximum Power Mismatch = %g \n', maxerror)
fprintf('                             No. of Iterations = %g \n\n', iter)
head =['    Bus  Voltage  Angle    ------Load------    ---Generation---   Injected'
       '    No.  Mag.     Degree     MW       Mvar       MW       Mvar       Mvar '
       '                                                                          '];
disp(head)
for n=1:nbus
     fprintf(' %5g', n), fprintf(' %7.3f', Vm(n)),
     fprintf(' %8.3f', deltad(n)), fprintf(' %9.3f', Pd(n)),
     fprintf(' %9.3f', Qd(n)),  fprintf(' %9.3f', Pg(n)),
     fprintf(' %9.3f ', Qg(n)), fprintf(' %8.3f\n', Qsh(n))
end
    fprintf('      \n'), fprintf('    Total              ')
    fprintf(' %9.3f', Pdt), fprintf(' %9.3f', Qdt),
    fprintf(' %9.3f', Pgt), fprintf(' %9.3f', Qgt), fprintf(' %9.3f\n\n', Qsht)


%% fuel cost

data=[
0	40	0.01	-5	15
0	40	0.01	-300	300
0	40	0.01	-13	50
0	40	0.01	-300	300
0	20	0.022222222	-147	200
0	20	0.117647059	-35	120
0	40	0.01	-10	30
0	40	0.01	-16	50
0	40	0.01	-8	24
0	40	0.01	-300	300
0	20	0.045454546	-47	140
0	20	0.031847134	-1000	1000
0	40	0.01	-300	300
0	20	1.42857143	-300	300
0	40	0.01	-14	42
0	40	0.01	-8	24
0	40	0.01	-8	24
0	40	0.01	-300	300
0	40	0.01	-300	300
0	20	0.526315789	-100	100
0	20	0.049019608	-85	210
0	20	0.208333333	-300	300
0	40	0.01	-8	23
0	40	0.01	-8	15
0	20	0.064516129	-60	180
0	20	0.0625	-100	300
0	40	0.01	-20	20
0	20	0.025575448	-67	200
0	20	0.025510204	-67	200
0	20	0.019365	-300	300
0	20	0.019364834	-300	300
0	40	0.01	-10	32
0	40	0.01	-100	100
0	40	0.01	-100	100
0	40	0.01	-6	9
0	40	0.01	-8	23
0	40	0.01	-20	70
0	20	0.020964361	-165	280
0	40	0.01	-8	23
0	20	2.5	-100	1000
0	20	0.016474465	-210	300
0	40	0.01	-300	300
0	40	0.01	-100	100
0	40	0.01	-3	9
0	40	0.01	-100	100
0	20	0.03968254	-50	155
0	20	0.25	-15	40
0	40	0.01	-8	23
0	40	0.01	-8	23
0	40	0.01	-200	200
0	40	0.01	-8	23
0	20	0.277777778	-100	1000
0	40	0.01	-100	1000
0	40	0.01	-100	200


];
Pg(Pg==0)=[];
Generated_power = Pg';

Generated_power(Generated_power==0)=[];



N = length(data(:,1)); % no.of generators

Fuel_cost=zeros(N,1); total_Gen=0;
    for i=1:N
        Fuel_cost(i)=(data(i,1)*Generated_power(i)^2+data(i,2)*Generated_power(i)+data(i,3))/82.44;
        
    end

fprintf('Generated power and fuel cost :\n')


d=table(generator_no,Generated_power,Fuel_cost);
disp(d)



% 
% for i=1:length(Generated_power)
%     fprintf('%d \t %f \t %f\n',i,Generated_power(i),Fuel_cost(i))
% end
Tot_gen = sum(Generated_power);
fprintf('The total generation and fuel cost:\n',Tot_gen)
TotCost=sum(Fuel_cost);
fprintf('%f\t%f\n',Tot_gen,TotCost)
