package magicspring
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicSpringFrame extends Frame
   {
      
      private var _bufferTimeText:FilterFrameText;
      
      private var _totalBufferText:FilterFrameText;
      
      private var _selectBufferText:FilterFrameText;
      
      private var _potionNeedCountText1:FilterFrameText;
      
      private var _potionNeedCountText2:FilterFrameText;
      
      private var _potionNeedCountText3:FilterFrameText;
      
      private var _potionHasCountText1:FilterFrameText;
      
      private var _potionHasCountText2:FilterFrameText;
      
      private var _potionHasCountText3:FilterFrameText;
      
      private var _potionHasImage1:Image;
      
      private var _potionHasImage2:Image;
      
      private var _potionHasImage3:Image;
      
      private var _potionNeedImage1:ScaleFrameImage;
      
      private var _potionNeedImage2:ScaleFrameImage;
      
      private var _potionNeedImage3:ScaleFrameImage;
      
      private var _border:ScaleBitmapImage;
      
      private var _makeBtn:IconButton;
      
      private var _mBack:MutipleImage;
      
      private var _helpBtn:BaseButton;
      
      private var _springMc:MovieClip;
      
      private var _makeSuccessMc:MovieClip;
      
      private var _selectIcon:BaseIconView;
      
      private var _leftView:MagicSpringFormulaLeftView;
      
      private var _topView:MagicSpringSlotTopView;
      
      private var materialEnough:Boolean = true;
      
      private var isMcPlaying:Boolean = false;
      
      private var endPointArray:Array = [[293,78],[384,78],[475,78],[566,78],[657,78]];
      
      private var newTempId:int;
      
      private var newIcon:BaseIconView;
      
      private var _potionHasImage4:Image;
      
      private var _potionHasImage5:Image;
      
      private var _potionHasImage6:Image;
      
      private var _potionHasCountText4:FilterFrameText;
      
      private var _potionHasCountText5:FilterFrameText;
      
      private var _potionHasCountText6:FilterFrameText;
      
      private var refreshTimeId:int;
      
      private var _preClickTime:Number;
      
      public function MagicSpringFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bufferTimeText = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.bufferTimeText");
         _totalBufferText = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.totalBufferText");
         _selectBufferText = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.selectBufferText");
         _potionHasCountText1 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.greenHasCountText");
         _potionHasCountText2 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.purpleHasCountText");
         _potionHasCountText3 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.redHasCountText");
         _potionNeedCountText1 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.greenNeedCountText");
         _potionNeedCountText2 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.purpleNeedCountText");
         _potionNeedCountText3 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.redNeedCountText");
         _potionHasImage1 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.greenHasImage");
         _potionHasImage2 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.purpleHasImage");
         _potionHasImage3 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.redHasImage");
         _potionNeedImage1 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.NeedImage");
         _potionNeedImage2 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.NeedImage");
         _potionNeedImage3 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.NeedImage");
         _border = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.border");
         _makeBtn = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.makeBtn");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.mBack");
         _selectIcon = ComponentFactory.Instance.creatCustomObject("MagicSpringFrame.selectIcon");
         _springMc = ComponentFactory.Instance.creatCustomObject("MagicSpringFrame.springMc");
         _leftView = ComponentFactory.Instance.creatCustomObject("MagicSpringFrame.leftView");
         _topView = ComponentFactory.Instance.creatCustomObject("MagicSpringFrame.topView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.helpBtn");
         _makeSuccessMc = ComponentFactory.Instance.creatCustomObject("MagicSpringFrame.makeSuccessMc");
         _potionHasImage4 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.dustHasImage");
         _potionHasImage5 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.hornHasImage");
         _potionHasImage6 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.featherHasImage");
         _potionHasCountText4 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.dustHasCountText");
         _potionHasCountText5 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.hornHasCountText");
         _potionHasCountText6 = ComponentFactory.Instance.creatComponentByStylename("MagicSpring.MagicSpringFrame.featherHasCountText");
         addToContent(_border);
         addToContent(_mBack);
         addToContent(_leftView);
         addToContent(_topView);
         addToContent(_springMc);
         addToContent(_makeSuccessMc);
         addToContent(_helpBtn);
         addToContent(_selectIcon);
         addToContent(_selectBufferText);
         addToContent(_totalBufferText);
         addToContent(_potionHasImage1);
         addToContent(_potionHasImage2);
         addToContent(_potionHasImage3);
         addToContent(_potionHasImage4);
         addToContent(_potionHasImage5);
         addToContent(_potionHasImage6);
         addToContent(_potionNeedImage1);
         addToContent(_potionNeedImage2);
         _potionNeedImage2.x = _potionNeedImage1.x + 70;
         addToContent(_potionNeedImage3);
         _potionNeedImage3.x = _potionNeedImage2.x + 70;
         addToContent(_potionHasCountText1);
         addToContent(_potionHasCountText2);
         addToContent(_potionHasCountText3);
         addToContent(_potionHasCountText4);
         addToContent(_potionHasCountText5);
         addToContent(_potionHasCountText6);
         addToContent(_potionNeedCountText1);
         addToContent(_potionNeedCountText2);
         addToContent(_potionNeedCountText3);
         addToContent(_makeBtn);
         addToContent(_bufferTimeText);
         _springMc.mouseChildren = _springMc.mouseEnabled = false;
         _springMc.gotoAndPlay(1);
         _makeSuccessMc.mouseChildren = _makeSuccessMc.mouseEnabled = false;
         _makeSuccessMc.gotoAndStop(1);
         _makeSuccessMc.visible = false;
         _potionNeedImage1.setFrame(1);
         _potionNeedImage2.setFrame(1);
         _potionNeedImage3.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _makeBtn.addEventListener("click",_makeBtnClickHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
         MsgMan.addObserver("SELECT_FORMULA_CHANGE",this,__selectFormulaChangeHandler);
         MsgMan.addObserver("INFO_CHANGE_BACK",this,__infoChangeHandler);
         MsgMan.addObserver("MAKE_SUCCESS_BACK",this,__makeSuccessHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_makeBtn)
         {
            _makeBtn.removeEventListener("click",_makeBtnClickHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         MsgMan.removeObserver("SELECT_FORMULA_CHANGE",this,__selectFormulaChangeHandler);
         MsgMan.removeObserver("INFO_CHANGE_BACK",this,__infoChangeHandler);
         MsgMan.removeObserver("MAKE_SUCCESS_BACK",this,__makeSuccessHandler);
      }
      
      private function __selectFormulaChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __infoChangeHandler(param1:String, param2:Object) : void
      {
         if(isMcPlaying)
         {
            refreshTimeId = setTimeout(refreshView,1500);
         }
         else
         {
            refreshView();
         }
      }
      
      private function __makeSuccessHandler(param1:String, param2:Object) : void
      {
         disapearComplete();
         isMcPlaying = true;
         newTempId = param2 as int;
         var _loc3_:MagicSpringFormulaTempInfo = TempleteManager.instance.magicSpringTempCate.getTemplateById(newTempId);
         newIcon = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         newIcon.icon = IconFactory.getMagicSpringPath(_loc3_.Icon);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         _makeSuccessMc.visible = true;
         _makeSuccessMc.addFrameScript(35,showIconMove,_makeSuccessMc.totalFrames - 1,_makeSuccessMcEnd);
         _makeSuccessMc.gotoAndPlay(1);
         this.closeButton.enable = false;
         _makeBtn.enable = false;
      }
      
      private function showIconMove() : void
      {
         if(!newIcon)
         {
            return;
         }
         newIcon.x = _selectIcon.x;
         newIcon.y = _selectIcon.y;
         newIcon.mouseChildren = newIcon.mouseEnabled = false;
         addToContent(newIcon);
         var _loc3_:int = int(model.getIndxByTempId(newTempId));
         var _loc1_:int = int(endPointArray[_loc3_][0]);
         var _loc2_:int = int(endPointArray[_loc3_][1]);
         TweenMax.to(newIcon,0.8,{
            "bezierThrough":[{
               "x":newIcon.x,
               "y":newIcon.y
            },{
               "x":_loc1_,
               "y":_loc2_
            }],
            "scaleX":1,
            "scaleY":1,
            "orientToBezier":false,
            "ease":Quart.easeOut,
            "onComplete":_moveComplete
         });
      }
      
      private function _moveComplete() : void
      {
         TweenMax.to(newIcon,0.5,{
            "alpha":0,
            "onComplete":disapearComplete
         });
      }
      
      private function disapearComplete() : void
      {
         ObjectUtils.disposeObject(newIcon);
         newIcon = null;
      }
      
      private function _makeSuccessMcEnd() : void
      {
         if(_makeSuccessMc)
         {
            _makeSuccessMc.gotoAndStop(1);
            _makeSuccessMc.visible = false;
         }
         isMcPlaying = false;
         newTempId = 0;
         this.closeButton.enable = true;
         _makeBtn.enable = true;
         refreshView();
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("MagicSpringFrame.helperFrame");
         _loc2_.show();
      }
      
      private function _makeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!model.selectFormula)
         {
            return;
         }
         var _loc4_:Number = getTimer();
         if(_loc4_ - _preClickTime < 2000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _preClickTime = _loc4_;
         SoundManager.instance.play("022");
         if(!materialEnough)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MagicSpringFrame.make.noGoodsAlert"));
            return;
         }
         var _loc7_:MagicSpringSlotInfo = model.getFormulaInfoByTempId(model.selectFormula.TemplateId);
         if(_loc7_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MagicSpringFrame.make.hasFormulaAlert"));
            return;
         }
         if(model.openSlotCount <= model.slotList.length)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MagicSpringFrame.make.noSlotAlert"));
            return;
         }
         var _loc6_:String = LanguageMgr.GetTranslation("MagicSpringSlotItem.makeConfirm.content",model.selectFormula.TemplateName);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [confirmMakeHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function confirmMakeHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         MagicSpringManager.instance.sendMagicSpringRequest(2,model.selectFormula.TemplateId);
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         clearInterval(refreshTimeId);
         refreshTimeId = 0;
         _topView.refreshView();
         if(!model.selectFormula)
         {
            return;
         }
         materialEnough = true;
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc5_ = int(model.potionTempArr[_loc2_ - 1]);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
            _loc6_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc5_));
            this["_potionHasCountText" + _loc2_].text = _loc6_ + "";
            this["_potionHasImage" + _loc2_].tipData = _loc3_.TemplateName + "\n" + _loc3_.Description;
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _loc1_ = int(model.selectFormula["PotionCount" + _loc2_]);
            this["_potionNeedCountText" + _loc2_].text = "x" + _loc1_;
            _loc5_ = int(model.selectFormula["ItemTempId" + _loc2_]);
            _loc4_ = model.potionTempArr.indexOf(_loc5_ + "") + 1;
            if(_loc4_ > 0)
            {
               this["_potionNeedImage" + _loc2_].setFrame(_loc4_);
            }
            _loc6_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc5_));
            if(_loc6_ < _loc1_)
            {
               materialEnough = false;
            }
            _loc2_++;
         }
         _selectBufferText.htmlText = model.selectFormula.Desc;
         _bufferTimeText.text = LanguageMgr.GetTranslation("MagicSpringFrame.bufferTimeText.text",model.selectFormula.ValidTime);
         _selectIcon.icon = IconFactory.getMagicSpringPath(model.selectFormula.Icon);
         _makeBtn.enable = thane.totalGrade >= model.selectFormula.NeedGrade;
         setTotalBufferText();
      }
      
      private function setTotalBufferText() : void
      {
         var _loc2_:int = 0;
         var _loc4_:MagicSpringSlotInfo = null;
         var _loc3_:String = "";
         var _loc1_:int = int(model.slotList.length);
         _loc2_ = 1;
         while(_loc2_ <= _loc1_)
         {
            _loc4_ = model.slotList[_loc2_ - 1];
            _loc3_ += _loc2_ + "." + _loc4_.tempInfo.Desc + "\n\n";
            _loc2_++;
         }
         _totalBufferText.htmlText = _loc3_.substr(0,_loc3_.lastIndexOf("\n\n"));
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
      
      private function get model() : MagicSpringModel
      {
         return MagicSpringManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_magicspring");
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bufferTimeText);
         _bufferTimeText = null;
         ObjectUtils.disposeObject(_totalBufferText);
         _totalBufferText = null;
         ObjectUtils.disposeObject(_selectBufferText);
         _selectBufferText = null;
         ObjectUtils.disposeObject(_potionHasCountText1);
         _potionHasCountText1 = null;
         ObjectUtils.disposeObject(_potionHasCountText2);
         _potionHasCountText2 = null;
         ObjectUtils.disposeObject(_potionHasCountText3);
         _potionHasCountText3 = null;
         ObjectUtils.disposeObject(_potionHasCountText4);
         _potionHasCountText4 = null;
         ObjectUtils.disposeObject(_potionHasCountText5);
         _potionHasCountText5 = null;
         ObjectUtils.disposeObject(_potionHasCountText6);
         _potionHasCountText6 = null;
         ObjectUtils.disposeObject(_potionNeedCountText1);
         _potionNeedCountText1 = null;
         ObjectUtils.disposeObject(_potionNeedCountText2);
         _potionNeedCountText2 = null;
         ObjectUtils.disposeObject(_potionNeedCountText3);
         _potionNeedCountText3 = null;
         ObjectUtils.disposeObject(_potionHasImage1);
         _potionHasImage1 = null;
         ObjectUtils.disposeObject(_potionHasImage2);
         _potionHasImage2 = null;
         ObjectUtils.disposeObject(_potionHasImage3);
         _potionHasImage3 = null;
         ObjectUtils.disposeObject(_potionHasImage4);
         _potionHasImage4 = null;
         ObjectUtils.disposeObject(_potionHasImage5);
         _potionHasImage5 = null;
         ObjectUtils.disposeObject(_potionHasImage6);
         _potionHasImage6 = null;
         ObjectUtils.disposeObject(_potionNeedImage1);
         _potionNeedImage1 = null;
         ObjectUtils.disposeObject(_potionNeedImage2);
         _potionNeedImage2 = null;
         ObjectUtils.disposeObject(_potionNeedImage3);
         _potionNeedImage3 = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_makeBtn);
         _makeBtn = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeViolentMc(_springMc);
         _springMc = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_selectIcon);
         _selectIcon = null;
         ObjectUtils.disposeObject(newIcon);
         newIcon = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeViolentMc(_makeSuccessMc);
         _makeSuccessMc = null;
         super.dispose();
      }
   }
}

