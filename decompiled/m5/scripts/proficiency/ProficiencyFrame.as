package proficiency
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.proficiency.ProficiencyModel;
   import proficiency.item.ProficiencyPropItem;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ProficiencyManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ProficiencyFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _layerText:FilterFrameText;
      
      private var _curItem:ProficiencyPropItem;
      
      private var _nextItem:ProficiencyPropItem;
      
      private var _maxBg:Bitmap;
      
      private var _maxText:FilterFrameText;
      
      private var _proficiencyValueText:FilterFrameText;
      
      private var _practiceBtn:IconButton;
      
      private var _exchangeBtn:IconButton;
      
      private var _layerMc:MovieClip;
      
      private var _ballMcView:ProficiencyGradeMcView;
      
      private var isFirst:Boolean = true;
      
      private var preGrade:int;
      
      private var preLayer:int;
      
      public function ProficiencyFrame()
      {
         super();
         initView();
         addEvent();
         ProficiencyManager.instance.sendProficiencyRequest(0);
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,755,565);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.back");
         _layerText = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.layerText");
         _curItem = ComponentFactory.Instance.creatCustomObject("ProficiencyFrame.curItem",[1]);
         _nextItem = ComponentFactory.Instance.creatCustomObject("ProficiencyFrame.nextItem",[2]);
         _proficiencyValueText = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.proficiencyValueText");
         _maxBg = ComponentFactory.Instance.creatBitmap("asset.ProficiencyFrame.maxBg");
         _maxText = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.maxText");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.exchangeBtn");
         _practiceBtn = ComponentFactory.Instance.creatComponentByStylename("ProficiencyFrame.practiceBtn");
         _layerMc = ComponentFactory.Instance.creatCustomObject("ProficiencyFrame.layerMc");
         _ballMcView = ComponentFactory.Instance.creatCustomObject("ProficiencyFrame.ballMcView");
         addToContent(_back);
         addToContent(_ballMcView);
         addToContent(_layerMc);
         addToContent(_layerText);
         addToContent(_curItem);
         addToContent(_nextItem);
         addToContent(_maxBg);
         addToContent(_maxText);
         addToContent(_proficiencyValueText);
         addToContent(_exchangeBtn);
         addToContent(_practiceBtn);
         _layerMc.mouseChildren = _layerMc.mouseEnabled = false;
         _layerMc.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _exchangeBtn.addEventListener("click",__exchangeBtnClickHandler);
         _practiceBtn.addEventListener("click",__practiceBtnClickHandler);
         MsgMan.addObserver("PROFICIENCY_INFO_UPDATE",this,__updateProficiencyView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",__exchangeBtnClickHandler);
         }
         if(_practiceBtn)
         {
            _practiceBtn.removeEventListener("click",__practiceBtnClickHandler);
         }
         MsgMan.removeObserver("PROFICIENCY_INFO_UPDATE",this,__updateProficiencyView);
      }
      
      private function __exchangeBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("proficiency","EXCHANGE_FRAME");
      }
      
      private function __practiceBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.nextTempInfo && model.proficiencyValue < model.nextTempInfo.Exp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("proficiency.practice.noValueAlert"));
            return;
         }
         ProficiencyManager.instance.sendProficiencyRequest(2);
      }
      
      private function __updateProficiencyView(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(model.nextTempInfo)
         {
            _practiceBtn.enable = true;
            _maxBg.visible = false;
            _maxText.text = "";
            _nextItem.visible = true;
            _nextItem.setPropView(model.nextTempInfo);
            if(model.proficiencyValue < model.nextTempInfo.Exp)
            {
               _proficiencyValueText.htmlText = "<font color=\'#ff0000\'>" + model.proficiencyValue + "</font>" + "/" + model.nextTempInfo.Exp;
            }
            else
            {
               _proficiencyValueText.htmlText = model.proficiencyValue + "/" + model.nextTempInfo.Exp;
            }
         }
         else
         {
            _practiceBtn.enable = false;
            _maxBg.visible = true;
            _maxText.text = LanguageMgr.GetTranslation("ProficiencyFrame.maxText.text");
            _nextItem.visible = false;
            _proficiencyValueText.htmlText = model.proficiencyValue + "/0";
         }
         _curItem.setPropView(model.proficiencyTempInfo);
         _layerText.text = model.proficiencyTempInfo.Layer + "";
         if((model.proficiencyGrade + 1) % 7 == 0)
         {
            _practiceBtn.iconStyle = "asset.ProficiencyFrame.practiceBtn.icon2";
            _practiceBtn.iconInnerRectString = "53,49,13,21,13";
         }
         else
         {
            _practiceBtn.iconStyle = "asset.ProficiencyFrame.practiceBtn.icon";
            _practiceBtn.iconInnerRectString = "53,50,13,22,13";
         }
         if(!isFirst)
         {
            if(preGrade != model.proficiencyGrade)
            {
               _ballMcView.refreshView();
            }
            if(preLayer != model.proficiencyTempInfo.Layer)
            {
               _layerMc.gotoAndPlay(1);
            }
         }
         else
         {
            _ballMcView.initBallView();
         }
         isFirst = false;
         preLayer = model.proficiencyTempInfo.Layer;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("DragonTalkerProficiencyFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get model() : ProficiencyModel
      {
         return ProficiencyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_layerText);
         _layerText = null;
         ObjectUtils.disposeObject(_proficiencyValueText);
         _proficiencyValueText = null;
         ObjectUtils.disposeObject(_maxBg);
         _maxBg = null;
         ObjectUtils.disposeObject(_maxText);
         _maxText = null;
         ObjectUtils.disposeObject(_curItem);
         _curItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_practiceBtn);
         _practiceBtn = null;
         ObjectUtils.disposeObject(_ballMcView);
         _ballMcView = null;
         ObjectUtils.disposeViolentMc(_layerMc);
         _layerMc = null;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         super.dispose();
      }
   }
}

