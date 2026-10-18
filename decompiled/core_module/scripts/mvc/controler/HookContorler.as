package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.campaign.HangupStateListMsg;
   import com.road.yishi.proto.campaign.HangupStateMsg;
   import manager.LanguageMgr;
   import managers.WorldBossSocketOutManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleDictionary;
   
   public class HookContorler extends FrameController
   {
      
      public var roomState:SimpleDictionary = new SimpleDictionary();
      
      private var _isPreLoadOver:Boolean = false;
      
      public function HookContorler()
      {
         super();
         initEvent();
      }
      
      override protected function get preLoad() : Boolean
      {
         return !_isPreLoadOver;
      }
      
      override protected function startPreLoad() : void
      {
         requestRoomInfo();
      }
      
      private function requestRoomInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(8295);
         SocketSendManager.instance.send(_loc1_);
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4204,__updateRoomState);
      }
      
      private function __updateRoomState(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:HangupStateListMsg = new HangupStateListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as HangupStateListMsg;
         roomState.clear();
         for each(var _loc3_:HangupStateMsg in _loc2_.hangupState)
         {
            roomState.add(_loc3_.campaignId,getStateByCount(_loc3_.curCount,_loc2_.maxCount));
         }
         _isPreLoadOver = true;
         start(_data);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
         _isPreLoadOver = false;
      }
      
      private function getStateByCount(param1:int, param2:int) : String
      {
         if(param1 >= param2 / 2)
         {
            return LanguageMgr.GetTranslation("hook.view.HookItem.capcity");
         }
         return LanguageMgr.GetTranslation("hook.view.HookItem.free");
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "hook.HookFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function openRewardFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("core.HookRewardFrame");
         _loc1_["show"]();
      }
      
      public function sendEnterBattle(param1:CampaignTemplate) : void
      {
         WorldBossSocketOutManager.sendWorldBossCmd(param1.CampaignId);
      }
   }
}

