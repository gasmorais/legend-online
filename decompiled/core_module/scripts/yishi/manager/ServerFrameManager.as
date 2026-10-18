package yishi.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.campaign.CampaignNotifyMsg;
   import dialog.DialogControl;
   import dialog.DialogModel;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.view.tips.MessageTipManager;
   
   public class ServerFrameManager
   {
      
      private static var _instance:ServerFrameManager;
      
      public static const NOVICE_FRAME:int = 0;
      
      public static const DIALOG_FRAME:int = 1;
      
      public static const SYSTEM_MESSAGETIPS:int = 2;
      
      public function ServerFrameManager()
      {
         super();
      }
      
      public static function get instance() : ServerFrameManager
      {
         if(!_instance)
         {
            _instance = new ServerFrameManager();
         }
         return _instance;
      }
      
      public function createFrame(param1:PackageIn, param2:Function) : void
      {
         var _loc3_:CampaignNotifyMsg = new CampaignNotifyMsg();
         _loc3_ = param1.readBody(_loc3_) as CampaignNotifyMsg;
         var _loc4_:int = _loc3_.id;
         var _loc6_:String = _loc3_.scene;
         var _loc5_:Array = [_loc3_.body];
         switch(_loc4_)
         {
            case 0:
               param2();
               break;
            case 2:
               MessageTipManager.instance().show(_loc5_[0].toString(),true,param2);
               break;
            case 1:
               throw new Error(LanguageMgr.GetTranslation("yishi.manager.ServerFrameManager.Error"));
         }
      }
      
      private function openDialogFrame(param1:String, param2:DialogModel, param3:Function) : void
      {
         var _loc4_:DialogControl = new DialogControl(param3,StageReferance.stage);
         _loc4_.model = param2;
      }
   }
}

