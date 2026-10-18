package friends.findfriend
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SNSEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SNSManager;
   import mvc.module.sns.BaseSnsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ConditionFindFriendView extends Sprite implements Disposeable
   {
      
      private var _sexTxt:FilterFrameText;
      
      private var _birthTxt:FilterFrameText;
      
      private var _horoscopeTxt:FilterFrameText;
      
      private var _bloodTxt:FilterFrameText;
      
      private var _countryTxt:FilterFrameText;
      
      private var _provinceTxt:FilterFrameText;
      
      private var _cityTxt:FilterFrameText;
      
      private var _sexComBox:ComboBox;
      
      private var _horoscopeComBox:ComboBox;
      
      private var _bloodComBox:ComboBox;
      
      private var _countryComBox:ComboBox;
      
      private var _provinceComBox:ComboBox;
      
      private var _cityComBox:ComboBox;
      
      private var _birthBtn:TextButton;
      
      private var _birthContainer:Sprite;
      
      private var _birthContainerBg:Scale9CornerImage;
      
      private var _monthComBox:ComboBox;
      
      private var _dayComBox:ComboBox;
      
      private var _findBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _resultFrame:FindResultFrame;
      
      private var _unlimitObj:Object;
      
      public function ConditionFindFriendView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _sexTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindSexTxt");
         _birthTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindBirthTxt");
         _horoscopeTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindHoroscopeTxt");
         _bloodTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindBloodTxt");
         _countryTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindCountryTxt");
         _provinceTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindProvinceTxt");
         _cityTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindCityTxt");
         _sexComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindSexComBox");
         _horoscopeComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindHoroscopeComBox");
         _bloodComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindBloodComBox");
         _countryComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindCountryComBox");
         _provinceComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindProvinceComBox");
         _cityComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindCityComBox");
         _findBtn = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindFindBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindCancleBtn");
         _birthBtn = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindBirthBtn");
         _birthContainerBg = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindBirthContainerBg");
         _monthComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindMonthComBox");
         _dayComBox = ComponentFactory.Instance.creatComponentByStylename("friends.ConditionFindDayComBox");
         _birthContainer = new Sprite();
         _birthContainer.x = _birthBtn.x;
         _birthContainer.y = _birthBtn.y + _birthBtn.height;
         _birthBtn.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
         _sexTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.sex");
         _birthTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.birth");
         _horoscopeTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.horoscope");
         _bloodTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.blood");
         _countryTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.country");
         _provinceTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.province");
         _cityTxt.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.city");
         _findBtn.text = LanguageMgr.GetTranslation("friends.view.FriendsFrame.findFriend");
         _cancleBtn.text = LanguageMgr.GetTranslation("public.cancel");
         if(snsManager.model.hasSnsTemp)
         {
            initComBox();
         }
         else
         {
            snsManager.addEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
            snsManager.loadSnsTemplate();
         }
         _birthContainer.addChild(_birthContainerBg);
         _birthContainer.addChild(_monthComBox);
         _birthContainer.addChild(_dayComBox);
         addChild(_sexTxt);
         addChild(_birthTxt);
         addChild(_horoscopeTxt);
         addChild(_bloodTxt);
         addChild(_countryTxt);
         addChild(_provinceTxt);
         addChild(_cityTxt);
         addChild(_sexComBox);
         addChild(_birthBtn);
         addChild(_horoscopeComBox);
         addChild(_bloodComBox);
         addChild(_countryComBox);
         addChild(_provinceComBox);
         addChild(_cityComBox);
         addChild(_findBtn);
         addChild(_cancleBtn);
      }
      
      private function initComBox() : void
      {
         var _loc6_:int = 0;
         var _loc4_:Object = null;
         _unlimitObj = {
            "id":0,
            "name":LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit")
         };
         _sexComBox.listPanel.vectorListModel.append(_unlimitObj);
         _horoscopeComBox.listPanel.vectorListModel.append(_unlimitObj);
         _bloodComBox.listPanel.vectorListModel.append(_unlimitObj);
         _countryComBox.listPanel.vectorListModel.append(_unlimitObj);
         _provinceComBox.listPanel.vectorListModel.append(_unlimitObj);
         _cityComBox.listPanel.vectorListModel.append(_unlimitObj);
         _monthComBox.listPanel.vectorListModel.append(_unlimitObj);
         _dayComBox.listPanel.vectorListModel.append(_unlimitObj);
         for each(var _loc3_:Object in snsManager.model.sexList)
         {
            _sexComBox.listPanel.vectorListModel.append(_loc3_);
         }
         for each(var _loc2_:Object in snsManager.model.horoscopeList)
         {
            _horoscopeComBox.listPanel.vectorListModel.append(_loc2_);
         }
         for each(var _loc5_:Object in snsManager.model.bloodTypeList)
         {
            _bloodComBox.listPanel.vectorListModel.append(_loc5_);
         }
         for each(var _loc1_:Object in snsManager.model.countryList)
         {
            _countryComBox.listPanel.vectorListModel.append(_loc1_);
         }
         _loc6_ = 1;
         while(_loc6_ <= 12)
         {
            _loc4_ = {
               "id":String(_loc6_),
               "name":String(_loc6_)
            };
            _monthComBox.listPanel.vectorListModel.append(_loc4_);
            _loc6_++;
         }
         _sexComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _horoscopeComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _bloodComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _countryComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _provinceComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _cityComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _monthComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         _dayComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
      }
      
      private function __snsTempLoadCompleteHandler(param1:SNSEvent) : void
      {
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
         initComBox();
      }
      
      private function addEvent() : void
      {
         _findBtn.addEventListener("click",__onFindClick);
         _cancleBtn.addEventListener("click",__onCancleClick);
         _birthBtn.addEventListener("click",__onBirthClick);
         _countryComBox.listPanel.list.addEventListener("listItemClick",__countrySelectedHandler);
         _provinceComBox.listPanel.list.addEventListener("listItemClick",__provinceSelectedHandler);
         _monthComBox.listPanel.list.addEventListener("listItemClick",__monthSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         _findBtn.removeEventListener("click",__onFindClick);
         _cancleBtn.removeEventListener("click",__onCancleClick);
         _birthBtn.removeEventListener("click",__onBirthClick);
         _countryComBox.listPanel.list.removeEventListener("listItemClick",__countrySelectedHandler);
         _provinceComBox.listPanel.list.removeEventListener("listItemClick",__provinceSelectedHandler);
         _monthComBox.listPanel.list.removeEventListener("listItemClick",__monthSelectedHandler);
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
         StageReferance.stage.removeEventListener("click",__onStageClick);
      }
      
      private function __countrySelectedHandler(param1:ListItemEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = param1.cellValue as Object;
         _provinceComBox.listPanel.vectorListModel.clear();
         _provinceComBox.listPanel.vectorListModel.append(_unlimitObj);
         if(_loc2_ && int(_loc2_["id"]) > 0 && snsManager.model.provinceList[_loc2_["id"]])
         {
            _loc3_ = snsManager.model.provinceList[_loc2_["id"]];
            for each(var _loc4_:Object in _loc3_)
            {
               _provinceComBox.listPanel.vectorListModel.append(_loc4_);
            }
         }
         _provinceComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
      }
      
      private function __provinceSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Object = param1.cellValue as Object;
         _cityComBox.listPanel.vectorListModel.clear();
         _cityComBox.listPanel.vectorListModel.append(_unlimitObj);
         if(_loc2_ && int(_loc2_["id"]) > 0 && snsManager.model.cityList[_loc2_["id"]])
         {
            _loc4_ = snsManager.model.cityList[_loc2_["id"]];
            for each(var _loc3_:Object in _loc4_)
            {
               _cityComBox.listPanel.vectorListModel.append(_loc3_);
            }
         }
         _cityComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
      }
      
      private function __monthSelectedHandler(param1:ListItemEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:Object = param1.cellValue as Object;
         _dayComBox.listPanel.vectorListModel.clear();
         if(_loc2_ && int(_loc2_["id"]) > 0)
         {
            _loc4_ = int(DateFormatter.getMonthMaxDay(int(_loc2_["id"]) - 1,2000));
            _loc3_ = 1;
            while(_loc3_ <= _loc4_)
            {
               _loc5_ = {
                  "id":String(_loc3_),
                  "name":String(_loc3_)
               };
               _dayComBox.listPanel.vectorListModel.append(_loc5_);
               _loc3_++;
            }
            _dayComBox.listPanel.list.defaultSelectItemByCellValue = _dayComBox.listPanel.vectorListModel.first();
         }
         else
         {
            _dayComBox.listPanel.vectorListModel.append(_unlimitObj);
            _dayComBox.listPanel.list.defaultSelectItemByCellValue = _unlimitObj;
         }
      }
      
      private function __onFindClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!checkHasSelected)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.selectedAlert"));
            return;
         }
         if(_resultFrame)
         {
            _resultFrame.dispose();
         }
         _resultFrame = null;
         _resultFrame = ComponentFactory.Instance.creatComponentByStylename("friends.FindResultFrame");
         var _loc2_:BaseSnsInfo = new BaseSnsInfo();
         _loc2_.sex = _sexComBox.currentSelectedCellValue ? _sexComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.horoscope = _horoscopeComBox.currentSelectedCellValue ? _horoscopeComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.bloodType = _bloodComBox.currentSelectedCellValue ? _bloodComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.country = _countryComBox.currentSelectedCellValue ? _countryComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.province = _provinceComBox.currentSelectedCellValue ? _provinceComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.city = _cityComBox.currentSelectedCellValue ? _cityComBox.currentSelectedCellValue["id"] : 0;
         if(_monthComBox.currentSelectedCellValue && _dayComBox.currentSelectedCellValue && _monthComBox.currentSelectedCellValue["id"] > 0 && _dayComBox.currentSelectedCellValue["id"] > 0)
         {
            _loc2_.birthMonth = _monthComBox.currentSelectedCellValue["id"];
            _loc2_.birthDay = _dayComBox.currentSelectedCellValue["id"];
         }
         else
         {
            _loc2_.birthMonth = _loc2_.birthDay = 0;
         }
         _resultFrame.findInfo = _loc2_;
         _resultFrame.show();
         FrameControllerManager.instance.friendControler.removeFindFriendFrame();
      }
      
      private function __onBirthClick(param1:MouseEvent) : void
      {
         if(_birthContainer && _birthContainer.parent)
         {
            return;
         }
         addChild(_birthContainer);
         param1.stopPropagation();
         StageReferance.stage.addEventListener("click",__onStageClick);
      }
      
      private function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,_birthContainer) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_monthComBox.listPanel)) || Boolean(DisplayUtils.isTargetOrContain(_loc2_,_dayComBox.listPanel)))
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__onStageClick);
         if(_birthContainer && _birthContainer.parent)
         {
            _birthContainer.parent.removeChild(_birthContainer);
         }
         if(_monthComBox.currentSelectedCellValue && _dayComBox.currentSelectedCellValue && _monthComBox.currentSelectedCellValue["id"] > 0)
         {
            _birthBtn.text = LanguageMgr.GetTranslation("public.dateType_mmdd",_monthComBox.currentSelectedCellValue["id"],_dayComBox.currentSelectedCellValue["id"]);
         }
         else
         {
            _birthBtn.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
         }
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.friendControler.closeFindFriendFrame();
      }
      
      private function get checkHasSelected() : Boolean
      {
         if(_sexComBox.currentSelectedCellValue && _sexComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_horoscopeComBox.currentSelectedCellValue && _horoscopeComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_bloodComBox.currentSelectedCellValue && _bloodComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_countryComBox.currentSelectedCellValue && _countryComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_provinceComBox.currentSelectedCellValue && _provinceComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_cityComBox.currentSelectedCellValue && _cityComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(_monthComBox.currentSelectedCellValue && _dayComBox.currentSelectedCellValue && _monthComBox.currentSelectedCellValue["id"] > 0 && _dayComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         return false;
      }
      
      private function get snsManager() : SNSManager
      {
         return SNSManager.instance;
      }
      
      public function reset() : void
      {
         if(_sexComBox)
         {
            _sexComBox.listPanel.selectFirst();
         }
         if(_horoscopeComBox)
         {
            _horoscopeComBox.listPanel.selectFirst();
         }
         if(_bloodComBox)
         {
            _bloodComBox.listPanel.selectFirst();
         }
         if(_countryComBox)
         {
            _countryComBox.listPanel.selectFirst();
         }
         if(_provinceComBox)
         {
            _provinceComBox.listPanel.selectFirst();
         }
         if(_cityComBox)
         {
            _cityComBox.listPanel.selectFirst();
         }
         if(_monthComBox)
         {
            _monthComBox.listPanel.selectFirst();
         }
         if(_dayComBox)
         {
            _dayComBox.listPanel.selectFirst();
         }
         _birthBtn.text = LanguageMgr.GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_sexTxt)
         {
            _sexTxt.dispose();
         }
         _sexTxt = null;
         if(_birthTxt)
         {
            _birthTxt.dispose();
         }
         _birthTxt = null;
         if(_horoscopeTxt)
         {
            _horoscopeTxt.dispose();
         }
         _horoscopeTxt = null;
         if(_bloodTxt)
         {
            _bloodTxt.dispose();
         }
         _bloodTxt = null;
         if(_countryTxt)
         {
            _countryTxt.dispose();
         }
         _countryTxt = null;
         if(_provinceTxt)
         {
            _provinceTxt.dispose();
         }
         _provinceTxt = null;
         if(_cityTxt)
         {
            _cityTxt.dispose();
         }
         _cityTxt = null;
         if(_sexComBox)
         {
            _sexComBox.dispose();
         }
         _sexComBox = null;
         if(_horoscopeComBox)
         {
            _horoscopeComBox.dispose();
         }
         _horoscopeComBox = null;
         if(_bloodComBox)
         {
            _bloodComBox.dispose();
         }
         _bloodComBox = null;
         if(_countryComBox)
         {
            _countryComBox.dispose();
         }
         _countryComBox = null;
         if(_provinceComBox)
         {
            _provinceComBox.dispose();
         }
         _provinceComBox = null;
         if(_cityComBox)
         {
            _cityComBox.dispose();
         }
         _cityComBox = null;
         if(_findBtn)
         {
            _findBtn.dispose();
         }
         _findBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
         if(_birthBtn)
         {
            _birthBtn.dispose();
         }
         _birthBtn = null;
         if(_birthContainerBg)
         {
            _birthContainerBg.dispose();
         }
         _birthContainerBg = null;
         if(_monthComBox)
         {
            _monthComBox.dispose();
         }
         _monthComBox = null;
         if(_dayComBox)
         {
            _dayComBox.dispose();
         }
         _dayComBox = null;
         if(_resultFrame)
         {
            _resultFrame.dispose();
         }
         _resultFrame = null;
         _birthContainer = null;
         _unlimitObj = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

