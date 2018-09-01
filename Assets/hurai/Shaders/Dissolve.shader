Shader "Custom/Dissolve"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Main Color", Color) = (1,1,1,1)

		_DissolveTex("Dissolve Tex", 2D) = "white" {}
		_CutOff("CutOff", Range(0, 1)) = 0.0
		_Width("Dissolve Width", float) = 0
		_BurnColor("Burn Color", Color) = (0,0,0,1)
	}
	SubShader
	{
		Tags
		{
			"RenderType"="Transparent"
			"Queue"="Transparent"
		}

		Pass
		{
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#define SMOOTH_SIZE 0.1

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 dissolveUv : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _Color;

			sampler2D _DissolveTex;
			float4 _DissolveTex_ST;

			float _CutOff;
			float _Width;
			fixed4 _BurnColor;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.dissolveUv = TRANSFORM_TEX(v.uv, _DissolveTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 texColor = tex2D(_MainTex, i.uv) * _Color;
				fixed4 col = texColor;
				fixed dissolveEnd = tex2D(_DissolveTex, i.dissolveUv).r - _CutOff;
				fixed burnBegin = dissolveEnd - _Width;

				fixed baseAlpha = smoothstep(0.0, SMOOTH_SIZE, dissolveEnd);
				fixed burnAlpha = smoothstep(0.0, SMOOTH_SIZE, burnBegin);
				col.a *= baseAlpha;

				fixed3 baseColor = texColor.rgb * baseAlpha * burnAlpha;
				fixed3 burnColor = _BurnColor.rgb * (1 - burnAlpha);
				col.rgb = baseColor + burnColor;

				return col;
			}
			ENDCG
		}
	}
}
