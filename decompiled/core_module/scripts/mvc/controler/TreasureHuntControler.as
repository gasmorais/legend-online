package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.road.yishi.proto.seek.PlayerSeekInfoMsg;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TreasureHuntManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.treasurehunt.HuntPointModel;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureHuntControler extends FrameController
   {
      
      private var _dialogFrame:DisplayObject;
      
      public function TreasureHuntControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 32)
         {
            _loc2_ = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.gotoSeekLimit");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         setPreFrame("magiccard");
      }
      
      override public function get frameClassName() : String
      {
         return "treasurehunt.TreasureHuntFrame";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function sendHuntRequest(param1:int) : void
      {
      }
      
      public function showDialogFrame() : void
      {
         var _loc1_:HuntPointModel = TreasureHuntManager.instance.model;
         if(_dialogFrame || _loc1_.state == 0)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("hunt.HunterDialogFrame.eventDesc",_loc1_.getNodeByNodeId().nodeName,_loc1_.eventDesc);
         _dialogFrame = ComponentFactory.Instance.creatCustomObject("treasurehunt.HunterDialogFrame");
         _dialogFrame["content"] = _loc2_;
         _dialogFrame["show"](sendHuntRequest);
         _dialogFrame.addEventListener("dispose",__disposeHandler);
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("dispose",__disposeHandler);
         _dialogFrame = null;
      }
      
      public function showAlerFrame() : void
      {
         SimpleAlertHelper.instance.data = [quitBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("hunt.treasurehuntAlert.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,false,true,2,"SIMPLE_ALERT",0,"",null,"treasurehunt.SimpleAlert");
      }
      
      public function closeAlerFrame() : void
      {
         if(_dialogFrame)
         {
            Component(_dialogFrame).dispose();
            _dialogFrame = null;
         }
      }
      
      private function quitBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendHuntRequest(5);
         }
         else if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      public function showExchangeAlerFrame() : void
      {
         SimpleAlertHelper.instance.data = [exchangeResponse];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("hunt.TreasureHuntFrame.exchangeBtnTipData");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,false,false,2);
      }
      
      private function exchangeResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendHuntRequest(6);
         }
      }
   }
}

