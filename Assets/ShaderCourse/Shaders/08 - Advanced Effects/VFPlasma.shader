//Rewrite the plasma shader as a VF shader instead of a Surface shader

Shader "Holistic/VFPlasma" {
	Properties {
		_Tint("Color Tint", Color) = (1,1,1,1)
		_Speed("Speed", Range(1,100))=10
		_Scale1("Scale 1", Range(0.1,10)) = 2
		_Scale2("Scale 2", Range(0.1,10)) = 2
		_Scale3("Scale 3", Range(0.1,10)) = 2
		_Scale4("Scale 4", Range(0.1,10)) = 2
	}
	SubShader {
		Pass{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				fixed4 _Tint;
				float _Speed;
				float _Scale1;
				float _Scale2;
				float _Scale3;
				float _Scale4;
				
				struct appdata {
					float4 vertex : POSITION;
				};

				struct v2f {
					float4 vertex : SV_POSITION;
				};

				v2f vert (appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target 
				{
					const float PI = 3.14159265;
					float t = _Time.x * _Speed;

					
					float xpos = i.vertex.x * 0.01;
					float ypos = i.vertex.y * 0.01;

					//vertical
					float c = sin(xpos * _Scale1 + t);
					//horizontal
					c+= sin(ypos * _Scale2 + t);
					//diagonal
					c+= sin(_Scale3*(xpos*sin(t/2.0) + ypos*cos(t/3))+t);
					//circular
					float c1 = pow(xpos + 0.5 * sin(t/5),2);
					float c2 = pow(ypos + 0.5 * sin(t/3),2);
					c+= sin(sqrt(_Scale4*(c1+c2)+1+t));

					fixed4 col;	

					col.r = sin(c/4.0 * PI);
					col.g = sin(c/4.0 * PI + 2*PI/4);
					col.b = sin(c/4.0 * PI + 4*PI/4);
					col.rgb *= _Tint;

					return col;
				}
			ENDCG
		}
	}
}
