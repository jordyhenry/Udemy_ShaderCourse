//Create a shader that takes a texture to use as the albedo colour, 
//but no matter what always turns up the green channel to full. 

Shader "Holistic/02 - Shader Essentials/Challenge2" 
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _MainTex;

			struct Input
			{
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
				o.Albedo.g = 1;
			}
		ENDCG
	}

	Fallback "Diffuse"
}
