local d=string.byte;local f=string.char;local t=string.sub;local D=table.concat;local e=table.insert;local h=math.ldexp;local F=getfenv or function()return _ENV end;local e=setmetatable;local r=select;local c=unpack or table.unpack;local i=tonumber;local function B(a)local l,n,o="","",{}local C=256;local c={}for e=0,C-1 do c[e]=f(e)end;local e=1;local function d()local l=i(t(a,e,e),36)e=e+1;local n=i(t(a,e,e+l-1),36)e=e+l;return n end;l=f(d())o[1]=l;while e<#a do local e=d()if c[e]then n=c[e]else n=l..t(l,1,1)end;c[C]=l..t(n,1,1)o[#o+1],l,C=n,n,C+1 end;return table.concat(o)end;local i=B('22K22F27522C22827522F1Y21C21I21H27B21I22C21X2791321121Q21C21C21E2111427P1X27P1I27T21L1Z22C21T2791K21R21K21G21K2311G21L22P21G21L1V1121D1121L1521C21322T1K1422C21V2792331421N1W1Q22V21G22O21P21B21M1F1K22R21L2131J22P22S1O22C21Z2791521E21C21Q2101Z27P1P21E1Z27V21E27X27Z28128328523122P2111J21H21F1E1M1222P22T1W121621121D1Q22C22G2791M21F21F29O27X1V21I21L21F21N27P22C22L29S28421K141Z21I21127Y2AR2752822AT2AF21M21Q21L27728121Q1Z21Q21929P22C22J28121121E21I29J1321R2BI21I21F22527922D2AD27927921X22C27922E2BW2BV22D2C122F2C02BY27527I22F2C322B2BV2C22C522F2C927522A2C42C02292CD2BS2CF2CH22F2782C82752CL2BS2AD2C32C02792B02CA2CF2BT2CO2C823427922N2CW2792C72CG2D727522M2BW2212D027923B22I2CD2742D42C02CC27929C2752CY2CG2DI2752D12DL2DN2CA2AD2C02CJ2DS2CO2CZ2362BZ2BV2CM2DU2DB2CS22F1K2BA2BC2BE2BG2B12BO2BL2BN2BJ21F2E52DW2EA2752E02CE2DP2CN2DT2D22E82EU2CU2CN2D227522B21S2CD2F22F42F522H2DB28P27521021921021N21O1U22T21F21P1O21G21F121022R22O1Z1U28K2AQ2AS2852AK21B1K21G2BF2G221K2G41M1P1L2AB2BV2B82B12EI2BD2B72DR22F1021I2BA2CZ2791N25K1N27H27J27L27N27P27R21127T2112AI27Y2802B129T28628828A28C28E28G28I28K28M28O28Q28S28U28W28Y29029229429629829A2EL2EG2H91K21N21Q29P1Z28N2D12B22852AV2AX27Y2742H82B321F2B521L2I32G92B42B622627923521U2792272CF2DQ2F92752IP2C021X2D72C02C32D62D22DC2IM22F2CC29C2DQ2J42IS22F2J62ET2CM2ES23B2802CM2JH2CG2752782EF2792CM2DV2C92CM2D92CT2CR22F2DG2JT2D92D12JN22F2D92GR2F32GM22F2IU2DD2J422F2IA2JC22F2HV22F2BR2CM2C02CL2C62K62CF2F72J92K72IW22F2CJ2DM2C82DI2CM2FE2792KG2IQ2752E92FC22F2EC2ED2762GM21N21K2BP2G82IB2852HY2I027X142ES21X2CH2GR2C92IY2F52D22IZ2BV2KI2CN2K32CE2L72792L92LB2KB2I521K2II2IF2LJ2LL2CK2F62CN2C32LR2EA2LV2KM2CN2ES2GH2EG2GJ2BE2GM2GO2GQ2CD26726C2GV2BU22F2AF2AH27W1Z2AK2AM2AO2112AC27921K28H21E21021K1Y21121G21E2I72AY2JW2CG2ES2GR23B2MA2JJ2CF2DC2CD2JP2BV2GM2LN2KR2DA2MC2DY2E72L12F32MF2L52GW27527K27M27O27Q27S27U2MX2HJ2751X21K21Q2ID2N521O21E21A23121M2N521E21N2L921L21E22C22P27924426F24525K24526224527023B1M27X21Q29E2N82NA2NC2P92AW2AY23B1122T23123B21F29M21E21G29J21F23B2BI2PA2NB21E2PJ23H23H22C2LR2PX22C1T27J21R29H23B21321N21I21A27P23B1Z27L21E2PQ1Z21K23B2B621P2PN1Z23B21I23B21N1Y2QQ21021G27L2132QO2PX1E2N923B21G2AL2342QO21F29H27D2AO2QD2Q521023B21K2QY21Q2N52Q12EF27F27E27C2KX2CG2232L02JT2MB2C42BY2NO2F72CD2C92CJ2K527622F2BY2CJ2C92CC2ES2792CJ2ME2KH2LU2L42CP2F42L52MD2MF2O02LS2O02MH2EF2EH2BB2GK22C2MM2GP1Z2LV2MQ2MS2AE2AG2H52MZ2AN2AP2RP2N52P92N92PU2AV2RG2NG21X2NI2DK2NL2NT2RX2NY2CQ2NS2F42ES2D42NW22F2D12DV22F2L22SK2GR2O22CH2O52GZ2O82H22OA2I12OC22F2OE2OG2ON21L2OJ2OL2UA2OP2OR2OT2302OW2OY2P02P22P42P62BB2T82PB21E2PD2I82PG22T23B2TB2132PJ2PL29J2PO2QG2PR2N72T92NC2PW2PY2Q02PY2Q32O42RD2Q72Q92QB2112QD2QF2QH2QJ2QL2QN2QP2QR2QT23B2QV2QX2QZ23H2R11Y2R32R52R72R921H2RB1Z2VF2RG2BB2RJ2PY2RL27C2RN21I2RP21X2RR2LT2RT2M92C92RW2CN2S22S02K92CD2WN2S62RY2S92CI2SK2752SD2FA2SF2IV2SH2SE2WJ2SM2F52GR2K3');local o=bit and bit.bxor or function(e,l)local n,o=1,0 while e>0 and l>0 do local t,C=e%2,l%2 if t~=C then o=o+n end e,l,n=(e-t)/2,(l-C)/2,n*2 end if e<l then e=l end while e>0 do local l=e%2 if l>0 then o=o+n end e,n=(e-l)/2,n*2 end return o end local function n(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local C,l,n,t=d(i,e,e+3);C=o(C,87)l=o(l,87)n=o(n,87)t=o(t,87)e=e+4;return(t*16777216)+(n*65536)+(l*256)+C;end;local function a()local l=o(d(i,e,e),87);e=e+1;return l;end;local function C()local n,l=d(i,e,e+2);n=o(n,87)l=o(l,87)e=e+2;return(l*256)+n;end;local function s()local e=l();local l=l();local t=1;local o=(n(l,1,20)*(2^32))+e;local e=n(l,21,31);local l=((-1)^n(l,32));if(e==0)then if(o==0)then return l*0;else e=1;t=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return h(l,e-1023)*(t+(o/(2^52)));end;local B=l;local function h(l)local n;if(not l)then l=B();if(l==0)then return'';end;end;n=t(i,e,e+l-1);e=e+l;local l={}for e=1,#n do l[e]=f(o(d(t(n,e,e)),87))end return D(l);end;local e=l;local function D(...)return{...},r('#',...)end local function B()local d={};local i={};local e={};local f={d,i,nil,e};local e=l()local o={}for n=1,e do local l=a();local e;if(l==0)then e=(a()~=0);elseif(l==1)then e=s();elseif(l==3)then e=h();end;o[n]=e;end;for i=1,l()do local e=a();if(n(e,1,1)==0)then local t=n(e,2,3);local c=n(e,4,6);local e={C(),C(),nil,nil};if(t==0)then e[3]=C();e[4]=C();elseif(t==1)then e[3]=l();elseif(t==2)then e[3]=l()-(2^16)elseif(t==3)then e[3]=l()-(2^16)e[4]=C();end;if(n(c,1,1)==1)then e[2]=o[e[2]]end if(n(c,2,2)==1)then e[3]=o[e[3]]end if(n(c,3,3)==1)then e[4]=o[e[4]]end d[i]=e;end end;f[3]=a();for e=1,l()do i[e-1]=B();end;return f;end;local function i(e,l,C)local n=e[1];local l=e[2];local e=e[3];return function(...)local o=n;local f=l;local t=e;local e=D local l=1;local e=-1;local B={};local a={...};local d=r('#',...)-1;local e={};local n={};for e=0,d do if(e>=t)then B[e-t]=a[e+1];else n[e]=a[e+1];end;end;local e=d-t+1 local e;local t;while true do e=o[l];t=e[1];if t<=19 then if t<=9 then if t<=4 then if t<=1 then if t==0 then C[e[3]]=n[e[2]];else if n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=2 then local t;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];elseif t>3 then local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;else local t;C[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](c(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];end;elseif t<=6 then if t>5 then local l=e[2]n[l](c(n,l+1,e[3]))else local t;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];end;elseif t<=7 then n[e[2]]();elseif t>8 then if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;else n[e[2]]=e[3];end;elseif t<=14 then if t<=11 then if t>10 then n[e[2]]=e[3];else local l=e[2]n[l](c(n,l+1,e[3]))end;elseif t<=12 then local t;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];do return end;elseif t>13 then if n[e[2]]then l=l+1;else l=e[3];end;else n[e[2]]=n[e[3]][e[4]];end;elseif t<=16 then if t==15 then n[e[2]]=i(f[e[3]],nil,C);else local e=e[2]n[e](n[e+1])end;elseif t<=17 then do return end;elseif t==18 then local t;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];do return end;else local e=e[2]n[e]=n[e](n[e+1])end;elseif t<=29 then if t<=24 then if t<=21 then if t==20 then n[e[2]]=n[e[3]];else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t<=22 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](c(n,t+1,e[3]))l=l+1;e=o[l];do return end;l=l+1;e=o[l];l=e[3];elseif t>23 then n[e[2]]=C[e[3]];else l=e[3];end;elseif t<=26 then if t==25 then n[e[2]]=n[e[3]];else n[e[2]]();end;elseif t<=27 then n[e[2]]=(e[3]~=0);elseif t>28 then local e=e[2]n[e](n[e+1])else local d;local t;local a;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];a=e[3];t=n[a]for e=a+1,e[4]do t=t..n[e];end;n[e[2]]=t;l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];d=e[2]n[d](c(n,d+1,e[3]))l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];do return end;l=l+1;e=o[l];do return end;end;elseif t<=34 then if t<=31 then if t==30 then n[e[2]]=C[e[3]];else local d;local t;local a;n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];a=e[3];t=n[a]for e=a+1,e[4]do t=t..n[e];end;n[e[2]]=t;l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];d=e[2]n[d](c(n,d+1,e[3]))l=l+1;e=o[l];n[e[2]]=C[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];do return end;l=l+1;e=o[l];do return end;end;elseif t<=32 then n[e[2]]=n[e[3]][e[4]];elseif t==33 then n[e[2]]=(e[3]~=0);else local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;end;elseif t<=36 then if t>35 then n[e[2]]=i(f[e[3]],nil,C);else l=e[3];end;elseif t<=37 then do return end;elseif t>38 then C[e[3]]=n[e[2]];else local e=e[2]n[e]=n[e](n[e+1])end;l=l+1;end;end;end;return i(B(),{},F())();