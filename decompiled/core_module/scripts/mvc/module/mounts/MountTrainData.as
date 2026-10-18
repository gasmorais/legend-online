package mvc.module.mounts
{
   import yishi.manager.TempleteManager;
   
   public class MountTrainData
   {
      
      public var mountFoodTemplateId:int = 208017;
      
      public var advanceTrainCount:int = 50;
      
      public function MountTrainData()
      {
         super();
      }
      
      public function get advanceTrainPoint() : int
      {
         return advanceTrainCount * trainPoint;
      }
      
      public function get trainPoint() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("Mount_Point").ConfigValue);
      }
   }
}

