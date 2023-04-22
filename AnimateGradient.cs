using UnityEngine;

public class AnimateGradient : MonoBehaviour {
  [SerializeField] private Material gradientMaterial;
  [SerializeField] private float effectDuration = 20f;

  // Black/Black
  [SerializeField] private Color startTopColour = Color.black;
  [SerializeField] private Color startBottomColour = Color.black;
  // Black/Yellow
  [SerializeField] private Color midTopColour = Color.black;
  [SerializeField] private Color midBottomColour = new (0.90f, 0.81f, 0.54f);
  // White/Blue
  [SerializeField] private Color endTopColour = new (0.73f, 0.93f, 0.95f);
  [SerializeField] private Color endBottomColour = new (0.13f, 0.41f, 0.51f);
  
  void Update() {
    // Taken modulo the effect duration to loop animation.
    float elapsedTime = Time.timeSinceLevelLoad % effectDuration;
    // Each colour change takes 1/4 of the duration.
    float percent = (elapsedTime % (effectDuration / 4)) / (effectDuration / 4);

    // Lerps for each of the four sections
    Color top, bottom;
    if (elapsedTime < (effectDuration / 4)) {
      top = Color.Lerp(startTopColour, midTopColour, percent);
      bottom = Color.Lerp(startBottomColour, midBottomColour, percent);
    } else if (elapsedTime < (effectDuration / 2)) {
      top = Color.Lerp(midTopColour, endTopColour, percent);
      bottom = Color.Lerp(midBottomColour, endBottomColour, percent);
    } else if (elapsedTime  < ((effectDuration * 3) / 4)) {
      top = Color.Lerp(endTopColour, midTopColour, percent);
      bottom = Color.Lerp(endBottomColour, midBottomColour, percent);
    } else {
      top = Color.Lerp(midTopColour, startTopColour, percent);
      bottom = Color.Lerp(midBottomColour, startBottomColour, percent);
    }
    gradientMaterial.SetColor("_TopColour", top);
    gradientMaterial.SetColor("_BottomColour", bottom);
  }
}
