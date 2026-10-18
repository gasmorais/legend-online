package fish.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.TimeDownBitmapView;
   
   public class FishHelpFrame extends Frame
   {
      
      private var _back:Bitmap;
      
      private var _CDTxt:Bitmap;
      
      private var _time:TimeDownBitmapView;
      
      private var _worldBtn:SelectedButton;
      
      private var _consortiaBtn:SelectedButton;
      
      private var _pointBtn:SelectedButton;
      
      private var _apos:String = "&apos;";
      
      public function FishHelpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("fish.FishHelpFrame.title");
         _back = ComponentFactory.Instance.creatBitmap("asset.fish.FishHelpFrameBack");
         _CDTxt = ComponentFactory.Instance.creatBitmap("asset.fish.FishHelpFrameCDTxt");
         _time = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpFrame.time");
         _worldBtn = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpFrame.worldBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpFrame.consortiaBtn");
         _pointBtn = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpFrame.pointBtn");
         addToContent(_back);
         addToContent(_CDTxt);
         addToContent(_time);
         addToContent(_worldBtn);
         addToContent(_consortiaBtn);
         addToContent(_pointBtn);
      }
      
      private function addEvent() : void
      {
         _time.addEventListener("timerDown_complete",__completeHandler);
         addEventListener("response",__frameResponseHandler);
         _worldBtn.addEventListener("click",__worldHandler);
         _consortiaBtn.addEventListener("click",__consortiaHandler);
         _pointBtn.addEventListener("click",__pointHandler);
      }
      
      private function __worldHandler(param1:MouseEvent) : void
      {
         chatHelp(2);
      }
      
      private function __consortiaHandler(param1:MouseEvent) : void
      {
         chatHelp(3);
      }
      
      private function __pointHandler(param1:MouseEvent) : void
      {
         if(model.playerList.length == 3)
         {
            return;
         }
         var _loc4_:int = (3 - model.playerList.length) * 5;
         SimpleAlertHelper.instance.data = [payCallBack,_loc4_];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("fish.FishHelp.content",_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"FUNCTION_ALERT",0,"",null,"SimpleStyle",_loc4_);
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            model.isPointHelp = true;
            model.pointHelp();
         }
      }
      
      private function chatHelp(param1:int) : void
      {
         FishManager.instance.fishAction(7,[param1]);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_worldBtn)
         {
            _worldBtn.removeEventListener("click",__worldHandler);
         }
         if(_consortiaBtn)
         {
            _consortiaBtn.removeEventListener("click",__consortiaHandler);
         }
         if(_pointBtn)
         {
            _pointBtn.removeEventListener("click",__pointHandler);
         }
         if(_time)
         {
            _time.removeEventListener("timerDown_complete",__completeHandler);
         }
      }
      
      private function __completeHandler(param1:Event) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function timeNum(param1:int) : void
      {
         _time.timeCount = param1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function transferredApos(param1:String) : String
      {
         return StringHelper.replaceStr(param1,"\'",_apos);
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_CDTxt);
         _CDTxt = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_worldBtn);
         _worldBtn = null;
         ObjectUtils.disposeObject(_consortiaBtn);
         _consortiaBtn = null;
         ObjectUtils.disposeObject(_pointBtn);
         _pointBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

