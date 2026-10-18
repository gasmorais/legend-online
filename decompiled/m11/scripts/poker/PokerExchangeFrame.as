package poker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PokerExchangeFrame extends Frame
   {
      
      private var _point:int;
      
      private var _bg:DisplayObject;
      
      private var _confirmBtn:BaseButton;
      
      private var _cancelBtn:BaseButton;
      
      private var _exchangeNote1:FilterFrameText;
      
      private var _exchangeNote2:FilterFrameText;
      
      private var _exchangeTxtBg1:DisplayObject;
      
      private var _exchangeTxtBg2:DisplayObject;
      
      private var _exchangeTxt1:FilterFrameText;
      
      private var _exchangeTxt2:FilterFrameText;
      
      private var _chipIcon:Image;
      
      private var _pointIcon:Image;
      
      public function PokerExchangeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,340,400);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("poker.PokerExchangeFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("poker.PokerExchangeBack");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("poker.view.confirmStyle");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("poker.view.cancelStyle");
         _exchangeNote1 = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeNote");
         _exchangeNote2 = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeNote");
         _exchangeTxtBg1 = ComponentFactory.Instance.creatComponentByStylename("poker.Inputback");
         _exchangeTxtBg2 = ComponentFactory.Instance.creatComponentByStylename("poker.Inputback");
         _exchangeTxt1 = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeTxt1");
         _exchangeTxt2 = ComponentFactory.Instance.creatComponentByStylename("poker.exchangeTxt2");
         _chipIcon = ComponentFactory.Instance.creatComponentByStylename("poker.chipIcon");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("poker.pointImg");
         addToContent(_bg);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_exchangeNote1);
         addToContent(_exchangeNote2);
         _exchangeNote2.y = 66;
         addToContent(_exchangeTxtBg1);
         addToContent(_exchangeTxt1);
         addToContent(_exchangeTxt2);
         addToContent(_chipIcon);
         addToContent(_pointIcon);
         _exchangeTxt1.maxChars = 6;
         StageReferance.stage.focus = _exchangeTxt1;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _exchangeTxt1.addEventListener("keyDown",__keydownHandler);
         _exchangeTxt1.addEventListener("change",__textChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _exchangeTxt1.removeEventListener("keyDown",__keydownHandler);
         _exchangeTxt1.removeEventListener("change",__textChangHandler);
      }
      
      private function refreshView() : void
      {
         _exchangeNote1.text = LanguageMgr.GetTranslation("poker.PokerExchangeFrame.exchangeNote1");
         _exchangeNote2.text = LanguageMgr.GetTranslation("poker.PokerExchangeFrame.exchangeNote2");
         _exchangeTxt1.text = _point + "";
         _exchangeTxt2.text = _point + "";
      }
      
      private function __confirmHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:int = int(_exchangeTxt2.text);
         if(_loc5_ == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poker.PokerExchangeFrame.nopoint"));
            return;
         }
         if(_loc5_ > playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         SimpleAlertHelper.instance.data = [confirmBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("poker.PokerExchangeFrame.exchangeTip");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,true,true,false);
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = int(_exchangeTxt2.text);
            PokerManager.instance.RequestPoker(1,_loc3_);
            dispose();
         }
      }
      
      private function __cancelHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         _exchangeTxt2.text = _exchangeTxt1.text;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object = null) : void
      {
         _point = param1 as int;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_exchangeNote1);
         _exchangeNote1 = null;
         ObjectUtils.disposeObject(_exchangeNote2);
         _exchangeNote2 = null;
         ObjectUtils.disposeObject(_exchangeTxtBg1);
         _exchangeTxtBg1 = null;
         ObjectUtils.disposeObject(_exchangeTxtBg2);
         _exchangeTxtBg2 = null;
         ObjectUtils.disposeObject(_exchangeTxt1);
         _exchangeTxt1 = null;
         ObjectUtils.disposeObject(_exchangeTxt2);
         _exchangeTxt2 = null;
         ObjectUtils.disposeObject(_chipIcon);
         _chipIcon = null;
         ObjectUtils.disposeObject(_pointIcon);
         _pointIcon = null;
         super.dispose();
      }
   }
}

