Shader "Unlit/Highligt"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="transparent" 
            "RenderQeue" = "transparent"
        }
        
        LOD 100
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
       

            #include "UnityCG.cginc"

            struct mesh_data // per vertex mesh data
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct interpolators
            {
                float2 uv : TEXCOORD0;

                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            interpolators vert (mesh_data v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (interpolators i) : SV_Target // per fragment (pixel) on the screen
            {
                fixed4 col = fixed4(i.uv*2-1, 0, 0);
   
                return col;
            }
            ENDCG
        }
    }
}
