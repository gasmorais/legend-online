package yishi.view.shadow
{
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class TransformLib
   {
      
      public static var normal:ColorTransform = new ColorTransform();
      
      public static var white_classic:ColorTransform = new ColorTransform(1.3,1.3,1.3,1);
      
      public static var white_high:ColorTransform = new ColorTransform(1.6,1.6,1.6,1);
      
      public static var white_all:ColorTransform = new ColorTransform(2,2,2,1,200,200,200);
      
      public static var black_classic:ColorTransform = new ColorTransform(0.7,0.7,0.7,1);
      
      public static var blue_classic:ColorTransform = new ColorTransform(0,0.5,1,1);
      
      public static var red_classic:ColorTransform = new ColorTransform(1,0.5,0.5,1);
      
      public static var black_all:ColorTransform = new ColorTransform(0,0,0,1);
      
      public static var green_classic:ColorTransform = new ColorTransform(0.5,1.1,0.8,1);
      
      public static var green_glow_filter:GlowFilter = new GlowFilter(52479,1,20,20,1.5,1);
      
      public function TransformLib()
      {
         super();
      }
   }
}

