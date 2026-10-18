package battle.skillsys.mode.framedata
{
   public class HideFrameData implements IFrameData
   {
      
      public var target:int;
      
      public var disappearEffect:String;
      
      public var appearEffect:String;
      
      public var persistentFrame:int;
      
      public function HideFrameData()
      {
         super();
      }
      
      public function getRes() : Array
      {
         return [disappearEffect,appearEffect];
      }
   }
}

