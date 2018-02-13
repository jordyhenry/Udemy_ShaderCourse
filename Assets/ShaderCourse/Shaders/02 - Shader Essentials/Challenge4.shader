//1. Write a shader that has two properties; one for a diffuse texture and one for a emissive texture. 
//2. Use the attached images to test with Zombunny. There is one for diffuse and one for emissive. 
//3. Apply the diffuse to the model's albedo and the emissive to the emission. 

//What do you notice happens to the visual result when only a diffuse texture is given and no emissive one? 
//How do you think this is correct? 
//See the solution file attached to find out.

Shader "Holistic/02 - Shader Essentials/Challenge4" 
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		//set this texture to black to stop the white
    //overwhelming the effect if no emission texture
    //is present
		_EmissiveTex("Emissive Texure", 2D) = "black" {}
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _MainTex;
			sampler2D _EmissiveTex;

			struct Input
			{
				float2 uv_MainTex;
				float2 uv_EmissiveTex;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
				o.Emission = tex2D(_EmissiveTex, IN.uv_EmissiveTex).rgb;
			}
		ENDCG
	}

	Fallback "Diffuse"
}
