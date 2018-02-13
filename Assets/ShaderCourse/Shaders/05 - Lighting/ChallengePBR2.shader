//Reverse the glossiness effect, so the black areas
//of the map are highly reflective and the grey and white
//much more diffuse.

Shader "Holistic/05 - Lighting/ChallengePBR2" 
{
	Properties {
		_Color("Color", Color) = (1,1,1,1)
		_MetallicTex("Metallic (R)", 2D) = "white" {}
		_SpecColor("Specular Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags{ "Queue" = "Geometry"}

		CGPROGRAM
			#pragma surface surf StandardSpecular

			sampler2D _MetallicTex;
			
			fixed4 _Color;

			struct Input
			{
				float2 uv_MetallicTex;
			};

			void surf(Input IN, inout SurfaceOutputStandardSpecular o)
			{
				o.Albedo = _Color.rgb;
				o.Specular = _SpecColor.rgb;
				o.Smoothness = 0.9 - tex2D(_MetallicTex, IN.uv_MetallicTex).r;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
