package mvc.module.secretary.acts
{
   import farm.FarmManager;
   import farm.FarmModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class FarmAction extends ILitteAction
   {
      
      public function FarmAction()
      {
         super();
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.army.baseHero;
      }
      
      override public function exc() : void
      {
         FarmManager.instance.sendReqAutoPick(25,thane.userId);
         FarmManager.instance.sendReqAutoPick(26,thane.userId);
         isFinish = true;
      }
      
      private function get farmModel() : FarmModel
      {
         return FarmManager.instance.model;
      }
   }
}

