local d=string.byte;local h=string.char;local t=string.sub;local C=table.concat;local e=table.insert;local B=math.ldexp;local G=getfenv or function()return _ENV end;local r=setmetatable;local s=select;local i=unpack or table.unpack;local f=tonumber;local function H(i)local l,n,c="","",{}local a=256;local o={}for e=0,a-1 do o[e]=h(e)end;local e=1;local function d()local l=f(t(i,e,e),36)e=e+1;local n=f(t(i,e,e+l-1),36)e=e+l;return n end;l=h(d())c[1]=l;while e<#i do local e=d()if o[e]then n=o[e]else n=l..t(l,1,1)end;o[a]=l..t(n,1,1)c[#c+1],l,a=n,n,a+1 end;return table.concat(c)end;local f=H('25325727525424W27525726525Q26025S25Y26626726226726725E25627927N25725424P27926N25L25U26426426625L26G27Y25P27Y27228225X25R25424T27926W25V25W26025W23L27025X23X26025X26R26L26526L25X26H26425N23T26W26G25424V27923N26G25Z25O26U23V26023W25T25F25Y26B26W23Z25X25N27323X23S26S25424R27926H26626425U25K25R27Y26T26625R28426628628828A28C28E23L23X25L27326126726A26Y26M23X23T25O26M26I25L26526U25425027926Y27J29X28626R26225X26725Z27Y25424X2A128D25W26G25R26225L2872AZ27528B2B12AO25Y25U25X25425828A25U25R25U25D29Y2542742B925L26626229S26N25V2BR27I2572592792552792BG2BI2BK2BM2BF2BP25726W2BX2BU2BW2BS26725727M27O2CJ2C227525B2AM27N2CI2892752CI25725A27924P2442792CT24B24J27O2C225523T2CH2CJ28Y2752C22CQ2CZ2792512C32D925725K25D25K25Z25S26Q23T26725T26S26026726M26K23Z23W25R26Q28T2AY2B028E2AS25F26W2602BO2E325W2E526Y26T26X2AK27N2C42B92BJ2BL2BN25B27926K2622BJ2CT27526Z21026Z27Q27S27U27W27Y28025L28225L2AQ2872CR2CA2A228F28H28J28L28N28P28R28T28V28X28Z29129329529729929B29D29F29H29J2C92BA28E26W25Z25U29Y25R28W2B82F92B12B32B52872782B92FA2BC2BE2G42EA2GE25X2C027924H27924D24Y27924I2D727M2CN2GQ2D724P27427M2CL2572GX2572C22542GN23U2572EN2BH2GT2H82CO2572HA2HC27924Q2GW2CY2C02CV27524B2462BZ2HQ2C027R2HE2HU27O2C02DB2H12752C024Z2CW2752BH2GP2752HT2I22G52792I12D727O2CT2EN2GV27M2H22EN2GB2H12HK2572C92572GR2C027M27M2592C02H52GR2IF2HD2IY2H12742CV2522CW2IN2DF2GV2IS2ID2F82CT2H02542IG25725Z25W27I2E92GC2B12FZ2G128626G27O2BH2I72GM2CS2I32D72H02D32H32CJ2IT2K22CJ2K52CP2C12C32JG2JI2JK2IL2FX25W2GI2JR27N2JT2H12JV2ID2HZ2JY2K62D42K42ES2JW2K62K62CT2HM27P2KJ26W2EK2C72JF2EO2EQ25R2KS21F182EW2HD2AO2672F62AS2AU2AW25L25424U27925W25X2JO2G229N25K25W25Q25L2602662G82B62KM2GK27P2HT25727T27V27X27Z28128328528724S2EA23L26L25U25W25Z2BT2MG25X27329V26626029S26725423X27923C1B23D21023D21I23D1G24B26Y28625U2LQ2LS2LU2662LQ2B42B624B26L23T23L24B2672MN2MP27G24B2BR2LR2LT2LV2NH2412412542H02NT25426P27S25V29Q24B25N2MI25E27Y24B25R27U2NM25R25W24B2BE25T2MO25R24B26224B25Z25Q2OK25K26027U25N2OI2NT26A2LS24B2602AT24C2OI26729Q2622612AW2O82O125K24B25W2OS2MK2NX2IL27B27D27F27H27J27L27N2J82H124D2GS2JX2KQ2I727627P2CJ2JG2PT2CU2H82CJ2H52H52CV2HT2EN2KX2792CV2KS2HQ2QA2IU2GW2JW2M02DD2K32IE2KV2792I62H124L2DD2HN2CK2KN27M2H52K52HY2M22Q02PY27M2KX2D52K12KU2HY2572JC2792G52EI2CA2L12EM2L42ER27O2L826Z2QA22323O2QA24R2EW2M22M42F02M72F32M92G22542MC2JM2A32MF2MH2MJ2LM2MM29S2NL2MR24F2MU1P23D21323D1J24B26R2G22EQ26W25W2BR24B26X27226N26Y2NH2NJ2S52MQ24B26U26N27325423O2O02O22O42622O625L2O82OA2672O82OD2P528D25S2P72662OJ2N526025V2BS2OI2KB2P225X2642TH2T926425W2OI25S25U27D27G2772792PG27E27G27I27K27O24N2J62QP25724B2HI27N2C22HT2QT2KP2KM2K52QG2I22IZ2792UM2HG2752GY27523V2UA24B24B27O2IG2I22KT2UQ2572J52DC2V12572UU2V12512DF2CV2HI2UN2752VD2V22JW2CX2IB2CW2Q92HV2KN2C22V02KN2H52QM2792EN2QA2Q72CJ2VM2QX2IA2K72HB2QJ2R62UV2C12D62CJ24P2402UA2KU2UG2R32VO2PV2PY2H52JG2Q52PZ2K02VV2WG2M02HT2H52KJ2K82QW2CY2VP2CW24O2PV2KJ2R22WO2WN2D72592GZ2K12QI2432K52H22C22QM2X62K12H52X92XB2742C22G52VJ2C22IL2D12K12C22XK2D62WJ27N28Y2KQ2II2WW2572XP2D22KQ2742XF2Q32KO2572XA2K52YA2UJ2XX2X82752R7275');local o=bit and bit.bxor or function(e,l)local n,o=1,0 while e>0 and l>0 do local t,c=e%2,l%2 if t~=c then o=o+n end e,l,n=(e-t)/2,(l-c)/2,n*2 end if e<l then e=l end while e>0 do local l=e%2 if l>0 then o=o+n end e,n=(e-l)/2,n*2 end return o end local function n(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local l,t,c,n=d(f,e,e+3);l=o(l,187)t=o(t,187)c=o(c,187)n=o(n,187)e=e+4;return(n*16777216)+(c*65536)+(t*256)+l;end;local function a()local l=o(d(f,e,e),187);e=e+1;return l;end;local function c()local l,n=d(f,e,e+2);l=o(l,187)n=o(n,187)e=e+2;return(n*256)+l;end;local function K()local o=l();local e=l();local t=1;local o=(n(e,1,20)*(2^32))+o;local l=n(e,21,31);local e=((-1)^n(e,32));if(l==0)then if(o==0)then return e*0;else l=1;t=0;end;elseif(l==2047)then return(o==0)and(e*(1/0))or(e*(0/0));end;return B(e,l-1023)*(t+(o/(2^52)));end;local B=l;local function H(l)local n;if(not l)then l=B();if(l==0)then return'';end;end;n=t(f,e,e+l-1);e=e+l;local l={}for e=1,#n do l[e]=h(o(d(t(n,e,e)),187))end return C(l);end;local e=l;local function f(...)return{...},s('#',...)end local function B()local d={};local o={};local e={};local i={d,o,nil,e};local e=l()local t={}for n=1,e do local l=a();local e;if(l==0)then e=(a()~=0);elseif(l==1)then e=K();elseif(l==3)then e=H();end;t[n]=e;end;i[3]=a();for e=1,l()do o[e-1]=B();end;for i=1,l()do local e=a();if(n(e,1,1)==0)then local o=n(e,2,3);local a=n(e,4,6);local e={c(),c(),nil,nil};if(o==0)then e[3]=c();e[4]=c();elseif(o==1)then e[3]=l();elseif(o==2)then e[3]=l()-(2^16)elseif(o==3)then e[3]=l()-(2^16)e[4]=c();end;if(n(a,1,1)==1)then e[2]=t[e[2]]end if(n(a,2,2)==1)then e[3]=t[e[3]]end if(n(a,3,3)==1)then e[4]=t[e[4]]end d[i]=e;end end;return i;end;local function d(e,a,c)local l=e[1];local n=e[2];local e=e[3];return function(...)local o=l;local h=n;local t=e;local e=f local l=1;local e=-1;local B={};local C={...};local s=s('#',...)-1;local f={};local n={};for e=0,s do if(e>=t)then B[e-t]=C[e+1];else n[e]=C[e+1];end;end;local e=s-t+1 local e;local t;while true do e=o[l];t=e[1];if t<=25 then if t<=12 then if t<=5 then if t<=2 then if t<=0 then local l=e[2]n[l](i(n,l+1,e[3]))elseif t==1 then local h=h[e[3]];local i;local t={};i=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==40 then t[c-1]={n,e[3]};else t[c-1]={a,e[3]};end;f[#f+1]=t;end;n[e[2]]=d(h,i,c);else local h=h[e[3]];local i;local t={};i=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==40 then t[c-1]={n,e[3]};else t[c-1]={a,e[3]};end;f[#f+1]=t;end;n[e[2]]=d(h,i,c);end;elseif t<=3 then l=e[3];elseif t>4 then local t;n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];t=e[2]n[t](i(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];l=e[3];else if n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=8 then if t<=6 then if n[e[2]]then l=l+1;else l=e[3];end;elseif t==7 then local e=e[2]n[e]=n[e](n[e+1])else a[e[3]]=n[e[2]];end;elseif t<=10 then if t>9 then n[e[2]]();else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t>11 then c[e[3]]=n[e[2]];else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=18 then if t<=15 then if t<=13 then local e=e[2]n[e](n[e+1])elseif t>14 then l=e[3];else if(e[2]<=n[e[4]])then l=e[3];else l=l+1;end;end;elseif t<=16 then if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;elseif t>17 then a[e[3]]=n[e[2]];else local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=a[e[3]];l=l+1;e=o[l];if n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=21 then if t<=19 then n[e[2]]=e[3];elseif t>20 then n[e[2]]=n[e[3]];else local e=e[2]n[e](n[e+1])end;elseif t<=23 then if t==22 then do return end;else local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;end;elseif t>24 then n[e[2]]();else n[e[2]]=n[e[3]][e[4]];end;elseif t<=38 then if t<=31 then if t<=28 then if t<=26 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];a[e[3]]=n[e[2]];l=l+1;e=o[l];do return end;elseif t>27 then local l=e[2]n[l](i(n,l+1,e[3]))else n[e[2]]=n[e[3]][e[4]];end;elseif t<=29 then n[e[2]]=e[3];elseif t==30 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];else c[e[3]]=n[e[2]];end;elseif t<=34 then if t<=32 then n[e[2]]=n[e[3]]+e[4];elseif t>33 then n[e[2]]=n[e[3]]+e[4];else n[e[2]]=d(h[e[3]],nil,c);end;elseif t<=36 then if t==35 then if(e[2]<=n[e[4]])then l=e[3];else l=l+1;end;else local e=e[2]n[e]=n[e](n[e+1])end;elseif t==37 then n[e[2]]=a[e[3]];else local a;local t;local d;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];d=e[3];t=n[d]for e=d+1,e[4]do t=t..n[e];end;n[e[2]]=t;l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];a=e[2]n[a](i(n,a+1,e[3]))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];do return end;l=l+1;e=o[l];do return end;end;elseif t<=44 then if t<=41 then if t<=39 then do return end;elseif t==40 then n[e[2]]=n[e[3]];else local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];a[e[3]]=n[e[2]];l=l+1;e=o[l];do return end;end;elseif t<=42 then n[e[2]]=(e[3]~=0);elseif t==43 then local t;c[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=(e[3]~=0);l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](i(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])else n[e[2]]=c[e[3]];end;elseif t<=47 then if t<=45 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](i(n,t+1,e[3]))l=l+1;e=o[l];do return end;l=l+1;e=o[l];l=e[3];elseif t>46 then n[e[2]]=c[e[3]];else n[e[2]]=(e[3]~=0);end;elseif t<=49 then if t>48 then if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;else n[e[2]]=a[e[3]];end;elseif t==50 then n[e[2]]=d(h[e[3]],nil,c);else local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;end;l=l+1;end;end;end;return d(B(),{},G())();