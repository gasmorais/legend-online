package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.leed.LeadRewardMsg;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class DayGuideController extends FrameController
   {
      
      private static var _instance:DayGuideController;
      
      public var noPlayGoodsMovie:Boolean;
      
      public function DayGuideController()
      {
         super();
      }
      
      public static function get instance() : DayGuideController
      {
         if(!_instance)
         {
            _instance = new DayGuideController();
         }
         return _instance;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == 1)
         {
            return "dayGuide.SignDayFrame";
         }
         return "ActiveLeed.ActiveLeedFrame";
      }
      
      public function sendSign() : void
      {
         var _loc1_:PackageOut = new PackageOut(8266);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendLuckDraw(param1:int) : void
      {
         if(param1 == 1)
         {
            noPlayGoodsMovie = true;
         }
         var _loc3_:PackageOut = new PackageOut(9523);
         var _loc2_:LeadRewardMsg = new LeadRewardMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

