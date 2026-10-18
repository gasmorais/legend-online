package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.DragonTalkerViewHelper;
   import dragontalker.cell.DragonTalkerTalismanHandleCell;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSwallowView extends Component
   {
      
      private var _swallowBtn:IconButton;
      
      private var _swallowBack:MutipleImage;
      
      private var _leftCell:DragonTalkerTalismanHandleCell;
      
      private var _rightCell:DragonTalkerTalismanHandleCell;
      
      private var _leftPropVbox:VBox;
      
      private var _rightPropVbox:VBox;
      
      private var _effectMC:MovieClip;
      
      private var _propMc:MovieClip;
      
      private var rightLen:int;
      
      private var endFrame:int = 1;
      
      private var frameArr:Array = [1,4,8,10];
      
      private var standFrameArr:Array = [1,5,10];
      
      private var timer:int;
      
      public function DragonTalkerSwallowView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _swallowBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0y.swallowBtn");
         _swallowBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0y.swallowBack");
         _leftCell = ComponentFactory.Instance.creatCustomObject("DragonTalkerSwallowView.leftCell",[3,1]);
         _rightCell = ComponentFactory.Instance.creatCustomObject("DragonTalkerSwallowView.rightCell",[3,2]);
         _leftPropVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSwallowView.leftPropVbox");
         _rightPropVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSwallowView.rightPropVbox");
         _effectMC = ComponentFactory.Instance.creatCustomObject("DragonTalkerSwallowView.swallowEffectMC");
         _propMc = ComponentFactory.Instance.creatCustomObject("DragonTalkerSwallowView.propMc");
         addChild(_effectMC);
         addChild(_swallowBack);
         addChild(_propMc);
         addChild(_leftCell);
         addChild(_rightCell);
         addChild(_leftPropVbox);
         addChild(_rightPropVbox);
         addChild(_swallowBtn);
         _effectMC.gotoAndStop(1);
         _effectMC.addFrameScript(_effectMC.totalFrames - 1,cleanEffect);
         _effectMC.mouseChildren = _effectMC.mouseEnabled = false;
         _propMc.gotoAndStop(1);
         _propMc.visible = false;
         _propMc.mouseChildren = _propMc.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _swallowBtn.addEventListener("click",clickswallowBtnHandler);
         MsgMan.addObserver("HIDE_DIC_CHANGE",this,__updateHandlerCellView);
         MsgMan.addObserver("TALISMAN_SWALLOW_BACK",this,__updateSwallowBackHandler);
         MsgMan.addObserver("TALISMAN_SWALLOW_SKILL_BACK",this,__updateSelectSkillBackHandler);
      }
      
      private function removeEvent() : void
      {
         if(_swallowBtn)
         {
            _swallowBtn.removeEventListener("click",clickswallowBtnHandler);
         }
         MsgMan.removeObserver("HIDE_DIC_CHANGE",this,__updateHandlerCellView);
         MsgMan.removeObserver("TALISMAN_SWALLOW_BACK",this,__updateSwallowBackHandler);
         MsgMan.removeObserver("TALISMAN_SWALLOW_SKILL_BACK",this,__updateSelectSkillBackHandler);
      }
      
      private function clickswallowBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(!_leftCell.data || !_rightCell.data)
         {
            return;
         }
         if(_rightCell.data.isEquip)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerIntensifyView.isEqup.swallowalert"));
            return;
         }
         if(!_rightCell.data.isExpType)
         {
            _loc3_ = DragonTalkerViewHelper.GetTextColorByProfile(_rightCell.data.goodsTempInfo.Profile,_rightCell.data.goodsTempInfo.TemplateName);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.swallow.talismanAlert",_loc3_);
            SharedManagerHelper.ins.needAlert("DragonTalkerIntensifyView.swallow.Alert",confirmResultHandler,_loc2_,_loc4_);
         }
         else
         {
            confirmResultHandler();
         }
      }
      
      private function confirmResultHandler() : void
      {
         DragonTalkerManager.instance.sendDragonTalkerTalismanReq(6,_leftCell.data.id,_rightCell.data.id);
      }
      
      private function __updateSelectSkillBackHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Boolean = param2 as int == 0;
         if(_loc3_)
         {
            __updateHandlerCellView(null,null);
         }
      }
      
      private function __updateSwallowBackHandler(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = param2.result == 0;
         var _loc5_:int = int(param2.index);
         if(_loc3_)
         {
            _effectMC.gotoAndPlay(1);
            _propMc.visible = true;
            _propMc.addFrameScript(4,null,8,null,10,null);
            _propMc.gotoAndPlay(1);
            _loc4_ = int(frameArr[rightLen]);
            endFrame = standFrameArr[_loc5_];
            _propMc.addFrameScript(_loc4_,replayPropMc);
         }
         else
         {
            endFrame = 1;
            __updateHandlerCellView(null,null);
         }
      }
      
      private function replayPropMc() : void
      {
         _propMc.gotoAndPlay(1);
      }
      
      private function cleanEffect() : void
      {
         _effectMC.gotoAndStop(1);
         _propMc.gotoAndStop(endFrame);
         timer = setTimeout(updateMcView,500);
      }
      
      private function updateMcView() : void
      {
         clearTimeout(timer);
         timer = 0;
         _propMc.visible = false;
         __updateHandlerCellView(null,null);
      }
      
      private function __updateHandlerCellView(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SimpleDictionary = model.hideCellDic;
         _leftCell.data = null;
         _rightCell.data = null;
         for(var _loc5_:String in _loc4_)
         {
            _loc3_ = int(_loc5_.split("_")[1]);
            if(_loc3_ == 1)
            {
               _leftCell.data = _loc4_[_loc5_];
            }
            else if(_loc3_ == 2)
            {
               _rightCell.data = _loc4_[_loc5_];
            }
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc10_:SkillTempInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc7_:String = null;
         var _loc9_:String = null;
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         clean();
         var _loc4_:DragonTalkerTalismanInfo = _leftCell.data;
         var _loc5_:DragonTalkerTalismanInfo = _rightCell.data;
         _leftPropVbox.spacing = _rightPropVbox.spacing = 7;
         DragonTalkerViewHelper.SetPropTextView(3,_leftPropVbox,_loc4_);
         DragonTalkerViewHelper.SetPropTextView(3,_rightPropVbox,_loc5_);
         if(_loc5_)
         {
            rightLen = _loc5_.hasSkillCount;
         }
         if(_loc4_ && _loc5_)
         {
            _swallowBtn.enable = true;
         }
         else
         {
            _swallowBtn.enable = false;
         }
         var _loc8_:DragonTalkerTalismanInfo = model.needAlertSkillInfo;
         if(_loc8_)
         {
            _loc6_ = int(_loc8_.randomSkillList[_loc8_.oldSkillIndex]);
            _loc10_ = TempleteManager.instance.skillTemplateDic[_loc6_];
            _loc3_ = TempleteManager.instance.skillTemplateDic[_loc8_.newSkillId];
            if(!_loc3_)
            {
               return;
            }
            _loc7_ = "";
            _loc9_ = DragonTalkerViewHelper.GetTextColorByProfile(_loc3_.Grades,_loc3_.TemplateName);
            _loc1_ = LanguageMgr.GetTranslation("public.confirm");
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc11_ = LanguageMgr.GetTranslation("public.prompt");
            if(!_loc10_)
            {
               _loc12_ = LanguageMgr.GetTranslation("dragonTalker.swallow.skillSelect.content01",_loc8_.goodsTempInfo.TemplateName,_loc9_);
            }
            else
            {
               _loc7_ = DragonTalkerViewHelper.GetTextColorByProfile(_loc10_.Grades,_loc10_.TemplateName);
               _loc12_ = LanguageMgr.GetTranslation("dragonTalker.swallow.skillSelect.content02",_loc8_.goodsTempInfo.TemplateName,_loc7_,_loc9_);
            }
            SimpleAlertHelper.instance.data = [__selectSkillHandler,_loc8_];
            SimpleAlertHelper.instance.popAlerFrame(_loc11_,_loc12_,_loc1_,_loc2_,true,true,false);
         }
      }
      
      private function __selectSkillHandler(param1:Boolean, param2:Boolean, param3:DragonTalkerTalismanInfo) : void
      {
         if(param1)
         {
            DragonTalkerManager.instance.sendDragonTalkerTalismanReq(14,param3.id);
         }
         else
         {
            DragonTalkerManager.instance.sendDragonTalkerTalismanReq(15,param3.id);
         }
      }
      
      private function clean() : void
      {
         _leftPropVbox.removeAllChild();
         _rightPropVbox.removeAllChild();
         _swallowBtn.enable = false;
         rightLen = 0;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.clearHideDic();
         ObjectUtils.disposeObject(_swallowBtn);
         _swallowBtn = null;
         ObjectUtils.disposeObject(_swallowBack);
         _swallowBack = null;
         ObjectUtils.disposeObject(_leftCell);
         _leftCell = null;
         ObjectUtils.disposeObject(_rightCell);
         _rightCell = null;
         ObjectUtils.disposeObject(_leftPropVbox);
         _leftPropVbox = null;
         ObjectUtils.disposeObject(_rightPropVbox);
         _rightPropVbox = null;
         ObjectUtils.disposeViolentMc(_effectMC);
         _effectMC = null;
         ObjectUtils.disposeViolentMc(_propMc);
         _propMc = null;
         super.dispose();
      }
   }
}

