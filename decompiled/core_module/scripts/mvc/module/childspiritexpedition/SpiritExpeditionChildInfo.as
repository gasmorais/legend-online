package mvc.module.childspiritexpedition
{
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PlayerManager;
   
   public class SpiritExpeditionChildInfo
   {
      
      public var childId:int;
      
      public var energy:int;
      
      public var pos:int;
      
      public var skills:String;
      
      public var cdTime:Date;
      
      public var sort:int;
      
      public function SpiritExpeditionChildInfo()
      {
         super();
      }
      
      public function get childData() : ChildData
      {
         return ChildManager.instance.model.getChildById(childId);
      }
      
      public function get childTemp() : ChildTempInfo
      {
         if(!childData)
         {
            return null;
         }
         return childData.childTempInfo;
      }
      
      public function get leftCount() : int
      {
         if(!cdTime)
         {
            return 0;
         }
         return (cdTime.time - playerModel.sysCurtime.time) / 1000;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

