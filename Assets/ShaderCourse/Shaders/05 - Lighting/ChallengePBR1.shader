//Add an emissive slider that makes the model glow
//in the same areas that are grey and white in the
//metallic gloss map

Shader "Holistic/05 - Lighting/ChallengePBR1" 
{
	Properties {
		_Color("Color", Color) = (1,1,1,1)
		_MetallicTex("Metallic (R)", 2D) = "white" {}
		_SpecColor("Specular Color", Color) = (1,1,1,1)
		_Emission("Emission", Range(0,7)) = 1
	}
	SubShader {
		Tags{ "Queue" = "Geometry"}

		CGPROGRAM
			#pragma surface surf StandardSpecular

			sampler2D _MetallicTex;
			half _Emission;
			
			fixed4 _Color;

			struct Input
			{
				float2 uv_MetallicTex;
			};

			void surf(Input IN, inout SurfaceOutputStandardSpecular o)
			{
				o.Albedo = _Color.rgb;
				o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
				o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r * _Emission;
				o.Specular = _SpecColor.rgb;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
