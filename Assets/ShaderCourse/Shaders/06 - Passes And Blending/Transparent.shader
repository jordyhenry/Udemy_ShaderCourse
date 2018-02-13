Shader "Holistic/07 - Passes and Blending/Transparent"
{
	Properties{
		_MainTex("Main Texture", 2D) = "black" {}
	}
	SubShader{
		Tags{ "Queue" = "Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Pass{
			SetTexture [_MainTex] { combine texture }
		}
	}
}