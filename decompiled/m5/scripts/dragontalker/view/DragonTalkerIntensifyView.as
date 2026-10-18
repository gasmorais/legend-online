package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.DragonTalkerMutipleIntensifyHelper;
   import dragontalker.DragonTalkerViewHelper;
   import dragontalker.cell.DragonTalkerTalismanHandleCell;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BulePowerItem;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerIntensifyView extends Component
   {
      
      private var _instensifyBack:MutipleImage;
      
      private var _needImage:ScaleFrameImage;
      
      private var _intensifyBtn:IconButton;
      
      private var _awakeBtn:IconButton;
      
      private var _leftCell:DragonTalkerTalismanHandleCell;
      
      private var _rightCell:DragonTalkerTalismanHandleCell;
      
      private var _propVbox:VBox;
      
      private var _inputText:FilterFrameText;
      
      private var _expBar:BulePowerItem;
      
      private var _addImage:Bitmap;
      
      private var _addExpText:FilterFrameText;
      
      private var _addValueText:FilterFrameText;
      
      private var _mutiIntensifyBtn:BaseButton;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      public function DragonTalkerIntensifyView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _instensifyBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0x.instensifyBack");
         _needImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.needImage");
         _awakeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0x.awakeBtn");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.ppj0x.intensifyBtn");
         _leftCell = ComponentFactory.Instance.creatCustomObject("DragonTalkerIntensifyView.leftCell",[2,1]);
         _rightCell = ComponentFactory.Instance.creatCustomObject("DragonTalkerIntensifyView.rightCell",[2,2]);
         _propVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.propVbox");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.inputText");
         _expBar = ComponentFactory.Instance.creatCustomObject("DragonTalkerIntensifyView.expBar",[true]);
         _addImage = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerIntensifyView.addImage");
         _addExpText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.addExpText");
         _addValueText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.addValueText");
         _mutiIntensifyBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerIntensifyView.mutiIntensifyBtn");
         addChild(_instensifyBack);
         addChild(_needImage);
         addChild(_leftCell);
         addChild(_rightCell);
         addChild(_propVbox);
         addChild(_addImage);
         addChild(_addValueText);
         addChild(_addExpText);
         addChild(_inputText);
         addChild(_expBar);
         addChild(_intensifyBtn);
         addChild(_awakeBtn);
         addChild(_mutiIntensifyBtn);
         _inputText.text = "1";
         _needImage.setFrame(1);
         _addValueText.text = "1111";
      }
      
      private function addEvent() : void
      {
         _intensifyBtn.addEventListener("click",clickintensifyBtnHandler);
         _awakeBtn.addEventListener("click",clickawakeBtnHandler);
         _inputText.addEventListener("change",__textInputChangHandler);
         _mutiIntensifyBtn.addEventListener("click",__mutiIntensifyClickHandler);
         MsgMan.addObserver("HIDE_DIC_CHANGE",this,__updateIntensifyView);
         MsgMan.addObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateIntensifyView);
         MsgMan.addObserver("MUTI_INTENSIFY_FRAME_CHANGE",this,__updateMutiIntensifyStateView);
      }
      
      private function removeEvent() : void
      {
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("click",clickintensifyBtnHandler);
         }
         if(_awakeBtn)
         {
            _awakeBtn.removeEventListener("click",clickawakeBtnHandler);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("change",__textInputChangHandler);
         }
         if(_mutiIntensifyBtn)
         {
            _mutiIntensifyBtn.removeEventListener("click",__mutiIntensifyClickHandler);
         }
         MsgMan.removeObserver("HIDE_DIC_CHANGE",this,__updateIntensifyView);
         MsgMan.removeObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateIntensifyView);
         MsgMan.removeObserver("MUTI_INTENSIFY_FRAME_CHANGE",this,__updateMutiIntensifyStateView);
      }
      
      private function __textInputChangHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!curUpgradeTemp)
         {
            _inputText.text = "1";
            return;
         }
         if(curUpgradeTemp.ActiveObject != 0 && _leftCell.data.goodsTempInfo.Property3 == curUpgradeTemp.Data)
         {
            _inputText.text = curUpgradeTemp.ActiveObject + "";
            _addExpText.text = "";
         }
         else if(_rightCell.data)
         {
            _loc2_ = int(_rightCell.data.count);
            _loc3_ = parseInt(_inputText.text);
            if(_loc3_ >= _loc2_)
            {
               _inputText.text = _loc2_ + "";
            }
            if(_loc3_ <= 0)
            {
               _inputText.text = "1";
            }
            _addExpText.text = "+" + _rightCell.data.goodsTempInfo.Property1 * int(_inputText.text);
         }
         else
         {
            _inputText.text = "1";
            _addExpText.text = "";
         }
      }
      
      private function clickintensifyBtnHandler(param1:MouseEvent) : void
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
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerIntensifyView.isEqup.intensifyalert"));
            return;
         }
         if(!_rightCell.data.isExpType)
         {
            _loc3_ = DragonTalkerViewHelper.GetTextColorByProfile(_rightCell.data.goodsTempInfo.Profile,_rightCell.data.goodsTempInfo.TemplateName);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("DragonTalkerIntensifyView.strength.talismanAlert",_loc3_);
            SharedManagerHelper.ins.needAlert("DragonTalkerIntensifyView.strength.Alert",confirmResultHandler,_loc2_,_loc4_);
         }
         else
         {
            confirmResultHandler();
         }
      }
      
      private function confirmResultHandler() : void
      {
         var _loc1_:int = int(_inputText.text);
         DragonTalkerManager.instance.sendDragonTalkerTalismanReq(5,_leftCell.data.id,_rightCell.data.id,_loc1_);
      }
      
      private function clickawakeBtnHandler(param1:MouseEvent) : void
      {
         if(!_leftCell.data || !curUpgradeTemp)
         {
            return;
         }
         if(curUpgradeTemp.ActiveObject > ResourceManager.instance.gold.count)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
            return;
         }
         DragonTalkerManager.instance.sendDragonTalkerTalismanReq(16,_leftCell.data.id);
      }
      
      private function __mutiIntensifyClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         DragonTalkerMutipleIntensifyHelper.instance.onIntensifyButtonClickHandler();
      }
      
      private function __updateMutiIntensifyStateView(param1:String, param2:Object) : void
      {
         refreshView();
         if(model.isOpenMutiIntensify)
         {
            _awakeBtn.enable = false;
            _intensifyBtn.enable = false;
         }
      }
      
      private function __updateIntensifyView(param1:String, param2:Object) : void
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
         var _loc17_:Array = null;
         var _loc8_:int = 0;
         var _loc11_:String = null;
         var _loc4_:int = 0;
         var _loc15_:String = null;
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc10_:SkillTempInfo = null;
         var _loc5_:String = null;
         var _loc14_:String = null;
         var _loc9_:String = null;
         var _loc1_:String = null;
         var _loc16_:String = null;
         var _loc7_:String = null;
         clean();
         var _loc2_:DragonTalkerTalismanInfo = _leftCell.data;
         if(!_loc2_)
         {
            return;
         }
         model.intensifyTalismanInfo = _loc2_;
         curUpgradeTemp = model.talismanUpgradeArr[_loc2_.grade];
         nextUpgradeTemp = model.talismanUpgradeArr[_loc2_.grade + 1];
         _propVbox.spacing = 0;
         DragonTalkerViewHelper.SetPropTextView(2,_propVbox,_loc2_);
         _expBar.visible = true;
         if(!nextUpgradeTemp)
         {
            _addImage.visible = false;
            _expBar.full = true;
            _expBar.setText("Max");
            _intensifyBtn.visible = true;
            _intensifyBtn.enable = false;
            _addExpText.text = "";
            _addValueText.text = "";
            _needImage.setFrame(1);
            _mutiIntensifyBtn.enable = false;
         }
         else
         {
            _addImage.visible = true;
            if(curUpgradeTemp.ActiveObject != 0 && _loc2_.goodsTempInfo.Property3 == curUpgradeTemp.Data)
            {
               _expBar.full = true;
               _expBar.setText("Max");
               _awakeBtn.visible = true;
               _awakeBtn.enable = true;
               _inputText.text = curUpgradeTemp.ActiveObject + "";
               _addExpText.text = "";
               _addValueText.text = "";
               _needImage.setFrame(2);
               _needImage.x = 70;
               _needImage.y = 240;
               _mutiIntensifyBtn.enable = false;
            }
            else
            {
               _intensifyBtn.visible = true;
               _intensifyBtn.enable = _rightCell.data ? true : false;
               _mutiIntensifyBtn.enable = _rightCell.data ? false : true;
               _needImage.setFrame(1);
               _expBar.max = nextUpgradeTemp.Data - curUpgradeTemp.Data;
               _expBar.current = _loc2_.leftExp;
               if(_rightCell.data)
               {
                  _addExpText.text = "+" + _rightCell.data.goodsTempInfo.Property1 * int(_inputText.text);
               }
               _loc17_ = _loc2_.goodsTempInfo.hasValueAtt;
               _loc8_ = int(_loc17_.length);
               _loc11_ = "";
               _loc4_ = 0;
               while(_loc4_ < _loc8_)
               {
                  _loc15_ = _loc17_[_loc4_];
                  _loc12_ = int(_loc2_.goodsTempInfo[_loc15_]);
                  _loc11_ += "+" + Math.floor(_loc12_ * 0.02);
                  _loc4_++;
               }
               _addValueText.text = _loc11_;
               _addValueText.setFrame(_loc2_.goodsTempInfo.Profile);
            }
         }
         var _loc13_:DragonTalkerTalismanInfo = model.needAlertSkillInfo;
         if(_loc13_)
         {
            _loc3_ = int(_loc13_.randomSkillList[_loc13_.oldSkillIndex]);
            _loc6_ = TempleteManager.instance.skillTemplateDic[_loc3_];
            _loc10_ = TempleteManager.instance.skillTemplateDic[_loc13_.newSkillId];
            if(!_loc10_)
            {
               return;
            }
            _loc5_ = "";
            _loc14_ = DragonTalkerViewHelper.GetTextColorByProfile(_loc10_.Grades,_loc10_.TemplateName);
            _loc9_ = LanguageMgr.GetTranslation("public.confirm");
            _loc1_ = LanguageMgr.GetTranslation("public.cancel");
            _loc16_ = LanguageMgr.GetTranslation("public.prompt");
            if(!_loc6_)
            {
               _loc7_ = LanguageMgr.GetTranslation("dragonTalker.swallow.skillSelect.content01",_loc13_.goodsTempInfo.TemplateName,_loc14_);
            }
            else
            {
               _loc5_ = DragonTalkerViewHelper.GetTextColorByProfile(_loc6_.Grades,_loc6_.TemplateName);
               _loc7_ = LanguageMgr.GetTranslation("dragonTalker.swallow.skillSelect.content02",_loc13_.goodsTempInfo.TemplateName,_loc5_,_loc14_);
            }
            SimpleAlertHelper.instance.data = [__selectSkillHandler,_loc13_];
            SimpleAlertHelper.instance.popAlerFrame(_loc16_,_loc7_,_loc9_,_loc1_,true,true,false);
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
         _propVbox.removeAllChild();
         _addExpText.text = "";
         _inputText.text = "1";
         _addImage.visible = false;
         _addValueText.text = "";
         _awakeBtn.visible = false;
         _intensifyBtn.visible = true;
         _intensifyBtn.enable = false;
         _expBar.visible = false;
         _mutiIntensifyBtn.enable = false;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.clearHideDic();
         model.intensifyTalismanInfo = null;
         ObjectUtils.disposeObject(_awakeBtn);
         _awakeBtn = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_instensifyBack);
         _instensifyBack = null;
         ObjectUtils.disposeObject(_leftCell);
         _leftCell = null;
         ObjectUtils.disposeObject(_rightCell);
         _rightCell = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_needImage);
         _needImage = null;
         ObjectUtils.disposeObject(_addExpText);
         _addExpText = null;
         ObjectUtils.disposeObject(_addImage);
         _addImage = null;
         ObjectUtils.disposeObject(_addValueText);
         _addValueText = null;
         ObjectUtils.disposeObject(_mutiIntensifyBtn);
         _mutiIntensifyBtn = null;
         ObjectUtils.disposeObject(_propVbox);
         _propVbox = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         super.dispose();
      }
   }
}

