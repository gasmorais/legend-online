package managers
{
   import com.road.yishi.proto.player.MailCheckMsg;
   import manager.LanguageMgr;
   import mvc.module.mailcheck.MailCheckEvent;
   import mvc.module.mailcheck.MailCheckModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MailCheckManager
   {
      
      private static var _instance:MailCheckManager;
      
      public static const OP_SEND_CHECK_MAIL:int = 1;
      
      public static const OP_SUBMIT:int = 2;
      
      public var currSelectedPage:String = "";
      
      public var currSelectedView:String = "";
      
      public var openFrame:int = 1;
      
      private var firstLoad:Boolean = true;
      
      private var _model:MailCheckModel;
      
      private var _delay:uint;
      
      public function MailCheckManager()
      {
         super();
         if(_model == null)
         {
            _model = new MailCheckModel();
         }
      }
      
      public static function get instance() : MailCheckManager
      {
         if(!_instance)
         {
            _instance = new MailCheckManager();
         }
         return _instance;
      }
      
      public function get model() : MailCheckModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 337,__mailCheckInfoHandler);
      }
      
      public function sendCheckMail(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(9591);
         var _loc2_:MailCheckMsg = new MailCheckMsg();
         _loc2_.op = 1;
         _loc2_.mail = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function submitCheckCode(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9591);
         var _loc3_:MailCheckMsg = new MailCheckMsg();
         _loc3_.op = 2;
         _loc3_.mail = param1;
         _loc3_.pin = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      protected function __mailCheckInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MailCheckMsg = new MailCheckMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MailCheckMsg;
         model.state = _loc2_.state;
         model.mailAddress = _loc2_.mail;
         model.isShow = _loc2_.state != 2;
         var _loc3_:String = SceneManager.instance.currentType;
         if(model.isShow && (_loc3_ == "SPACE_SCENE" || _loc3_ == "CASTLE_SCENE") && (_loc2_.state == 4 || _loc2_.state == 0))
         {
            FrameControllerManager.instance.openControllerByInfo("mailcheck",1);
         }
         NotificationManager.instance.dispatchEvent(new MailCheckEvent("MailCheckEvent.STATE_UPDATE"));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function openDragonTitanFrame() : void
      {
         if(thane.isChangeJob)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01"));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("dragontitan");
         }
      }
   }
}

