package yishi.actions.map
{
   import com.pickgliss.ui.ComponentFactory;
   import manager.LanguageMgr;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class MultiFailedAlertAction extends MapBaseAction
   {
      
      public function MultiFailedAlertAction()
      {
         super();
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         showAlert(startAlertBack);
         dispose();
      }
      
      private function showAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.multiFaildedCheckDate;
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         var _loc6_:Boolean = SharedManager.instance.multiFailded;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("battle.multiFailedAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("Campaign.MultiFailedAlert");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,startAlertBack);
         }
         return _loc2_;
      }
      
      private function startAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.multiFailded = param1;
         SharedManager.instance.multiFaildedCheckDate = new Date();
         SharedManager.instance.saveMultiFailedCheck();
      }
   }
}

