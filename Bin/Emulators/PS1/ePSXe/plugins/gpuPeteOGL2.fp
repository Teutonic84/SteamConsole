!!ARBfp1.0

TEMP  color0, color1, color2, color3;

PARAM divFour = { 0.25, 0.25, 0.25, 1.0 };

TEX	color0, fragment.texcoord[ 0 ], texture[ 0 ], 2D;
TEX	color1, fragment.texcoord[ 1 ], texture[ 0 ], 2D;
TEX	color2, fragment.texcoord[ 2 ], texture[ 0 ], 2D;
TEX	color3, fragment.texcoord[ 3 ], texture[ 0 ], 2D;

ADD	color0, color0, color1;
ADD	color2, color2, color3;
ADD	color0, color0, color2;
MUL	result.color, color0, divFour;

END
