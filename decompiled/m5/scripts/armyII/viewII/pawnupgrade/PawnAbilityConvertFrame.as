package armyII.viewII.pawnupgrade
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.PawnSpecialTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PawnAbilityConvertFrame extends Frame implements IManualSize
   {
      
      private static var POINT_VALUE:int = 200;
      
      private static var SOUL_VALUE:int = 2000000;
      
      private var _back:Bitmap;
      
      private var _itemBack:Bitmap;
      
      private var _converImage:Bitmap;
      
      private var _changeImage:Bitmap;
      
      private var _abilityName1:FilterFrameText;
      
      private var _abilityName2:FilterFrameText;
      
      private var _changeValueText:FilterFrameText;
      
      private var _oldItem:PawnSpecialItem;
      
      private var _newItem:PawnSpecialItem;
      
      private var _pointBtn:SelectedButton;
      
      private var _soulBtn:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _pointIcon:Image;
      
      private var __soulIcon:Image;
      
      private var _pointTxt:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _pawnComBox:ComboBox;
      
      private var _converBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _oldPawn:ArmyPawn;
      
      private var _newPawn:ArmyPawn;
      
      public function PawnAbilityConvertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,406,343);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("buildings.casern.view.PawnSpecialAbilityFrame.Title");
         _back = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnAbilityConvertFrameBg");
         _converImage = ComponentFactory.Instance.creatBitmap("asset.arrmyII.PawnAbilityConverImage");
         _itemBack = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnAbilityConvertItemBg");
         _oldItem = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialOldItem");
         _newItem = ComponentFactory.Instance.creatCustomObject("armyII.PawnSpecialNewItem");
         _changeImage = ComponentFactory.Instance.creatBitmap("asset.armyII.PawnLevelUpIncress");
         _changeValueText = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.AddTxt");
         _abilityName1 = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.AbilityName1");
         _abilityName2 = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.AbilityName2");
         _pointBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.SelectedButton1");
         _soulBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.SelectedButton2");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.PointBack");
         __soulIcon = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.SoulBack");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.PointTextStyle");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.SoulTextStyle");
         _pawnComBox = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.ComBox");
         _converBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertFrame.ConverBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnSpecialHelpBtn");
         addToContent(_back);
         addToContent(_abilityName1);
         addToContent(_abilityName2);
         addToContent(_converImage);
         addToContent(_itemBack);
         addToContent(_oldItem);
         addToContent(_newItem);
         addToContent(_changeImage);
         _changeImage.x = 116;
         _changeImage.visible = false;
         addToContent(_changeValueText);
         _changeValueText.visible = false;
         addToContent(_pointBtn);
         addToContent(_soulBtn);
         addToContent(_pointIcon);
         addToContent(__soulIcon);
         addToContent(_pointTxt);
         _pointTxt.text = POINT_VALUE + "";
         addToContent(_soulTxt);
         _soulTxt.text = SOUL_VALUE + "";
         addToContent(_pawnComBox);
         addToContent(_converBtn);
         addToContent(_helpBtn);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_pointBtn);
         _buttonGroup.addSelectItem(_soulBtn);
         _buttonGroup.selectIndex = 1;
         refreshComBox();
      }
      
      private function refreshComBox() : void
      {
         var _loc1_:int = 0;
         _pawnComBox.listPanel.vectorListModel.clear();
         _loc1_ = 0;
         while(_loc1_ < defaultCellList.length)
         {
            _pawnComBox.listPanel.vectorListModel.append(defaultCellList[_loc1_]);
            _loc1_++;
         }
         _pawnComBox.textField.text = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.comBox.text");
      }
      
      private function get defaultCellList() : Array
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         var _loc1_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < tempArr.length)
         {
            if(TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(tempArr[_loc4_].specialAbility)))
            {
               _loc2_ = int(TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(tempArr[_loc4_].specialAbility)).Grades);
               _loc3_ = {};
               _loc3_["id"] = tempArr[_loc4_].templateInfo.MasterType;
               if(_loc3_["id"] < 8)
               {
                  _loc3_["name"] = tempArr[_loc4_].templateInfo.Name + "        " + LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.pawnGrades",_loc2_);
               }
               else
               {
                  _loc3_["name"] = tempArr[_loc4_].templateInfo.Name + "    " + LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.pawnGrades",_loc2_);
               }
               _loc1_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function get tempArr() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = ArmyManager.instance.casernPawnList.getList();
         _loc1_.sort(sortByNeedBuild);
         return _loc1_;
      }
      
      private function sortByNeedBuild(param1:ArmyPawn, param2:ArmyPawn) : int
      {
         var _loc4_:int = int(param1.templateInfo.NeedBuilding);
         var _loc3_:int = int(param2.templateInfo.NeedBuilding);
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         return 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         _pawnComBox.addEventListener("stateChange",__selectedHandler);
         _converBtn.addEventListener("rollOver",__overHandler);
         _converBtn.addEventListener("rollOut",__outHandler);
         _converBtn.addEventListener("click",__converHandler);
         for each(var _loc1_:ArmyPawn in tempArr)
         {
            _loc1_.addEventListener("SPECIAL_ALIBITY",__converSucceeded);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _changeValueText.visible = true;
         _changeImage.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _changeValueText.visible = false;
         _changeImage.visible = false;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpHandler);
         }
         if(_pawnComBox)
         {
            _pawnComBox.removeEventListener("stateChange",__selectedHandler);
         }
         if(_converBtn)
         {
            _converBtn.removeEventListener("rollOver",__overHandler);
         }
         if(_converBtn)
         {
            _converBtn.removeEventListener("rollOut",__outHandler);
         }
         if(_converBtn)
         {
            _converBtn.removeEventListener("click",__converHandler);
         }
         for each(var _loc1_:ArmyPawn in tempArr)
         {
            _loc1_.removeEventListener("SPECIAL_ALIBITY",__converSucceeded);
         }
      }
      
      private function __converSucceeded(param1:PawnEvent) : void
      {
         refreshView();
      }
      
      private function __converHandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc8_:TodayNotAlertFrame = null;
         var _loc5_:TodayNotAlertFrame = null;
         if(!_oldPawn || !_newPawn)
         {
            return;
         }
         var _loc6_:Boolean = true;
         var _loc2_:Date = SharedManager.instance.pownConverAlertDate;
         if(_loc2_)
         {
            _loc4_ = new Date();
            if(_loc4_.fullYear == _loc2_.fullYear && _loc4_.month == _loc2_.month && _loc4_.date == _loc2_.date)
            {
               _loc6_ = false;
            }
         }
         if(_loc6_)
         {
            _loc7_ = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.PawnAbilityConvertFrame.pawnSpecial");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            if(_buttonGroup.selectIndex == 0)
            {
               _loc8_ = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertAlert");
               _loc8_.width = _loc8_.width + 20;
               _loc8_.show(_loc7_,_loc3_,__converSureCall,null,"center",2,true,200);
            }
            else if(_buttonGroup.selectIndex == 1)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("armyII.PawnAbilityConvertAlert2");
               _loc5_.width = _loc5_.width + 20;
               _loc5_.show(_loc7_,_loc3_,__converSureCall,null,"center",2,true,200);
            }
         }
         else
         {
            __converSureCall(false,true);
         }
      }
      
      private function __converSureCall(param1:Boolean, param2:Boolean = true) : void
      {
         if(param1)
         {
            SharedManager.instance.pownConverAlertDate = new Date();
            SharedManager.instance.savePownConverAlert();
         }
         SharedManager.instance.pownConveruseBind = param2;
         SharedManager.instance.savePownConveruseBind();
         if(_buttonGroup.selectIndex == 0)
         {
            sendConverByPoint(param2);
         }
         else if(_buttonGroup.selectIndex == 1)
         {
            sendConverBySoul(param2);
         }
      }
      
      private function sendConverByPoint(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(_oldPawn.templateId == _newPawn.templateId)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.samePawn");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:int = int(model.playerInfo.point);
         if(param1)
         {
            _loc3_ = model.playerInfo.giftToken + playerInfo.point;
         }
         if(_loc3_ < POINT_VALUE)
         {
            RechargeAlertMannager.show();
            return;
         }
         control.sendPawnChange(_oldPawn.templateId,_newPawn.templateId,1,param1);
      }
      
      private function sendConverBySoul(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(_oldPawn.templateId == _newPawn.templateId)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.samePawn");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.playerInfo.strategy < SOUL_VALUE)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         control.sendPawnChange(_oldPawn.templateId,_newPawn.templateId,2,param1);
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      public function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __selectedHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:int = 0;
         if(!_pawnComBox || !_pawnComBox.currentSelectedItem)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < tempArr.length)
         {
            if(tempArr[_loc2_].templateInfo.MasterType == _pawnComBox.currentSelectedCellValue["id"])
            {
               _newPawn = tempArr[_loc2_];
            }
            _loc2_++;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:PawnSpecialTempInfo = null;
         var _loc2_:PawnSpecialTempInfo = null;
         _loc1_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_oldPawn.specialAbility));
         _loc2_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_newPawn.specialAbility));
         _oldItem.data = _loc1_;
         _newItem.data = _loc2_;
         _abilityName1.text = _oldPawn.templateInfo.Name + LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.property");
         _abilityName2.text = _newPawn.templateInfo.Name + LanguageMgr.GetTranslation("armyII.viewII.pawnupgrade.property");
         if(_loc2_.Grades >= _loc1_.Grades)
         {
            _changeValueText.text = "" + (_loc2_.Grades - _loc1_.Grades);
            _changeImage.scaleY = 1;
            _changeImage.y = 64;
         }
         else
         {
            _changeValueText.text = "" + (_loc1_.Grades - _loc2_.Grades);
            _changeImage.scaleY = -1;
            _changeImage.y = 96;
         }
         refreshComBox();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:ArmyPawn) : void
      {
         _oldPawn = param1;
         firstView();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function firstView() : void
      {
         var _loc1_:int = 0;
         if(!_oldPawn)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < tempArr.length)
         {
            if(tempArr[_loc1_].templateId != _oldPawn.templateId && tempArr[_loc1_].templateInfo.Level >= 10)
            {
               _newPawn = tempArr[_loc1_] as ArmyPawn;
               break;
            }
            _loc1_++;
         }
         if(!_newPawn)
         {
            _newPawn = new ArmyPawn();
         }
         refreshView();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("armyII.pawnConvertHelpFrame");
         _loc2_.show();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_converImage);
         _converImage = null;
         ObjectUtils.disposeObject(_changeImage);
         _changeImage = null;
         ObjectUtils.disposeObject(_abilityName1);
         _abilityName1 = null;
         ObjectUtils.disposeObject(_abilityName2);
         _abilityName2 = null;
         ObjectUtils.disposeObject(_changeValueText);
         _changeValueText = null;
         ObjectUtils.disposeObject(_oldItem);
         _oldItem = null;
         ObjectUtils.disposeObject(_newItem);
         _newItem = null;
         ObjectUtils.disposeObject(_pointBtn);
         _pointBtn = null;
         ObjectUtils.disposeObject(_soulBtn);
         _soulBtn = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_pointIcon);
         _pointIcon = null;
         ObjectUtils.disposeObject(__soulIcon);
         __soulIcon = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_soulTxt);
         _soulTxt = null;
         ObjectUtils.disposeObject(_pawnComBox);
         _pawnComBox = null;
         ObjectUtils.disposeObject(_converBtn);
         _converBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _oldPawn = null;
         _newPawn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

