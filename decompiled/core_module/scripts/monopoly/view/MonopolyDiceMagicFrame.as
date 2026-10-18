package monopoly.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import yishi.keyboard.KeyBoardRegister;
   
   public class MonopolyDiceMagicFrame extends Frame
   {
      
      private var _contentBg:Image;
      
      private var _diceSelectBg1:Image;
      
      private var _diceSelectBg2:Image;
      
      private var _diceSelectBg3:Image;
      
      private var _diceSelectBg4:Image;
      
      private var _diceSelectBg5:Image;
      
      private var _diceSelectBg6:Image;
      
      private var _diceBtn1:BaseButton;
      
      private var _diceBtn2:BaseButton;
      
      private var _diceBtn3:BaseButton;
      
      private var _diceBtn4:BaseButton;
      
      private var _diceBtn5:BaseButton;
      
      private var _diceBtn6:BaseButton;
      
      private var _btn2bg:Dictionary;
      
      public function MonopolyDiceMagicFrame()
      {
         super();
         _btn2bg = new Dictionary();
         initView();
         addEvent();
         hideSelectBg();
      }
      
      override public function get groups() : Array
      {
         return ["POPUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("monopoly.view.MonopolyDiceMagicFrame.TitleTxt");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.ContentBg");
         _diceSelectBg1 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg1");
         _diceSelectBg2 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg2");
         _diceSelectBg3 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg3");
         _diceSelectBg4 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg4");
         _diceSelectBg5 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg5");
         _diceSelectBg6 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicBtn.DiceSelectBg6");
         _diceBtn1 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn1");
         _diceBtn2 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn2");
         _diceBtn3 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn3");
         _diceBtn4 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn4");
         _diceBtn5 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn5");
         _diceBtn6 = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyDiceMagicFrame.DiceBtn6");
         addToContent(_contentBg);
         addToContent(_diceSelectBg1);
         addToContent(_diceSelectBg2);
         addToContent(_diceSelectBg3);
         addToContent(_diceSelectBg4);
         addToContent(_diceSelectBg5);
         addToContent(_diceSelectBg6);
         addToContent(_diceBtn1);
         addToContent(_diceBtn2);
         addToContent(_diceBtn3);
         addToContent(_diceBtn4);
         addToContent(_diceBtn5);
         addToContent(_diceBtn6);
         _btn2bg[_diceBtn1] = _diceSelectBg1;
         _btn2bg[_diceBtn2] = _diceSelectBg2;
         _btn2bg[_diceBtn3] = _diceSelectBg3;
         _btn2bg[_diceBtn4] = _diceSelectBg4;
         _btn2bg[_diceBtn5] = _diceSelectBg5;
         _btn2bg[_diceBtn6] = _diceSelectBg6;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_diceSelectBg1);
         _diceSelectBg1 = null;
         ObjectUtils.disposeObject(_diceSelectBg2);
         _diceSelectBg2 = null;
         ObjectUtils.disposeObject(_diceSelectBg3);
         _diceSelectBg3 = null;
         ObjectUtils.disposeObject(_diceSelectBg4);
         _diceSelectBg4 = null;
         ObjectUtils.disposeObject(_diceSelectBg5);
         _diceSelectBg5 = null;
         ObjectUtils.disposeObject(_diceSelectBg6);
         _diceSelectBg6 = null;
         ObjectUtils.disposeObject(_diceBtn1);
         _diceBtn1 = null;
         ObjectUtils.disposeObject(_diceBtn2);
         _diceBtn2 = null;
         ObjectUtils.disposeObject(_diceBtn3);
         _diceBtn3 = null;
         ObjectUtils.disposeObject(_diceBtn4);
         _diceBtn4 = null;
         ObjectUtils.disposeObject(_diceBtn5);
         _diceBtn5 = null;
         ObjectUtils.disposeObject(_diceBtn6);
         _diceBtn6 = null;
         ObjectUtils.disposeAllChildren(this);
         _btn2bg = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _diceBtn1.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn2.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn3.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn4.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn5.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn6.addEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn1.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn2.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn3.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn4.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn5.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn6.addEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn1.addEventListener("click",__diceBtnClickHandler);
         _diceBtn2.addEventListener("click",__diceBtnClickHandler);
         _diceBtn3.addEventListener("click",__diceBtnClickHandler);
         _diceBtn4.addEventListener("click",__diceBtnClickHandler);
         _diceBtn5.addEventListener("click",__diceBtnClickHandler);
         _diceBtn6.addEventListener("click",__diceBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _diceBtn1.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn2.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn3.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn4.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn5.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn6.removeEventListener("rollOver",__diceBtnRollOverHandler);
         _diceBtn1.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn2.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn3.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn4.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn5.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn6.removeEventListener("rollOut",__diceBtnRollOutHandler);
         _diceBtn1.removeEventListener("click",__diceBtnClickHandler);
         _diceBtn2.removeEventListener("click",__diceBtnClickHandler);
         _diceBtn3.removeEventListener("click",__diceBtnClickHandler);
         _diceBtn4.removeEventListener("click",__diceBtnClickHandler);
         _diceBtn5.removeEventListener("click",__diceBtnClickHandler);
         _diceBtn6.removeEventListener("click",__diceBtnClickHandler);
      }
      
      private function hideSelectBg() : void
      {
         _diceSelectBg1.visible = false;
         _diceSelectBg2.visible = false;
         _diceSelectBg3.visible = false;
         _diceSelectBg4.visible = false;
         _diceSelectBg5.visible = false;
         _diceSelectBg6.visible = false;
      }
      
      private function __diceBtnRollOverHandler(param1:MouseEvent) : void
      {
         hideSelectBg();
         if(_btn2bg[param1.target])
         {
            _btn2bg[param1.target].visible = true;
         }
      }
      
      private function __diceBtnRollOutHandler(param1:MouseEvent) : void
      {
         hideSelectBg();
      }
      
      private function __diceBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 1;
         switch(param1.target)
         {
            case _diceBtn1:
               _loc2_ = 1;
               break;
            case _diceBtn2:
               _loc2_ = 2;
               break;
            case _diceBtn3:
               _loc2_ = 3;
               break;
            case _diceBtn4:
               _loc2_ = 4;
               break;
            case _diceBtn5:
               _loc2_ = 5;
               break;
            case _diceBtn6:
               _loc2_ = 6;
         }
         MonopolySocketOutManager.sendRollDice(1,_loc2_);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

