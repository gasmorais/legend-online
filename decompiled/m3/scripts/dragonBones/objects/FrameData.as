package dragonBones.objects
{
   import flash.geom.ColorTransform;
   
   public final class FrameData
   {
      
      public var duration:Number;
      
      public var tweenEasing:Number;
      
      public var tweenRotate:int;
      
      public var displayIndex:int;
      
      public var movement:String;
      
      public var visible:Boolean;
      
      public var event:String;
      
      public var sound:String;
      
      public var soundEffect:String;
      
      public var node:BoneTransform;
      
      public var colorTransform:ColorTransform;
      
      public var filterArr:Array;
      
      public var filterAbleArr:Array;
      
      public var label:String;
      
      public var blendMode:String;
      
      public function FrameData()
      {
         super();
         this.duration = 0;
         this.tweenEasing = 0;
         this.node = new BoneTransform();
         this.colorTransform = new ColorTransform();
      }
   }
}

