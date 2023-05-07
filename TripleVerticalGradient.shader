Shader "Unlit/TripleVerticalGradient"
{
    Properties
    {
        _TopColour("Top Gradient Colour: ", Color) = (0.125,0,0.125,1)
        _MiddleColour("Middle Gradient Colour: ", Color) = (0.75,0.75,0.25,1)
        _BottomColour("Bottom Gradient Colour: ", Color) = (0.5,0.125,0,1)
        _MiddlePosition("Location relative to the bottom: ", float) = 0.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // Pass through the UV coordinates.
                o.uv = v.uv;
                return o;
            }

            fixed4 _TopColour;
            fixed4 _MiddleColour;
            fixed4 _BottomColour;
            float _MiddlePosition;

            fixed4 frag (v2f i) : SV_Target
            {
                // IF/ELSE version of the code.
                // Interpolate the colour between each vertex.
                //fixed4 col;
                //if (i.uv.y < _MiddlePosition) {
                //  // E.g., if pos=0.2, maps 0->0, 0.2->1.
                //  col = lerp(_BottomColour, _MiddleColour, i.uv.y / _MiddlePosition);
                //} else {
                //  // E.g., if pos=0.2, maps 0.2->0, 1->1.
                //  col = lerp(_MiddleColour, _TopColour, (i.uv.y - _MiddlePosition) / (1 - _MiddlePosition));
                //}
                //return col;

                // OPTIMISED OUT IF/ELSE version of the code.
                // Which section are we in. 0:Bottom->Middle, 1:Middle->Top
                float is_top = step(_MiddlePosition, i.uv.y);
                // Choose the two colours needed for this section.
                fixed4 col1 = lerp(_BottomColour, _MiddleColour, is_top);
                fixed4 col2 = lerp(_MiddleColour, _TopColour, is_top);
                // Calculate the percentage through this section.
                // is_top=0 => i.uv.y / _MiddlePosition
                // is_top=1 => (i.uv.y - _MiddlePosition) / (1 - _MiddlePosition)
                float percent = (i.uv.y - (is_top * _MiddlePosition)) / 
                                (is_top + (-2 * is_top + 1) * _MiddlePosition);
                // Create the gradient by linearly interpolating between the two colours.
                return lerp(col1, col2, percent);
            }
            ENDCG
        }
    }
}
