#version 330

//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;

vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

// compatibility #defines
#define vTexCoord TEX0.xy
#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy;
}

#elif defined(FRAGMENT)

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out COMPAT_PRECISION vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;

// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

float nnedi3(int comp) {
    vec2 p = floor(gl_FragCoord.xy);//vec2(floor(vTexCoord.x * OutputSize.x), floor(vTexCoord.y * OutputSize.y));
    if (mod(p.y, 2.0) == 0.0) {
        return COMPAT_TEXTURE(Source, vTexCoord.xy)[comp];
    }
#define GET(i, j) COMPAT_TEXTURE(Source, vTexCoord.xy + (vec2((i) - (3.000000), (j) - (1.500000))/SourceSize.xy))[comp]
	vec4 samples[8];
	samples[0] = vec4(GET(0.0, 0.0), GET(1.0, 0.0), GET(2.0, 0.0), GET(3.0, 0.0));
	samples[1] = vec4(GET(4.0, 0.0), GET(5.0, 0.0), GET(6.0, 0.0), GET(7.0, 0.0));
	samples[2] = vec4(GET(0.0, 1.0), GET(1.0, 1.0), GET(2.0, 1.0), GET(3.0, 1.0));
	samples[3] = vec4(GET(4.0, 1.0), GET(5.0, 1.0), GET(6.0, 1.0), GET(7.0, 1.0));
	samples[4] = vec4(GET(0.0, 2.0), GET(1.0, 2.0), GET(2.0, 2.0), GET(3.0, 2.0));
	samples[5] = vec4(GET(4.0, 2.0), GET(5.0, 2.0), GET(6.0, 2.0), GET(7.0, 2.0));
	samples[6] = vec4(GET(0.0, 3.0), GET(1.0, 3.0), GET(2.0, 3.0), GET(3.0, 3.0));
	samples[7] = vec4(GET(4.0, 3.0), GET(5.0, 3.0), GET(6.0, 3.0), GET(7.0, 3.0));
	float sum = 0.0, sumsq = 0.0;
	for (int i = 0; i < 8; i++) {
		sum += dot(samples[i], vec4(1.0));
		sumsq += dot(samples[i], samples[i]);
	}
	float mstd0 = sum / 32.0;
	float mstd1 = sumsq / 32.0 - mstd0 * mstd0;
	float mstd2 = mix(0.0, inversesqrt(mstd1), mstd1 >= 1.192092896e-7);
	mstd1 *= mstd2;
	float vsum = 0.0, wsum = 0.0, sum1, sum2;
#define T(x) intBitsToFloat(x)
#define W(i,w0,w1,w2,w3) dot(samples[i],vec4(T(w0),T(w1),T(w2),T(w3)))
#define WS(w0,w1) sum1 = exp(sum1 * mstd2 + T(w0)); sum2 = sum2 * mstd2 + T(w1); wsum += sum1; vsum += sum1*(sum2/(1.0+abs(sum2)));
	sum1=W(0,1036208225,1039469975,1027560868,1039536921)+W(1,-1144450173,1035622988,1024461970,1029776426)+W(2,-1091571194,-1095740683,-1097328754,1025116802)+W(3,1043923973,1049700439,1024545936,1047463785)+W(4,1048590727,1028885330,1039928979,1017576356)+W(5,-1098962113,-1090255529,-1100301043,-1090407950)+W(6,1032174663,1026075554,1023201972,1042058704)+W(7,1033278580,1046104373,1035224848,1043393326);sum2=W(0,-1098253927,-1166389754,-1106582410,1034460863)+W(1,1027738130,-1113669665,1016925525,-1129223232)+W(2,1055965966,-1101782718,1045236553,-1132225959)+W(3,1057568628,1055278331,-1127810369,-1108092808)+W(4,1006679350,983512221,-1097283179,-1090237017)+W(5,1036184228,-1133967067,1022264595,1009711002)+W(6,-1096709168,-1105895383,1040768379,1030302550)+W(7,-1111760224,1033275358,-1104949250,1045297871);WS(-1080723616,-1076327864);
	sum1=W(0,1017315691,-1140602116,1037257964,-1107192473)+W(1,1022003974,1022805527,1021604747,1014959990)+W(2,-1106293281,1024505865,-1101486193,1027220277)+W(3,1032001763,-1106692027,1020788295,-1109388172)+W(4,1041272315,-1129176587,1040932726,-1098639185)+W(5,1032224091,1038889695,1019749115,1036681163)+W(6,-1113397025,1022464939,1024865293,1043879330)+W(7,-1118929755,-1123579783,-1117432531,998707020);sum2=W(0,1015755803,-1140061902,-1129835189,1032555441)+W(1,-1138877514,-1123339814,1016646759,-1165772366)+W(2,-1127131649,1016927815,-1112279061,-1095938931)+W(3,-1116204914,1009679614,-1153656135,-1146249364)+W(4,-1137718334,-1129880851,-1089663810,-1069364926)+W(5,-1092530653,-1148409052,-1122312216,1018619187)+W(6,1033341381,1024947773,1058036499,1079454606)+W(7,1053318688,1022404175,1028043253,1025789685);WS(1058954560,1004956589);
	sum1=W(0,-1128607008,1038458494,1047693245,1026348672)+W(1,-1108459679,-1116524774,1024592800,-1117551096)+W(2,-1102342440,-1105082889,-1085974686,1047296084)+W(3,1058722958,-1135229473,1019546620,-1122816147)+W(4,1027139080,-1147341058,1057887999,-1100046248)+W(5,-1087115665,1043502422,1020243248,1043995308)+W(6,1038455278,-1156235011,-1103441674,1029167261)+W(7,1033885827,1027001826,-1124163292,1023459588);sum2=W(0,1039897191,-1116902056,-1115617116,-1116419565)+W(1,-1121428266,1003022729,1032782009,-1161229156)+W(2,1032715073,1035295215,1051413477,-1089611288)+W(3,1039274043,-1102315300,1012620980,1023483611)+W(4,-1104821098,-1120385367,1060018690,-1132652148)+W(5,1008252604,-1117381948,-1113601670,-1116040249)+W(6,-1103487249,-1118716257,-1091510775,1048354743)+W(7,1040404198,1037629937,1035102099,-1132320852);WS(-1088253760,-1127575790);
	sum1=W(0,1038728366,1033404580,1036121471,1045370723)+W(1,994877095,1036217881,1012008372,1040247041)+W(2,-1156102863,1042126700,-1099951467,-1083618166)+W(3,1040753147,-1099186053,1033329669,-1099351704)+W(4,1036225546,-1111684630,1050604224,-1088174091)+W(5,-1098202972,1039701042,1015138122,1032444126)+W(6,1011512228,1043566527,1032168346,1050156122)+W(7,1037663513,1034991255,1030253051,1041638884);sum2=W(0,1030438042,1009286759,1027607240,1019667875)+W(1,-1113200383,1032828373,-1125602091,1008172775)+W(2,-1147399085,1025260806,1032031341,1065802217)+W(3,1046766533,-1110418147,-1137630919,-1119451994)+W(4,-1093920639,-1086940227,-1090745109,1049694895)+W(5,-1117099650,1041550488,-1114583845,1034586333)+W(6,-1109485523,-1143426189,-1114490725,-1135657207)+W(7,1032826151,1024844082,993352218,-1137428855);WS(-1079364256,1057874888);
	sum1=W(0,1038744583,1028964378,1038770168,1044691424)+W(1,1039465822,1031872786,1031706975,1026510455)+W(2,1023431711,1034807569,1043817591,-1093522810)+W(3,1033837359,1026052487,1024735357,1032349913)+W(4,-1097930673,-1105253352,-1095573950,-1085514994)+W(5,-1111615463,1038514603,1029114647,1036441879)+W(6,1027252187,1030066159,1037737491,1045101529)+W(7,1019830473,1014931844,1030853165,1025856707);sum2=W(0,-1110129969,-1122608874,-1109784187,1036903789)+W(1,1016388156,-1134147112,1025386706,-1114085729)+W(2,1023276596,1020476676,1055608478,1056514262)+W(3,-1122102418,1032271709,-1109100200,1030585586)+W(4,1028080466,-1106237621,-1110801543,-1099727798)+W(5,1033517697,-1114242709,-1110189468,-1128034084)+W(6,-1115008651,-1145788944,-1135649000,1034305529)+W(7,1019861916,-1104837577,1027443202,-1105665752);WS(-1091483264,-1079194671);
	sum1=W(0,-1131351604,-1113984995,1021186040,-1116327562)+W(1,-1132080655,-1206829265,1023600234,-1126861572)+W(2,-1116837930,1032278999,-1099425098,1045060919)+W(3,1054575181,-1113261897,-1130307600,-1115285054)+W(4,-1139989065,987288903,1055014512,1046630795)+W(5,-1092379987,1027226210,-1122295330,1003385298)+W(6,1024497830,-1120582522,-1105371085,-1115581427)+W(7,1026057008,-1110689206,-1130576880,-1136751161);sum2=W(0,-1129629424,1028468886,-1120636360,-1136732761)+W(1,1036262769,1022425868,1019955588,-1123045172)+W(2,1004745569,-1114381934,1032177433,1051604488)+W(3,-1115452378,1026786204,-1123076816,-1139760465)+W(4,1012138921,1032075412,-1114041388,-1122709320)+W(5,-1105925279,-1102674451,1002766561,-1135173233)+W(6,1021845392,1000184001,1017905952,-1141636449)+W(7,-1138562729,1006971361,-1146151969,-1127921184);WS(1067689632,-1150117831);
	sum1=W(0,-1109849008,-1130553174,-1123520321,1036413160)+W(1,1029117869,-1127374955,-1140464318,1027561031)+W(2,1047555836,1029999475,1050420518,-1116179871)+W(3,1035246488,-1104890550,1020611803,-1113066609)+W(4,1035630764,-1114674616,1040630545,-1098283742)+W(5,1031697439,-1116392999,-1125473743,-1114557056)+W(6,-1099893915,-1113991840,-1107722684,-1150636351)+W(7,1041501593,1019029347,1031847583,1006720846);sum2=W(0,1032302578,-1114467512,1035589071,-1140727686)+W(1,1028178655,-1123814512,-1131958732,-1114865396)+W(2,1032483043,1037446674,-1114962225,-1107033941)+W(3,1017647091,-1102520792,1028700703,-1106445462)+W(4,1055539881,1053856893,1060021172,1044678306)+W(5,-1086216329,-1096729370,-1098594526,-1103816765)+W(6,-1089061083,-1095432519,-1087688027,-1119624965)+W(7,1060967891,1056004093,1046082925,1049601918);WS(1053174400,-1151490459);
	sum1=W(0,-1122069115,-1147738936,1027718109,1032697654)+W(1,1025368761,-1112696969,1007532846,-1121758051)+W(2,1032070534,-1116405775,1043517586,-1108806494)+W(3,1041596435,1030488179,-1145227340,1032005679)+W(4,-1106451229,1015337751,-1118269791,-1117317899)+W(5,1044803791,-1098708424,1024445699,-1105947015)+W(6,1016988943,-1131178679,1030116243,1014470144)+W(7,-1112007328,1036691591,-1121635481,1025294511);sum2=W(0,1030975148,1021517080,1055956931,1077778659)+W(1,1057214094,1029844584,1029913248,1021753404)+W(2,-1130068082,-1126516206,-1091517508,-1071480833)+W(3,-1089646275,-1129174056,-1116251741,998387790)+W(4,-1128045540,1010660367,-1115164896,-1096786527)+W(5,-1109767888,1010452735,-1130073888,-1161269496)+W(6,1009416079,1014043007,-1124472846,1028586964)+W(7,1004868686,-1122799750,1023899390,-1126055830);WS(1064255296,1017910760);
	sum1=W(0,1034554881,-1112041607,-1108750194,-1098306542)+W(1,-1140839485,-1117661336,-1142577806,-1131295699)+W(2,1054734130,1053450179,1051103338,1044871248)+W(3,-1103441076,1027829882,-1122634224,1024857124)+W(4,-1098111935,1024002066,-1095577677,1046694116)+W(5,-1111281057,1048629833,1032310597,1048835924)+W(6,-1127407003,-1117294562,1016696883,-1097130662)+W(7,983357671,-1104687573,-1118108640,-1098281839);sum2=W(0,-1120767464,1032914397,-1109760249,1040094052)+W(1,1016200567,1009241688,-1122384418,1032959032)+W(2,1053966016,1073793292,1060302091,-1072585870)+W(3,-1094220304,-1113143087,1028063795,-1104349617)+W(4,1035968374,1040357442,-1122023462,-1086238928)+W(5,-1172011891,1043210576,1025380203,-1119727737)+W(6,-1147532546,-1129131123,-1130362887,-1116834009)+W(7,1036030945,1015923256,1017132829,1019714285);WS(-1096343168,-1126236522);
	sum1=W(0,1030703603,1007810299,1040041675,1047119465)+W(1,-1113575360,-1132527909,-1134236941,1009418349)+W(2,-1108689250,-1119306439,-1096469888,-1085509191)+W(3,1056154112,1020253526,1041829816,1033231243)+W(4,1038321302,1031818658,1053153171,-1089344732)+W(5,1045446045,999324634,-1115315934,-1107897834)+W(6,-1121378303,-1127608870,-1126859158,1045457184)+W(7,-1144694086,1029954693,1019451938,1026209383);sum2=W(0,983284602,1016178696,1029794920,1029986296)+W(1,-1109420788,-1131549160,-1118046352,-1117716768)+W(2,1020456556,-1144975071,-1114118472,1041996066)+W(3,-1139464095,-1114876306,1015095008,983229178)+W(4,-1131636264,-1131007184,997214653,1053737341)+W(5,-1097949071,-1113647896,-1115559594,-1141234271)+W(6,1015204808,1022946788,998054973,1023304596)+W(7,1029400914,1024576522,-1124860928,-1131778280);WS(1054415488,1031748714);
	sum1=W(0,1032036500,-1106849745,1032905605,998976710)+W(1,1035586875,1024707071,-1137244643,1040319748)+W(2,1016814449,1048190511,1025341687,1051815981)+W(3,-1102465150,-1113968464,-1127337837,-1115415046)+W(4,-1098109636,-1110288412,-1090213441,1042721902)+W(5,-1117518441,1046144796,-1117570737,-1135047459)+W(6,1018567785,-1119790601,1041909072,1029877301)+W(7,1033626399,-1106536335,1018599181,-1122513053);sum2=W(0,990440998,-1138393335,-1115155620,1002996807)+W(1,-1122715509,-1107496177,-1109700727,-1100731818)+W(2,-1103416430,-1121991569,-1128966950,-1100463136)+W(3,-1095499559,1010012987,1000571127,1048400711)+W(4,-1120602807,1037302636,-1098451061,1060125031)+W(5,1057202890,1038403096,1011003397,1041385707)+W(6,1034530622,-1117267403,1032576586,-1114490937)+W(7,-1120765719,-1126507430,1027555951,-1105804206);WS(1057399616,1074070393);
	sum1=W(0,-1116946950,-1167692925,1025124136,1027460150)+W(1,1033233658,1043057687,1031827147,1036180887)+W(2,1049855515,1048650971,1035712138,-1096264273)+W(3,-1093603523,-1089515076,-1102565613,-1089497938)+W(4,-1097294408,-1103643414,-1094845877,-1106323062)+W(5,1045414146,1057610273,1043872372,1048651645)+W(6,1045229301,1041758026,1045455640,1036926493)+W(7,1036007790,-1123310040,1012034194,1034964477);sum2=W(0,-1099019906,1016280180,-1104956478,-1160553787)+W(1,-1115190705,1040551613,-1110901592,1043284947)+W(2,-1135117191,-1104821294,1031344902,1057285857)+W(3,-1108143797,-1096822242,-1121444630,-1108844527)+W(4,1053230727,-1108236474,1044240449,1060881655)+W(5,-1141578351,-1110487530,1033167055,-1097266933)+W(6,-1102919364,1021862852,-1102746088,-1121198562)+W(7,-1107568696,1027740054,-1115478973,1039050835);WS(-1079272096,-1088198283);
	sum1=W(0,-1150549691,-1136809437,1035238887,-1114730926)+W(1,1013948517,1024493634,1014747375,1007675727)+W(2,-1112293630,-1147892734,-1101200910,-1153686203)+W(3,1033312670,-1111552818,993656219,-1115285591)+W(4,1038263474,-1131332343,1042949876,-1109365886)+W(5,-1123815596,1033656538,999554974,1031561484)+W(6,-1117531256,1024124492,1022854919,1038223988)+W(7,-1137128325,-1131368443,-1123012682,983503863);sum2=W(0,-1130912341,933663296,1024898014,1026863962)+W(1,1006981209,1015250909,-1128875465,-1163156681)+W(2,-1131869901,973137042,1022547165,-1103034755)+W(3,1032168251,-1122671508,1002623282,-1124284861)+W(4,1021624533,1031913949,1049231168,1074345895)+W(5,1046910286,1033396431,1015118461,987851849)+W(6,-1116201618,-1114826138,-1097351564,-1074065991)+W(7,-1101411998,-1116799454,-1122428830,-1131138133);WS(1066898592,-1135257599);
	sum1=W(0,-1110180874,-1104421608,-1108282395,-1109212258)+W(1,-1112266449,-1104815307,-1117810340,-1107536862)+W(2,1039457202,1036077428,1042328969,1047234565)+W(3,-1102031401,-1101771699,-1107974833,-1105991798)+W(4,-1099722419,-1109956850,-1108344348,1050666829)+W(5,1052651555,1056795268,1044347095,1052879183)+W(6,1033603984,1025966004,1027866348,-1127852161)+W(7,-1117920074,-1103088922,-1114797145,-1109126692);sum2=W(0,-1109573955,-1130272686,-1112628352,-1135365682)+W(1,-1127976571,-1109041460,-1141484375,-1124075328)+W(2,1053252716,-1099761318,1053124236,1015950468)+W(3,1055173972,1056516595,-1111992284,-1111067004)+W(4,-1111963093,1023415227,1036225124,-1098416341)+W(5,984548524,-1099834172,-1115296758,-1123095583)+W(6,-1104024699,-1113318439,-1113101390,989675628)+W(7,-1113626094,1021900236,-1121224929,1035158074);WS(-1080514464,1071098312);
	sum1=W(0,1029423638,1032590577,1026820152,1032314563)+W(1,-1121041060,-1118573868,-1120807462,-1138006521)+W(2,-1104998922,-1109637973,-1100165641,1052963835)+W(3,1049180397,1051364482,1040988017,1046351030)+W(4,1034143047,1035675859,1041959039,1044386890)+W(5,-1094089003,-1091683740,-1104568584,-1100071438)+W(6,-1121480226,-1116754806,-1119258414,-1124675269)+W(7,-1141724766,1026232616,-1142663074,-1128189972);sum2=W(0,-1103917515,1015651007,-1110033797,-1102760582)+W(1,-1111112749,1038662254,-1114159185,1037944898)+W(2,1047440331,-1161898742,1037971494,1064882055)+W(3,-1094052244,-1095531648,1028288648,-1103088589)+W(4,1045127249,-1107946310,1032097498,1062501861)+W(5,-1097807648,-1103513552,1000704926,-1103412727)+W(6,-1101094893,1034127906,-1105034150,-1105985747)+W(7,952358760,1029080884,-1115269879,1036625418);WS(1048356096,1025975827);
	sum1=W(0,-1127785256,-1122099232,-1101696686,1026577988)+W(1,1038799529,1035389109,1026796836,1026531900)+W(2,1042988217,1042373466,1057753530,1024353684)+W(3,-1089144738,-1100403603,-1117105634,-1118224663)+W(4,-1143337570,-1109964850,-1091154007,1027827940)+W(5,1052285203,-1125657656,-1109515886,-1110632314)+W(6,-1113788528,985728647,981326605,1025248769)+W(7,1031883373,1042938314,1041478413,1024598728);sum2=W(0,1012220951,-1116521159,-1112142878,1029633040)+W(1,-1134401830,-1123437332,-1127274631,-1127142758)+W(2,-1127410563,-1105350472,1052174871,-1097063130)+W(3,-1157154125,1029744370,-1133421881,1031896001)+W(4,-1133847817,1023881724,1044599155,-1106094805)+W(5,1059986787,-1111846084,1028497368,-1111750394)+W(6,-1150652997,-1121646209,-1123898264,1019540966)+W(7,-1101447493,-1113752268,-1115689394,-1144497399);WS(1047538944,-1094881626);
	sum1=W(0,-1131292909,-1116924690,-1112297452,1021777101)+W(1,1043477817,-1116873677,-1148100662,-1142312694)+W(2,1026526343,1015768341,1061821276,1006944475)+W(3,-1091685625,1042550748,-1112344306,1025260793)+W(4,-1137367995,1040643394,-1088680894,-1090839121)+W(5,1059324523,-1162815447,1036475455,1009991259)+W(6,-1137761291,-1105713526,1031500559,-1122499811)+W(7,-1107169411,-1119456201,998501030,1032218389);sum2=W(0,1018368946,1027383442,1026347909,-1120907217)+W(1,-1113638165,1015876554,-1121952605,-1157376536)+W(2,-1112001321,-1114299623,-1159080892,1048017951)+W(3,1043117803,-1117678872,1016312397,-1122492527)+W(4,-1120361628,-1113414147,-1114902877,1047229175)+W(5,1034197636,-1153448320,1030999359,-1146986041)+W(6,-1136144308,995591994,-1130300135,-1113455406)+W(7,-1104824263,-1135559770,-1116260909,1024817261);WS(1059019584,-1093542352);
	sum1=W(0,-1118590060,1036739212,-1117950862,1044992135)+W(1,1031932973,-1157350427,1018600951,-1135788111)+W(2,1030085820,-1117660736,1053611807,-1088498407)+W(3,-1106481599,1041316489,1033416637,1042914684)+W(4,1044414089,1037660574,1035930184,-1087395836)+W(5,1044296603,-1101366685,-1113146202,-1105147443)+W(6,-1139295455,1017695255,-1132182919,1041445842)+W(7,-1162575911,1028651518,1029799946,1024137952);sum2=W(0,-1139124704,-1129149604,-1112674264,1041796064)+W(1,1023328190,983636161,-1131439188,968306692)+W(2,-1098733365,-1096002059,-1099326395,1042574015)+W(3,993486752,1013026008,-1121650464,1025526661)+W(4,-1134878408,-1139933424,1006823136,1054885382)+W(5,1040771663,1012616072,-1119789204,1007743024)+W(6,1017748092,-1120672660,1007868832,1038924927)+W(7,-1118903044,-1117420588,1032346590,1016029412);WS(1034201600,1032755867);
	sum1=W(0,-1153568391,1027758260,-1120836106,-1106713574)+W(1,-1110497539,-1113115007,-1129181937,-1106649828)+W(2,-1096012775,-1105013167,-1096428191,1052356477)+W(3,1040996254,1046162344,1026611286,1046578147)+W(4,1054286804,1040809774,1052819554,1045456334)+W(5,-1104715738,-1106901340,-1119554608,-1111616164)+W(6,-1151613767,-1113241540,-1109787424,-1103823871)+W(7,-1140335480,-1136669162,-1129950605,1018423993);sum2=W(0,-1116195452,-1114916062,1015539387,1031939547)+W(1,1004500534,1002967134,-1116253852,1037899637)+W(2,1046553581,1044137813,1039450853,-1081686100)+W(3,-1106570618,1023858175,1032662783,1018521363)+W(4,1060291180,1067697792,1056432615,-1075409426)+W(5,-1100622921,1018449047,1002080710,-1106597825)+W(6,-1133268119,1023665145,1037512606,1033868463)+W(7,1015733077,-1120650920,1016550645,1008358731);WS(-1092032128,-1114982082);
	sum1=W(0,1022785838,1030256707,1019093490,-1129380878)+W(1,-1136259347,-1112386231,-1119087591,-1105547264)+W(2,-1092594901,-1096516325,-1091986421,1046024022)+W(3,-1122621159,1047446468,983613607,1044817638)+W(4,1053421570,1038780564,1047196191,1055287349)+W(5,-1127922606,-1103792760,-1127804734,-1107803612)+W(6,-1131318086,-1117764855,-1114799192,-1136363407)+W(7,-1144800614,1031400745,-1141783466,1035179430);sum2=W(0,1041280609,-1122718101,1032208518,-1105883428)+W(1,1032385022,-1105712369,1026423073,-1100029914)+W(2,-1101864626,-1105911709,-1098031958,1058683727)+W(3,-1120084233,1049511237,-1101782173,1048360263)+W(4,-1094055741,-1103824921,-1096453130,1064792422)+W(5,1036982526,1028614917,1024411853,1045846387)+W(6,1033694830,-1107222411,-1124818562,-1108861898)+W(7,-1126293810,-1108778587,1022233154,-1104838815);WS(-1109129728,1010433912);
	sum1=W(0,-1117250164,1006908285,-1122855062,-1107144297)+W(1,-1106683568,-1123315850,-1130212999,-1125685047)+W(2,-1096823624,-1105899410,-1092542200,1057728383)+W(3,1037050434,1026000812,-1117617698,-1122267030)+W(4,1040646763,1019351431,1052048931,1064635860)+W(5,-1117087348,-1107858814,-1107016783,-1100117973)+W(6,1019407999,-1137630799,-1109418342,-1105008732)+W(7,-1114857797,1029923270,-1137382471,1034575732);sum2=W(0,-1153548328,-1146428548,-1122720334,-1131960189)+W(1,-1105417557,-1140382642,-1130524097,1025793768)+W(2,-1138461074,1040260969,1050908092,1057542522)+W(3,1046314824,-1105004761,1024281381,-1110366356)+W(4,-1109953492,-1109276610,-1119113122,-1109440842)+W(5,1008998438,-1140136790,-1119699464,-1135544654)+W(6,970383811,1016706951,-1113772244,-1149783528)+W(7,-1111645386,-1114961145,-1128062487,-1113390177);WS(1028043776,1066748487);
	sum1=W(0,1020869188,1029235758,-1130366216,1035504777)+W(1,1043701316,1028701624,-1140377801,-1122144394)+W(2,1042153037,-1142684082,1055996350,1053860476)+W(3,-1085695847,-1103910983,-1112356264,-1125763849)+W(4,-1114798157,-1109061593,-1084468040,1054127718)+W(5,1050138268,-1111428405,-1142788434,-1122964802)+W(6,-1111756535,1025123714,1039957533,1020063133)+W(7,1020852591,1027291444,1023500800,-1137256281);sum2=W(0,-1124029698,924100096,-1114278109,-1110737625)+W(1,-1113250169,-1121059730,998717971,-1125884533)+W(2,-1129530165,-1119644642,-1119677450,1050522694)+W(3,1031715210,-1121636434,-1145009875,-1119348450)+W(4,-1125964837,1007880106,1030663674,1051750384)+W(5,-1120664914,-1117515026,-1122454562,1010693450)+W(6,1021970837,-1133743274,-1118803866,-1114387111)+W(7,999385235,1025411170,1019195093,-1127692741);WS(1060837696,-1133947077);
	sum1=W(0,-1111653883,1028161858,1026751705,1035200691)+W(1,1000443428,-1124636570,-1153569903,1010162044)+W(2,1043511426,-1107876293,1032976162,-1100826286)+W(3,1046154066,-1109841015,1028652293,-1123706233)+W(4,1035524535,1015032078,1051427819,-1104551490)+W(5,1014718172,-1105048272,-1150803951,-1122173975)+W(6,-1102491073,-1120891991,-1107214884,-1125941943)+W(7,1038586510,1029969865,1023653077,990755503);sum2=W(0,-1109148006,1027230711,-1141349815,-1115012616)+W(1,1025861327,-1129789352,1018453676,1031045509)+W(2,-1124907300,-1130116966,-1099589874,1033368851)+W(3,-1097709653,1048790586,-1111271581,1042673858)+W(4,-1092637531,-1092832201,-1085994041,1040685020)+W(5,1063174823,1056989663,1049450817,1044673285)+W(6,1058387135,1052271642,1062146597,1019043320)+W(7,-1085821967,-1089224415,-1100831168,-1096709646);WS(1052991104,1024635730);
	sum1=W(0,1035832004,-1113667962,-1115665493,-1099876558)+W(1,-1124670698,-1123144798,-1141396670,991927035)+W(2,1054985227,1053766219,1046292645,-1128304655)+W(3,-1115760280,1032906080,1011324759,1032830229)+W(4,-1101014640,1027437528,-1097461637,-1148766910)+W(5,-1103841730,1048476772,1034147624,1048946541)+W(6,-1119430356,-1121298600,1029858016,-1098528437)+W(7,1026860541,-1107490221,-1114702739,-1098098175);sum2=W(0,1023525971,-1123155104,1037524511,-1119336486)+W(1,-1120201684,-1140931614,1025256785,-1116496860)+W(2,-1101540780,-1081244300,-1094597742,1068940029)+W(3,1051860638,998725346,1002156586,1038812729)+W(4,-1109590196,-1107189914,1026840221,1038949441)+W(5,1014639773,-1110977051,-1117345859,1033886084)+W(6,-1124206084,989815561,979200786,1039597181)+W(7,-1126284432,-1128575576,-1123250336,-1117282785);WS(-1106197760,-1107941957);
	sum1=W(0,-1126741205,992223587,-1103296147,-1096167611)+W(1,-1103227950,1041994672,-1124973941,1027666259)+W(2,958134964,-1096404880,1050569383,-1089676235)+W(3,1032016157,1020956357,-1180953690,1043412107)+W(4,1042417753,-1114006205,1053212362,-1101748223)+W(5,1057274419,1042030605,1049652990,1052224033)+W(6,-1131232109,-1156891819,-1104768673,-1105076618)+W(7,-1101041056,-1124618361,-1114495652,-1117167007);sum2=W(0,-1114619118,-1149001791,-1110825372,-1090736686)+W(1,-1106216772,1027272732,1033544093,-1120615480)+W(2,1033666378,1045400432,924614016,1063026008)+W(3,-1114127208,-1108719036,1032301903,-1114760302)+W(4,1015708744,-1103940412,-1107881456,1059931802)+W(5,-1107266078,1024735270,-1134995311,1034226031)+W(6,1027002418,-1125963088,-1103385448,-1091159350)+W(7,-1139192735,-1125128312,1019689496,1032462491);WS(-1076602784,-1079939509);
	sum1=W(0,1033209209,-1124683769,1015980198,-1141354248)+W(1,-1106007132,-1114123684,-1121157953,1019464370)+W(2,-1103738752,-1119780485,-1096323000,1042233324)+W(3,1054450248,1052850909,1043529432,1045060053)+W(4,1025390185,1041533536,1052087227,1039917313)+W(5,-1105614956,-1098158311,-1107965437,-1103437636)+W(6,1002177000,-1112424745,-1104846498,-1113895617)+W(7,-1119444855,-1112376802,1021969694,-1109951699);sum2=W(0,1032197744,-1119329897,1026978731,1042368013)+W(1,1034747948,-1109569271,1037031349,-1111213511)+W(2,-1106233686,-1117977933,-1119744119,-1074309068)+W(3,1068607081,1064708176,-1119111329,1041980892)+W(4,-1119285117,1035649904,1046616172,-1080074847)+W(5,1045039448,1043980108,1029320825,1028259198)+W(6,1036373860,-1113988579,-1150690390,-1148379867)+W(7,1031972703,-1113275705,1015848847,1008019670);WS(-1093673600,-1131421273);
	sum1=W(0,-1121371719,-1126420325,1033366837,1021303790)+W(1,-1117842165,1011797877,1021502382,-1131840478)+W(2,-1114120908,-1110871822,-1087025669,-1118558279)+W(3,1056872571,1032969664,1037611499,1040800018)+W(4,1035660544,1021798446,1058317703,1042294182)+W(5,-1088792724,-1114500968,-1111697864,1017988942)+W(6,1009001293,1008740253,-1120291359,1022689127)+W(7,1031810222,-1148303562,-1137856917,-1121301883);sum2=W(0,-1145039688,-1129835426,-1119915157,-1110668832)+W(1,-1111519800,1002833896,-1127947266,1006052904)+W(2,-1114206314,-1119983153,-1121785409,1051729955)+W(3,1012089860,-1118223897,-1130809610,-1123764449)+W(4,-1116540509,-1113040628,-1118504757,1051989643)+W(5,1039755978,1025479957,-1158783904,-1127132522)+W(6,1020565626,1000979816,989230112,-1112437186)+W(7,-1112214518,1015165050,-1128941978,1025956493);WS(1065682080,-1111828541);
	sum1=W(0,1015869752,1017604463,-1112250175,1024786188)+W(1,1036568133,1002255762,-1131800664,982208647)+W(2,-1145885026,-1115077208,1052074397,-1121697500)+W(3,-1086889687,1045248549,-1130857684,1037568127)+W(4,1022264616,1021224792,-1089954536,1047440331)+W(5,1049268572,-1109225970,-1123514660,-1113425822)+W(6,-1126764880,1032942526,1040282413,1035803452)+W(7,-1125683619,1031850711,-1141787602,1017131424);sum2=W(0,-1122978131,1016040732,-1114060649,-1125004872)+W(1,1029971540,1026938249,1017189437,-1124460348)+W(2,1016858600,968811648,1029169324,1051074882)+W(3,1006053609,-1154135582,-1115290499,-1140773838)+W(4,1028741871,1021399769,1032336595,1031746308)+W(5,-1103346234,-1113140779,-1141169189,-1122277912)+W(6,993636865,-1144040913,-1118019503,-1109484363)+W(7,-1124468225,1013417282,-1169769501,-1139883250);WS(1068575136,1057679145);
	sum1=W(0,-1106541599,1008215334,989927934,1042310507)+W(1,1018512183,1040070410,1014261304,1041475113)+W(2,1049880682,1049251178,1026486412,-1095539136)+W(3,-1094672658,-1089191083,-1100618939,-1087252724)+W(4,-1093397815,-1111487207,-1092992340,-1103138323)+W(5,1043830943,1057944056,1044894993,1049811244)+W(6,1052783569,1042509671,1051194971,1040579493)+W(7,1038856114,-1114567880,1025292508,1038361721);sum2=W(0,-1114445084,-1136765855,1039574032,-1113238946)+W(1,1030357662,-1106803932,964162478,-1113028634)+W(2,1053593458,1055007475,-1105638736,-1078800745)+W(3,-1104375874,1059224194,1050059734,1035501186)+W(4,1057823779,1054334485,-1096181786,-1078443122)+W(5,1049857835,1058193036,1043677394,1029634285)+W(6,-1150175899,-1141017037,1042094581,-1134493359)+W(7,1020483059,-1099695416,-1118569338,-1110238952);WS(-1069843280,1043992756);
	sum1=W(0,-1124948267,-1135429253,1025550072,1025838726)+W(1,1019242118,-1116233196,998797102,-1130610171)+W(2,1027695014,-1119099178,1044103833,-1113789227)+W(3,1039477491,1024839950,-1142719774,1028120504)+W(4,-1108770183,1017935435,-1112757821,-1130965835)+W(5,1042243413,-1101790135,1012540023,-1106167085)+W(6,1008956039,-1129507307,1030807982,1014849865)+W(7,-1114625158,1035190516,-1127852007,1023573770);sum2=W(0,-1114838118,-1121247640,-1095359738,-1072953064)+W(1,-1093135708,-1115141896,-1116140314,-1127503160)+W(2,1026300352,1028491168,1053083344,1074653957)+W(3,1056568596,1033233928,1030713448,1023653964)+W(4,1004928481,-1130258048,1024432884,-1102013621)+W(5,1030571276,-1116002270,1015669456,-1129660856)+W(6,-1130791968,-1127851536,1025789396,1030571860)+W(7,984097412,1025870428,-1120604784,1016702232);WS(1066802848,-1129257078);
	sum1=W(0,1015630667,-1118978065,-1113784260,-1101616805)+W(1,-1108037466,-1114908350,-1114956027,-1111947911)+W(2,1033473243,-1155453851,1035395194,1065736411)+W(3,1045542397,1040181775,-1177594330,1036229652)+W(4,-1104672775,-1122431286,-1115117829,1061324843)+W(5,-1100789945,-1114134583,-1124148059,-1138173719)+W(6,-1114728473,-1121467910,-1105320751,-1095556296)+W(7,-1104703871,-1109993148,-1111474306,-1106051686);sum2=W(0,-1109560646,-1134031950,-1107125821,1017238679)+W(1,1024343484,-1127256871,1004378333,-1129735047)+W(2,-1155123513,-1108713026,1038996664,1026897780)+W(3,-1107646918,-1107869542,-1112902766,-1145442397)+W(4,1035199782,-1107664082,1043157052,1051508948)+W(5,1055083262,998755997,-1159444594,1012570830)+W(6,-1115008786,1019412439,-1123597732,1016515095)+W(7,-1106563795,-1116358964,-1117600772,-1110777694);WS(-1093453440,1062530498);
	sum1=W(0,-1124930739,1018166794,-1109529502,-1114300581)+W(1,1025096231,1023247327,998443854,-1125424515)+W(2,-1115495349,-1109318263,1024699176,1040214918)+W(3,-1105577322,1043329716,-1123543752,1034740398)+W(4,1025637074,1039727605,931786146,1052285453)+W(5,1009762919,-1105534248,988548151,-1116356474)+W(6,1023868966,1023563962,-1131885027,-1104984446)+W(7,-1110072888,-1137647791,-1123805240,1018092315);sum2=W(0,-1116378324,-1110334365,-1139723269,-1134041225)+W(1,-1147091114,-1112237914,-1123080609,-1131603942)+W(2,1018118074,-1135013993,-1117515615,-1097345050)+W(3,1039717826,-1107830137,1032288465,978891919)+W(4,1027066059,1002595554,1053899571,1043336959)+W(5,1040668505,1010598309,1016807738,1026333875)+W(6,-1110082211,-1111471528,-1114430561,1040454031)+W(7,1033656482,-1117546906,-1115822981,-1119917138);WS(1067735712,-1080534052);
	return clamp(mstd0 + 5.0 * vsum / wsum * mstd1, 0.0, 1.0);
}

void main()
{
	FragColor = vec4(nnedi3(0), 1.0, 1.0, 1.0);
} 
#endif
