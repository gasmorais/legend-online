// @ts-nocheck
export const defs = {};
export const deps = {};
defs["friends.findfriend.ConditionFindFriendView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ConditionFindFriendView extends __Base {
    static $fields(self) {
    self._sexTxt = null;
    self._birthTxt = null;
    self._horoscopeTxt = null;
    self._bloodTxt = null;
    self._countryTxt = null;
    self._provinceTxt = null;
    self._cityTxt = null;
    self._sexComBox = null;
    self._horoscopeComBox = null;
    self._bloodComBox = null;
    self._countryComBox = null;
    self._provinceComBox = null;
    self._cityComBox = null;
    self._birthBtn = null;
    self._birthContainer = null;
    self._birthContainerBg = null;
    self._monthComBox = null;
    self._dayComBox = null;
    self._findBtn = null;
    self._cancleBtn = null;
    self._resultFrame = null;
    self._unlimitObj = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._sexTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindSexTxt");
         this._birthTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindBirthTxt");
         this._horoscopeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindHoroscopeTxt");
         this._bloodTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindBloodTxt");
         this._countryTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindCountryTxt");
         this._provinceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindProvinceTxt");
         this._cityTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindCityTxt");
         this._sexComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindSexComBox");
         this._horoscopeComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindHoroscopeComBox");
         this._bloodComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindBloodComBox");
         this._countryComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindCountryComBox");
         this._provinceComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindProvinceComBox");
         this._cityComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindCityComBox");
         this._findBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindFindBtn");
         this._cancleBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindCancleBtn");
         this._birthBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindBirthBtn");
         this._birthContainerBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindBirthContainerBg");
         this._monthComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindMonthComBox");
         this._dayComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConditionFindDayComBox");
         this._birthContainer = new ($.C("flash.display.Sprite"))();
         this._birthContainer.x = this._birthBtn.x;
         this._birthContainer.y = this._birthBtn.y + this._birthBtn.height;
         this._birthBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
         this._sexTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.sex");
         this._birthTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.birth");
         this._horoscopeTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.horoscope");
         this._bloodTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.blood");
         this._countryTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.country");
         this._provinceTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.province");
         this._cityTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.city");
         this._findBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.findFriend");
         this._cancleBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         if(this.snsManager.model.hasSnsTemp)
         {
            this.initComBox();
         }
         else
         {
            this.snsManager.addEventListener("SNSTEMP_LOAD_COMPLETE",$.bind(this, "__snsTempLoadCompleteHandler"));
            this.snsManager.loadSnsTemplate();
         }
         this._birthContainer.addChild(this._birthContainerBg);
         this._birthContainer.addChild(this._monthComBox);
         this._birthContainer.addChild(this._dayComBox);
         this.addChild(this._sexTxt);
         this.addChild(this._birthTxt);
         this.addChild(this._horoscopeTxt);
         this.addChild(this._bloodTxt);
         this.addChild(this._countryTxt);
         this.addChild(this._provinceTxt);
         this.addChild(this._cityTxt);
         this.addChild(this._sexComBox);
         this.addChild(this._birthBtn);
         this.addChild(this._horoscopeComBox);
         this.addChild(this._bloodComBox);
         this.addChild(this._countryComBox);
         this.addChild(this._provinceComBox);
         this.addChild(this._cityComBox);
         this.addChild(this._findBtn);
         this.addChild(this._cancleBtn);
      }
    initComBox() {
         var _loc6_ = 0;
         var _loc4_ = null;
         this._unlimitObj = {
            "id":0,
            "name":$.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit")
         };
         this._sexComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._horoscopeComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._bloodComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._countryComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._provinceComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._cityComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._monthComBox.listPanel.vectorListModel.append(this._unlimitObj);
         this._dayComBox.listPanel.vectorListModel.append(this._unlimitObj);
         for (var _loc3_ of $.values(this.snsManager.model.sexList))
         {
            this._sexComBox.listPanel.vectorListModel.append(_loc3_);
         }
         for (var _loc2_ of $.values(this.snsManager.model.horoscopeList))
         {
            this._horoscopeComBox.listPanel.vectorListModel.append(_loc2_);
         }
         for (var _loc5_ of $.values(this.snsManager.model.bloodTypeList))
         {
            this._bloodComBox.listPanel.vectorListModel.append(_loc5_);
         }
         for (var _loc1_ of $.values(this.snsManager.model.countryList))
         {
            this._countryComBox.listPanel.vectorListModel.append(_loc1_);
         }
         _loc6_ = 1;
         while(_loc6_ <= 12)
         {
            _loc4_ = {
               "id":String(_loc6_),
               "name":String(_loc6_)
            };
            this._monthComBox.listPanel.vectorListModel.append(_loc4_);
            _loc6_++;
         }
         this._sexComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._horoscopeComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._bloodComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._countryComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._provinceComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._cityComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._monthComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         this._dayComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
      }
    __snsTempLoadCompleteHandler(param1) {
         this.snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",$.bind(this, "__snsTempLoadCompleteHandler"));
         this.initComBox();
      }
    addEvent() {
         this._findBtn.addEventListener("click",$.bind(this, "__onFindClick"));
         this._cancleBtn.addEventListener("click",$.bind(this, "__onCancleClick"));
         this._birthBtn.addEventListener("click",$.bind(this, "__onBirthClick"));
         this._countryComBox.listPanel.list.addEventListener("listItemClick",$.bind(this, "__countrySelectedHandler"));
         this._provinceComBox.listPanel.list.addEventListener("listItemClick",$.bind(this, "__provinceSelectedHandler"));
         this._monthComBox.listPanel.list.addEventListener("listItemClick",$.bind(this, "__monthSelectedHandler"));
      }
    removeEvent() {
         this._findBtn.removeEventListener("click",$.bind(this, "__onFindClick"));
         this._cancleBtn.removeEventListener("click",$.bind(this, "__onCancleClick"));
         this._birthBtn.removeEventListener("click",$.bind(this, "__onBirthClick"));
         this._countryComBox.listPanel.list.removeEventListener("listItemClick",$.bind(this, "__countrySelectedHandler"));
         this._provinceComBox.listPanel.list.removeEventListener("listItemClick",$.bind(this, "__provinceSelectedHandler"));
         this._monthComBox.listPanel.list.removeEventListener("listItemClick",$.bind(this, "__monthSelectedHandler"));
         this.snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",$.bind(this, "__snsTempLoadCompleteHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("click",$.bind(this, "__onStageClick"));
      }
    __countrySelectedHandler(param1) {
         var _loc3_ = undefined;
         var _loc2_ = $.as(param1.cellValue, "Object");
         this._provinceComBox.listPanel.vectorListModel.clear();
         this._provinceComBox.listPanel.vectorListModel.append(this._unlimitObj);
         if(_loc2_ && $.int(_loc2_["id"]) > 0 && this.snsManager.model.provinceList[_loc2_["id"]])
         {
            _loc3_ = this.snsManager.model.provinceList[_loc2_["id"]];
            for (var _loc4_ of $.values(_loc3_))
            {
               this._provinceComBox.listPanel.vectorListModel.append(_loc4_);
            }
         }
         this._provinceComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
      }
    __provinceSelectedHandler(param1) {
         var _loc4_ = undefined;
         var _loc2_ = $.as(param1.cellValue, "Object");
         this._cityComBox.listPanel.vectorListModel.clear();
         this._cityComBox.listPanel.vectorListModel.append(this._unlimitObj);
         if(_loc2_ && $.int(_loc2_["id"]) > 0 && this.snsManager.model.cityList[_loc2_["id"]])
         {
            _loc4_ = this.snsManager.model.cityList[_loc2_["id"]];
            for (var _loc3_ of $.values(_loc4_))
            {
               this._cityComBox.listPanel.vectorListModel.append(_loc3_);
            }
         }
         this._cityComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
      }
    __monthSelectedHandler(param1) {
         var _loc4_ = 0;
         var _loc3_ = 0;
         var _loc5_ = null;
         var _loc2_ = $.as(param1.cellValue, "Object");
         this._dayComBox.listPanel.vectorListModel.clear();
         if(_loc2_ && $.int(_loc2_["id"]) > 0)
         {
            _loc4_ = $.int($.C("yishi.utils.DateFormatter").getMonthMaxDay($.int(_loc2_["id"]) - 1,2000));
            _loc3_ = 1;
            while(_loc3_ <= _loc4_)
            {
               _loc5_ = {
                  "id":String(_loc3_),
                  "name":String(_loc3_)
               };
               this._dayComBox.listPanel.vectorListModel.append(_loc5_);
               _loc3_++;
            }
            this._dayComBox.listPanel.list.defaultSelectItemByCellValue = this._dayComBox.listPanel.vectorListModel.first();
         }
         else
         {
            this._dayComBox.listPanel.vectorListModel.append(this._unlimitObj);
            this._dayComBox.listPanel.list.defaultSelectItemByCellValue = this._unlimitObj;
         }
      }
    __onFindClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this.checkHasSelected)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.selectedAlert"));
            return;
         }
         if(this._resultFrame)
         {
            this._resultFrame.dispose();
         }
         this._resultFrame = null;
         this._resultFrame = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrame");
         var _loc2_ = new ($.C("mvc.module.sns.BaseSnsInfo"))();
         _loc2_.sex = this._sexComBox.currentSelectedCellValue ? this._sexComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.horoscope = this._horoscopeComBox.currentSelectedCellValue ? this._horoscopeComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.bloodType = this._bloodComBox.currentSelectedCellValue ? this._bloodComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.country = this._countryComBox.currentSelectedCellValue ? this._countryComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.province = this._provinceComBox.currentSelectedCellValue ? this._provinceComBox.currentSelectedCellValue["id"] : 0;
         _loc2_.city = this._cityComBox.currentSelectedCellValue ? this._cityComBox.currentSelectedCellValue["id"] : 0;
         if(this._monthComBox.currentSelectedCellValue && this._dayComBox.currentSelectedCellValue && this._monthComBox.currentSelectedCellValue["id"] > 0 && this._dayComBox.currentSelectedCellValue["id"] > 0)
         {
            _loc2_.birthMonth = this._monthComBox.currentSelectedCellValue["id"];
            _loc2_.birthDay = this._dayComBox.currentSelectedCellValue["id"];
         }
         else
         {
            _loc2_.birthMonth = _loc2_.birthDay = 0;
         }
         this._resultFrame.findInfo = _loc2_;
         this._resultFrame.show();
         $.C("yishi.manager.FrameControllerManager").instance.friendControler.removeFindFriendFrame();
      }
    __onBirthClick(param1) {
         if(this._birthContainer && this._birthContainer.parent)
         {
            return;
         }
         this.addChild(this._birthContainer);
         param1.stopPropagation();
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("click",$.bind(this, "__onStageClick"));
      }
    __onStageClick(param1) {
         var _loc2_ = $.as(param1.target, $.C("flash.display.DisplayObject"));
         if($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._birthContainer) || Boolean($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._monthComBox.listPanel)) || Boolean($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._dayComBox.listPanel)))
         {
            return;
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("click",$.bind(this, "__onStageClick"));
         if(this._birthContainer && this._birthContainer.parent)
         {
            this._birthContainer.parent.removeChild(this._birthContainer);
         }
         if(this._monthComBox.currentSelectedCellValue && this._dayComBox.currentSelectedCellValue && this._monthComBox.currentSelectedCellValue["id"] > 0)
         {
            this._birthBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.dateType_mmdd",this._monthComBox.currentSelectedCellValue["id"],this._dayComBox.currentSelectedCellValue["id"]);
         }
         else
         {
            this._birthBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
         }
      }
    __onCancleClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.friendControler.closeFindFriendFrame();
      }
    get checkHasSelected() {
         if(this._sexComBox.currentSelectedCellValue && this._sexComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._horoscopeComBox.currentSelectedCellValue && this._horoscopeComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._bloodComBox.currentSelectedCellValue && this._bloodComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._countryComBox.currentSelectedCellValue && this._countryComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._provinceComBox.currentSelectedCellValue && this._provinceComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._cityComBox.currentSelectedCellValue && this._cityComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         if(this._monthComBox.currentSelectedCellValue && this._dayComBox.currentSelectedCellValue && this._monthComBox.currentSelectedCellValue["id"] > 0 && this._dayComBox.currentSelectedCellValue["id"] > 0)
         {
            return true;
         }
         return false;
      }
    get snsManager() {
         return $.C("managers.SNSManager").instance;
      }
    reset() {
         if(this._sexComBox)
         {
            this._sexComBox.listPanel.selectFirst();
         }
         if(this._horoscopeComBox)
         {
            this._horoscopeComBox.listPanel.selectFirst();
         }
         if(this._bloodComBox)
         {
            this._bloodComBox.listPanel.selectFirst();
         }
         if(this._countryComBox)
         {
            this._countryComBox.listPanel.selectFirst();
         }
         if(this._provinceComBox)
         {
            this._provinceComBox.listPanel.selectFirst();
         }
         if(this._cityComBox)
         {
            this._cityComBox.listPanel.selectFirst();
         }
         if(this._monthComBox)
         {
            this._monthComBox.listPanel.selectFirst();
         }
         if(this._dayComBox)
         {
            this._dayComBox.listPanel.selectFirst();
         }
         this._birthBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.ConditionFindFriendView.unlimit");
      }
    dispose() {
         this.removeEvent();
         if(this._sexTxt)
         {
            this._sexTxt.dispose();
         }
         this._sexTxt = null;
         if(this._birthTxt)
         {
            this._birthTxt.dispose();
         }
         this._birthTxt = null;
         if(this._horoscopeTxt)
         {
            this._horoscopeTxt.dispose();
         }
         this._horoscopeTxt = null;
         if(this._bloodTxt)
         {
            this._bloodTxt.dispose();
         }
         this._bloodTxt = null;
         if(this._countryTxt)
         {
            this._countryTxt.dispose();
         }
         this._countryTxt = null;
         if(this._provinceTxt)
         {
            this._provinceTxt.dispose();
         }
         this._provinceTxt = null;
         if(this._cityTxt)
         {
            this._cityTxt.dispose();
         }
         this._cityTxt = null;
         if(this._sexComBox)
         {
            this._sexComBox.dispose();
         }
         this._sexComBox = null;
         if(this._horoscopeComBox)
         {
            this._horoscopeComBox.dispose();
         }
         this._horoscopeComBox = null;
         if(this._bloodComBox)
         {
            this._bloodComBox.dispose();
         }
         this._bloodComBox = null;
         if(this._countryComBox)
         {
            this._countryComBox.dispose();
         }
         this._countryComBox = null;
         if(this._provinceComBox)
         {
            this._provinceComBox.dispose();
         }
         this._provinceComBox = null;
         if(this._cityComBox)
         {
            this._cityComBox.dispose();
         }
         this._cityComBox = null;
         if(this._findBtn)
         {
            this._findBtn.dispose();
         }
         this._findBtn = null;
         if(this._cancleBtn)
         {
            this._cancleBtn.dispose();
         }
         this._cancleBtn = null;
         if(this._birthBtn)
         {
            this._birthBtn.dispose();
         }
         this._birthBtn = null;
         if(this._birthContainerBg)
         {
            this._birthContainerBg.dispose();
         }
         this._birthContainerBg = null;
         if(this._monthComBox)
         {
            this._monthComBox.dispose();
         }
         this._monthComBox = null;
         if(this._dayComBox)
         {
            this._dayComBox.dispose();
         }
         this._dayComBox = null;
         if(this._resultFrame)
         {
            this._resultFrame.dispose();
         }
         this._resultFrame = null;
         this._birthContainer = null;
         this._unlimitObj = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set checkHasSelected(v) { super.checkHasSelected = v; }
    set snsManager(v) { super.snsManager = v; }
  }
  $.meta(__ConditionFindFriendView, "friends.findfriend.ConditionFindFriendView", ["Disposeable"]);
  return __ConditionFindFriendView;
}
deps["friends.findfriend.ConditionFindFriendView"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.DisplayUtils", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.DisplayObject", "flash.display.Sprite", "manager.LanguageMgr", "managers.SNSManager", "mvc.module.sns.BaseSnsInfo", "yishi.manager.FrameControllerManager", "yishi.utils.DateFormatter", "yishi.view.tips.MessageTipManager"];

defs["friends.findfriend.ExactFindFriendView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ExactFindFriendView extends __Base {
    static $fields(self) {
    self._inputTipTxt = null;
    self._inputNameBg = null;
    self._inputNameTxt = null;
    self._clickTipTxt = null;
    self._addFriendBtn = null;
    self._clickTimer = null;
    self._tempStr = "";
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._inputTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ExactFindInputTipTxt");
         this._inputNameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ExactFindInputNameBg");
         this._inputNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ExactFindInputNameTxt");
         this._clickTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ExactFindClickTipTxt");
         this._addFriendBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.addBtn");
         this._clickTimer = new ($.C("flash.utils.Timer"))(1000,1);
         this._inputTipTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.alert");
         this._clickTipTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.describt");
         this._addFriendBtn.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.addFriendBtnTxt");
         this._inputNameTxt.setFocus();
         this.addChild(this._inputTipTxt);
         this.addChild(this._inputNameBg);
         this.addChild(this._inputNameTxt);
         this.addChild(this._clickTipTxt);
         this.addChild(this._addFriendBtn);
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("PLAYER_NAME_CLICK",$.bind(this, "__getNameFromChatHandler"));
         this._addFriendBtn.addEventListener("click",$.bind(this, "__onAddFriendClick"));
         this._inputNameTxt.addEventListener("change",$.bind(this, "__inputNameChangeHandler"));
         this._inputNameTxt.addEventListener("keyDown",$.bind(this, "__keyDownHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("PLAYER_NAME_CLICK",$.bind(this, "__getNameFromChatHandler"));
         this._addFriendBtn.removeEventListener("click",$.bind(this, "__onAddFriendClick"));
         this._inputNameTxt.removeEventListener("change",$.bind(this, "__inputNameChangeHandler"));
         this._inputNameTxt.removeEventListener("keyDown",$.bind(this, "__keyDownHandler"));
      }
    __getNameFromChatHandler(param1) {
         var _loc2_ = null;
         if(param1.data && this._inputNameTxt)
         {
            _loc2_ = $.as(param1.data, $.C("chat.datas.ChatCellData"));
            this._inputNameTxt.text = String(_loc2_.data);
         }
      }
    __keyDownHandler(param1) {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            this.__onAddFriendClick(null);
         }
      }
    __inputNameChangeHandler(param1) {
         if($.C("yishi.utils.StringHelper").checkStringLength(this._inputNameTxt.text) > 12)
         {
            this._inputNameTxt.text = this._tempStr;
         }
         this._tempStr = this._inputNameTxt.text;
      }
    __onAddFriendClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._inputNameTxt)
         {
            if(this._clickTimer && this._clickTimer.running)
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("activity.view.ActivityItem.command01"));
               return;
            }
            if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._inputNameTxt.text))
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.command01"));
               return;
            }
            $.C("yishi.manager.FrameControllerManager").instance.friendControler.sendAddFriendRequest(this._inputNameTxt.text,1);
            this.reset();
            this.restartClickTimer();
         }
      }
    __onCancleClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         $.C("yishi.manager.FrameControllerManager").instance.friendControler.closeFindFriendFrame();
      }
    restartClickTimer() {
         if(this._clickTimer)
         {
            this._clickTimer.reset();
            this._clickTimer.start();
         }
      }
    reset() {
         this._inputNameTxt.text = "";
         this._inputNameTxt.setFocus();
      }
    dispose() {
         this.removeEvent();
         if(this._clickTimer)
         {
            this._clickTimer.stop();
         }
         this._clickTimer = null;
         if(this._inputTipTxt)
         {
            this._inputTipTxt.dispose();
         }
         this._inputTipTxt = null;
         if(this._inputNameBg)
         {
            this._inputNameBg.dispose();
         }
         this._inputNameBg = null;
         if(this._inputNameTxt)
         {
            this._inputNameTxt.dispose();
         }
         this._inputNameTxt = null;
         if(this._clickTipTxt)
         {
            this._clickTipTxt.dispose();
         }
         this._clickTipTxt = null;
         if(this._addFriendBtn)
         {
            this._addFriendBtn.dispose();
         }
         this._addFriendBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ExactFindFriendView, "friends.findfriend.ExactFindFriendView", ["Disposeable"]);
  return __ExactFindFriendView;
}
deps["friends.findfriend.ExactFindFriendView"] = ["chat.datas.ChatCellData", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.utils.Timer", "manager.LanguageMgr", "yishi.manager.FrameControllerManager", "yishi.manager.NotificationManager", "yishi.utils.StringHelper", "yishi.view.tips.MessageTipManager"];

defs["friends.findfriend.FindFriendFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __FindFriendFrame extends __Base {
    static $fields(self) {
    self._scaleBg = null;
    self._bg = null;
    self._findFriendView = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.addFriend");
         this._scaleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindFriendFrameScaleBg");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindFriendFrameBg");
         this._findFriendView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.FindFriendView");
         this.addToContent(this._scaleBg);
         this.addToContent(this._bg);
         this.addToContent(this._findFriendView);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               this.dispose();
         }
      }
    removeAllPanelView() {
         if(this._findFriendView && this._findFriendView.parent)
         {
            this._findFriendView.parent.removeChild(this._findFriendView);
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    dispose() {
         this.removeEvent();
         if(this._scaleBg)
         {
            this._scaleBg.dispose();
         }
         this._scaleBg = null;
         if(this._findFriendView)
         {
            this._findFriendView.dispose();
         }
         this._findFriendView = null;
         this._bg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__FindFriendFrame, "friends.findfriend.FindFriendFrame", []);
  return __FindFriendFrame;
}
deps["friends.findfriend.FindFriendFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr"];

defs["friends.findfriend.FindFriendView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FindFriendView extends __Base {
    static $fields(self) {
    self._exactFindView = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._exactFindView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.ExactFindFriendView");
         this.addChild(this._exactFindView);
      }
    dispose() {
         if(this._exactFindView)
         {
            this._exactFindView.dispose();
         }
         this._exactFindView = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__FindFriendView, "friends.findfriend.FindFriendView", ["Disposeable"]);
  return __FindFriendView;
}
deps["friends.findfriend.FindFriendView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["friends.findfriend.FindResultFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __FindResultFrame extends __Base {
    static $fields(self) {
    self._resultTipTxt = null;
    self._unFindTipTxt = null;
    self._scrollPanel = null;
    self._vBox = null;
    self._curPageTxt = null;
    self._prePageBtn = null;
    self._nextPageBtn = null;
    self._closeBtn = null;
    self._findInfo = null;
    self._totalPage = 0;
    self._curPage = 0;
    self._curList = null;
    self._pageDic = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindFriendFrame.title");
         this._resultTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameResultTipTxt");
         this._unFindTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameUnfindTipTxt");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameScrollPanel");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameVBox");
         this._curPageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameCurPageTxt");
         this._prePageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFramePrePageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameNextPageBtn");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultFrameCloseBtn");
         this._pageDic = new ($.C("flash.utils.Dictionary"))();
         this._scrollPanel.setView(this._vBox);
         this._resultTipTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.resultTip");
         this._unFindTipTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.unfindTip");
         this._curPageTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.curPageTip",1);
         this._prePageBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.prePage");
         this._nextPageBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.nextPage");
         this._closeBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.close");
         this.addToContent(this._resultTipTxt);
         this.addToContent(this._scrollPanel);
         this.addToContent(this._vBox);
         this.addToContent(this._curPageTxt);
         this.addToContent(this._prePageBtn);
         this.addToContent(this._nextPageBtn);
         this.addToContent(this._closeBtn);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseClick"));
         this._prePageBtn.addEventListener("click",$.bind(this, "__onPrePageClick"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onNextPageClick"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("GET_FIND_RESULTS",$.bind(this, "__getResultsHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         if(this._closeBtn)
         {
            this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseClick"));
         }
         if(this._prePageBtn)
         {
            this._prePageBtn.removeEventListener("click",$.bind(this, "__onPrePageClick"));
         }
         if(this._nextPageBtn)
         {
            this._nextPageBtn.removeEventListener("click",$.bind(this, "__onNextPageClick"));
         }
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("GET_FIND_RESULTS",$.bind(this, "__getResultsHandler"));
      }
    __getResultsHandler(param1) {
         this._totalPage = param1.totalPage;
         this._curList = $.as(param1.data, "Array");
         this._pageDic[this._curPage] = this._curList;
         this.refreshView();
         this.setPageBtnEnable();
      }
    __onPrePageClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.curPage -= 1;
      }
    __onNextPageClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.curPage += 1;
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               this.dispose();
         }
      }
    setPageBtnEnable() {
         this._prePageBtn.enable = this._curPage > 1;
         this._nextPageBtn.enable = this._curPage < this._totalPage;
      }
    set findInfo(param1) {
         if(this._findInfo == param1)
         {
            return;
         }
         this._findInfo = param1;
         this.curPage = 1;
      }
    get curPage() {
         return this._curPage;
      }
    set curPage(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._curPage == param1 || param1 <= 0)
         {
            return;
         }
         this._curPage = param1;
         this.setPageBtnEnable();
         if(this._pageDic && this._pageDic[this._curPage])
         {
            this._curList = this._pageDic[this._curPage];
            this.refreshView();
         }
         else
         {
            $.C("managers.FriendSocketOutManager").sendFindFriend(this._findInfo,this._curPage);
            this._prePageBtn.enable = this._nextPageBtn.enable = false;
         }
      }
    refreshView() {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         this.clean();
         if(this._unFindTipTxt.parent)
         {
            this._unFindTipTxt.parent.removeChild(this._unFindTipTxt);
         }
         if(this._curList && this._curList.length > 0)
         {
            _loc2_ = $.int(this._curList.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = new ($.C("friends.findfriend.FindResultItem"))();
               _loc1_.data = this._curList[_loc3_];
               _loc1_.setFrame(_loc3_ % 2 + 1);
               this._vBox.addChild(_loc1_);
               _loc3_++;
            }
         }
         else
         {
            this.addChild(this._unFindTipTxt);
         }
         this._scrollPanel.scrollToTop();
         this._scrollPanel.invalidateViewport();
         this._curPageTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultFrame.curPageTip",this._curPage);
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    clean() {
         var _loc1_ = null;
         if(this._vBox)
         {
            while(this._vBox.numChildren > 0)
            {
               _loc1_ = this._vBox.getChildAt(0);
               this._vBox.removeChild(_loc1_);
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
    dispose() {
         this.removeEvent();
         this.clean();
         if(this._resultTipTxt)
         {
            this._resultTipTxt.dispose();
         }
         this._resultTipTxt = null;
         if(this._unFindTipTxt)
         {
            this._unFindTipTxt.dispose();
         }
         this._unFindTipTxt = null;
         if(this._vBox)
         {
            this._vBox.dispose();
         }
         this._vBox = null;
         if(this._scrollPanel)
         {
            this._scrollPanel.dispose();
         }
         this._scrollPanel = null;
         if(this._curPageTxt)
         {
            this._curPageTxt.dispose();
         }
         this._curPageTxt = null;
         if(this._prePageBtn)
         {
            this._prePageBtn.dispose();
         }
         this._prePageBtn = null;
         if(this._nextPageBtn)
         {
            this._nextPageBtn.dispose();
         }
         this._nextPageBtn = null;
         if(this._closeBtn)
         {
            this._closeBtn.dispose();
         }
         this._closeBtn = null;
         this._findInfo = null;
         this._curList = null;
         this._pageDic = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("yishi.manager.FrameControllerManager").instance.friendControler.showFindFriendFrame();
      }
    get findInfo() { return super.findInfo; }
  }
  $.meta(__FindResultFrame, "friends.findfriend.FindResultFrame", []);
  return __FindResultFrame;
}
deps["friends.findfriend.FindResultFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.utils.Dictionary", "friends.findfriend.FindResultItem", "manager.LanguageMgr", "managers.FriendSocketOutManager", "yishi.manager.FrameControllerManager", "yishi.manager.FriendManager"];

defs["friends.findfriend.FindResultItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FindResultItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._headCell = null;
    self._nameTxt = null;
    self._sexTxt = null;
    self._horoscopeTxt = null;
    self._bloodTxt = null;
    self._areaTxt = null;
    self._checkBtn = null;
    self._addFriendBtn = null;
    self._data = null;
    self._province = null;
    self._city = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellBg");
         this._headCell = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.FindResultCellHeadCell");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellNameTxt");
         this._sexTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellSexTxt");
         this._horoscopeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellHoroscopeTxt");
         this._bloodTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellBloodTxt");
         this._areaTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellAreaTxt");
         this._checkBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellCheckBtn");
         this._addFriendBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FindResultCellAddFriendBtn");
         this._areaTxt.isAutoFitLength = true;
         this._checkBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.info");
         this._addFriendBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.addFriend");
         this.addChild(this._bg);
         this.addChild(this._headCell);
         this.addChild(this._nameTxt);
         this.addChild(this._sexTxt);
         this.addChild(this._horoscopeTxt);
         this.addChild(this._bloodTxt);
         this.addChild(this._areaTxt);
         this.addChild(this._checkBtn);
         this.addChild(this._addFriendBtn);
      }
    addEvent() {
         this._checkBtn.addEventListener("click",$.bind(this, "__onCheckClick"));
         this._addFriendBtn.addEventListener("click",$.bind(this, "__onAddFriendClick"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("ADD_FRIEND",$.bind(this, "__addFriendHandler"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("REMOVE_FRIEND",$.bind(this, "__removeFriendHandler"));
      }
    removeEvent() {
         this._checkBtn.removeEventListener("click",$.bind(this, "__onCheckClick"));
         this._addFriendBtn.removeEventListener("click",$.bind(this, "__onAddFriendClick"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("ADD_FRIEND",$.bind(this, "__addFriendHandler"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("REMOVE_FRIEND",$.bind(this, "__removeFriendHandler"));
      }
    __addFriendHandler(param1) {
         if(this._data && this._data.userId == $.int(param1.object))
         {
            this._addFriendBtn.enable = false;
         }
      }
    __removeFriendHandler(param1) {
         if(this._data && this._data.userId == $.int(param1.data))
         {
            this._addFriendBtn.enable = true;
         }
      }
    __onCheckClick(param1) {
         if(this._data)
         {
            $.C("yishi.manager.PlayerInfoManager").instance.show(this._data.userId);
         }
      }
    __onAddFriendClick(param1) {
         if(this._data)
         {
            if($.C("yishi.manager.FriendManager").getInstance().checkIsExistRelation(this._data.userId,1))
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.manager.FriendManager.command05"));
               this._addFriendBtn.enable = false;
               return;
            }
            $.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(this._data.nickName,1);
         }
      }
    checkAddFriend(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.C("yishi.manager.FriendManager").getInstance().friendList.getList();
         for (var _loc3_ of $.values(_loc2_))
         {
            if(_loc3_.userId == param1 && (_loc3_.relation == 1 || _loc3_.relation == 3))
            {
               return false;
            }
         }
         return true;
      }
    set data(param1) {
         if(this._data == param1)
         {
            return;
         }
         this._data = $.as(param1, $.C("mvc.module.sns.BaseSnsInfo"));
         if(this._data)
         {
            this._sexTxt.text = this._data.sexName;
            this._horoscopeTxt.text = this._data.horoscopeName;
            this._bloodTxt.text = this._data.bloodName;
            this._province = this._data.provinceName != "" ? this._data.provinceName : $.C("manager.LanguageMgr").GetTranslation("friends.findfriend.FindResultItem.unknown");
            this._city = this._data.cityName;
            this._headCell.headId = this._data.headId;
            this._nameTxt.text = this._data.nickName;
            this._areaTxt.text = this._province + "   " + this._city;
            this._addFriendBtn.enable = this.checkAddFriend(this._data.userId);
         }
      }
    setFrame(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._bg)
         {
            this._bg.setFrame(param1);
         }
      }
    dispose() {
         this.removeEvent();
         if(this._bg)
         {
            this._bg.dispose();
         }
         this._bg = null;
         if(this._headCell)
         {
            this._headCell.dispose();
         }
         this._headCell = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._sexTxt)
         {
            this._sexTxt.dispose();
         }
         this._sexTxt = null;
         if(this._horoscopeTxt)
         {
            this._horoscopeTxt.dispose();
         }
         this._horoscopeTxt = null;
         if(this._bloodTxt)
         {
            this._bloodTxt.dispose();
         }
         this._bloodTxt = null;
         if(this._areaTxt)
         {
            this._areaTxt.dispose();
         }
         this._areaTxt = null;
         if(this._checkBtn)
         {
            this._checkBtn.dispose();
         }
         this._checkBtn = null;
         if(this._addFriendBtn)
         {
            this._addFriendBtn.dispose();
         }
         this._addFriendBtn = null;
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__FindResultItem, "friends.findfriend.FindResultItem", ["Disposeable"]);
  return __FindResultItem;
}
deps["friends.findfriend.FindResultItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.sns.BaseSnsInfo", "yishi.manager.FriendManager", "yishi.manager.PlayerInfoManager", "yishi.view.tips.MessageTipManager"];

defs["friends.view.AddOrDeleteFriendFrame"] = function define($) {
  const __Base = $.C("yishi.view.base.BaseInputFrame");
  class __AddOrDeleteFriendFrame extends __Base {
    static $fields(self) {
    self._relation = 0;
    }
    constructor() {
         super();
      }
    initText() {
         this._inputTxt.maxChars = 14;
         this._alertTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.alert");
         this._describtTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.describt");
         this._confirmBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         this.inputFocuseText = $.C("manager.LanguageMgr").GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command03");
      }
    initEvent() {
         super.initEvent();
         $.C("yishi.manager.NotificationManager").instance.addEventListener("PLAYER_NAME_CLICK",$.bind(this, "__getNameFromChat"));
      }
    removeEvent() {
         super.removeEvent();
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("PLAYER_NAME_CLICK",$.bind(this, "__getNameFromChat"));
      }
    __focuseOutHandler(param1) {
         $.C("yishi.manager.IMEManager").disable();
         param1.stopPropagation();
      }
    __getNameFromChat(param1) {
         var _loc2_ = $.as(param1.data, $.C("chat.datas.ChatCellData"));
         this._inputTxt.text = String(_loc2_.data);
      }
    __confirmHandler(param1) {
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc3_ = this._inputTxt.text;
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc3_))
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this._relation == 1)
         {
            this.control.sendAddFriendRequest(_loc3_,1);
         }
         else if(this._relation == 2)
         {
            this.control.sendAddFriendRequest(_loc3_,2);
         }
         this.dispose();
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.friendControler;
      }
    set relation(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._relation = param1;
         if(this._relation == 1)
         {
            this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.addFriend");
         }
         else
         {
            this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.view.AddOrDeleteFriendFrame.title");
         }
         this.initEvent();
      }
    show() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this._inputTxt;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true);
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set control(v) { super.control = v; }
    get relation() { return super.relation; }
  }
  $.meta(__AddOrDeleteFriendFrame, "friends.view.AddOrDeleteFriendFrame", []);
  return __AddOrDeleteFriendFrame;
}
deps["friends.view.AddOrDeleteFriendFrame"] = ["chat.datas.ChatCellData", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "yishi.manager.FrameControllerManager", "yishi.manager.IMEManager", "yishi.manager.NotificationManager", "yishi.utils.StringHelper", "yishi.view.base.BaseInputFrame", "yishi.view.tips.MessageTipManager"];

defs["friends.view.ConsortiaMenuView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ConsortiaMenuView extends __Base {
    static $fields(self) {
    self._consortiaBtn = null;
    self._list = null;
    self._itemList = null;
    self._memeberList = null;
    self._onLine = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.setMember();
      }
    initView() {
         this._consortiaBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.MenuConsortiaButton");
         this._consortiaBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ConsortiaMenuView.consortia","0/0");
         this.addChild(this._consortiaBtn);
         this._list = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._list.y = this._consortiaBtn.height + 2;
         this._list.x = 2;
         this._list.spacing = 8;
         this._itemList = [];
      }
    setMember() {
         var _loc4_ = null;
         var _loc2_ = 0;
         var _loc3_ = null;
         if(this.playerInfo.consortiaID <= 0)
         {
            return;
         }
         this._memeberList = $.C("yishi.manager.ConsortiaManager").instance.model.consortiaMemberList.getList();
         this._memeberList.sortOn(["state","vocationGrades","grades"],[2,2,2]);
         var _loc1_ = $.int(this._memeberList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = $.as(this._memeberList[_loc2_], $.C("yishi.datas.playerinfo.ThaneInfo"));
            _loc3_ = new ($.C("friends.view.FriendItemButton"))(true);
            _loc3_.data = _loc4_;
            _loc3_.canDelete = false;
            if(_loc4_.isOnline)
            {
               this._onLine = this._onLine + 1;
               _loc3_.enable = true;
            }
            else
            {
               _loc3_.enable = false;
            }
            if(_loc4_.userId == this.playerInfo.userId)
            {
               this._list.addChildAt(_loc3_,0);
               this._itemList.unshift(_loc3_);
            }
            else
            {
               this._list.addChild(_loc3_);
               this._itemList.push(_loc3_);
            }
            _loc2_++;
         }
         this._consortiaBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ConsortiaMenuView.consortia",this._onLine + "/" + _loc1_);
         this._consortiaBtn.dispatchEvent(new ($.C("flash.events.MouseEvent"))("click"));
      }
    refreshView() {
         var _loc4_ = null;
         var _loc2_ = 0;
         var _loc3_ = null;
         this.clean();
         this._memeberList = $.C("yishi.manager.ConsortiaManager").instance.model.consortiaMemberList.getList();
         this._memeberList.sortOn(["state","vocationGrades","grades"],[2,2,2]);
         var _loc1_ = $.int(this._memeberList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = $.as(this._memeberList[_loc2_], $.C("yishi.datas.playerinfo.ThaneInfo"));
            _loc3_ = new ($.C("friends.view.FriendItemButton"))(true);
            _loc3_.data = _loc4_;
            _loc3_.canDelete = false;
            if(_loc4_.isOnline)
            {
               this._onLine = this._onLine + 1;
               _loc3_.enable = true;
            }
            else
            {
               _loc3_.enable = false;
            }
            if(_loc4_.userId == this.playerInfo.userId)
            {
               this._list.addChildAt(_loc3_,0);
               this._itemList.unshift(_loc3_);
            }
            else
            {
               this._list.addChild(_loc3_);
               this._itemList.push(_loc3_);
            }
            _loc2_++;
         }
         this._consortiaBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ConsortiaMenuView.consortia",this._onLine + "/" + _loc1_);
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._list)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._list);
         }
         this._list = null;
         this._itemList = null;
         this._consortiaBtn = null;
      }
    addEvent() {
         this._consortiaBtn.addEventListener("click",$.bind(this, "__onConsortiaBtnHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("UPDE_MEMEBER_STATE",$.bind(this, "__onMemberStateChange"));
         $.C("yishi.manager.ConsortiaManager").instance.model.addEventListener("UPDATA_CONSORTIA_MEMBER",$.bind(this, "__onMemberStateChange"));
      }
    removeEvent() {
         if(this._consortiaBtn)
         {
            this._consortiaBtn.removeEventListener("click",$.bind(this, "__onConsortiaBtnHandler"));
         }
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("UPDE_MEMEBER_STATE",$.bind(this, "__onMemberStateChange"));
         $.C("yishi.manager.ConsortiaManager").instance.model.removeEventListener("UPDATA_CONSORTIA_MEMBER",$.bind(this, "__onMemberStateChange"));
      }
    __onMemberStateChange(param1) {
         this.refreshView();
      }
    __onConsortiaBtnHandler(param1) {
         if(this._consortiaBtn.selected)
         {
            this.addChild(this._list);
         }
         else
         {
            this.removeChild(this._list);
         }
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("events.ConsortiaMenuEvent"))("SHOW_MEMBER_LIST"));
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    clean() {
         var _loc1_ = null;
         while(this._list.numChildren > 0)
         {
            _loc1_ = this._list.getChildAt(0);
            this._list.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__ConsortiaMenuView, "friends.view.ConsortiaMenuView", ["Disposeable"]);
  return __ConsortiaMenuView;
}
deps["friends.view.ConsortiaMenuView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "events.ConsortiaMenuEvent", "flash.display.Sprite", "flash.events.MouseEvent", "friends.view.FriendItemButton", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.ConsortiaManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager"];

defs["friends.view.FridendsListView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FridendsListView extends __Base {
    static $fields(self) {
    self._listPanel = null;
    self._group = null;
    self._friendsInfo = null;
    self._strangerInfo = null;
    self._blackInfo = null;
    self._recentInfo = null;
    self._addGroupInfo = null;
    self._crossFriendsInfo = null;
    self._crossBlankInfo = null;
    self._crossStrangerInfo = null;
    self._mateInfo = null;
    self._inputGroupNameTxt = null;
    self._inputGroupNameBg = null;
    self._scrollValue = 0;
    self._tempStr = "";
    self._menu = null;
    self._curSelectedGroup = null;
    }
    constructor() {
         super();
         this.init();
         this.initData();
         this.initEvent();
         this.updateList();
      }
    init() {
         this._group = new ($.C("yishi.utils.SimpleDictionary"))();
         this._listPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendListPanel");
         this._inputGroupNameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InputGroupNameBg");
         this._inputGroupNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InputGroupNameTxt");
         this.addChild(this._listPanel);
      }
    initData() {
         var _loc17_ = null;
         var _loc9_ = null;
         var _loc6_ = null;
         var _loc18_ = 0;
         var _loc1_ = $.C("yishi.manager.FriendManager").getInstance().onlineBlacks;
         var _loc2_ = $.C("yishi.manager.FriendManager").getInstance().offlineBlacks;
         this._mateInfo = $.as(this.friendManager.getFriendById($.C("managers.MarryManager").instance.model.selfMarryInfo.userId), $.C("mvc.module.friends.FriendItemCellInfo"));
         if($.C("managers.MarryManager").instance.model.isMarry && this._mateInfo)
         {
            this._mateInfo.type = 0;
            this._mateInfo.groupId = -2;
            this._listPanel.vectorListModel.append(this._mateInfo);
            this._group.add(this._mateInfo.groupId,this._mateInfo);
         }
         this._recentInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._recentInfo.type = 1;
         this._recentInfo.groupId = 1;
         var _loc14_ = $.int($.C("yishi.manager.FriendManager").getInstance().privatePerson.length);
         this._recentInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.recent",_loc14_);
         this._listPanel.vectorListModel.append(this._recentInfo);
         this._group.add(this._recentInfo.groupId,this._recentInfo);
         var _loc7_ = this.friendManager.groupDic.getList();
         _loc7_.sortOn("groupId",16);
         for (var _loc22_ of $.values(_loc7_))
         {
            if(_loc22_.groupId != -2)
            {
               _loc17_ = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
               _loc9_ = this.friendManager.getListByGroupIdAndState(_loc22_.groupId,-1);
               _loc6_ = this.friendManager.getOfflineList(_loc9_);
               _loc18_ = _loc9_.length - _loc6_.length;
               _loc17_.type = 1;
               _loc17_.groupId = _loc22_.groupId;
               _loc17_.title = _loc22_.groupName + "[" + this.toArialBold(_loc18_ + " / " + _loc9_.length) + "]";
               this._listPanel.vectorListModel.append(_loc17_);
               this._group.add(_loc17_.groupId,_loc17_);
               if(_loc17_.groupId == 2)
               {
                  this._friendsInfo = _loc17_;
               }
            }
         }
         this._strangerInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._strangerInfo.type = 1;
         this._strangerInfo.groupId = -1;
         var _loc3_ = this.friendManager.getListByGroupIdAndState(-1,-1);
         var _loc12_ = this.friendManager.getOnlineList(_loc3_);
         var _loc8_ = this.toArialBold(_loc12_.length + " / " + _loc3_.length);
         this._strangerInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.stranger",_loc8_);
         this._listPanel.vectorListModel.append(this._strangerInfo);
         this._group.add(this._strangerInfo.groupId,this._strangerInfo);
         this._blackInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._blackInfo.type = 1;
         this._blackInfo.groupId = 3;
         var _loc20_ = this.toArialBold(_loc1_.length + " / " + (_loc1_.length + _loc2_.length));
         this._blackInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.black",_loc20_);
         this._listPanel.vectorListModel.append(this._blackInfo);
         this._group.add(this._blackInfo.groupId,this._blackInfo);
         this._crossFriendsInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._crossFriendsInfo.type = 1;
         this._crossFriendsInfo.groupId = 1001;
         var _loc5_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(1,true).length);
         var _loc21_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossFriendList.getList().length);
         var _loc10_ = this.toArialBold(_loc5_ + " / " + _loc21_);
         this._crossFriendsInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossFriendsTitle",_loc10_);
         this._listPanel.vectorListModel.append(this._crossFriendsInfo);
         this._group.add(this._crossFriendsInfo.groupId,this._crossFriendsInfo);
         this._crossStrangerInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._crossStrangerInfo.type = 1;
         this._crossStrangerInfo.groupId = 1002;
         var _loc13_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(2,true).length);
         var _loc11_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossStrangerList.getList().length);
         var _loc4_ = this.toArialBold(_loc13_ + " / " + _loc11_);
         this._crossStrangerInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossStrangerTitle",_loc4_);
         this._listPanel.vectorListModel.append(this._crossStrangerInfo);
         this._group.add(this._crossStrangerInfo.groupId,this._crossStrangerInfo);
         this._crossBlankInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._crossBlankInfo.type = 1;
         this._crossBlankInfo.groupId = 1003;
         var _loc15_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(3,true).length);
         var _loc16_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossBlackList.getList().length);
         var _loc19_ = this.toArialBold(_loc15_ + " / " + _loc16_);
         this._crossBlankInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossBlankTitle",_loc19_);
         this._listPanel.vectorListModel.append(this._crossBlankInfo);
         this._group.add(this._crossBlankInfo.groupId,this._crossBlankInfo);
         this._addGroupInfo = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
         this._addGroupInfo.type = -1;
         this._addGroupInfo.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.addGroup");
         this._curSelectedGroup = this.friendManager.model.curSelectedGroup;
         if(this._curSelectedGroup && this._group[this._curSelectedGroup.groupId])
         {
            ($.as(this._group[this._curSelectedGroup.groupId], $.C("mvc.module.friends.FriendItemCellInfo"))).selected = true;
         }
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    uninit() {
         if(this._listPanel)
         {
            this._listPanel.dispose();
         }
         this._listPanel = null;
         if(this._inputGroupNameTxt)
         {
            this._inputGroupNameTxt.dispose();
         }
         this._inputGroupNameTxt = null;
         if(this._inputGroupNameBg)
         {
            this._inputGroupNameBg.dispose();
         }
         this._inputGroupNameBg = null;
         if(this._group)
         {
            this._group.clear();
         }
         this._group = null;
         this._recentInfo = null;
         this._friendsInfo = null;
         this._strangerInfo = null;
         this._blackInfo = null;
         this._crossFriendsInfo = null;
         this._crossBlankInfo = null;
         this._crossStrangerInfo = null;
         this._addGroupInfo = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    initEvent() {
         this.friendManager.addEventListener("FRIEND_ITEM_SELECTED",$.bind(this, "__itemClickHandler"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("FRIEND_UPDATE",$.bind(this, "__updateList"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("friendchange",$.bind(this, "__updateList"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("ADD_RECENT_CONTACT",$.bind(this, "__updateList"));
         this.imManager.addEventListener("RECEIVE_MSG",$.bind(this, "__receiveIMMsgHandler"));
         this.imManager.addEventListener("MSG_LIST_DEL",$.bind(this, "__updateList"));
         this._inputGroupNameTxt.addEventListener("focusOut",$.bind(this, "__inputGroupNameHandler"));
         this._inputGroupNameTxt.addEventListener("change",$.bind(this, "__groupTxtInputHandler"));
         this.friendManager.addEventListener("ADD_GROUP",$.bind(this, "__addGroupHandler"));
         this.friendManager.addEventListener("DEL_GROUP",$.bind(this, "__delGroupHandler"));
         this.friendManager.addEventListener("RENAME_GROUP",$.bind(this, "__renameGroupHandler"));
         this.friendManager.addEventListener("MOVE_FRIEND",$.bind(this, "__updateList"));
         this.friendManager.addEventListener("RECENT_CONTACT_UPDATE",$.bind(this, "__recentContactUpdateHandler"));
         this.playerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",$.bind(this, "__systimeUpdateHandler"));
         $.C("yishi.utils.MsgMan").addObserver("CROSS_FRIENDS_UPDATE",this,$.bind(this, "__updateCrossList"));
      }
    removeEvent() {
         this.friendManager.removeEventListener("FRIEND_ITEM_SELECTED",$.bind(this, "__itemClickHandler"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("FRIEND_UPDATE",$.bind(this, "__updateList"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("friendchange",$.bind(this, "__updateList"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("ADD_RECENT_CONTACT",$.bind(this, "__updateList"));
         this.imManager.removeEventListener("RECEIVE_MSG",$.bind(this, "__receiveIMMsgHandler"));
         this.imManager.removeEventListener("MSG_LIST_DEL",$.bind(this, "__updateList"));
         this._inputGroupNameTxt.removeEventListener("focusOut",$.bind(this, "__inputGroupNameHandler"));
         this._inputGroupNameTxt.removeEventListener("change",$.bind(this, "__groupTxtInputHandler"));
         this.friendManager.removeEventListener("ADD_GROUP",$.bind(this, "__addGroupHandler"));
         this.friendManager.removeEventListener("DEL_GROUP",$.bind(this, "__delGroupHandler"));
         this.friendManager.removeEventListener("RENAME_GROUP",$.bind(this, "__renameGroupHandler"));
         this.friendManager.removeEventListener("MOVE_FRIEND",$.bind(this, "__updateList"));
         this.friendManager.removeEventListener("RECENT_CONTACT_UPDATE",$.bind(this, "__recentContactUpdateHandler"));
         this.playerModel.removeEventListener("SYSTIME_UPGRADE_MINUTE",$.bind(this, "__systimeUpdateHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("CROSS_FRIENDS_UPDATE",this,$.bind(this, "__updateCrossList"));
      }
    __updateCrossList(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.updateList();
      }
    __systimeUpdateHandler(param1) {
         if(this.playerModel.sysCurTimeBySecond - this.friendManager.model.lastReqRecentsTime > 1800)
         {
            if(this.friendManager.privatePerson.length > 0)
            {
               $.C("managers.FriendSocketOutManager").sendReqChatState(this.friendManager.privatePerson);
               this.friendManager.model.lastReqRecentsTime = this.playerModel.sysCurTimeBySecond;
            }
         }
      }
    __addGroupHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = $.as(param1.data, $.C("mvc.module.friends.FriendGroupInfo"));
         if(_loc3_)
         {
            _loc2_ = new ($.C("mvc.module.friends.FriendItemCellInfo"))();
            _loc2_.type = 1;
            _loc2_.groupId = _loc3_.groupId;
            this._group.add(_loc2_.groupId,_loc2_);
            this.updateList();
         }
      }
    __delGroupHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("mvc.module.friends.FriendGroupInfo"));
         if(_loc2_)
         {
            this._group.del(_loc2_.groupId);
            this.updateList();
         }
      }
    __renameGroupHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("mvc.module.friends.FriendGroupInfo"));
         if(_loc2_)
         {
            this.updateList();
         }
      }
    __groupTxtInputHandler(param1) {
         if($.C("yishi.utils.StringHelper").checkStringLength(this._inputGroupNameTxt.text) > 12)
         {
            this._inputGroupNameTxt.text = this._tempStr;
         }
         this._tempStr = this._inputGroupNameTxt.text;
      }
    __groupTxtKeyDownHandler(param1) {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
            this.__inputGroupNameHandler(null);
         }
      }
    __inputGroupNameHandler(param1) {
         this._inputGroupNameTxt.removeEventListener("keyDown",$.bind(this, "__groupTxtKeyDownHandler"));
         if(this._inputGroupNameTxt && this._inputGroupNameTxt.parent)
         {
            if(!$.C("yishi.utils.StringHelper").isNullOrEmpty($.C("yishi.utils.StringHelper").trimAll(this._inputGroupNameTxt.text)))
            {
               if($.C("manager.FilterWordManager").containSpecificChar(this._inputGroupNameTxt.text,",|%"))
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.InputAgain"));
               }
               else
               {
                  $.C("managers.FriendSocketOutManager").sendAddGroup(this._inputGroupNameTxt.text);
               }
            }
            this._inputGroupNameTxt.text = "";
            this._inputGroupNameTxt.parent.removeChild(this._inputGroupNameTxt);
         }
         if(this._inputGroupNameBg && this._inputGroupNameBg.parent)
         {
            this._inputGroupNameBg.parent.removeChild(this._inputGroupNameBg);
         }
      }
    __receiveIMMsgHandler(param1) {
         var _loc5_ = null;
         var _loc4_ = false;
         var _loc7_ = null;
         var _loc6_ = undefined;
         var _loc3_ = null;
         var _loc8_ = null;
         var _loc2_ = param1.msg;
         if(_loc2_.imThane)
         {
            _loc5_ = $.as(this.friendManager.getCrossThaneInfoByUuid(_loc2_.imThane.uuid), $.C("mvc.module.friends.FriendItemCellInfo"));
         }
         else
         {
            _loc5_ = this.imManager.getFriendInfo(param1.msg.userId);
         }
         if(_loc5_)
         {
            _loc4_ = _loc5_.serviceName != "" && _loc5_.serviceName != null && _loc5_.serviceName != this.playerModel.playerInfo.serviceName;
            _loc7_ = _loc4_ ? _loc5_.serviceName + "_" + _loc5_.userId : _loc5_.userId + "";
            if(this._curSelectedGroup && this._curSelectedGroup.groupId == _loc5_.groupId)
            {
               _loc6_ = this.imManager.model.unreadMsgDic[_loc7_];
               if(!_loc6_ || _loc6_.length > 1)
               {
                  return;
               }
               this.updateList();
            }
            else
            {
               _loc3_ = $.as(this._listPanel.list.getItemByValue(this._group[_loc5_.groupId]), $.C("friends.view.FriendItemCell"));
               _loc8_ = this.imManager.model.openIMFrameDic[_loc7_];
               if(_loc3_ && (!_loc8_ || !_loc8_.parent))
               {
                  _loc3_.shining = true;
               }
            }
         }
      }
    __recentContactUpdateHandler(param1) {
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == 1)
         {
            this.updateList();
         }
      }
    __updateList(param1) {
         this.updateList();
      }
    showMenu(param1, param2 = false) {
         var _loc6_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId);
         var _loc3_ = $.as(param1.getCellValue(), $.C("mvc.module.friends.FriendItemCellInfo"));
         if(_loc3_ && !_loc3_.isCross)
         {
            if(_loc3_.userId == _loc6_)
            {
               return;
            }
            this.playerManager.sendRequestSimpleAndSnsInfo(($.as(param1.getCellValue(), $.C("mvc.module.friends.FriendItemCellInfo"))).userId,3);
         }
         var _loc5_ = param1.parent.localToGlobal(new ($.C("flash.geom.Point"))(param1.x,param1.y));
         var _loc4_ = Boolean($.C("managers.FreedomTeamManager").instance.canInviteMember(_loc3_.userId,_loc3_.grades));
         if(_loc3_ && _loc3_.isCross)
         {
            _loc4_ = false;
         }
         this._menu = new ($.C("yishi.view.community.PlayerMenu"))(false,false,_loc3_.isCross,false,_loc4_);
         this._menu.setData(_loc3_,param2);
         this._menu.x = _loc5_.x - this._menu.width;
         this._menu.y = _loc5_.y - this._menu.height > 0 ? _loc5_.y - this._menu.height : 0;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
      }
    __itemClickHandler(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc3_ = null;
         if(!param1.item || !param1.data)
         {
            return;
         }
         var _loc5_ = $.as(param1.data, $.C("mvc.module.friends.FriendItemCellInfo"));
         if(_loc5_.type == 0)
         {
            if(this._curSelectedGroup && this._curSelectedGroup.groupId == 1 && _loc5_.userId != $.C("managers.MarryManager").instance.model.selfMarryInfo.userId)
            {
               this.showMenu($.as(param1.item, $.C("com.pickgliss.ui.controls.cell.IListCell")),true);
            }
            else
            {
               this.showMenu($.as(param1.item, $.C("com.pickgliss.ui.controls.cell.IListCell")));
            }
            return;
         }
         if(_loc5_.type == -1)
         {
            if(this.friendManager.groupDic.getList().length >= 4)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.command01");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            _loc4_ = $.as(this._listPanel.list.getItemByValue(this._addGroupInfo), $.C("friends.view.FriendItemCell"));
            if(_loc4_)
            {
               _loc4_.addChild(this._inputGroupNameBg);
               _loc4_.addChild(this._inputGroupNameTxt);
               this._inputGroupNameTxt.addEventListener("keyDown",$.bind(this, "__groupTxtKeyDownHandler"));
               this._inputGroupNameTxt.setFocus();
            }
            return;
         }
         if(_loc5_.selected)
         {
            _loc5_.selected = false;
            this.friendModel.curSelectedGroup = this._curSelectedGroup = null;
            this.updateList();
         }
         else
         {
            _loc3_ = $.as(this._listPanel.list.getItemByValue(_loc5_), $.C("friends.view.FriendItemCell"));
            if(_loc3_)
            {
               _loc3_.shining = false;
            }
            if(this._curSelectedGroup)
            {
               this._curSelectedGroup.selected = false;
            }
            this.friendModel.curSelectedGroup = this._curSelectedGroup = _loc5_;
            this.updateList();
            _loc5_.selected = true;
         }
         this._listPanel.beginChanges();
         this._listPanel.list.updateListView();
         this._listPanel.commitChanges();
      }
    updateList() {
         this._scrollValue = this._listPanel.vScrollbar ? this._listPanel.vScrollbar.scrollValue : 0;
         this.refreshGroupTitle();
         this._group.getList().sortOn("groupId",16);
         if(!this._curSelectedGroup)
         {
            this._listPanel.vectorListModel.clear();
            for (var _loc1_ of $.values(this._group.getList()))
            {
               if(_loc1_.groupId != -1 && _loc1_.groupId != 3 && _loc1_.groupId != 1001 && _loc1_.groupId != 1002 && _loc1_.groupId != 1003)
               {
                  this._listPanel.vectorListModel.append(_loc1_);
               }
            }
         }
         else
         {
            this._listPanel.vectorListModel.clear();
            for (var _loc2_ of $.values(this._group.getList()))
            {
               if(!(_loc2_.groupId == -1 || _loc2_.groupId == 3 || _loc2_.groupId == 1001 || _loc2_.groupId == 1002 || _loc2_.groupId == 1003))
               {
                  this._listPanel.vectorListModel.append(_loc2_);
                  if(this._curSelectedGroup.groupId == _loc2_.groupId)
                  {
                     this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
                  }
               }
            }
         }
         this._listPanel.vectorListModel.append(this._strangerInfo);
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == -1)
         {
            this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
         }
         this._listPanel.vectorListModel.append(this._blackInfo);
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == 3)
         {
            this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
         }
         this._listPanel.vectorListModel.append(this._crossFriendsInfo);
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == 1001)
         {
            this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
         }
         this._listPanel.vectorListModel.append(this._crossStrangerInfo);
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == 1002)
         {
            this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
         }
         this._listPanel.vectorListModel.append(this._crossBlankInfo);
         if(this._curSelectedGroup && this._curSelectedGroup.groupId == 1003)
         {
            this._listPanel.vectorListModel.appendAll(this.getListByGroupId(this._curSelectedGroup.groupId));
         }
         this._listPanel.vectorListModel.append(this._addGroupInfo);
         this._listPanel.list.updateListView();
         if(this._scrollValue > 0 && this._listPanel.vScrollbar)
         {
            this._listPanel.vScrollbar.scrollValue = this._scrollValue;
         }
      }
    refreshGroupTitle() {
         var _loc11_ = 0;
         var _loc17_ = null;
         var _loc4_ = 0;
         var _loc18_ = 0;
         var _loc7_ = null;
         var _loc10_ = 0;
         var _loc9_ = 0;
         var _loc3_ = null;
         var _loc12_ = 0;
         var _loc13_ = 0;
         var _loc16_ = null;
         var _loc8_ = null;
         var _loc5_ = null;
         var _loc15_ = 0;
         var _loc6_ = null;
         var _loc1_ = $.C("yishi.manager.FriendManager").getInstance().onlineBlacks;
         var _loc2_ = $.C("yishi.manager.FriendManager").getInstance().offlineBlacks;
         for (var _loc14_ of $.values(this._group))
         {
            if(_loc14_.groupId == -2)
            {
               continue;
            }
            switch(_loc14_.groupId)
            {
               case 1:
                  _loc11_ = $.int($.C("yishi.manager.FriendManager").getInstance().privatePerson.length);
                  _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.recent",_loc11_);
                  break;
               case 3:
                  _loc17_ = this.toArialBold(_loc1_.length + " / " + (_loc1_.length + _loc2_.length));
                  _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.black",_loc17_);
                  break;
               case 1001:
                  _loc4_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(1,true).length);
                  _loc18_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossFriendList.getList().length);
                  _loc7_ = this.toArialBold(_loc4_ + " / " + _loc18_);
                  _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossFriendsTitle",_loc7_);
                  break;
               case 1002:
                  _loc10_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(2,true).length);
                  _loc9_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossStrangerList.getList().length);
                  _loc3_ = this.toArialBold(_loc10_ + " / " + _loc9_);
                  _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossStrangerTitle",_loc3_);
                  break;
               case 1003:
                  _loc12_ = $.int($.C("yishi.manager.FriendManager").getInstance().getCrossFriendsRelationByType(3,true).length);
                  _loc13_ = $.int($.C("yishi.manager.FriendManager").getInstance().crossBlackList.getList().length);
                  _loc16_ = this.toArialBold(_loc12_ + " / " + _loc13_);
                  _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.crossBlankTitle",_loc16_);
                  break;
               default:
                  _loc8_ = this.friendManager.getListByGroupIdAndState(_loc14_.groupId,-1);
                  _loc5_ = this.friendManager.getOfflineList(_loc8_);
                  _loc15_ = _loc8_.length - _loc5_.length;
                  if(_loc14_.groupId == -1)
                  {
                     _loc6_ = this.toArialBold(_loc15_ + " / " + _loc8_.length);
                     _loc14_.title = $.C("manager.LanguageMgr").GetTranslation("friends.view.FridendsListView.stranger",_loc6_);
                  }
                  else
                  {
                     _loc14_.title = this.friendManager.groupDic[_loc14_.groupId].groupName + "[" + this.toArialBold(_loc15_ + " / " + _loc8_.length) + "]";
                  }
            }
         }
      }
    getListByGroupId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = [];
         switch(param1)
         {
            case 1:
               return $.C("yishi.manager.FriendManager").getInstance().privatePerson;
            case 3:
               _loc2_ = $.C("yishi.manager.FriendManager").getInstance().onlineBlacks;
               _loc2_ = _loc2_.concat($.C("yishi.manager.FriendManager").getInstance().offlineBlacks);
               break;
            case -1:
               _loc2_ = this.friendManager.getListByGroupIdAndState(-1,-1);
               break;
            case 1001:
               _loc2_ = $.C("yishi.manager.FriendManager").getInstance().crossFriendList.getList();
               break;
            case 1002:
               _loc2_ = $.C("yishi.manager.FriendManager").getInstance().crossStrangerList.getList();
               break;
            case 1003:
               _loc2_ = $.C("yishi.manager.FriendManager").getInstance().crossBlackList.getList();
               break;
            default:
               _loc2_ = this.friendManager.getListByGroupIdAndState(param1,-1);
         }
         _loc2_.sortOn(["isShine","state","friendGrade","friendGp","grades","nickName"],[2,0x10 | 2,0x10 | 2,0x10 | 2,0x10 | 2,1]);
         return _loc2_;
      }
    get friendManager() {
         return $.C("yishi.manager.FriendManager").getInstance();
      }
    get friendModel() {
         return $.C("yishi.manager.FriendManager").getInstance().model;
      }
    get imManager() {
         return $.C("managers.IMManager").instance;
      }
    get playerModel() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    get playerManager() {
         return $.C("yishi.manager.PlayerManager").instance;
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this._menu)
         {
            this._menu.dispose();
         }
         this._menu = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set friendManager(v) { super.friendManager = v; }
    set friendModel(v) { super.friendModel = v; }
    set imManager(v) { super.imManager = v; }
    set playerModel(v) { super.playerModel = v; }
    set playerManager(v) { super.playerManager = v; }
  }
  $.meta(__FridendsListView, "friends.view.FridendsListView", ["Disposeable"]);
  return __FridendsListView;
}
deps["friends.view.FridendsListView"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.cell.IListCell", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point", "friends.view.FriendItemCell", "manager.FilterWordManager", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.FriendSocketOutManager", "managers.IMManager", "managers.MarryManager", "mvc.module.friends.FriendGroupInfo", "mvc.module.friends.FriendItemCellInfo", "yishi.manager.FriendManager", "yishi.manager.PlayerManager", "yishi.utils.MsgMan", "yishi.utils.SimpleDictionary", "yishi.utils.StringHelper", "yishi.view.community.PlayerMenu", "yishi.view.tips.MessageTipManager"];

defs["friends.view.FriendAutoSearchBox"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FriendAutoSearchBox extends __Base {
    static $fields(self) {
    self._list = null;
    self._friendList = null;
    self._tempText = null;
    self._tempList = null;
    self._searchString = null;
    self._backGround = null;
    self._dataList = [];
    self._isDefualt = true;
    }
    constructor(param1 = null) {
         super();
         if(param1)
         {
            this._dataList = param1;
            this._isDefualt = false;
         }
         this.initView();
         this.initEvent();
      }
    initView() {
         this._backGround = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.searchResultBg");
         this._backGround.width = 235;
         this._backGround.height = 120;
         this.addChild(this._backGround);
         this._list = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._list.y = 10;
         this._list.spacing = 8;
         this.addChild(this._list);
         this._friendList = $.C("yishi.manager.FriendManager").getInstance().friendList;
         this._tempText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.AutoSearchTextStyle");
         this._tempText.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendAutoSearchBox.temp");
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._backGround = null;
      }
    initEvent() {
         this._backGround.addEventListener("click",$.bind(this, "__clickHander"));
      }
    removeEvent() {
         if(this._backGround)
         {
            this._backGround.removeEventListener("click",$.bind(this, "__clickHander"));
         }
      }
    removeList() {
         this._tempList = [];
         this._list.disposeAllChildren();
         this._list.refreshChildPos();
      }
    refreshList() {
         var _loc3_ = null;
         var _loc2_ = null;
         this.removeList();
         if(this._isDefualt)
         {
            if(this.control.currentPanel == 1)
            {
               _loc3_ = $.C("yishi.manager.FriendManager").getInstance().friendList.getList();
               _loc3_ = _loc3_.concat($.C("yishi.manager.FriendManager").getInstance().crossFriendList.getList());
               _loc3_ = _loc3_.concat($.C("yishi.manager.FriendManager").getInstance().crossStrangerList.getList());
               _loc3_ = _loc3_.concat($.C("yishi.manager.FriendManager").getInstance().crossBlackList.getList());
            }
            else
            {
               _loc3_ = $.C("yishi.manager.ConsortiaManager").instance.model.consortiaMemberList.getList();
            }
         }
         else
         {
            _loc3_ = this._dataList;
         }
         var _loc1_ = this._searchString.toLocaleLowerCase();
         for (var _loc4_ of $.values(_loc3_))
         {
            _loc2_ = _loc4_.nickName.toLocaleLowerCase();
            if(_loc2_.indexOf(_loc1_) >= 0)
            {
               this._tempList.push(_loc4_);
               if(this._tempList.length >= 5)
               {
                  return;
               }
            }
         }
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.friendControler;
      }
    refreshView() {
         var _loc1_ = null;
         if(this._tempList.length == 0)
         {
            this._list.addChild(this._tempText);
            this._backGround.height = 30;
            return;
         }
         this._tempList.sortOn("state",2);
         for (var _loc2_ of $.values(this._tempList))
         {
            _loc1_ = new ($.C("friends.view.FriendItemButton"))();
            _loc1_.scaleX = 0.97;
            _loc1_.canDelete = false;
            _loc1_.chatVisible = true;
            _loc1_.data = _loc2_;
            _loc1_.enable = _loc2_.isOnline;
            this._list.addChild(_loc1_);
         }
         this._backGround.height = this._list.y + this._list.height + 6;
      }
    setSearchString(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._searchString = param1;
         this.refreshList();
         this.refreshView();
      }
    __clickHander(param1) {
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this._list)
         {
            this._list.dispose();
         }
         this._list = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set control(v) { super.control = v; }
  }
  $.meta(__FriendAutoSearchBox, "friends.view.FriendAutoSearchBox", ["Disposeable"]);
  return __FriendAutoSearchBox;
}
deps["friends.view.FriendAutoSearchBox"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "friends.view.FriendItemButton", "manager.LanguageMgr", "yishi.manager.ConsortiaManager", "yishi.manager.FrameControllerManager", "yishi.manager.FriendManager"];

defs["friends.view.FriendItemButton"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FriendItemButton extends __Base {
    static $fields(self) {
    self._selected = false;
    self._bg = null;
    self._deleteBtn = null;
    self._chatBtn = null;
    self._icon = null;
    self._nameTxt = null;
    self._level = null;
    self._data = null;
    self._enable = false;
    self._alert = null;
    self._canDelete = false;
    self._vipText = null;
    self._vocationIcon = null;
    self._isConsortiaPanel = false;
    }
    constructor(param1 = false) {
         super();
         this._isConsortiaPanel = param1;
         this.init();
         this.initEvent();
      }
    init() {
         this.buttonMode = true;
         this.canDelete = true;
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsItemBg");
         this._bg.setFrame(1);
         this._bg.mouseChildren = false;
         this._bg.mouseEnabled = false;
         this.addChild(this._bg);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ItemSexIcon");
         this.addChild(this._icon);
         this._deleteBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsDeleteBtn");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.deleteBtnTipData");
         this._deleteBtn.tipData = _loc2_;
         this.addChild(this._deleteBtn);
         this._chatBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsChatBtn");
         this.addChild(this._chatBtn);
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.privateChat");
         this._chatBtn.tipData = _loc1_;
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendsItemNameTextStyle");
         this._nameTxt.mouseEnabled = false;
         this.addChild(this._nameTxt);
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendsItemLevelTextStyle");
         this._level.mouseEnabled = false;
         this.addChild(this._level);
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsItem.VocationIcon");
         this._vocationIcon.visible = false;
         this.addChild(this._vocationIcon);
         if(this._isConsortiaPanel)
         {
            this._chatBtn.x = 182;
         }
         this._deleteBtn.visible = false;
         this.setVipIcon();
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._deleteBtn = null;
         this._bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    initEvent() {
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this);
         this.addEventListener("click",$.bind(this, "__onMouseClick"));
         this.addEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.addEventListener("rollOver",$.bind(this, "__onMouseRollover"));
         this.addEventListener("rollOut",$.bind(this, "__onMouseRollout"));
         this._deleteBtn.addEventListener("click",$.bind(this, "__deleteHandler"));
         this._deleteBtn.addEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._chatBtn.addEventListener("click",$.bind(this, "__privateChatHandler"));
         this._chatBtn.addEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
      }
    removeEvent() {
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this);
         this.removeEventListener("click",$.bind(this, "__onMouseClick"));
         this.removeEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.removeEventListener("rollOver",$.bind(this, "__onMouseRollover"));
         this.removeEventListener("rollOut",$.bind(this, "__onMouseRollout"));
         if(this._deleteBtn)
         {
            this._deleteBtn.removeEventListener("click",$.bind(this, "__deleteHandler"));
            this._deleteBtn.removeEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         }
         if(this._chatBtn)
         {
            this._chatBtn.removeEventListener("click",$.bind(this, "__privateChatHandler"));
            this._chatBtn.removeEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         }
      }
    __chatDownHandler(param1) {
         param1.stopPropagation();
      }
    privateChat() {
         $.C("managers.IMManager").instance.createIMFrame(this._data);
      }
    __privateChatHandler(param1) {
         param1.stopImmediatePropagation();
         this.privateChat();
      }
    __onDoubleClick(param1) {
         this.privateChat();
      }
    __onMouseClick(param1) {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         if($.is(this._data, $.C("yishi.datas.playerinfo.ThaneInfo")) && ($.as(this._data, $.C("yishi.datas.playerinfo.ThaneInfo"))).userId == $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         var _loc4_ = this.parent.localToGlobal(new ($.C("flash.geom.Point"))(this.x,this.y + 20));
         var _loc2_ = Boolean($.C("managers.FreedomTeamManager").instance.canInviteMember(this._data.userId,this._data.grades));
         var _loc3_ = new ($.C("yishi.view.community.PlayerMenu"))(false,false,false,false,_loc2_);
         _loc3_.setData(this._data);
         _loc3_.x = _loc4_.x - _loc3_.width;
         _loc3_.y = _loc4_.y - _loc3_.height;
         if(_loc3_.y < 0)
         {
            _loc3_.y = 0;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(_loc3_,7);
      }
    __onMouseRollover(param1) {
         if(!this.selected)
         {
            this._bg.setFrame(2);
            if(this._enable)
            {
               this._chatBtn.filters = [$.C("yishi.filter.UIFilter").getLightingFilter()];
            }
            else
            {
               this._chatBtn.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            }
            if(!this._canDelete)
            {
               this._deleteBtn.visible = false;
            }
            else
            {
               this._deleteBtn.visible = true;
            }
         }
      }
    __onMouseRollout(param1) {
         if(!this.selected)
         {
            if(!this._enable)
            {
               this._chatBtn.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            }
            else
            {
               this._chatBtn.filters = [$.C("yishi.filter.UIFilter").getLightingFilter()];
            }
            this._bg.setFrame(1);
            this._deleteBtn.visible = false;
         }
      }
    __deleteHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         param1.stopImmediatePropagation();
         if(this._data)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            _loc3_ = "";
            switch($.int(this._data.relation) - 2)
            {
               case 0:
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str02");
                  this._alert = $.C("com.pickgliss.ui.AlertManager").Instance.simpleAlert(_loc2_,_loc3_ + this._data.nickName,"","",true);
                  break;
               case 1:
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
                  this._alert = $.C("com.pickgliss.ui.AlertManager").Instance.simpleAlert(_loc2_,_loc3_ + this._data.nickName,"","",true);
                  break;
               case 2:
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str01");
                  this._alert = $.C("com.pickgliss.ui.AlertManager").Instance.simpleAlert(_loc2_,_loc3_ + this._data.nickName,"","",true);
                  break;
               default:
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str03");
                  this._alert = $.C("com.pickgliss.ui.AlertManager").Instance.simpleAlert(_loc2_,_loc3_ + this._data.nickName,"","",true);
            }
            this._alert.addEventListener("response",$.bind(this, "__resposeHandler"));
         }
      }
    __resposeHandler(param1) {
         switch($.int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               this._alert.removeEventListener("response",$.bind(this, "__resposeHandler"));
               if(this._data.relation != 4)
               {
                  $.C("yishi.manager.FriendManager").getInstance().sendRemoveFriendRequest(this._data.userId);
                  break;
               }
               $.C("yishi.manager.FriendManager").getInstance().removePrivatePerson(this._data.userId);
         }
      }
    set autoSelect(param1) {
      }
    get selected() {
         return this._selected;
      }
    set selected(param1) {
         if(!this._enable)
         {
            return;
         }
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         if(this._selected)
         {
            this._bg.setFrame(3);
            this._deleteBtn.visible = true;
            this._nameTxt.setFrame(2);
            this._level.setFrame(2);
         }
         else
         {
            this._bg.setFrame(1);
            this._deleteBtn.visible = false;
            this._nameTxt.setFrame(1);
            this._level.setFrame(1);
         }
      }
    get data() {
         return this._data;
      }
    setVipIcon() {
         this._vipText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendsItemNameGradientText");
         this.addChild(this._vipText);
      }
    set data(param1) {
         this._data = param1;
         this._nameTxt.text = param1.nickName;
         this._level.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",param1.grades);
         if(this._data.sexs == 0)
         {
            this._icon.setFrame(2);
         }
         else
         {
            this._icon.setFrame(1);
         }
         switch($.int(this._data.relation) - 1)
         {
            case 0:
               this._deleteBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str05");
               break;
            case 1:
               this._deleteBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str04");
               break;
            case 2:
               this._deleteBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
         }
         if(this._data.IsVipAndNoExpirt)
         {
            this._vipText.visible = true;
            this._nameTxt.visible = false;
            this._vipText.text = this._nameTxt.text;
         }
         else
         {
            this._vipText.visible = false;
            this._nameTxt.visible = true;
         }
         this.refreshVocation();
      }
    refreshVocation() {
         if(this._data && this._data.vocationGrades > 0)
         {
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName(this._data.templateInfo.Job,this._data.vocationStep,this._data.vocationLevel);
            this._vocationIcon.setFrame(this._data.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    set enable(param1) {
         var _loc3_ = 0;
         var _loc2_ = null;
         this._enable = param1;
         _loc3_ = 0;
         while(_loc3_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc3_);
            if(_loc2_ != this._deleteBtn)
            {
               _loc2_.filters = this._enable ? null : [$.C("yishi.filter.UIFilter").getGrayFilter()];
            }
            _loc3_++;
         }
      }
    asDisplayObject() {
         return this;
      }
    dispose() {
         this.removeEvent();
         this.uninit();
      }
    get canDelete() {
         return this._canDelete;
      }
    set canDelete(param1) {
         this._canDelete = param1;
         if(!this._canDelete)
         {
            this._deleteBtn.visible = false;
         }
      }
    set chatVisible(param1) {
         this._chatBtn.visible = param1;
      }
    get height() {
         return this._bg.height - 5;
      }
    get autoSelect() { return super.autoSelect; }
    get enable() { return super.enable; }
    get chatVisible() { return super.chatVisible; }
    set height(v) { super.height = v; }
  }
  $.meta(__FriendItemButton, "friends.view.FriendItemButton", ["Disposeable", "ISelectable"]);
  return __FriendItemButton;
}
deps["friends.view.FriendItemButton"] = ["com.pickgliss.ui.AlertManager", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.IMManager", "yishi.datas.playerinfo.ThaneInfo", "yishi.filter.UIFilter", "yishi.manager.FriendManager", "yishi.manager.PlayerManager", "yishi.view.community.PlayerMenu"];

defs["friends.view.FriendItemCell"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __FriendItemCell extends __Base {
    static $fields(self) {
    self._titleBack = null;
    self._titleTxt = null;
    self._itemBack = null;
    self._itemBigBack = null;
    self._icon = null;
    self._stateImg = null;
    self._privateChatBtn = null;
    self._nameTxt = null;
    self._level = null;
    self._levelTxt = null;
    self._mateStripView1 = null;
    self._mateBG1 = null;
    self._mateTxt1 = null;
    self._mateStripView2 = null;
    self._mateRing = null;
    self._mateRingTxt = null;
    self._mateBuff = null;
    self._groupShiningMC = null;
    self._friendShiningMC = null;
    self._shiningMC = null;
    self._delGroupBtn = null;
    self._renameGroupBtn = null;
    self._inputGroupNameBg = null;
    self._inputGroupNameTxt = null;
    self._alert = null;
    self._tempStr = "";
    self._vipText = null;
    self._timer = null;
    self._vocationIcon = null;
    self._info = null;
    self._headId = 0;
    }
    constructor() {
         super();
         this.buttonMode = true;
         this.init();
         this.initEvent();
      }
    init() {
         this._titleBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.TitleBack");
         this._titleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.TitleTxt");
         this._itemBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsItemGroupCellBg");
         this._itemBigBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsItemCellBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.FriendItemCellHeadCell");
         this._stateImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendItemCellStateImg");
         this._privateChatBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendItemCellChatBtn");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendItemCellNameText");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendItemCellLevelText");
         this._levelTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendItemCellLevelText2");
         this._groupShiningMC = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.IMGroupShiningMC");
         this._friendShiningMC = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.IMFriendShiningMC");
         this._mateStripView1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("Friends.FriendItemCellmateStripView1");
         this._mateStripView2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("Friends.FriendItemCellmateStripView2");
         this._mateBG1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.CellMateBG");
         this._mateTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.CellMateTxt");
         this._mateRing = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.CellMateRing");
         this._mateRingTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.CellMateRingTxt");
         this._mateBuff = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.CellMateRing");
         this._delGroupBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.DelGroupBtn");
         this._renameGroupBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RenameGroupBtn");
         this._delGroupBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("emailII.EmailFrame.delete");
         this._renameGroupBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendItemCell.renameGroup");
         this._delGroupBtn.visible = this._renameGroupBtn.visible = false;
         this._inputGroupNameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InputGroupNameBg");
         this._inputGroupNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InputGroupNameTxt");
         this._vipText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("FriendCellNameGradientText");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendCell.VocationIcon");
         this._timer = new ($.C("flash.utils.Timer"))(300,1);
         this._groupShiningMC.gotoAndStop(1);
         this._friendShiningMC.gotoAndStop(1);
         this._mateStripView1.addChild(this._mateBG1);
         this._mateStripView1.addChild(this._mateTxt1);
         this._mateStripView2.addChild(this._mateRing);
         this._mateStripView2.addChild(this._mateRingTxt);
         this._titleBack.setFrame(1);
         this._titleTxt.setFrame(1);
         this._itemBack.setFrame(1);
         this._stateImg.setFrame(7);
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.privateChat");
         this._privateChatBtn.tipData = _loc1_;
         this._privateChatBtn.visible = false;
      }
    initEvent() {
         this.addEventListener("rollOver",$.bind(this, "__overHandler"));
         this.addEventListener("rollOut",$.bind(this, "__outHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this);
         this.addEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.addEventListener("click",$.bind(this, "__onClick"));
         this._privateChatBtn.addEventListener("click",$.bind(this, "__chatHandler"));
         this._privateChatBtn.addEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._delGroupBtn.addEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._renameGroupBtn.addEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._delGroupBtn.addEventListener("click",$.bind(this, "__onDelGroupClick"));
         this._renameGroupBtn.addEventListener("click",$.bind(this, "__onRenameGroupClick"));
         this._inputGroupNameTxt.addEventListener("focusOut",$.bind(this, "__inputGroupNameHandler"));
         this._inputGroupNameTxt.addEventListener("change",$.bind(this, "__groupTxtInputHandler"));
         this._timer.addEventListener("timerComplete",$.bind(this, "__timerCompleteHandler"));
      }
    removeEvent() {
         this.removeEventListener("rollOver",$.bind(this, "__overHandler"));
         this.removeEventListener("rollOut",$.bind(this, "__outHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this);
         this.removeEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.removeEventListener("click",$.bind(this, "__onClick"));
         this._privateChatBtn.removeEventListener("click",$.bind(this, "__chatHandler"));
         this._privateChatBtn.removeEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._delGroupBtn.removeEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._delGroupBtn.removeEventListener("click",$.bind(this, "__onDelGroupClick"));
         this._renameGroupBtn.removeEventListener("mouseDown",$.bind(this, "__chatDownHandler"));
         this._renameGroupBtn.removeEventListener("click",$.bind(this, "__onRenameGroupClick"));
         this._inputGroupNameTxt.removeEventListener("focusOut",$.bind(this, "__inputGroupNameHandler"));
         this._inputGroupNameTxt.removeEventListener("change",$.bind(this, "__groupTxtInputHandler"));
         this._timer.removeEventListener("timerComplete",$.bind(this, "__timerCompleteHandler"));
      }
    addFriendListener() {
         if(this._info)
         {
            this._info.addEventListener("PLAYER_STATE_CHANGE",$.bind(this, "__friendBaseInfoChangeHandler"));
         }
      }
    removeFriendListener() {
         if(this._info)
         {
            this._info.removeEventListener("PLAYER_STATE_CHANGE",$.bind(this, "__friendBaseInfoChangeHandler"));
         }
      }
    __friendBaseInfoChangeHandler(param1) {
         this.refreshBaseView();
      }
    __onDelGroupClick(param1) {
         param1.stopImmediatePropagation();
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "delGroupResponseHandler")];
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         var _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
         var _loc5_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendItemCell.content");
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
      }
    delGroupResponseHandler(param1, param2) {
         if(param1 && this._info)
         {
            $.C("managers.FriendSocketOutManager").sendDelGroup(this._info.groupId);
         }
      }
    __onRenameGroupClick(param1) {
         param1.stopImmediatePropagation();
         var _loc2_ = this.localToGlobal(new ($.C("flash.geom.Point"))(20,-3));
         var _loc3_ = this.localToGlobal(new ($.C("flash.geom.Point"))(26,1));
         this._inputGroupNameBg.x = _loc2_.x;
         this._inputGroupNameBg.y = _loc2_.y;
         this._inputGroupNameTxt.x = _loc3_.x;
         this._inputGroupNameTxt.y = _loc3_.y;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._inputGroupNameBg,3,false,false);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._inputGroupNameTxt,3,false,false);
         this._inputGroupNameTxt.addEventListener("keyDown",$.bind(this, "__groupTxtKeyDownHandler"));
         this._inputGroupNameTxt.setFocus();
      }
    __groupTxtKeyDownHandler(param1) {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
            this.__inputGroupNameHandler(null);
         }
      }
    __groupTxtInputHandler(param1) {
         if($.C("yishi.utils.StringHelper").checkStringLength(this._inputGroupNameTxt.text) > 12)
         {
            this._inputGroupNameTxt.text = this._tempStr;
         }
         this._tempStr = this._inputGroupNameTxt.text;
      }
    __inputGroupNameHandler(param1) {
         this._inputGroupNameTxt.removeEventListener("keyDown",$.bind(this, "__groupTxtKeyDownHandler"));
         if(this._inputGroupNameTxt && this._inputGroupNameTxt.parent)
         {
            if(!$.C("yishi.utils.StringHelper").isNullOrEmpty($.C("yishi.utils.StringHelper").trimAll(this._inputGroupNameTxt.text)) && this._info)
            {
               if($.C("manager.FilterWordManager").containSpecificChar(this._inputGroupNameTxt.text,",|%"))
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.view.FriendItemCell.InputAgain"));
               }
               else
               {
                  $.C("managers.FriendSocketOutManager").sendRenameGroup(this._info.groupId,this._inputGroupNameTxt.text);
               }
            }
            this._inputGroupNameTxt.text = "";
            this._inputGroupNameTxt.parent.removeChild(this._inputGroupNameTxt);
         }
         if(this._inputGroupNameBg && this._inputGroupNameBg.parent)
         {
            this._inputGroupNameBg.parent.removeChild(this._inputGroupNameBg);
         }
      }
    __chatDownHandler(param1) {
         param1.stopPropagation();
      }
    __chatHandler(param1) {
         param1.stopImmediatePropagation();
         this.shining = false;
         $.C("managers.IMManager").instance.createIMFrame(this._info);
         $.C("com.pickgliss.toplevel.StageReferance").stage.dispatchEvent(new ($.C("flash.events.MouseEvent"))("mouseDown"));
      }
    __overHandler(param1) {
         if(this._info && this.checkIsCustomGroup(this._info.groupId))
         {
            this._delGroupBtn.visible = this._renameGroupBtn.visible = true;
         }
         if(!this._info || Boolean(this._info.selected))
         {
            return;
         }
         if(this._info.type == 1)
         {
            this._itemBack.setFrame(2);
         }
         else if(this._info.type == 0)
         {
            this._privateChatBtn.visible = true;
            this._itemBigBack.visible = true;
         }
      }
    __outHandler(param1) {
         if(this._delGroupBtn && this._renameGroupBtn)
         {
            this._delGroupBtn.visible = this._renameGroupBtn.visible = false;
         }
         if(!this._info || Boolean(this._info.selected))
         {
            return;
         }
         if(this._info.type == 1)
         {
            this._itemBack.setFrame(1);
         }
         else if(this._info.type == 0)
         {
            this._privateChatBtn.visible = false;
            this._itemBigBack.visible = false;
         }
      }
    __onDoubleClick(param1) {
         if(!this._info)
         {
            return;
         }
         if(this._info.type != 0)
         {
            return;
         }
         this.shining = false;
         $.C("managers.IMManager").instance.createIMFrame(this._info);
      }
    __onClick(param1) {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         $.C("yishi.manager.FriendManager").getInstance().dispatchEvent(new ($.C("events.FriendGroupEvent"))("FRIEND_ITEM_SELECTED",this._info,this));
      }
    __timerCompleteHandler(param1) {
         this._icon.headId = this._headId;
      }
    refreshBaseView() {
         if(this._info)
         {
            this._stateImg.setFrame(this._info.state);
         }
      }
    setListCellStatus(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
      }
    getCellValue() {
         return this._info;
      }
    setCellValue(param1) {
         var _loc2_ = false;
         if(this._info)
         {
            this.removeFriendListener();
            this.filters = null;
            this._info = null;
            this.shining = false;
            if(this._titleBack.parent)
            {
               this._titleBack.parent.removeChild(this._titleBack);
            }
            if(this._titleTxt.parent)
            {
               this._titleTxt.parent.removeChild(this._titleTxt);
            }
            if(this._itemBack.parent)
            {
               this._itemBack.parent.removeChild(this._itemBack);
            }
            if(this._itemBigBack.parent)
            {
               this._itemBigBack.parent.removeChild(this._itemBigBack);
            }
            if(this._icon.parent)
            {
               this._icon.parent.removeChild(this._icon);
            }
            if(this._stateImg.parent)
            {
               this._stateImg.parent.removeChild(this._stateImg);
            }
            if(this._privateChatBtn.parent)
            {
               this._privateChatBtn.parent.removeChild(this._privateChatBtn);
            }
            if(this._nameTxt.parent)
            {
               this._nameTxt.parent.removeChild(this._nameTxt);
            }
            if(this._level.parent)
            {
               this._level.parent.removeChild(this._level);
            }
            if(this._levelTxt.parent)
            {
               this._levelTxt.parent.removeChild(this._levelTxt);
            }
            if(this._mateStripView1.parent)
            {
               this._mateStripView1.parent.removeChild(this._mateStripView1);
            }
            if(this._mateStripView2.parent)
            {
               this._mateStripView2.parent.removeChild(this._mateStripView2);
            }
            if(this._shiningMC.parent)
            {
               this._shiningMC.parent.removeChild(this._shiningMC);
            }
            if(this._delGroupBtn.parent)
            {
               this._delGroupBtn.parent.removeChild(this._delGroupBtn);
            }
            if(this._renameGroupBtn.parent)
            {
               this._renameGroupBtn.parent.removeChild(this._renameGroupBtn);
            }
            if(this._inputGroupNameTxt.parent)
            {
               this._inputGroupNameTxt.parent.removeChild(this._inputGroupNameTxt);
            }
            if(this._vipText.parent)
            {
               this._vipText.parent.removeChild(this._vipText);
            }
            if(this._vocationIcon.parent)
            {
               this._vocationIcon.parent.removeChild(this._vocationIcon);
            }
         }
         this._info = $.as(param1, $.C("mvc.module.friends.FriendItemCellInfo"));
         this.addFriendListener();
         if(!this._info)
         {
            return;
         }
         if(this._info.type != 0)
         {
            this._shiningMC = this._groupShiningMC;
            this._shiningMC["content"].addChild(this._titleBack);
            this._shiningMC["content"].addChild(this._titleTxt);
            this._itemBack.setFrame(1);
            this._titleTxt.htmlText = this._info.title;
            this.addChildAt(this._shiningMC,0);
            this.addChildAt(this._itemBack,0);
            if(this.checkIsCustomGroup(this._info.groupId))
            {
               this.addChild(this._renameGroupBtn);
               this.addChild(this._delGroupBtn);
            }
            this.checkGroupIsShine();
         }
         else
         {
            this._shiningMC = this._friendShiningMC;
            this._shiningMC["content"].addChild(this._icon);
            this._shiningMC["content"].addChild(this._stateImg);
            this._nameTxt.text = this._info.nickName;
            if(this._info.isCross)
            {
               this._nameTxt.text = this._info.nickName + "(" + this._info.serviceName + ")";
            }
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendItemCell.levelTxt1");
            this._levelTxt.text = String(this._info.grades);
            if(this._info.isCross)
            {
               if(this._headId != this._info.pics)
               {
                  this._headId = this._info.pics;
                  this._timer.reset();
                  this._timer.start();
               }
            }
            else if(this._headId != this._info.snsInfo.headId)
            {
               this._headId = this._info.snsInfo.headId;
               this._timer.reset();
               this._timer.start();
            }
            this._stateImg.setFrame(this._info.state);
            if(!this._info.isOnline)
            {
               this.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            }
            this.addChild(this._itemBigBack);
            this.addChild(this._privateChatBtn);
            this.addChild(this._nameTxt);
            this.addChild(this._vipText);
            this.addChild(this._vocationIcon);
            this.addChild(this._level);
            this.addChild(this._levelTxt);
            this.addChild(this._shiningMC);
            _loc2_ = this._info.groupId == -2;
            this.setPositionByType(_loc2_);
            this.checkFriendIsShine();
         }
         this.update();
      }
    setPositionByType(param1) {
         var _loc2_ = 0;
         var _loc3_ = null;
         if(param1)
         {
            this._itemBigBack.height = 85;
            this._shiningMC.y = 15;
            this.addChild(this._mateStripView1);
            this.addChild(this._mateStripView2);
            this._mateStripView1.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendItemCell.happies",$.C("managers.MarryManager").instance.model.marriageData.happyInfo.happyGrade);
            this._mateTxt1.text = "x" + $.C("managers.MarryManager").instance.model.marriageData.happyInfo.happyGrade;
            _loc2_ = $.int($.C("managers.MarryManager").instance.model.marriageData.ringInfo.ringGrade);
            if(_loc2_ > 9)
            {
               _loc2_ = 9;
            }
            this._mateRing.icon = $.C("yishi.utils.IconFactory").getMarryRingIcon(_loc2_);
            this._mateRingTxt.text = "" + $.C("managers.MarryManager").instance.model.marriageData.ringInfo.ringGrade;
            this._mateBuff.icon = $.C("yishi.utils.IconFactory").getMarryBuffIconByHappies($.C("managers.MarryManager").instance.model.marriageData.happyInfo.happyGp);
            _loc3_ = new ($.C("mvc.module.marry.MarryTipData"))();
            _loc3_.type = 2;
            _loc3_.grades = $.C("managers.MarryManager").instance.model.marriageData.ringInfo.ringGrade;
            _loc3_.nickNameB = $.C("yishi.manager.ArmyManager").instance.thane.nickName;
            this._mateStripView2.tipData = _loc3_;
            _loc3_ = new ($.C("mvc.module.marry.MarryTipData"))();
            _loc3_.type = 1;
         }
         else
         {
            this._itemBigBack.height = 45;
            this._privateChatBtn.y = 19;
            this._nameTxt.y = 0;
            this._vipText.y = 0;
            this._vocationIcon.y = 18;
            this._level.y = 22;
            this._levelTxt.y = 22;
            this._shiningMC.y = 2;
         }
      }
    update() {
         if(this._info.IsVipAndNoExpirt)
         {
            this._vipText.visible = true;
            this._nameTxt.visible = false;
            this._vipText.text = this._nameTxt.text;
         }
         else
         {
            this._vipText.visible = false;
            this._nameTxt.visible = true;
         }
         if(this._info.type == -1)
         {
            this._titleBack.setFrame(3);
            this._titleTxt.setFrame(4);
            return;
         }
         if(this._info.selected)
         {
            this._titleBack.setFrame(2);
            this._titleTxt.setFrame(2);
            if(this._info.type == 0)
            {
               this._itemBigBack.visible = true;
            }
         }
         else
         {
            this._titleBack.setFrame(1);
            this._titleTxt.setFrame(1);
            if(this._info.type == 0)
            {
               this._itemBigBack.visible = false;
            }
         }
         this.refreshVocation();
      }
    refreshVocation() {
         var _loc1_ = 0;
         if(this._info && this._info.vocationGrades > 0)
         {
            _loc1_ = $.int(this._info.isCross || !this._info.templateInfo ? this._info.job : $.int(this._info.templateInfo.Job));
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName(_loc1_,this._info.vocationStep,this._info.vocationLevel);
            this._vocationIcon.setFrame(this._info.vocationLevel);
            this._vocationIcon.visible = true;
            this._levelTxt.x = 114;
         }
         else
         {
            this._vocationIcon.visible = false;
            this._levelTxt.x = 87;
         }
      }
    checkIsCustomGroup(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         for (var _loc2_ of $.values($.C("yishi.manager.FriendManager").getInstance().groupDic))
         {
            if(param1 != 2 && param1 == _loc2_.groupId)
            {
               return true;
            }
         }
         return false;
      }
    checkGroupIsShine() {
         var _loc1_ = null;
         var _loc2_ = this.imManager.model.unreadMsgDic.keys;
         for (var _loc3_ of $.values(_loc2_))
         {
            _loc1_ = this.imManager.getFriendInfo(_loc3_);
            if(_loc1_ && this._info && this._info.type == 1 && !this._info.selected && this._info.groupId == _loc1_.groupId)
            {
               this.shining = true;
            }
         }
      }
    checkFriendIsShine() {
         if(this._info && this._info.type == 0 && this._info.isShine)
         {
            this.shining = true;
         }
      }
    set shining(param1) {
         if(param1)
         {
            this._shiningMC.gotoAndPlay(1);
         }
         else
         {
            this._shiningMC.gotoAndStop(1);
         }
      }
    setTitleVisible(param1) {
         if(param1)
         {
            if(this._titleTxt)
            {
               this.addChild(this._titleTxt);
            }
         }
         else if(this._titleTxt && this._titleTxt.parent)
         {
            this._titleTxt.parent.removeChild(this._titleTxt);
         }
         $.trace("setTitleVisible" + param1);
      }
    get imManager() {
         return $.C("managers.IMManager").instance;
      }
    asDisplayObject() {
         return this;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._titleBack)
         {
            this._titleBack.dispose();
         }
         this._titleBack = null;
         if(this._titleTxt)
         {
            this._titleTxt.dispose();
         }
         this._titleTxt = null;
         if(this._itemBack)
         {
            this._itemBack.dispose();
         }
         this._itemBack = null;
         if(this._itemBigBack)
         {
            this._itemBigBack.dispose();
         }
         this._itemBigBack = null;
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._stateImg)
         {
            this._stateImg.dispose();
         }
         this._stateImg = null;
         if(this._privateChatBtn)
         {
            this._privateChatBtn.dispose();
         }
         this._privateChatBtn = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._level)
         {
            this._level.dispose();
         }
         this._level = null;
         if(this._levelTxt)
         {
            this._levelTxt.dispose();
         }
         this._levelTxt = null;
         if(this._vocationIcon)
         {
            this._vocationIcon.dispose();
         }
         this._vocationIcon = null;
         if(this._alert)
         {
            this._alert.dispose();
         }
         this._alert = null;
         if(this._shiningMC)
         {
            this._shiningMC.stop();
         }
         this._shiningMC = null;
         if(this._groupShiningMC)
         {
            this._groupShiningMC.stop();
         }
         this._groupShiningMC = null;
         if(this._friendShiningMC)
         {
            this._friendShiningMC.stop();
         }
         this._friendShiningMC = null;
         if(this._delGroupBtn)
         {
            this._delGroupBtn.dispose();
         }
         this._delGroupBtn = null;
         if(this._renameGroupBtn)
         {
            this._renameGroupBtn.dispose();
         }
         this._renameGroupBtn = null;
         if(this._inputGroupNameTxt)
         {
            this._inputGroupNameTxt.dispose();
         }
         this._inputGroupNameTxt = null;
         if(this._inputGroupNameBg)
         {
            this._inputGroupNameBg.dispose();
         }
         this._inputGroupNameBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vipText);
         this._vipText = null;
         if(this._timer)
         {
            this._timer.stop();
         }
         this._timer = null;
         this._info = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get shining() { return super.shining; }
    set imManager(v) { super.imManager = v; }
  }
  $.meta(__FriendItemCell, "friends.view.FriendItemCell", ["Disposeable", "IListCell"]);
  return __FriendItemCell;
}
deps["friends.view.FriendItemCell"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "events.FriendGroupEvent", "flash.display.Sprite", "flash.events.MouseEvent", "flash.geom.Point", "flash.utils.Timer", "manager.FilterWordManager", "manager.LanguageMgr", "managers.FriendSocketOutManager", "managers.IMManager", "managers.MarryManager", "mvc.module.friends.FriendItemCellInfo", "mvc.module.marry.MarryTipData", "yishi.filter.UIFilter", "yishi.manager.ArmyManager", "yishi.manager.FriendManager", "yishi.manager.PlayerManager", "yishi.utils.IconFactory", "yishi.utils.SimpleAlertHelper", "yishi.utils.StringHelper", "yishi.view.tips.MessageTipManager"];

defs["friends.view.FriendSelectedButton"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.SelectedCheckButton");
  class __FriendSelectedButton extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    setFrame(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         super.setFrame(param1);
         if($.is(this._field, $.C("com.pickgliss.ui.text.FilterFrameText")) && !this.selected)
         {
            $.C("com.pickgliss.utils.DisplayUtils").setFrame(this._field,param1);
         }
      }
  }
  $.meta(__FriendSelectedButton, "friends.view.FriendSelectedButton", []);
  return __FriendSelectedButton;
}
deps["friends.view.FriendSelectedButton"] = ["com.pickgliss.ui.controls.SelectedCheckButton", "com.pickgliss.ui.text.FilterFrameText", "com.pickgliss.utils.DisplayUtils"];

defs["friends.view.FriendsFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __FriendsFrame extends __Base {
    static $fields(self) {
    self._scaleFrameBg = null;
    self._bg = null;
    self._friendTab = null;
    self._consortiaTab = null;
    self._communityTab = null;
    self._nickname = null;
    self._level = null;
    self._mood = null;
    self._moodBg = null;
    self._moodRollBg = null;
    self._moodRollEnabled = false;
    self._buttonGroup = null;
    self._groupChatButton = null;
    self._addButton = null;
    self._treeButton = null;
    self._headCell = null;
    self._stateComBox = null;
    self._friendsList = null;
    self._consortiaView = null;
    self._consortiaPanel = null;
    self._vocationIcon = null;
    self._snsInfo = null;
    self._tempStr = "";
    self._tipButton = null;
    }
    constructor() {
         super();
         $.C("managers.FriendSocketOutManager").requestCrossFriendMsg(4);
         this.initView();
         this.addEvent();
         this.control.currentPanel = 1;
      }
    get groups() {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
    addChildren() {
         super.addChildren();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.title");
         this._scaleFrameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMFriendsFrameScaleBg");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.DescribeScrollPanelBack");
         this._stateComBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateComBox");
         this._stateComBox.setData();
         this._nickname = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.heroNicknameTextStyle");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.heroLevelTextStyle");
         this._moodBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.HeroMoodBg");
         this._moodRollBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.HeroMoodRollBg");
         this._mood = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.heroMoodTextStyle");
         this._friendTab = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsButton");
         this._consortiaTab = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.UnionButton");
         this._communityTab = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.CommunityButton");
         this._groupChatButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.groupChatBtn");
         this._addButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.addfriendBtn");
         this._treeButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.treeBtn");
         this._friendsList = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.FridendsListView");
         this._consortiaView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.ConsortiaMenuView");
         this._consortiaPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.ConsortiaDescribeScrollPanel");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.VocationIcon");
         this._vocationIcon.visible = false;
         this._mood.mouseEnabled = true;
         this._moodBg.visible = false;
         this._moodRollBg.mouseEnabled = false;
         this._moodRollBg.visible = false;
         this._moodRollEnabled = true;
         this.addToContent(this._scaleFrameBg);
         this.addToContent(this._bg);
         this.addToContent(this._friendTab);
         this.addToContent(this._consortiaTab);
         this.addToContent(this._nickname);
         this.addToContent(this._level);
         this.addToContent(this._moodBg);
         this.addToContent(this._moodRollBg);
         this.addToContent(this._mood);
         this.addToContent(this._groupChatButton);
         this.groupChatBtnState();
         this.addToContent(this._addButton);
         this.addToContent(this._friendsList);
         this.addToContent(this._consortiaPanel);
         this.addToContent(this._stateComBox);
         this._communityTab.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.title");
         this._nickname.text = this.thane.nickName;
         if(this._nickname.text.substring(this._nickname.text.length - 3) == "..." && this.thane.nickName.substring(this.thane.nickName.length - 3) != "...")
         {
            this._tipButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.CloseBtn");
            this._tipButton.x = this._nickname.x;
            this._tipButton.y = this._nickname.y;
            this._tipButton.width = this._nickname.width;
            this._tipButton.height = this._nickname.height;
            this._tipButton.alpha = 0;
            this._tipButton.tipData = this.thane.nickName;
            this.addToContent(this._tipButton);
            this._tipButton.tipGapH = 0;
            this._tipButton.tipGapV = 0;
         }
         this._mood.text = this.thane.snsInfo.sign != "" ? this.thane.snsInfo.sign : $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.inputSignTip");
         this.simplifyThaneSign();
         this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this.thane.grades);
         this._consortiaTab.enable = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.consortiaID <= 0 ? false : true;
         this._communityTab.enable = false;
         this._buttonGroup = new ($.C("com.pickgliss.ui.controls.SelectedButtonGroup"))();
         this._buttonGroup.addSelectItem(this._friendTab);
         this._buttonGroup.addSelectItem(this._consortiaTab);
         this._buttonGroup.addSelectItem(this._communityTab);
         this._buttonGroup.selectIndex = 0;
         this._consortiaPanel.setView(this._consortiaView);
         this._consortiaPanel.visible = false;
         var _loc1_ = new ($.C("friends.view.SearchFriendView"))();
         this.addToContent(_loc1_);
         this._headCell = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("friends.HeadIconCell");
         this._headCell.headId = this.thane.snsInfo.headId;
         this.addToContent(this._headCell);
         this.addToContent(this._vocationIcon);
         this.refreshVocation();
      }
    refreshVocation() {
         if(this.thane && this.thane.vocationGrades > 0)
         {
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName(this.thane.templateInfo.Job,this.thane.vocationStep,this.thane.vocationLevel);
            this._vocationIcon.setFrame(this.thane.vocationLevel);
            this._vocationIcon.visible = true;
            this._level.x = this._vocationIcon.x + this._vocationIcon.width;
         }
         else
         {
            this._vocationIcon.visible = false;
            this._level.x = this._vocationIcon.x;
         }
      }
    groupChatBtnState() {
         if(this.player.consortiaID > 0)
         {
            this._groupChatButton.enable = true;
         }
         else
         {
            this._groupChatButton.enable = false;
         }
      }
    get player() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get imModel() {
         return $.C("managers.IMManager").instance.model;
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponse"));
         this._groupChatButton.addEventListener("click",$.bind(this, "__groupChatHandler"));
         this._addButton.addEventListener("click",$.bind(this, "__addHandler"));
         this._friendTab.addEventListener("click",$.bind(this, "__friendTabHandler"));
         this._consortiaTab.addEventListener("click",$.bind(this, "__consortiaTabHandler"));
         this._consortiaView.addEventListener("SHOW_MEMBER_LIST",$.bind(this, "__updataConsortiaView"));
         this._headCell.addEventListener("click",$.bind(this, "__onPlayerIconClick"));
         this.thane.addEventListener("NICKNAME_UPDATE",$.bind(this, "__nickNameHandler"));
         $.C("managers.SNSManager").instance.addEventListener("SNSINFO_UPDATE",$.bind(this, "__snsInfoUpdateHandler"));
         this.player.addEventListener("CONSORTIA_CHANGE",$.bind(this, "__onConsortiaChangeHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this._mood);
         this._mood.addEventListener("interactive_click",$.bind(this, "__onMoodClickHandler"));
         this._mood.addEventListener("change",$.bind(this, "__moodInputHandler"));
         this._mood.addEventListener("rollOver",$.bind(this, "__onRollOverHandler"));
         this._mood.addEventListener("rollOut",$.bind(this, "__onRollOutHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponse"));
         if(this._groupChatButton)
         {
            this._groupChatButton.removeEventListener("click",$.bind(this, "__groupChatHandler"));
         }
         if(this._addButton)
         {
            this._addButton.removeEventListener("click",$.bind(this, "__addHandler"));
         }
         if(this._friendTab)
         {
            this._friendTab.removeEventListener("click",$.bind(this, "__friendTabHandler"));
         }
         if(this._consortiaTab)
         {
            this._consortiaTab.removeEventListener("click",$.bind(this, "__consortiaTabHandler"));
         }
         if(this._consortiaView)
         {
            this._consortiaView.removeEventListener("SHOW_MEMBER_LIST",$.bind(this, "__updataConsortiaView"));
         }
         if(this._headCell)
         {
            this._headCell.removeEventListener("click",$.bind(this, "__onPlayerIconClick"));
         }
         this.thane.removeEventListener("NICKNAME_UPDATE",$.bind(this, "__nickNameHandler"));
         $.C("managers.SNSManager").instance.removeEventListener("SNSINFO_UPDATE",$.bind(this, "__snsInfoUpdateHandler"));
         this.player.removeEventListener("CONSORTIA_CHANGE",$.bind(this, "__onConsortiaChangeHandler"));
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this._mood);
         this._mood.removeEventListener("interactive_click",$.bind(this, "__onMoodClickHandler"));
         this._mood.removeEventListener("focusOut",$.bind(this, "__moodFocusOutHandler"));
         this._mood.removeEventListener("keyDown",$.bind(this, "__onMoodKeyDown"));
         this._mood.removeEventListener("change",$.bind(this, "__moodInputHandler"));
         this._mood.removeEventListener("rollOver",$.bind(this, "__onRollOverHandler"));
         this._mood.removeEventListener("rollOut",$.bind(this, "__onRollOutHandler"));
      }
    __onRollOverHandler(param1) {
         if(this._moodRollEnabled)
         {
            this._moodRollBg.visible = true;
         }
      }
    __onRollOutHandler(param1) {
         if(this._moodRollEnabled)
         {
            this._moodRollBg.visible = false;
         }
      }
    __moodInputHandler(param1) {
         if($.C("yishi.utils.StringHelper").checkStringLength(this._mood.text) > 100)
         {
            this._mood.text = this._tempStr;
         }
         this._tempStr = this._mood.text;
      }
    __onMoodClickHandler(param1) {
         if(!this._moodRollEnabled)
         {
            return;
         }
         this._moodRollBg.visible = false;
         this._moodRollEnabled = false;
         this._mood.mouseEnabled = false;
         this._mood.type = "input";
         this._mood.text = this.thane.snsInfo.sign != "" ? this.thane.snsInfo.sign : $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.inputSignTip");
         this._mood.setSelection(0,this._mood.length);
         this._mood.setFocus();
         this._moodBg.visible = true;
         this._mood.addEventListener("focusOut",$.bind(this, "__moodFocusOutHandler"));
         this._mood.addEventListener("keyDown",$.bind(this, "__onMoodKeyDown"));
      }
    __moodFocusOutHandler(param1) {
         this._moodRollEnabled = true;
         this._mood.removeEventListener("focusOut",$.bind(this, "__moodFocusOutHandler"));
         this._mood.removeEventListener("keyDown",$.bind(this, "__onMoodKeyDown"));
         this._mood.mouseEnabled = true;
         this._mood.type = "dynamic";
         this._moodBg.visible = false;
         if(this._mood.text != this.thane.snsInfo.sign && this._mood.text != $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.inputSignTip"))
         {
            if(!this._snsInfo)
            {
               this._snsInfo = new ($.C("mvc.module.sns.BaseSnsInfo"))();
            }
            this._snsInfo.sign = this._mood.text;
            $.C("managers.SNSManager").instance.sendAutoSaveInfo(this._snsInfo);
         }
         else
         {
            this._mood.text = this.thane.snsInfo.sign != "" ? this.thane.snsInfo.sign : $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.inputSignTip");
         }
         this.simplifyThaneSign();
      }
    __onMoodKeyDown(param1) {
         if(param1.keyCode == 13)
         {
            this.__moodFocusOutHandler(null);
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this;
         }
      }
    __onConsortiaChangeHandler(param1) {
         this.groupChatBtnState();
      }
    __nickNameHandler(param1) {
         this._nickname.text = this.thane.nickName;
      }
    __snsInfoUpdateHandler(param1) {
         this._mood.text = this.thane.snsInfo.sign != "" ? this.thane.snsInfo.sign : $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsFrame.inputSignTip");
         this.simplifyThaneSign();
         if(this._headCell.headId != this.thane.snsInfo.headId)
         {
            this._headCell.headId = this.thane.snsInfo.headId;
         }
      }
    simplifyThaneSign() {
         { const __m = this._mood;
            if(__m.textWidth > __m.width)
            {
               __m.text = __m.text.substring(0,__m.getCharIndexAtPoint(__m.width - 22,5)) + "...";
            }
         }
      }
    __frameResponse(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
               this.dispose();
               break;
            case 1:
               this.dispose();
         }
      }
    get control() {
         return $.C("yishi.manager.FrameControllerManager").instance.friendControler;
      }
    __groupChatHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonShine = false;
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = false;
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortiagroupchat");
      }
    __addHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         param1.stopPropagation();
         this.control.openFindFriendFrame();
      }
    __onPlayerIconClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.armyController.openChangeHeadFrame();
      }
    __friendTabHandler(param1) {
         this.control.currentPanel = 1;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._friendsList.visible = true;
         this._consortiaPanel.visible = false;
      }
    __consortiaTabHandler(param1) {
         this.control.currentPanel = 2;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._friendsList.visible = false;
         this._consortiaPanel.visible = true;
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToSpecial(this,3,true,true,1,-100,0,0,true);
      }
    dispose() {
         this.control.closeFindFriendFrame();
         this.control.currentPanel = 0;
         this.removeEvent();
         this.uninit();
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("managers.IMManager").instance.friendBtnShining = true;
      }
    uninit() {
         if(this._scaleFrameBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scaleFrameBg);
         }
         this._scaleFrameBg = null;
         if(this._bg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         }
         this._bg = null;
         if(this._tipButton)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipButton);
         }
         this._tipButton = null;
         if(this._friendTab)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._friendTab);
         }
         this._friendTab = null;
         if(this._consortiaTab)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consortiaTab);
         }
         this._consortiaTab = null;
         if(this._communityTab)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._communityTab);
         }
         this._communityTab = null;
         if(this._nickname)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nickname);
         }
         this._nickname = null;
         if(this._mood)
         {
            this._mood.dispose();
         }
         this._mood = null;
         if(this._moodBg)
         {
            this._moodBg.dispose();
         }
         this._moodBg = null;
         if(this._moodRollBg)
         {
            this._moodRollBg.dispose();
         }
         this._moodRollBg = null;
         if(this._level)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         }
         this._level = null;
         if(this._groupChatButton)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._groupChatButton);
         }
         this._groupChatButton = null;
         if(this._addButton)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._addButton);
         }
         this._addButton = null;
         if(this._friendsList)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._friendsList);
         }
         this._friendsList = null;
         if(this._headCell)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headCell);
         }
         this._headCell = null;
         if(this._stateComBox)
         {
            this._stateComBox.dispose();
         }
         this._stateComBox = null;
         if(this._treeButton)
         {
            this._treeButton.dispose();
         }
         this._treeButton = null;
         if(this._buttonGroup)
         {
            this._buttonGroup.dispose();
         }
         this._buttonGroup = null;
         if(this._consortiaPanel)
         {
            this._consortiaPanel.dispose();
         }
         this._consortiaPanel = null;
         if(this._consortiaView)
         {
            this._consortiaView.dispose();
         }
         this._consortiaView = null;
         if(this._vocationIcon)
         {
            this._vocationIcon.dispose();
         }
         this._vocationIcon = null;
         this._snsInfo = null;
         this._tempStr = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    __updataConsortiaView(param1) {
         this._consortiaPanel.invalidateViewport();
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,302,537);
      }
    set groups(v) { super.groups = v; }
    set player(v) { super.player = v; }
    set thane(v) { super.thane = v; }
    set imModel(v) { super.imModel = v; }
    set control(v) { super.control = v; }
    set viewRectangle(v) { super.viewRectangle = v; }
  }
  $.meta(__FriendsFrame, "friends.view.FriendsFrame", ["IManualSize"]);
  return __FriendsFrame;
}
deps["friends.view.FriendsFrame"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.SelectedButtonGroup", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Rectangle", "friends.view.SearchFriendView", "manager.LanguageMgr", "managers.FriendSocketOutManager", "managers.IMManager", "managers.SNSManager", "mvc.module.sns.BaseSnsInfo", "ui.maintoolbar.MainToolBar", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.utils.StringHelper"];

defs["friends.view.FriendsHelpFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __FriendsHelpFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._content = null;
    self._confirm = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._content = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.friends.FriendsHelp");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.friendsHelpBack");
         this._confirm = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.friendsHelpConfirmBtn");
         this._confirm.text = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         this.addToContent(this._bg);
         this.addToContent(this._content);
         this.addToContent(this._confirm);
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.view.FriendsHelpFrame.title");
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__frameResposeHandler"));
         this._confirm.addEventListener("click",$.bind(this, "__onClickHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResposeHandler"));
         this._confirm.removeEventListener("click",$.bind(this, "__onClickHandler"));
      }
    __onClickHandler(param1) {
         this.dispose();
      }
    __frameResposeHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
               this.dispose();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._content);
         this._content = null;
         super.dispose();
      }
  }
  $.meta(__FriendsHelpFrame, "friends.view.FriendsHelpFrame", []);
  return __FriendsHelpFrame;
}
deps["friends.view.FriendsHelpFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.keyboard.KeyBoardRegister"];

defs["friends.view.IMHistoryCellAdapter"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __IMHistoryCellAdapter extends __Base {
    static $fields(self) {
    self._data = null;
    }
    constructor() {
         super();
      }
    setListCellStatus(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
      }
    getCellValue() {
         return this._data;
      }
    setCellValue(param1) {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._data = param1;
         if(this._data)
         {
            this.addChild(this._data);
         }
      }
    dispose() {
         if(this._data)
         {
            this._data.dispose();
         }
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__IMHistoryCellAdapter, "friends.view.IMHistoryCellAdapter", ["IListCell"]);
  return __IMHistoryCellAdapter;
}
deps["friends.view.IMHistoryCellAdapter"] = ["com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils"];

defs["friends.view.RecommendFriendFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __RecommendFriendFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._list = null;
    self._currentItem = null;
    self._itemList = null;
    self._data = null;
    self._isScaleMove = false;
    self._bottomBg = null;
    self._bottomAllAdd = null;
    self._bottomClose = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
         this.createItem();
         this.refresh();
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendBG");
         var _loc1_ = new ($.C("flash.display.Sprite"))();
         var _loc7_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendTitleBG");
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendIDTxt");
         _loc3_.text = "ID";
         var _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendNameTxt");
         _loc5_.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.RecommendFriendFrame.name");
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendLVTxt");
         _loc2_.text = $.C("manager.LanguageMgr").GetTranslation("public.grade");
         var _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendSEXTxt");
         _loc8_.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.RecommendFriendFrame.sex");
         var _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendPowerTxt");
         _loc6_.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendFunTxt");
         _loc4_.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.RecommendFriendFrame.fun");
         this._bottomBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.BottomBg");
         this._bottomAllAdd = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.BottomAllAddBtn");
         this._bottomClose = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.BottomCloseBtn");
         _loc1_.addChild(_loc7_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc5_);
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc8_);
         _loc1_.addChild(_loc6_);
         _loc1_.addChild(_loc4_);
         _loc1_.addChild(this._bottomBg);
         _loc1_.addChild(this._bottomAllAdd);
         _loc1_.addChild(this._bottomClose);
         this._list = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendVbox");
         this.addToContent(this._bg);
         this.addToContent(_loc1_);
         this.addToContent(this._list);
         this.escEnable = true;
         _loc1_.x = 3;
         _loc1_.y = 5;
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.view.RecommendFriendFrame.title");
         this._itemList = new $.Vector();
      }
    initEvents() {
         this.addEventListener("response",$.bind(this, "_respose"));
         $.C("yishi.manager.FriendManager").getInstance().addEventListener("UPDATE_RECOMONDLIST",$.bind(this, "__updateListHandler"));
         this._bottomAllAdd.addEventListener("click",$.bind(this, "__bottomAllAddHandler"));
         this._bottomClose.addEventListener("click",$.bind(this, "__bottomCloseHandler"));
      }
    removeEvents() {
         this.removeEventListener("response",$.bind(this, "_respose"));
         $.C("yishi.manager.FriendManager").getInstance().removeEventListener("UPDATE_RECOMONDLIST",$.bind(this, "__updateListHandler"));
         if(this._bottomAllAdd)
         {
            this._bottomAllAdd.removeEventListener("click",$.bind(this, "__bottomAllAddHandler"));
         }
         if(this._bottomClose)
         {
            this._bottomClose.removeEventListener("click",$.bind(this, "__bottomCloseHandler"));
         }
      }
    __bottomAllAddHandler(param1) {
         var _loc4_ = 0;
         var _loc3_ = false;
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._data = $.C("yishi.manager.FriendManager").getInstance().recommendList;
         while(_loc4_ < this._data.length)
         {
            _loc3_ = Boolean($.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(this._data[_loc4_].name,1));
            if(_loc3_)
            {
               _loc2_ = $.as(this._data[_loc4_], $.C("mvc.module.friends.RecommendInfo"));
               this.changeState(_loc2_);
            }
            _loc4_++;
         }
      }
    changeState(param1) {
         var _loc3_ = 0;
         var _loc4_ = null;
         var _loc2_ = -1;
         _loc3_ = 0;
         while(_loc3_ < this._itemList.length)
         {
            _loc4_ = $.as(this._itemList[_loc3_].data, $.C("mvc.module.friends.RecommendInfo"));
            if(_loc4_.id == param1.id)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ >= 0)
         {
            this._itemList[_loc3_].isAddFriend = false;
         }
      }
    __bottomCloseHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this.dispose();
      }
    __updateListHandler(param1) {
         this.refresh();
      }
    _respose(param1) {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            this.dispose();
         }
      }
    _itemClick(param1) {
         var _loc2_ = $.as(param1.currentTarget, $.C("friends.view.RecommendFriendItem"));
         if(this._currentItem)
         {
            this._currentItem.selected = false;
         }
         this._currentItem = _loc2_;
         this._currentItem.selected = true;
      }
    _scaleMoveToFriendBtn() {
         this.isScaleMove = false;
         var _loc1_ = new ($.C("flash.geom.Point"))($.C("com.pickgliss.toplevel.StageReferance").stageWidth - 250,$.C("com.pickgliss.toplevel.StageReferance").stageHeight - 30);
         $.C("com.greensock.TweenMax").to(this,0.5,{
            "scaleX":0.01,
            "scaleY":0.01,
            "x":_loc1_.x,
            "y":_loc1_.y,
            "onComplete":$.bind(this, "_moveComplete")
         });
      }
    _moveComplete() {
         $.C("ui.maintoolbar.MainToolBar").instance.blinkFriendBtn();
         this.dispose();
      }
    createItem() {
         var _loc2_ = 0;
         var _loc1_ = null;
         while(_loc2_ < 10)
         {
            _loc1_ = new ($.C("friends.view.RecommendFriendItem"))();
            _loc1_.filterString = "core.DefaultFilter,core.LightFilter";
            _loc1_.index = _loc2_;
            this._itemList.push(_loc1_);
            this._list.addChild(_loc1_);
            _loc1_.addEventListener("click",$.bind(this, "_itemClick"));
            _loc2_++;
         }
      }
    refresh() {
         var _loc2_ = 0;
         var _loc1_ = null;
         this._data = $.C("yishi.manager.FriendManager").getInstance().recommendList;
         while(_loc2_ < this._itemList.length)
         {
            _loc1_ = this._itemList[_loc2_];
            if(_loc1_ && _loc2_ < this._data.length)
            {
               _loc1_.data = this._data[_loc2_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc2_++;
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    set isScaleMove(param1) {
         this._isScaleMove = param1;
      }
    get isScaleMove() {
         return this._isScaleMove;
      }
    getAddBtnByIndex(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1 < this._itemList.length)
         {
            return this._itemList[param1].addBtn;
         }
         return null;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvents();
         for (var _loc1_ of $.values(this._itemList))
         {
            _loc1_.removeEventListener("click",$.bind(this, "_itemClick"));
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._itemList.splice(0,this._itemList.length);
         this._itemList = null;
         this._currentItem = null;
         if(this._bg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         }
         this._bg = null;
         if(this._list)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._list);
         }
         this._list = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    set groups(v) { super.groups = v; }
  }
  $.meta(__RecommendFriendFrame, "friends.view.RecommendFriendFrame", []);
  return __RecommendFriendFrame;
}
deps["friends.view.RecommendFriendFrame"] = ["com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "flash.geom.Point", "friends.view.RecommendFriendItem", "manager.LanguageMgr", "mvc.module.friends.RecommendInfo", "ui.maintoolbar.MainToolBar", "yishi.datas.ComponentGroupType", "yishi.keyboard.KeyBoardRegister", "yishi.manager.FriendManager"];

defs["friends.view.RecommendFriendItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RecommendFriendItem extends __Base {
    static $fields(self) {
    self._index = 0;
    self._selected = false;
    self._background = null;
    self._sexBG = null;
    self._itemSelectBG = null;
    self._idtxt = null;
    self._nametxt = null;
    self._LVtxt = null;
    self._powertxt = null;
    self._addBtn = null;
    self._vocationIcon = null;
    self._data = null;
    self._frameFilter = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvents();
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         this.updata();
         this.refreshVocation();
      }
    refreshVocation() {
         var _loc1_ = null;
         if(this._data && this._data.vocationGrades > 0)
         {
            _loc1_ = new ($.C("yishi.datas.playerinfo.SimplePlayerInfo"))();
            _loc1_.vocationGrades = this._data.vocationGrades;
            _loc1_.vocationIndex = this._data.vocationIndex;
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName($.C("com.road.pb.helper.army.ThaneInfoHelper").getJob(this._data.job),_loc1_.vocationStep,_loc1_.vocationLevel);
            this._vocationIcon.setFrame(_loc1_.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    initView() {
         this._background = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.YieldItemBack");
         this._background.width = 462;
         this._idtxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendItemIDTxt");
         this._nametxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendItemNameTxt");
         this._LVtxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendItemLVTxt");
         this._powertxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendItemPowerTxt");
         this._addBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommentAddFriend");
         this._addBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.RecommendFriendItem.addBtn.text");
         this._itemSelectBG = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendpageBg");
         this._sexBG = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendIconBG");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortia.Recommend.VocationIcon");
         this.addChild(this._background);
         this.addChild(this._idtxt);
         this.addChild(this._nametxt);
         this.addChild(this._LVtxt);
         this.addChild(this._powertxt);
         this.addChild(this._addBtn);
         this.addChild(this._itemSelectBG);
         this.addChild(this._sexBG);
         this.addChild(this._vocationIcon);
         this._addBtn.visible = false;
         this._sexBG.visible = false;
         this._itemSelectBG.visible = false;
         this._itemSelectBG.width = 471;
         this._itemSelectBG.mouseEnabled = this._itemSelectBG.mouseChildren = false;
         this._vocationIcon.visible = false;
      }
    initEvents() {
         this._addBtn.addEventListener("click",$.bind(this, "_addClick"));
      }
    removeEvents() {
         this.removeEventListener("mouseOver",$.bind(this, "_over"));
         this.removeEventListener("mouseOut",$.bind(this, "_out"));
         this._addBtn.removeEventListener("click",$.bind(this, "_addClick"));
      }
    _addClick(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if($.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(this._nametxt.text,1))
         {
            this.isAddFriend = false;
         }
      }
    set index(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._index = param1 + 1;
         this._background.setFrame(this._index % 2 + 1);
      }
    clean() {
         this._idtxt.text = "";
         this._nametxt.text = "";
         this._LVtxt.text = "";
         this._powertxt.text = "";
         this._addBtn.visible = false;
         this._sexBG.visible = false;
         this._itemSelectBG.visible = false;
         this.buttonMode = false;
         this._itemSelectBG.width = 471;
         this._itemSelectBG.mouseEnabled = this._itemSelectBG.mouseChildren = false;
         this.removeEventListener("mouseOver",$.bind(this, "_over"));
         this.removeEventListener("mouseOut",$.bind(this, "_out"));
         this.filters = this._frameFilter[2];
      }
    updata() {
         this.clean();
         if(this._data)
         {
            this._idtxt.text = String(this._index);
            this._nametxt.text = this._data.name;
            this._LVtxt.text = this._data.level.toString();
            this._sexBG.setFrame(this._data.sex + 1);
            this._powertxt.text = this._data.attack.toString();
            this._addBtn.visible = true;
            this._addBtn.enable = true;
            this._sexBG.visible = true;
            this.buttonMode = true;
            this.addEventListener("mouseOver",$.bind(this, "_over"));
            this.addEventListener("mouseOut",$.bind(this, "_out"));
         }
      }
    set filterString(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._frameFilter = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatFrameFilters(param1);
      }
    _over(param1) {
         this._itemSelectBG.visible = true;
         this.filters = this._frameFilter[1];
      }
    _out(param1) {
         this._itemSelectBG.visible = this.selected;
         this.filters = this._frameFilter[2];
      }
    set isAddFriend(param1) {
         this._addBtn.enable = param1;
      }
    get isAddFriend() {
         return this._addBtn.enable;
      }
    set selected(param1) {
         this._selected = param1;
         this._itemSelectBG.visible = this._selected && this._data != null;
      }
    get selected() {
         return this._selected;
      }
    get height() {
         return this._background.height;
      }
    get addBtn() {
         return this._addBtn;
      }
    dispose() {
         this.removeEvents();
         if(this._background)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._background);
         }
         this._background = null;
         if(this._idtxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._idtxt);
         }
         this._idtxt = null;
         if(this._nametxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nametxt);
         }
         this._nametxt = null;
         if(this._LVtxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._LVtxt);
         }
         this._LVtxt = null;
         if(this._sexBG)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sexBG);
         }
         this._sexBG = null;
         if(this._powertxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._powertxt);
         }
         this._powertxt = null;
         if(this._addBtn)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._addBtn);
         }
         this._addBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get index() { return super.index; }
    get filterString() { return super.filterString; }
    set height(v) { super.height = v; }
    set addBtn(v) { super.addBtn = v; }
  }
  $.meta(__RecommendFriendItem, "friends.view.RecommendFriendItem", ["Disposeable"]);
  return __RecommendFriendItem;
}
deps["friends.view.RecommendFriendItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "com.road.pb.helper.army.ThaneInfoHelper", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.SimplePlayerInfo", "yishi.manager.FriendManager", "yishi.manager.PlayerManager"];

defs["friends.view.SearchFriendView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __SearchFriendView extends __Base {
    static $fields(self) {
    self._searchText = null;
    self._bg = null;
    self._btn = null;
    self._searchList = null;
    self._tempStr = "";
    }
    constructor() {
         super();
         this.init();
         this.initEvent();
      }
    init() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.searchBg");
         this.addChild(this._bg);
         this._btn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.searchBtn");
         this.addChild(this._btn);
         this._btn.selected = false;
         this._btn.mouseEnabled = false;
         this._searchText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.SearchTextStyle");
         this.addChild(this._searchText);
         this._searchList = new ($.C("friends.view.FriendAutoSearchBox"))();
         this._searchList.x = this._searchText.x;
         this._searchList.y = this._searchText.y + this._searchText.height;
      }
    uninit() {
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._searchText = null;
      }
    initEvent() {
         this._searchText.addEventListener("change",$.bind(this, "_textChange"));
         this._searchText.addEventListener("click",$.bind(this, "__inHandler"));
         this._searchText.addEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         this._btn.addEventListener("click",$.bind(this, "__deleteHandler"));
      }
    removeEvent() {
         if(this._searchText)
         {
            this._searchText.removeEventListener("change",$.bind(this, "_textChange"));
            this._searchText.removeEventListener("click",$.bind(this, "__inHandler"));
            this._searchText.removeEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         }
         if(this._btn)
         {
            this._btn.removeEventListener("click",$.bind(this, "__deleteHandler"));
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("click",$.bind(this, "__stageClick"));
      }
    __deleteHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this._searchText.text = "";
         this.hideList();
         this._btn.selected = false;
         this._btn.mouseEnabled = false;
      }
    _textChange(param1) {
         if(this._searchText.text == "")
         {
            this.hideList();
            this._btn.selected = false;
            this._btn.mouseEnabled = false;
         }
         else
         {
            this.showList();
            this._btn.selected = true;
            this._btn.mouseEnabled = true;
            if($.C("yishi.utils.StringHelper").checkStringLength(this._searchText.text) > 12)
            {
               this._searchText.text = this._tempStr;
            }
            this._tempStr = this._searchText.text;
         }
      }
    __keyDownHandler(param1) {
         param1.stopPropagation();
      }
    hideList() {
         if(this._searchList.parent)
         {
            this._searchList.parent.removeChild(this._searchList);
         }
      }
    showList() {
         this._searchList.setSearchString(this._searchText.text);
         this.addChild(this._searchList);
      }
    __inHandler(param1) {
         $.C("yishi.manager.IMEManager").enable();
         this._textChange(null);
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("click",$.bind(this, "__stageClick"));
      }
    __stageClick(param1) {
         if(this.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            return;
         }
         if($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain($.as(param1.target, $.C("flash.display.DisplayObject")),this._searchList))
         {
            return;
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("click",$.bind(this, "__stageClick"));
         this.hideList();
      }
    dispose() {
         this.removeEvent();
         this.uninit();
         if(this._searchList)
         {
            this._searchList.dispose();
         }
         this._searchList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__SearchFriendView, "friends.view.SearchFriendView", ["Disposeable"]);
  return __SearchFriendView;
}
deps["friends.view.SearchFriendView"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.DisplayUtils", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.DisplayObject", "flash.display.Sprite", "friends.view.FriendAutoSearchBox", "yishi.manager.IMEManager", "yishi.utils.StringHelper"];

defs["friends.view.ToolInviteFriendFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ToolInviteFriendFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._titlebarImg = null;
    self._nameTxt = null;
    self._gradeTxt = null;
    self._operationTxt = null;
    self._applyList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendFrame.titleText");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteDescribeBackground");
         this._titlebarImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.friends.InviteTitlebarBg");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameNameTextStyle");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameGradeTextStyle");
         this._operationTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameOperationTextStyle");
         this._applyList = new ($.C("friends.view.ToolInviteFriendList"))();
         this._applyList.x = -5;
         this._applyList.y = 43;
         this.addToContent(this._bg);
         this.addToContent(this._titlebarImg);
         this.addToContent(this._nameTxt);
         this.addToContent(this._gradeTxt);
         this.addToContent(this._operationTxt);
         this.addToContent(this._applyList);
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendFrame.nameTxtText");
         this._nameTxt.text = _loc3_;
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.grade");
         this._gradeTxt.text = _loc1_;
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendFrame.operationTxtText");
         this._operationTxt.text = _loc2_;
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "_respose"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "_respose"));
      }
    _respose(param1) {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            this.dispose();
         }
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         super.dispose();
      }
    set groups(v) { super.groups = v; }
  }
  $.meta(__ToolInviteFriendFrame, "friends.view.ToolInviteFriendFrame", []);
  return __ToolInviteFriendFrame;
}
deps["friends.view.ToolInviteFriendFrame"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "friends.view.ToolInviteFriendList", "manager.LanguageMgr", "yishi.datas.ComponentGroupType", "yishi.keyboard.KeyBoardRegister"];

defs["friends.view.ToolInviteFriendItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ToolInviteFriendItem extends __Base {
    static $fields(self) {
    self._colorBg = null;
    self._nameTxt = null;
    self._sexBG = null;
    self._gradeTxt = null;
    self._acceptBtn = null;
    self._rejectBtn = null;
    self._vocationIcon = null;
    self._data = null;
    self._menu = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._colorBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemHightcolorBg");
         this._sexBG = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendIconBG");
         this._sexBG.x = 0;
         this._sexBG.y = 0;
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemNameTextStyle");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemGradeTextStyle");
         this._acceptBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemAcceptBtn");
         this._rejectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemRejectBtn");
         this._nameTxt.htmlText = "";
         var _loc1_ = new ($.C("flash.text.StyleSheet"))();
         _loc1_.setStyle("a:hover",{"textDecoration":"underline"});
         this._nameTxt.styleSheet = _loc1_;
         this._gradeTxt.text = "";
         this._acceptBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.accept");
         this._rejectBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.reject");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortia.InvitePlayer.VocationIcon");
         this.addChild(this._colorBg);
         this.addChild(this._sexBG);
         this._sexBG.visible = false;
         this.addChild(this._nameTxt);
         this._nameTxt.width = 100;
         this._nameTxt.height = 20;
         this.addChild(this._gradeTxt);
         this._gradeTxt.width = 50;
         this._gradeTxt.height = 20;
         this.addChild(this._acceptBtn);
         this._acceptBtn.visible = false;
         this.addChild(this._rejectBtn);
         this._rejectBtn.visible = false;
         this.addChild(this._vocationIcon);
         this._vocationIcon.visible = false;
      }
    initEvent() {
         this._acceptBtn.addEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.addEventListener("click",$.bind(this, "__onRejectHandler"));
         this._nameTxt.addEventListener("link",$.bind(this, "__link"));
      }
    removeEvent() {
         this._acceptBtn.removeEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.removeEventListener("click",$.bind(this, "__onRejectHandler"));
         this._nameTxt.removeEventListener("link",$.bind(this, "__link"));
      }
    __link(param1) {
         if(this._menu)
         {
            this._menu.dispose();
         }
         this._menu = null;
         this._menu = new ($.C("chat.view.ChatItemMenu"))(this._data.nickName,this._data.id,false,this._data.serverName,false,false,false,false,false,this._data.uuid);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
         this._menu.x = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseX;
         this._menu.y = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseY;
      }
    __onAcceptHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.friendHandler(true);
      }
    __onRejectHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.friendHandler(false);
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.command01");
         $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
      }
    friendHandler(param1) {
         var _loc2_ = null;
         if(param1)
         {
            if(this.isCross)
            {
               $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(0,this._data.uuid);
            }
            else
            {
               if($.C("yishi.manager.FriendManager").getInstance().countFriend >= $.C("yishi.manager.FriendManager").getInstance().maxFriendCount)
               {
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.manager.FriendManager.command02");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
                  return;
               }
               if($.C("yishi.manager.FriendManager").getInstance().countFriend < $.C("yishi.manager.FriendManager").getInstance().maxFriendCount)
               {
                  $.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(this._data.nickName,1);
               }
            }
         }
         $.C("yishi.manager.FriendManager").getInstance().removeToolInviteFriend(this._data);
      }
    get colorBg() {
         return this._colorBg;
      }
    refreshVocation() {
         var _loc1_ = null;
         if(this._data && this._data.vocationGrades > 0)
         {
            _loc1_ = new ($.C("yishi.datas.playerinfo.SimplePlayerInfo"))();
            _loc1_.vocationGrades = this._data.vocationGrades;
            _loc1_.vocationIndex = this._data.vocationIndex;
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName($.C("com.road.pb.helper.army.ThaneInfoHelper").getJob(this._data.job),_loc1_.vocationStep,_loc1_.vocationLevel);
            this._vocationIcon.setFrame(_loc1_.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    set data(param1) {
         this._data = param1;
         if(this._data)
         {
            this._nameTxt.htmlText = "<a href=\'event:clickLink\'>" + this._data.nickName + "</a> ";
            this._sexBG.setFrame(this._data.sex + 1);
            this._gradeTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.grades);
            this._acceptBtn.visible = true;
            this._rejectBtn.visible = true;
            this._sexBG.visible = true;
         }
         else
         {
            this._nameTxt.htmlText = "";
            this._gradeTxt.text = "";
            this._acceptBtn.visible = false;
            this._rejectBtn.visible = false;
            this._sexBG.visible = false;
         }
         this.refreshVocation();
      }
    get data() {
         return this._data;
      }
    get isCross() {
         return this._data.serverName != null && this._data.serverName != "" && this._data.serverName != this.playerInfo.serviceName;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._acceptBtn = null;
         this._rejectBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set colorBg(v) { super.colorBg = v; }
    set isCross(v) { super.isCross = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__ToolInviteFriendItem, "friends.view.ToolInviteFriendItem", ["Disposeable"]);
  return __ToolInviteFriendItem;
}
deps["friends.view.ToolInviteFriendItem"] = ["chat.view.ChatItemMenu", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "com.road.pb.helper.army.ThaneInfoHelper", "flash.display.Sprite", "flash.text.StyleSheet", "manager.LanguageMgr", "yishi.datas.playerinfo.SimplePlayerInfo", "yishi.manager.FriendManager", "yishi.manager.PlayerManager", "yishi.view.tips.MessageTipManager"];

defs["friends.view.ToolInviteFriendList"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ToolInviteFriendList extends __Base {
    static $fields(self) {
    self._acceptBtn = null;
    self._rejectBtn = null;
    self._data = null;
    self._inviteNum = 0;
    self._pageTxt = null;
    self._prePageBtn = null;
    self._nextPageBtn = null;
    self._pageBg = null;
    self._infosItemList = null;
    self._pageNum = 0;
    self._pageNumMax = 8;
    self._recruitCurrentPage = 1;
    self._recruitListTotalPage = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.initData();
      }
    initView() {
         this._data = $.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList;
         this._inviteNum = 0;
         this._pageNum = this._pageNumMax;
         this._acceptBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerAcceptBtn");
         this._rejectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerRejectBtn");
         this._prePageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerPrePageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerNextPageBtn");
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerPageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePageTextStyle");
         this._infosItemList = new $.Vector();
         this._acceptBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendList.accept");
         this._rejectBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendList.reject");
         this._acceptBtn.enable = true;
         this._rejectBtn.enable = true;
         this._pageTxt.text = "1/1";
         this.addChild(this._acceptBtn);
         this.addChild(this._rejectBtn);
         this.addChild(this._prePageBtn);
         this.addChild(this._nextPageBtn);
         this.addChild(this._pageBg);
         this.addChild(this._pageTxt);
      }
    addEvent() {
         this._prePageBtn.addEventListener("click",$.bind(this, "__onPageBtnHandler"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onPageBtnHandler"));
         this._acceptBtn.addEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.addEventListener("click",$.bind(this, "__onRejectHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("INVITE_UPDATE",$.bind(this, "__updateInvate"));
      }
    removeEvent() {
         this._prePageBtn.removeEventListener("click",$.bind(this, "__onPageBtnHandler"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onPageBtnHandler"));
         this._acceptBtn.removeEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.removeEventListener("click",$.bind(this, "__onRejectHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("INVITE_UPDATE",$.bind(this, "__updateInvate"));
      }
    __onPageBtnHandler(param1) {
         if(param1.currentTarget == this._prePageBtn)
         {
            if(this._recruitCurrentPage <= 1)
            {
               return;
            }
            this._recruitCurrentPage = this._recruitCurrentPage - 1;
         }
         else
         {
            if(this._recruitCurrentPage >= this._recruitListTotalPage)
            {
               return;
            }
            this._recruitCurrentPage = this._recruitCurrentPage + 1;
         }
         this.__updateInvate(null);
      }
    __onAcceptHandler(param1) {
         var _loc3_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
         this._acceptBtn.enable = this._rejectBtn.enable = false;
         while(_loc2_ > 0)
         {
            _loc3_ = $.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList[0];
            if(_loc3_.serverName != null && _loc3_.serverName != "" && _loc3_.serverName != $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.serviceName)
            {
               $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(0,_loc3_.uuid);
            }
            else
            {
               $.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(_loc3_.nickName,1);
            }
            $.C("yishi.manager.FriendManager").getInstance().removeToolInviteFriend(_loc3_);
            _loc2_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
         }
         this._pageTxt.text = "1/1";
      }
    __onRejectHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendList.rejectAlert");
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "rejectCall")];
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame($.C("manager.LanguageMgr").GetTranslation("public.prompt"),_loc2_,$.C("manager.LanguageMgr").GetTranslation("public.confirm"),$.C("manager.LanguageMgr").GetTranslation("public.cancel"));
      }
    rejectCall(param1, param2) {
         var _loc4_ = 0;
         var _loc5_ = null;
         var _loc3_ = null;
         if(param1)
         {
            this._acceptBtn.enable = this._rejectBtn.enable = false;
            _loc4_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
            while(_loc4_ > 0)
            {
               _loc5_ = $.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList[0];
               $.C("yishi.manager.FriendManager").getInstance().removeToolInviteFriend(_loc5_);
               _loc4_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
            }
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
            this._pageTxt.text = "1/1";
         }
      }
    initData() {
         this.setItemList();
         this._recruitCurrentPage = 1;
         this.refreshList();
         this.setPageBtnEnable();
      }
    setItemList() {
         var _loc2_ = 0;
         var _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < this._pageNumMax)
         {
            _loc1_ = new ($.C("friends.view.ToolInviteFriendItem"))();
            _loc1_.y = _loc2_ * 33;
            _loc1_.colorBg.setFrame(_loc2_ % 2 + 1);
            this.addChild(_loc1_);
            this._infosItemList.push(_loc1_);
            _loc2_++;
         }
      }
    __updateInvate(param1) {
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this._pageNumMax)
         {
            this._infosItemList[_loc2_].data = null;
            _loc2_++;
         }
         if($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length > 0)
         {
            this._acceptBtn.enable = true;
            this._rejectBtn.enable = true;
         }
         else
         {
            this._acceptBtn.enable = false;
            this._rejectBtn.enable = false;
         }
         this.refreshList();
         this.setPageBtnEnable();
      }
    refreshList() {
         var _loc4_ = 0;
         var _loc1_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
         var _loc3_ = _loc1_ / 8;
         if(_loc1_ % 8 != 0 || _loc3_ == 0)
         {
            this._recruitListTotalPage = _loc3_ + 1;
         }
         else
         {
            this._recruitListTotalPage = _loc3_;
         }
         var _loc2_ = 8;
         if(this._recruitCurrentPage < 1)
         {
            this._recruitCurrentPage = 1;
         }
         if(this._recruitCurrentPage == this._recruitListTotalPage)
         {
            _loc2_ = _loc1_ % 8;
         }
         if(_loc1_ > 0 && _loc2_ == 0)
         {
            _loc2_ = 8;
         }
         this._pageTxt.text = this._recruitCurrentPage + "/" + this._recruitListTotalPage;
         _loc4_ = 0;
         while(_loc4_ < this._pageNumMax)
         {
            if(_loc2_ > _loc4_)
            {
               this._infosItemList[_loc4_].data = $.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList[_loc4_ + (this._recruitCurrentPage - 1) * 8];
            }
            _loc4_++;
         }
      }
    setPageBtnEnable() {
         this._prePageBtn.enable = this._recruitCurrentPage > 1;
         this._nextPageBtn.enable = this._recruitCurrentPage < this._recruitListTotalPage;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
         this._prePageBtn = null;
         this._nextPageBtn = null;
         this._acceptBtn = null;
         this._rejectBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ToolInviteFriendList, "friends.view.ToolInviteFriendList", ["Disposeable"]);
  return __ToolInviteFriendList;
}
deps["friends.view.ToolInviteFriendList"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "friends.view.ToolInviteFriendItem", "manager.LanguageMgr", "yishi.manager.FriendManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["friends.view.ToolJoinTeamFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ToolJoinTeamFrame extends __Base {
    static $fields(self) {
    self._bg = null;
    self._bg2 = null;
    self._nameTxt = null;
    self._gradeTxt = null;
    self._operationTxt = null;
    self._applyList = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("chatII.view.ChatItemMenu.applyJoinBtn");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friend.applyJoinBg");
         this._bg2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friend.applyJoinBg2");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameNameTextStyle");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameGradeTextStyle");
         this._operationTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.FriendsInviteFrameOperationTextStyle");
         this._applyList = new ($.C("friends.view.ToolJoinTeamList"))();
         this._applyList.x = 0;
         this._applyList.y = 39;
         this.addToContent(this._bg);
         this.addToContent(this._bg2);
         this.addToContent(this._nameTxt);
         this.addToContent(this._gradeTxt);
         this.addToContent(this._operationTxt);
         this.addToContent(this._applyList);
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendFrame.nameTxtText");
         this._nameTxt.text = _loc3_;
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.grade");
         this._gradeTxt.text = _loc1_;
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendFrame.operationTxtText");
         this._operationTxt.text = _loc2_;
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "_respose"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("TEAMCAPTAINCHANGE",$.bind(this, "_teamcaptainChange"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "_respose"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("TEAMCAPTAINCHANGE",$.bind(this, "_teamcaptainChange"));
      }
    _respose(param1) {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            this.dispose();
         }
      }
    _teamcaptainChange(param1) {
         this.dispose();
      }
    show() {
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,true,1);
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         this.y = ($.C("com.pickgliss.toplevel.StageReferance").stageHeight - 353) / 2;
      }
    get displayHeight() {
         return 353;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         super.dispose();
      }
    set groups(v) { super.groups = v; }
    set displayHeight(v) { super.displayHeight = v; }
  }
  $.meta(__ToolJoinTeamFrame, "friends.view.ToolJoinTeamFrame", ["Disposeable"]);
  return __ToolJoinTeamFrame;
}
deps["friends.view.ToolJoinTeamFrame"] = ["com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "friends.view.ToolJoinTeamList", "manager.LanguageMgr", "yishi.datas.ComponentGroupType", "yishi.keyboard.KeyBoardRegister", "yishi.manager.NotificationManager"];

defs["friends.view.ToolJoinTeamItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ToolJoinTeamItem extends __Base {
    static $fields(self) {
    self._data = null;
    self._line = null;
    self._nameTxt = null;
    self._sexBG = null;
    self._gradeTxt = null;
    self._acceptBtn = null;
    self._rejectBtn = null;
    self._vocationIcon = null;
    self._menu = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friend.applyJoinItemLine");
         this._sexBG = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.RecommendIconBG");
         this._sexBG.x = 0;
         this._sexBG.y = 0;
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemNameTextStyle");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemGradeTextStyle");
         this._acceptBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemAcceptBtn");
         this._rejectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerItemRejectBtn");
         this._nameTxt.htmlText = "";
         var _loc1_ = new ($.C("flash.text.StyleSheet"))();
         _loc1_.setStyle("a:hover",{"textDecoration":"underline"});
         this._nameTxt.styleSheet = _loc1_;
         this._gradeTxt.text = "";
         this._acceptBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.accept");
         this._rejectBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.reject");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortia.InvitePlayer.VocationIcon");
         this.addChild(this._line);
         this.addChild(this._sexBG);
         this._sexBG.visible = false;
         this.addChild(this._nameTxt);
         this._nameTxt.width = 100;
         this._nameTxt.height = 20;
         this.addChild(this._gradeTxt);
         this._gradeTxt.width = 50;
         this._gradeTxt.height = 20;
         this.addChild(this._acceptBtn);
         this._acceptBtn.visible = false;
         this.addChild(this._rejectBtn);
         this._rejectBtn.visible = false;
         this.addChild(this._vocationIcon);
         this._vocationIcon.visible = false;
      }
    initEvent() {
         this._acceptBtn.addEventListener("click",$.bind(this, "__acceptBtnHandler"));
         this._rejectBtn.addEventListener("click",$.bind(this, "__rejectBtnHandler"));
         this._nameTxt.addEventListener("link",$.bind(this, "__link"));
      }
    removeEvent() {
         this._acceptBtn.removeEventListener("click",$.bind(this, "__acceptBtnHandler"));
         this._rejectBtn.removeEventListener("click",$.bind(this, "__rejectBtnHandler"));
         this._nameTxt.removeEventListener("link",$.bind(this, "__link"));
      }
    __acceptBtnHandler(param1) {
         $.C("managers.FreedomTeamManager").instance.joinTeamOp(0,this._data.userId);
      }
    __rejectBtnHandler(param1) {
         $.C("managers.FreedomTeamManager").instance.joinTeamOp(1,this._data.userId);
      }
    __link(param1) {
         if(this._menu)
         {
            this._menu.dispose();
         }
         this._menu = null;
         this._menu = new ($.C("chat.view.ChatItemMenu"))(this._data.nickName,this._data.userId,false);
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
         this._menu.x = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseX;
         this._menu.y = $.C("com.pickgliss.toplevel.StageReferance").stage.mouseY;
      }
    set data(param1) {
         if(!param1)
         {
            this._nameTxt.htmlText = "";
            this._gradeTxt.htmlText = "";
            this._acceptBtn.visible = false;
            this._rejectBtn.visible = false;
            this._sexBG.visible = false;
            this._vocationIcon.visible = false;
            return;
         }
         this._data = param1;
         this._nameTxt.htmlText = "<a href=\'event:clickLink\'>" + this._data.nickName + "</a> ";
         this._gradeTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.lv);
         this._sexBG.visible = true;
         this._sexBG.setFrame(this._data.sex + 1);
         this._acceptBtn.visible = true;
         this._rejectBtn.visible = true;
         this.refreshVocation();
      }
    refreshVocation() {
         var _loc1_ = null;
         if(this._data && this._data.transGrade > 0)
         {
            _loc1_ = new ($.C("yishi.datas.playerinfo.SimplePlayerInfo"))();
            _loc1_.vocationGrades = this._data.transGrade;
            _loc1_.vocationIndex = this._data.transIndex;
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName($.C("com.road.pb.helper.army.ThaneInfoHelper").getJob(this._data.job),_loc1_.vocationStep,_loc1_.vocationLevel);
            this._vocationIcon.setFrame(_loc1_.vocationLevel);
            this._vocationIcon.visible = true;
         }
         else
         {
            this._vocationIcon.visible = false;
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sexBG);
         this._sexBG = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeTxt);
         this._gradeTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._acceptBtn);
         this._acceptBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._rejectBtn);
         this._rejectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vocationIcon);
         this._vocationIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._menu);
         this._menu = null;
      }
    get data() { return super.data; }
  }
  $.meta(__ToolJoinTeamItem, "friends.view.ToolJoinTeamItem", ["Disposeable"]);
  return __ToolJoinTeamItem;
}
deps["friends.view.ToolJoinTeamItem"] = ["chat.view.ChatItemMenu", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.road.pb.helper.army.ThaneInfoHelper", "flash.display.Sprite", "flash.text.StyleSheet", "manager.LanguageMgr", "managers.FreedomTeamManager", "yishi.datas.playerinfo.SimplePlayerInfo", "yishi.manager.PlayerManager"];

defs["friends.view.ToolJoinTeamList"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ToolJoinTeamList extends __Base {
    static $fields(self) {
    self._vbox = null;
    self._scrollPanel = null;
    self._acceptBtn = null;
    self._rejectBtn = null;
    self._data = null;
    self._pageNumMax = 10;
    self._itemList = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.initData();
      }
    initView() {
         this._data = $.C("yishi.manager.FriendManager").getInstance().applyJoinList;
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friend.applyJoinScrollPanel");
         this._vbox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vbox.spacing = 1;
         this._itemList = [];
         this._acceptBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerAcceptBtn");
         this._rejectBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.InvitePlayerRejectBtn");
         this._acceptBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendList.accept");
         this._rejectBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendList.reject");
         this._acceptBtn.enable = true;
         this._rejectBtn.enable = true;
         this._scrollPanel.setView(this._vbox);
         this.addChild(this._scrollPanel);
         this.addChild(this._acceptBtn);
         this.addChild(this._rejectBtn);
         this._acceptBtn.x = 65;
         this._acceptBtn.y = 169;
         this._rejectBtn.x = 210;
         this._rejectBtn.y = 169;
      }
    addEvent() {
         this._acceptBtn.addEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.addEventListener("click",$.bind(this, "__onRejectHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("REFRESH_JOINTEAMLIST",$.bind(this, "__updateJoinTeamList"));
      }
    removeEvent() {
         this._acceptBtn.removeEventListener("click",$.bind(this, "__onAcceptHandler"));
         this._rejectBtn.removeEventListener("click",$.bind(this, "__onRejectHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("REFRESH_JOINTEAMLIST",$.bind(this, "__updateJoinTeamList"));
      }
    __onAcceptHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.int($.C("yishi.manager.FriendManager").getInstance().toolInviteFriendList.length);
         $.C("managers.FreedomTeamManager").instance.joinTeamOp(3);
      }
    __onRejectHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolJoinTeamList.rejectAlert");
         $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "rejectCall")];
         $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame($.C("manager.LanguageMgr").GetTranslation("public.prompt"),_loc2_,$.C("manager.LanguageMgr").GetTranslation("public.confirm"),$.C("manager.LanguageMgr").GetTranslation("public.cancel"));
      }
    rejectCall(param1, param2) {
         var _loc3_ = null;
         if(param1)
         {
            $.C("managers.FreedomTeamManager").instance.joinTeamOp(2);
            this._rejectBtn.enable = false;
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.view.ToolInviteFriendItem.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
         }
      }
    initData() {
         this.refreshList();
      }
    __updateJoinTeamList(param1) {
         if($.C("yishi.manager.FriendManager").getInstance().applyJoinList.length > 0)
         {
            this._acceptBtn.enable = true;
            this._rejectBtn.enable = true;
         }
         else
         {
            this._acceptBtn.enable = false;
            this._rejectBtn.enable = false;
         }
         this.refreshList();
      }
    refreshList() {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc4_ = $.C("yishi.manager.FriendManager").getInstance().applyJoinList;
         if(!this._itemList)
         {
            this._itemList = [];
         }
         else
         {
            this.clearArr(this._itemList);
         }
         this._vbox.removeAllChild();
         var _loc1_ = $.int(_loc4_.length > 5 ? _loc4_.length : 5);
         if(_loc1_ > 5)
         {
            this._scrollPanel.vScrollbar.visible = true;
         }
         else
         {
            this._scrollPanel.vScrollbar.visible = false;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = new ($.C("friends.view.ToolJoinTeamItem"))();
            if(_loc4_.length > _loc3_)
            {
               _loc2_.data = _loc4_[_loc3_];
            }
            else
            {
               _loc2_.data = null;
            }
            this._vbox.addChild(_loc2_);
            _loc3_++;
         }
         this._scrollPanel.invalidateViewport();
      }
    clearArr(param1) {
         while(param1 && param1.length > 0)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(param1.shift());
         }
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
         this._acceptBtn = null;
         this._rejectBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._scrollPanel);
         this._scrollPanel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ToolJoinTeamList, "friends.view.ToolJoinTeamList", ["Disposeable"]);
  return __ToolJoinTeamList;
}
deps["friends.view.ToolJoinTeamList"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Sprite", "friends.view.ToolJoinTeamItem", "manager.LanguageMgr", "managers.FreedomTeamManager", "yishi.manager.FriendManager", "yishi.manager.NotificationManager", "yishi.utils.SimpleAlertHelper", "yishi.view.tips.MessageTipManager"];

defs["groupchat.ConsortiaGroupChatFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ConsortiaGroupChatFrame extends __Base {
    static $fields(self) {
    self.needDispose = false;
    self._outputBack = null;
    self._inputBack = null;
    self._broadcastBack = null;
    self._buttonBack = null;
    self._titleImg = null;
    self._minimizeBtn = null;
    self._miniCloseBtn = null;
    self._consortiaBtn = null;
    self._historyBtn = null;
    self._closeBtn = null;
    self._sendBtn = null;
    self._updateBtn = null;
    self._shineSwitchBtn = null;
    self._expressionBtn = null;
    self._expressionList = null;
    self._notice = null;
    self._broadCastTitle = null;
    self._broadCast = null;
    self._broadCastTip = null;
    self._memberListTitle = null;
    self._input = null;
    self._menberList = null;
    self._output = null;
    self._vBox = null;
    self._warningIcon = null;
    self._warningText = null;
    self._menberListArray = null;
    self._onLine = 0;
    self._currentInChannel = 0;
    self._lastData = null;
    self._selfCount = 1;
    self._timeLimit = false;
    self._timerID = 0;
    self._menu = null;
    self._isBroChanged = false;
    self._scrollValue = 0;
    self._broadcastFocusOutChange = "";
    self._historyView = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
         this.mouseEnabled = false;
         this._output.mouseEnabled = false;
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,602,462);
      }
    get groups() {
         return ["GROUPCHAT"];
      }
    initView() {
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.spacing = 0;
         this._vBox.mouseEnabled = false;
         this._output = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ChatList");
         this._output.setView(this._vBox,true);
         this._outputBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ChatListBack");
         this._inputBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.InputBack");
         this._broadcastBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.BroadCastBack");
         this._buttonBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ButtonBack");
         this._titleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.consortiagroupchat.TitleText");
         this._minimizeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MinimizeBtn");
         this._miniCloseBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MiniCloseBtn");
         this._consortiaBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ConsortiaBtn");
         this._historyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.HistoryBtn");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.CloseBtn");
         this._sendBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.SendBtn");
         this._updateBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.UpdateBtn");
         this._shineSwitchBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ShineSwitchBtn");
         this._expressionBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ChatExpressionBtn");
         this._broadCastTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.BroadCastTitleText");
         this._broadCast = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.BroadCastText");
         this._broadCastTip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.BroadCastInputTipTextStyle");
         this._memberListTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MenberListTitleText");
         this._input = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.InputText");
         this._menberList = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MenberListPanel");
         this._warningIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.WarningIcon");
         this._warningText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.WarningText");
         this._consortiaBtn.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.consortiaBtnTxt");
         this._historyBtn.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.historyBtnTxt");
         this._closeBtn.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.closeBtnTxt");
         this._sendBtn.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.sendBtnTxt");
         this._updateBtn.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.updateBtnTxt");
         this._broadCastTitle.text = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.broadCastTitle");
         this._broadCastTip.text = $.C("manager.LanguageMgr").GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.pronouncement");
         this._broadCastTip.visible = false;
         this._warningText.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMChatInfoView.Notice");
         this._sendBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.send");
         this._broadCast.selectable = this._broadCast.mouseEnabled = false;
         this._updateBtn.enable = false;
         this._updateBtn.visible = false;
         this._input.maxChars = 84;
         if(this.model.shineSwitch)
         {
            this._shineSwitchBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("groupchat.ConsortiaGroupChatFrame.shineClose");
            this._shineSwitchBtn.selected = false;
         }
         else
         {
            this._shineSwitchBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("groupchat.ConsortiaGroupChatFrame.shineOpen");
            this._shineSwitchBtn.selected = true;
         }
         this.addToContent(this._outputBack);
         this.addToContent(this._inputBack);
         this.addToContent(this._broadcastBack);
         this.addToContent(this._buttonBack);
         this.addToContent(this._titleImg);
         this.addToContent(this._minimizeBtn);
         this.addToContent(this._miniCloseBtn);
         this.addToContent(this._shineSwitchBtn);
         this.addToContent(this._expressionBtn);
         this.addToContent(this._consortiaBtn);
         this.addToContent(this._historyBtn);
         this.addToContent(this._closeBtn);
         this.addToContent(this._sendBtn);
         this.addToContent(this._updateBtn);
         this.addToContent(this._warningIcon);
         this.addToContent(this._warningText);
         this.addToContent(this._broadCastTitle);
         this.addToContent(this._broadCast);
         this.addToContent(this._broadCastTip);
         this.addToContent(this._memberListTitle);
         this.addToContent(this._input);
         this.addToContent(this._menberList);
         this.addToContent(this._output);
         this._expressionBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("chat.view.ChatView.command06");
         this._currentInChannel = 5;
         this.setBroadCast();
         this.setBroadCastState();
         this._input.setFocus();
      }
    initData() {
         var _loc3_ = 0;
         var _loc1_ = null;
         this._vBox.removeAllChild();
         var _loc2_ = $.int(this.model.curConsortiaChats.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.model.curConsortiaChats[_loc3_];
            this.appendChatData(_loc1_);
            _loc3_++;
         }
         this.refreshView();
      }
    initEvent() {
         this.addEventListener("response",$.bind(this, "__response"));
         this.model.addEventListener("consortiagroupchatupdate",$.bind(this, "__updateHandler"));
         this.model.addEventListener("consortiagroupchatitemselected",$.bind(this, "__itemClickHandler"));
         this.model.addEventListener("consortiagroupchatitemupdate",$.bind(this, "__itemUpdateHandler"));
         $.C("yishi.manager.ConsortiaManager").instance.model.addEventListener("UPDATA_CONSORTIA_MEMBER",$.bind(this, "__onMemberListUpdata"));
         $.C("yishi.manager.ConsortiaManager").instance.model.addEventListener("UPDA_CONSORTIA_RIGHTS",$.bind(this, "__onMemberListUpdata"));
         $.C("yishi.manager.ConsortiaManager").instance.model.addEventListener("UPDA_CONSORTIA_INFO",$.bind(this, "__onConsortiaUpdata"));
         $.C("managers.SNSManager").instance.addEventListener("SNSINFO_UPDATE",$.bind(this, "__snsInfoUpdateHandler"));
         this._minimizeBtn.addEventListener("click",$.bind(this, "__minimizeBtnHandler"));
         this._miniCloseBtn.addEventListener("click",$.bind(this, "__onCloseClick"));
         this._consortiaBtn.addEventListener("click",$.bind(this, "__consortiaBtnHandler"));
         this._historyBtn.addEventListener("click",$.bind(this, "__historyBtnHandler"));
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseClick"));
         this._sendBtn.addEventListener("click",$.bind(this, "__sendBtnHandler"));
         this._updateBtn.addEventListener("click",$.bind(this, "__updateBtnHandler"));
         this._shineSwitchBtn.addEventListener("select",$.bind(this, "__shineSwitchHandler"));
         this._expressionBtn.addEventListener("mouseDown",$.bind(this, "___expressionBtnDownHandler"));
         this._expressionBtn.addEventListener("click",$.bind(this, "___expressionBtnClickHandler"));
         this._input.addEventListener("focusIn",$.bind(this, "__onInputFocusInHandler"));
         this._input.addEventListener("focusOut",$.bind(this, "__onInputFocusOutHandler"));
         this._input.addEventListener("keyDown",$.bind(this, "__inputKeyDownHandler"));
         this._broadCast.addEventListener("focusIn",$.bind(this, "__onBroFocusInHandler"));
         this._broadCast.addEventListener("focusOut",$.bind(this, "__onBroFocusOutHandler"));
         this._broadCast.addEventListener("change",$.bind(this, "__onBroFocusOutChangeHandler"));
         this._broadCast.addEventListener("keyDown",$.bind(this, "__keyDownHandler"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__response"));
         this.model.removeEventListener("consortiagroupchatupdate",$.bind(this, "__updateHandler"));
         this.model.removeEventListener("consortiagroupchatitemselected",$.bind(this, "__itemClickHandler"));
         this.model.removeEventListener("consortiagroupchatitemupdate",$.bind(this, "__itemUpdateHandler"));
         $.C("yishi.manager.ConsortiaManager").instance.model.removeEventListener("UPDATA_CONSORTIA_MEMBER",$.bind(this, "__onMemberListUpdata"));
         $.C("yishi.manager.ConsortiaManager").instance.model.removeEventListener("UPDA_CONSORTIA_RIGHTS",$.bind(this, "__onMemberListUpdata"));
         $.C("yishi.manager.ConsortiaManager").instance.model.removeEventListener("UPDA_CONSORTIA_INFO",$.bind(this, "__onConsortiaUpdata"));
         $.C("managers.SNSManager").instance.removeEventListener("SNSINFO_UPDATE",$.bind(this, "__snsInfoUpdateHandler"));
         this._minimizeBtn.removeEventListener("click",$.bind(this, "__minimizeBtnHandler"));
         this._miniCloseBtn.removeEventListener("click",$.bind(this, "__onCloseClick"));
         this._consortiaBtn.removeEventListener("click",$.bind(this, "__consortiaBtnHandler"));
         this._historyBtn.removeEventListener("click",$.bind(this, "__historyBtnHandler"));
         this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseClick"));
         this._sendBtn.removeEventListener("click",$.bind(this, "__sendBtnHandler"));
         this._updateBtn.removeEventListener("click",$.bind(this, "__updateBtnHandler"));
         this._shineSwitchBtn.removeEventListener("select",$.bind(this, "__shineSwitchHandler"));
         this._expressionBtn.removeEventListener("mouseDown",$.bind(this, "___expressionBtnDownHandler"));
         this._expressionBtn.removeEventListener("click",$.bind(this, "___expressionBtnClickHandler"));
         this._input.removeEventListener("focusIn",$.bind(this, "__onInputFocusInHandler"));
         this._input.removeEventListener("focusOut",$.bind(this, "__onInputFocusOutHandler"));
         this._input.removeEventListener("keyDown",$.bind(this, "__inputKeyDownHandler"));
         this._broadCast.removeEventListener("focusIn",$.bind(this, "__onBroFocusInHandler"));
         this._broadCast.removeEventListener("focusOut",$.bind(this, "__onBroFocusOutHandler"));
         this._broadCast.removeEventListener("change",$.bind(this, "__onBroFocusOutChangeHandler"));
         this._broadCast.removeEventListener("keyDown",$.bind(this, "__keyDownHandler"));
      }
    ___expressionBtnDownHandler(param1) {
         param1.stopPropagation();
      }
    ___expressionBtnClickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._expressionList)
         {
            this._expressionList.dispose();
            return;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.clearGameMenuLayer();
         if(!this._expressionList)
         {
            this._expressionList = new ($.C("chat.view.ExpressionList"))();
         }
         this._expressionList.addEventListener("dispose",$.bind(this, "__onExpressionListDispose"));
         var _loc2_ = new ($.C("flash.geom.Point"))(this._expressionBtn.x,this._expressionBtn.y);
         this._expressionList.x = this.localToGlobal(_loc2_).x - this._expressionList.width / 2 + 18;
         this._expressionList.y = this.localToGlobal(_loc2_).y - this._expressionList.height + 8;
         this._expressionList.input = this._input;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._expressionList,7);
      }
    __onExpressionListDispose(param1) {
         this._expressionList.removeEventListener("dispose",$.bind(this, "__onExpressionListDispose"));
         this._expressionList = null;
      }
    __onInputFocusInHandler(param1) {
         $.C("yishi.manager.IMEManager").enable();
      }
    __onInputFocusOutHandler(param1) {
         $.C("yishi.manager.IMEManager").disable();
      }
    __inputKeyDownHandler(param1) {
         if(param1.keyCode == 13)
         {
            this.sendChat();
         }
         param1.stopPropagation();
      }
    sendChat() {
         var _loc1_ = "";
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(this._input.text))
         {
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
            return;
         }
         if(this._timeLimit)
         {
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.command03");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_,true);
            return;
         }
         this._timeLimit = true;
         this._timerID = $.C("flash.utils.setTimeout")($.bind(this, "limitTimeOutHandler"),1000);
         var _loc2_ = this._input.text;
         _loc1_ = $.C("chat.utils.ChatHelper").parasMsgs(_loc2_);
         if(!$.C("chat.utils.ChatHelper").checkCanSend(_loc1_,this._currentInChannel))
         {
            this._input.text = "";
            return;
         }
         $.C("com.pickgliss.utils.SoundManager").instance.play("006");
         $.C("chat.ChatManager").instance.chatNormal(_loc1_,this._currentInChannel,"",[],[],[]);
         this._input.text = "";
         this._input.setFocus();
      }
    limitTimeOutHandler() {
         $.C("flash.utils.clearTimeout")(this._timerID);
         this._timeLimit = false;
      }
    __onBroFocusInHandler(param1) {
         if(!this._isBroChanged)
         {
            this._broadCastTip.visible = false;
         }
         $.C("yishi.manager.IMEManager").enable();
         this._updateBtn.enable = true;
      }
    __onBroFocusOutHandler(param1) {
         if(!this._isBroChanged && Boolean($.C("yishi.utils.StringHelper").isNullOrEmpty(this._broadCast.text)))
         {
            this._broadCastTip.visible = true;
         }
      }
    __onBroFocusOutChangeHandler(param1) {
         if(this._broadCast.textHeight > 90)
         {
            this._broadCast.text = this._broadcastFocusOutChange;
            $.C("com.pickgliss.toplevel.StageReferance").stage.focus = this._updateBtn;
         }
         this._broadcastFocusOutChange = this._broadCast.text;
      }
    __keyDownHandler(param1) {
         param1.stopPropagation();
      }
    __minimizeBtnHandler(param1) {
         if(this._historyView)
         {
            this._historyView.dispose();
         }
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = true;
         this.dispose();
      }
    __consortiaBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortia");
      }
    __historyBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this._historyView)
         {
            this._historyView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.HistoryView");
            this._historyView.addEventListener("dispose",$.bind(this, "__disposeHandler"));
            this._historyView.show(this);
         }
         else
         {
            this._historyView.dispose();
         }
      }
    __disposeHandler(param1) {
         param1.currentTarget.removeEventListener("dispose",$.bind(this, "__disposeHandler"));
         this._historyView = null;
      }
    __sendBtnHandler(param1) {
         this.sendChat();
      }
    __updateBtnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(!this._updateBtn.enable)
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.sendModifyGroupPlacard(this._broadCast.text);
         this._updateBtn.enable = false;
      }
    __shineSwitchHandler(param1) {
         if(this._shineSwitchBtn)
         {
            if(!this._shineSwitchBtn.selected)
            {
               this._shineSwitchBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("groupchat.ConsortiaGroupChatFrame.shineClose");
               this.model.shineSwitch = true;
            }
            else
            {
               this._shineSwitchBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("groupchat.ConsortiaGroupChatFrame.shineOpen");
               this.model.shineSwitch = false;
            }
         }
      }
    __updateHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("mvc.module.groupchat.ConsortiaGroupChatData"));
         this.appendChatData(_loc2_);
         this.refreshView();
      }
    __itemClickHandler(param1) {
         if(!param1.item || !param1.data)
         {
            return;
         }
         var _loc3_ = $.int($.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.userId);
         if(($.as(param1.data, $.C("yishi.datas.playerinfo.ThaneInfo"))).userId == _loc3_)
         {
            return;
         }
         $.C("yishi.manager.PlayerManager").instance.sendRequestSimpleAndSnsInfo(($.as(param1.data, $.C("yishi.datas.playerinfo.ThaneInfo"))).userId,3);
         var _loc2_ = param1.item.parent.localToGlobal(new ($.C("flash.geom.Point"))(param1.item.x,param1.item.y));
         this._menu = new ($.C("yishi.view.community.PlayerMenu"))();
         this._menu.setData(param1.data);
         this._menu.x = _loc2_.x - this._menu.width;
         this._menu.y = _loc2_.y - this._menu.height > 0 ? _loc2_.y - this._menu.height : 0;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._menu,7);
      }
    __snsInfoUpdateHandler(param1) {
         var _loc2_ = this.model.getConsortiaMemberList()[this.thane.userId];
         _loc2_.headId = this.thane.snsInfo.headId;
         this.refreshView();
      }
    __itemUpdateHandler(param1) {
         this.refreshView();
      }
    __updataDutyInfo(param1) {
         this.refreshView();
      }
    __onConsortiaUpdata(param1) {
         this.setBroadCast();
         this.refreshView();
      }
    __onMemberListUpdata(param1) {
         this.refreshView();
      }
    playToBottom(param1 = null) {
         var _loc2_ = this._output.height + this._output.vScrollbar.scrollValue >= this._output.vScrollbar.maximum;
         if(!_loc2_ && Boolean(this._output.vScrollbar.getThumbVisible()))
         {
            this._output.invalidateViewport();
            return;
         }
         this._output.invalidateViewport(true);
      }
    appendChatData(param1) {
         var _loc2_ = null;
         if(this.model.isSelfFollow(param1,this._lastData) && this._selfCount < 5)
         {
            this._output.beginChanges();
            _loc2_ = $.as(this._vBox.getChildAt(this._vBox.numChildren - 1), $.C("groupchat.view.ConsortiaGroupChatNotic"));
            _loc2_.appendText(param1);
            this._vBox.refreshChildPos();
            this.playToBottom(param1);
            this._output.commitChanges();
            this._selfCount = this._selfCount + 1;
         }
         else
         {
            while(this._vBox.numChildren >= 20)
            {
               _loc2_ = $.as(this._vBox.removeChildAt(0), $.C("groupchat.view.ConsortiaGroupChatNotic"));
               _loc2_.dispose();
            }
            _loc2_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("groupchat.view.ConsortiaGroupChatNotic")), $.C("groupchat.view.ConsortiaGroupChatNotic"));
            _loc2_.data = param1;
            this._output.beginChanges();
            this._vBox.addChild(_loc2_);
            this._vBox.refreshChildPos();
            this.playToBottom(param1);
            this._output.commitChanges();
            this._selfCount = 1;
         }
         this._lastData = param1;
      }
    exitFrame() {
         this.model.disposeAllConsortiaChats();
         this.dispose();
      }
    __response(param1) {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            this.dispose();
         }
      }
    setBroadCast() {
         var _loc1_ = Boolean($.C("yishi.manager.FrameControllerManager").instance.consortiaController.getRightsByIndex(3));
         if(_loc1_ && Boolean($.C("yishi.utils.StringHelper").isNullOrEmpty($.C("yishi.manager.FrameControllerManager").instance.consortiaController.model.consortiaInfo.groupPlacard)))
         {
            this._isBroChanged = false;
            this._broadCastTip.visible = true;
            this._broadCast.text = "";
         }
         else
         {
            this._broadCastTip.visible = false;
            this._isBroChanged = true;
            this._broadCast.text = $.C("yishi.manager.FrameControllerManager").instance.consortiaController.model.consortiaInfo.groupPlacard;
         }
         this._broadcastFocusOutChange = this._broadCast.text;
      }
    sortByValue(param1, param2) {
         if(param1.userId == this.thane.userId)
         {
            return -1;
         }
         if(param2.userId == this.thane.userId)
         {
            return 1;
         }
         return 0;
      }
    refreshView() {
         var _loc3_ = null;
         var _loc2_ = 0;
         this._scrollValue = this._menberList.vScrollbar ? this._menberList.vScrollbar.scrollValue : 0;
         this._menberListArray = this.model.getConsortiaMemberList().getList();
         this._menberListArray.sort($.bind(this, "sortByValue"));
         this._menberListArray.shift();
         this._menberListArray.sortOn(["state","dutyId","consortiaTotalOffer","userId"],[0x10 | 2,16,0x10 | 2,16]);
         this._menberListArray.unshift(this.model.getConsortiaMemberList()[this.player.userId]);
         var _loc1_ = $.int(this._menberListArray.length);
         this._onLine = 0;
         this._menberList.beginChanges();
         this._menberList.vectorListModel.clear();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = $.as(this._menberListArray[_loc2_], $.C("yishi.datas.playerinfo.ThaneInfo"));
            if(_loc3_ && _loc3_.isOnline)
            {
               this._onLine = this._onLine + 1;
            }
            this._menberList.vectorListModel.append(_loc3_);
            _loc2_++;
         }
         this._menberList.commitChanges();
         this._menberList.invalidateViewport(true);
         this._menberList.list.updateListView();
         if(this._scrollValue > 0 && this._menberList.vScrollbar)
         {
            this._menberList.vScrollbar.scrollValue = this._scrollValue;
         }
         this._memberListTitle.htmlText = $.C("manager.LanguageMgr").GetTranslation("consortiagroupchat.memberListTitle") + "[" + this.toArialBold(this._onLine + " / " + _loc1_) + "]";
         this.setBroadCastState();
         if($.C("yishi.scene.SceneManager").instance.currentType == "BATTLE_SCENE")
         {
            this._consortiaBtn.enable = false;
            this.model.isOpenGroupChatTip = true;
         }
         else
         {
            this._consortiaBtn.enable = true;
            this.model.isOpenGroupChatTip = false;
         }
         this.model.unreadGroupChat = false;
         if(this.model.shineSwitch)
         {
            $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.consortiaBtnShining = true;
         }
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    setBroadCastState() {
         var _loc1_ = Boolean($.C("yishi.manager.FrameControllerManager").instance.consortiaController.getRightsByIndex(3));
         if(_loc1_)
         {
            this._updateBtn.visible = true;
            this._broadCast.selectable = this._broadCast.mouseEnabled = true;
         }
         else
         {
            this._updateBtn.visible = false;
            this._broadCast.selectable = this._broadCast.mouseEnabled = false;
         }
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.model;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get player() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    show() {
         this.scaleX = this.scaleY = 1;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,false);
         if(this._input)
         {
            this._input.setFocus();
         }
         if(this._historyView && this._historyView.parent)
         {
            this._historyView.show(this);
         }
         if(this._lastData)
         {
            this._lastData = null;
         }
         this._selfCount = 1;
         this.initData();
         $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonShine = false;
      }
    dispose() {
         if(this.needDispose)
         {
            this.removeEvent();
            if(this._vBox)
            {
               this._vBox.disposeAllChildren();
               this._vBox.removeAllChild();
               this._vBox = null;
            }
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._outputBack);
            this._outputBack = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._inputBack);
            this._inputBack = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._broadcastBack);
            this._broadcastBack = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._buttonBack);
            this._buttonBack = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleImg);
            this._titleImg = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._minimizeBtn);
            this._minimizeBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._miniCloseBtn);
            this._miniCloseBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._shineSwitchBtn);
            this._shineSwitchBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consortiaBtn);
            this._consortiaBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._historyBtn);
            this._historyBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._closeBtn);
            this._closeBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sendBtn);
            this._sendBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._updateBtn);
            this._updateBtn = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._notice);
            this._notice = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._broadCastTitle);
            this._broadCastTitle = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._broadCast);
            this._broadCast = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._memberListTitle);
            this._memberListTitle = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._input);
            this._input = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._menberList);
            this._menberList = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._output);
            this._output = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._warningIcon);
            this._warningIcon = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._warningText);
            this._warningText = null;
            this._menberListArray = null;
            this._lastData = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._historyView);
            this._historyView = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._menberList);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._menberList);
            this._menberList = null;
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
            $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = false;
            this.model.isOpenGroupChatTip = true;
            this.model.unreadGroupChat = false;
            if(this.model.shineSwitch)
            {
               $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.consortiaBtnShining = true;
            }
            this.model.disposeCurConsortiaChats();
            super.dispose();
         }
         else
         {
            $.C("ui.maintoolbar.MainToolBar").instance.poptipButtonVisible = true;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("com.pickgliss.ui.ComponentFactory").Instance.preStylename = "";
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    set groups(v) { super.groups = v; }
    set model(v) { super.model = v; }
    set thane(v) { super.thane = v; }
    set player(v) { super.player = v; }
  }
  $.meta(__ConsortiaGroupChatFrame, "groupchat.ConsortiaGroupChatFrame", ["IManualSize"]);
  return __ConsortiaGroupChatFrame;
}
deps["groupchat.ConsortiaGroupChatFrame"] = ["chat.ChatManager", "chat.utils.ChatHelper", "chat.view.ExpressionList", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.geom.Point", "flash.geom.Rectangle", "flash.utils.clearTimeout", "flash.utils.setTimeout", "groupchat.view.ConsortiaGroupChatNotic", "manager.LanguageMgr", "managers.SNSManager", "mvc.module.groupchat.ConsortiaGroupChatData", "ui.maintoolbar.MainToolBar", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.ArmyManager", "yishi.manager.ConsortiaManager", "yishi.manager.FrameControllerManager", "yishi.manager.IMEManager", "yishi.manager.PlayerManager", "yishi.scene.SceneManager", "yishi.utils.StringHelper", "yishi.view.community.PlayerMenu", "yishi.view.tips.MessageTipManager"];

defs["groupchat.view.ConsortiaGroupChatHistoryNotice"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ConsortiaGroupChatHistoryNotice extends __Base {
    static $fields(self) {
    self._data = null;
    self._text = null;
    self._noticeIcon = null;
    self._chatText = null;
    self._textFormat = null;
    self._infoTextWidth = 234;
    self._chatTextWidth = 250;
    self._noticeIconWidth = 22;
    }
    constructor() {
         super();
      }
    set data(param1) {
         this._data = $.as(param1, $.C("mvc.module.groupchat.ConsortiaGroupChatHistoryData"));
         this._chatText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ChatListText");
         this._chatText.multiline = false;
         this._chatText.wordWrap = false;
         this.addChild(this._chatText);
         if(this._data.type == 2)
         {
            if(this._data.style == 7)
            {
               this._noticeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.consortiagroupchat.NoticeIcon");
               this.addChild(this._noticeIcon);
            }
            this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.historyInfoTextStyle_t");
            this._chatText.x = this._noticeIconWidth;
            this._chatText.width = this._infoTextWidth;
            this._chatText.defaultTextFormat = this._textFormat;
            this._chatText.text = this._data.text;
            this._chatText.setTextFormat(this._textFormat);
            this.filters = [new ($.C("flash.filters.GlowFilter"))(0,1,4,4,4)];
         }
         else if(this._data.type == 1)
         {
            if(this._data.style == 5)
            {
               this._text = "";
            }
            else if(this._data.style == 6)
            {
               this._text = "   ";
            }
            if(this._data.color == 3)
            {
               this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.historyTextStyle_t");
            }
            else if(this._data.color == 4)
            {
               if(this._data.uid == $.C("yishi.manager.ArmyManager").instance.thane.userId)
               {
                  this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.historySelfNameTextStyle_t");
               }
               else
               {
                  this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.historyNameTextStyle_t");
               }
            }
            this._chatText.width = this._chatTextWidth;
            this._chatText.defaultTextFormat = this._textFormat;
            this._chatText.text = this._text + this._data.text;
            this._chatText.setTextFormat(this._textFormat);
            this.filters = [];
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._data)
         {
            this._data.dispose();
         }
         this._data = null;
         if(this._noticeIcon)
         {
            this._noticeIcon = null;
         }
         if(this._chatText)
         {
            this._chatText.dispose();
         }
         this._chatText = null;
         if(this._textFormat)
         {
            this._textFormat = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__ConsortiaGroupChatHistoryNotice, "groupchat.view.ConsortiaGroupChatHistoryNotice", ["Disposeable"]);
  return __ConsortiaGroupChatHistoryNotice;
}
deps["groupchat.view.ConsortiaGroupChatHistoryNotice"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.filters.GlowFilter", "mvc.module.groupchat.ConsortiaGroupChatHistoryData", "yishi.manager.ArmyManager"];

defs["groupchat.view.ConsortiaGroupChatHistoryView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __ConsortiaGroupChatHistoryView extends __Base {
    static $fields(self) {
    self._back = null;
    self._titleImg = null;
    self._miniCloseBtn = null;
    self._firstPageBtn = null;
    self._lastPageBtn = null;
    self._prePageBtn = null;
    self._nextPageBtn = null;
    self._pageBg = null;
    self._pageTxt = null;
    self._output = null;
    self._vBox = null;
    self._outputWidth = 254;
    self._selfCount = 1;
    self._curPage = 0;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.__onLastPageClick(null);
         this.setPageBtnEnable();
      }
    initView() {
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.HistoryViewChatListBack");
         this._titleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.consortiagroupchat.HistoryTitleText");
         this._miniCloseBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewMiniCloseBtn");
         this._firstPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewFirstPageBtn");
         this._lastPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewLastPageBtn");
         this._prePageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPrePageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewNextPageBtn");
         this._firstPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.firstPage");
         this._lastPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.lastPage");
         this._prePageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.prePage");
         this._nextPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.nextPage");
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.IMHistoryViewPageTxt");
         this._pageTxt.text = "1 / 1";
         this._output = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.HistoryViewChatList");
         this._output.setView(this._vBox);
         this.addToContent(this._back);
         this.addToContent(this._titleImg);
         this.addToContent(this._miniCloseBtn);
         this.addToContent(this._firstPageBtn);
         this.addToContent(this._lastPageBtn);
         this.addToContent(this._prePageBtn);
         this.addToContent(this._nextPageBtn);
         this.addToContent(this._pageBg);
         this.addToContent(this._pageTxt);
         this.addToContent(this._output);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._miniCloseBtn.addEventListener("click",$.bind(this, "__onCloseClick"));
         this._firstPageBtn.addEventListener("click",$.bind(this, "__onFirstPageClick"));
         this._lastPageBtn.addEventListener("click",$.bind(this, "__onLastPageClick"));
         this._prePageBtn.addEventListener("click",$.bind(this, "__onPrePageClick"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onNextPageClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._miniCloseBtn.removeEventListener("click",$.bind(this, "__onCloseClick"));
         this._firstPageBtn.removeEventListener("click",$.bind(this, "__onFirstPageClick"));
         this._lastPageBtn.removeEventListener("click",$.bind(this, "__onLastPageClick"));
         this._prePageBtn.removeEventListener("click",$.bind(this, "__onPrePageClick"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onNextPageClick"));
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    __onFirstPageClick(param1) {
         this.curPage = 1;
      }
    __onLastPageClick(param1) {
         this.curPage = this.model.getTotalPage();
      }
    __onPrePageClick(param1) {
         if(this._curPage > 1)
         {
            this.curPage = this._curPage - 1;
         }
      }
    __onNextPageClick(param1) {
         if(this._curPage < this.model.getTotalPage())
         {
            this.curPage = this._curPage + 1;
         }
      }
    set curPage(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._curPage == param1)
         {
            return;
         }
         this._curPage = param1;
         this.refreshView();
      }
    show(param1) {
         $.C("com.pickgliss.ui.LayerManager").Instance.addTolayerRelated(param1,this,3,true,false);
         this.x -= 35;
      }
    refreshView() {
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc4_ = (this._curPage - 1) * 30;
         var _loc2_ = this._curPage * 30;
         var _loc3_ = $.int(_loc2_ < this.model.historyArray.length ? _loc2_ : this.model.historyArray.length);
         this._vBox.removeAllChild();
         _loc4_;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = $.as(this.model.historyArray[_loc4_], $.C("mvc.module.groupchat.ConsortiaGroupChatHistoryData"));
            _loc5_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("groupchat.view.ConsortiaGroupChatHistoryNotice")), $.C("groupchat.view.ConsortiaGroupChatHistoryNotice"));
            _loc5_.data = _loc1_;
            this._output.beginChanges();
            this._vBox.addChild(_loc5_);
            this._vBox.refreshChildPos();
            this._output.invalidateViewport(true);
            this._output.commitChanges();
            _loc4_++;
         }
         this._pageTxt.text = this._curPage + " / " + this.model.getTotalPage();
         this.setPageBtnEnable();
      }
    setPageBtnEnable() {
         this._firstPageBtn.enable = this._prePageBtn.enable = this._curPage > 1;
         this._lastPageBtn.enable = this._nextPageBtn.enable = this._curPage < this.model.getTotalPage();
      }
    get model() {
         return $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.model;
      }
    dispose() {
         this.removeEvent();
         if(this._back)
         {
            this._back.dispose();
         }
         this._back = null;
         if(this._titleImg)
         {
            this._titleImg = null;
         }
         if(this._output)
         {
            this._output.dispose();
         }
         this._output = null;
         if(this._vBox)
         {
            this._vBox.dispose();
         }
         this._vBox = null;
         if(this._miniCloseBtn)
         {
            this._miniCloseBtn.dispose();
         }
         this._miniCloseBtn = null;
         if(this._firstPageBtn)
         {
            this._firstPageBtn.dispose();
         }
         this._firstPageBtn = null;
         if(this._lastPageBtn)
         {
            this._lastPageBtn.dispose();
         }
         this._lastPageBtn = null;
         if(this._prePageBtn)
         {
            this._prePageBtn.dispose();
         }
         this._prePageBtn = null;
         if(this._nextPageBtn)
         {
            this._nextPageBtn.dispose();
         }
         this._nextPageBtn = null;
         if(this._pageBg)
         {
            this._pageBg.dispose();
         }
         this._pageBg = null;
         if(this._pageTxt)
         {
            this._pageTxt.dispose();
         }
         this._pageTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get curPage() { return super.curPage; }
    set model(v) { super.model = v; }
  }
  $.meta(__ConsortiaGroupChatHistoryView, "groupchat.view.ConsortiaGroupChatHistoryView", []);
  return __ConsortiaGroupChatHistoryView;
}
deps["groupchat.view.ConsortiaGroupChatHistoryView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "groupchat.view.ConsortiaGroupChatHistoryNotice", "manager.LanguageMgr", "mvc.module.groupchat.ConsortiaGroupChatHistoryData", "yishi.manager.FrameControllerManager"];

defs["groupchat.view.ConsortiaGroupChatNotic"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ConsortiaGroupChatNotic extends __Base {
    static $fields(self) {
    self._rect = null;
    self._data = null;
    self._noticeIcon = null;
    self._chatText1 = null;
    self._chatText2 = null;
    self._chatText3 = null;
    self._chatText4 = null;
    self._chatText5 = null;
    self._chatCount = 0;
    self._pointVisible = false;
    self._textFormat = null;
    self._firstMsg = null;
    self._text = null;
    self._groupElement = null;
    self.$$_filters = null;
    self._noticeIconWidth = 22;
    self._paddingTop = 9;
    self._paddingLeft = 0;
    self._lineWidth = 385;
    self._bgWidth = 385;
    self._textBlock = null;
    self._faceHeigth = 18;
    self.totalLine = 0;
    }
    constructor() {
         $.pre(new.target, (__s) => {
         __s._rect = new ($.C("flash.geom.Rectangle"))(0,0,__s._lineWidth,__s._faceHeigth);
         });
         super();
         $.preFlush(this, new.target);
         this.mouseEnabled = false;
      }
    get viewRectangle() {
         return this._rect;
      }
    set data(param1) {
         var _loc2_ = 0;
         this._data = $.as(param1, $.C("mvc.module.groupchat.ConsortiaGroupChatData"));
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            this["_chatText" + _loc2_] = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.ChatListText");
            this["_chatText" + _loc2_].visible = false;
            this["_chatText" + _loc2_].text = $.C("manager.LanguageMgr").GetTranslation("mvc.module.groupchat.ConsortiaGroupChatModel.PointTxt");
            this.addChild(this["_chatText" + _loc2_]);
            _loc2_++;
         }
         this._data.commit(this._data.userId);
         var _loc4_ = this._data.groupHeadData.getAllElements();
         var _loc3_ = this._data.groupChatData.getAllElements();
         if(this._data && this._data.channel == 5)
         {
            if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(this._data.senderName))
            {
               if(!_loc4_ || _loc4_.length == 0 || !_loc3_ || _loc3_.length == 0)
               {
                  return;
               }
               if(this._data.uid == $.C("yishi.manager.ArmyManager").instance.thane.userId)
               {
                  this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.outputSelfTextStyle_t");
               }
               else
               {
                  this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.outputTextStyle_t");
               }
               this.$$_filters = [];
               this._lineWidth = this._bgWidth - 4;
               this._paddingLeft = 4;
               this._groupElement = new ($.C("flash.text.engine.GroupElement"))(_loc4_);
               this._textBlock = new ($.C("flash.text.engine.TextBlock"))();
               this._textBlock.baselineZero = "ideographicCenter";
               this._textBlock.content = this._groupElement;
               this.createTextLines();
               this._chatCount = 0;
               this._lineWidth -= this._noticeIconWidth;
               this._paddingLeft = this._noticeIconWidth;
               this._groupElement = new ($.C("flash.text.engine.GroupElement"))(_loc3_);
               this._textBlock = new ($.C("flash.text.engine.TextBlock"))();
               this._textBlock.baselineZero = "ideographicCenter";
               this._textBlock.content = this._groupElement;
               this.createTextLines();
               this.drawBack();
            }
            else
            {
               if(!_loc3_ || _loc3_.length == 0)
               {
                  return;
               }
               this._textFormat = $.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("consortiagroupchat.infoTextStyle_t");
               this._noticeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.consortiagroupchat.NoticeIcon");
               this.addChild(this._noticeIcon);
               this._lineWidth -= this._noticeIconWidth;
               this._paddingLeft = this._noticeIconWidth;
               this.$$_filters = [new ($.C("flash.filters.GlowFilter"))(0,1,4,4,4)];
               this._groupElement = new ($.C("flash.text.engine.GroupElement"))(_loc3_);
               this._textBlock = new ($.C("flash.text.engine.TextBlock"))();
               this._textBlock.baselineZero = "ideographicCenter";
               this._textBlock.content = this._groupElement;
               this.createTextLines();
               this.drawBack();
            }
         }
      }
    createTextLines() {
         this._chatCount = this._chatCount + 1;
         this["_chatText" + this._chatCount].y = this._paddingTop - 7;
         if(this._pointVisible)
         {
            this["_chatText" + this._chatCount].visible = true;
         }
         var _loc1_ = 0;
         var _loc2_ = true;
         var _loc3_ = this._textBlock.createTextLine(null,this._lineWidth);
         _loc3_.mouseEnabled = false;
         _loc3_.doubleClickEnabled = false;
         while(_loc3_)
         {
            this.totalLine = this.totalLine + 1;
            this.addChild(_loc3_);
            _loc3_.x = this._paddingLeft;
            if(_loc2_)
            {
               _loc2_ = false;
               _loc1_ = _loc3_.y = this._paddingTop;
            }
            else
            {
               _loc1_ = _loc3_.y = _loc1_ + this._faceHeigth;
            }
            _loc3_ = this._textBlock.createTextLine(_loc3_,this._lineWidth);
         }
         this.filters = this.$$_filters;
         this._paddingTop = _loc1_ + this._faceHeigth;
      }
    appendText(param1) {
         this._chatText1.visible = true;
         this._pointVisible = true;
         param1.commit(param1.userId);
         this._groupElement = new ($.C("flash.text.engine.GroupElement"))(param1.groupChatData.getAllElements());
         this._textBlock = new ($.C("flash.text.engine.TextBlock"))();
         this._textBlock.baselineZero = "ideographicCenter";
         this._textBlock.content = this._groupElement;
         this.createTextLines();
         this.drawBack();
      }
    drawBack() {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,this._bgWidth,this.totalLine * this._faceHeigth);
         this.graphics.endFill();
         this._rect.height = this.totalLine * this._faceHeigth;
      }
    dispose() {
         this.graphics.clear();
         this.totalLine = 0;
         this._chatCount = 0;
         this._paddingTop = 9;
         this._paddingLeft = 0;
         this._pointVisible = false;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._noticeIcon);
         this._noticeIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatText1);
         this._chatText1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatText2);
         this._chatText2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatText3);
         this._chatText3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatText4);
         this._chatText4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._chatText5);
         this._chatText5 = null;
         $.C("chat.utils.ChatFormat").clearTextLine(this._textBlock);
         this._textFormat = null;
         this.$$_filters = null;
         this._textBlock = null;
         this._groupElement = null;
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    get data() { return super.data; }
  }
  $.meta(__ConsortiaGroupChatNotic, "groupchat.view.ConsortiaGroupChatNotic", ["Disposeable", "IManualSize"]);
  return __ConsortiaGroupChatNotic;
}
deps["groupchat.view.ConsortiaGroupChatNotic"] = ["chat.utils.ChatFormat", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.filters.GlowFilter", "flash.geom.Rectangle", "flash.text.engine.GroupElement", "flash.text.engine.TextBlock", "manager.LanguageMgr", "mvc.module.groupchat.ConsortiaGroupChatData", "yishi.manager.ArmyManager", "yishi.utils.StringHelper"];

defs["groupchat.view.ConsortiaGroupChatPlayerItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __ConsortiaGroupChatPlayerItem extends __Base {
    static $fields(self) {
    self._selected = false;
    self._data = null;
    self._back = null;
    self._iconMaster = null;
    self._icon = null;
    self._nameText = null;
    self._vipIcon = null;
    self._vipText = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.PlayerItemBack");
         this._iconMaster = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MenberListItemMaster");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("consortiagroupchat.MenberListItemHeadCell");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MenberListItemName");
         this._vipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.vipIcon");
         this._vipText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("consortiagroupchat.MenberListItemNameGradientText");
         this._nameText.isAutoFitLength = true;
         this.addChild(this._back);
         this._back.visible = false;
         this.addChild(this._iconMaster);
         this._iconMaster.setFrame(1);
         this.addChild(this._icon);
         this.addChild(this._nameText);
         this.addChild(this._vipText);
         this.addChild(this._vipIcon);
         this._vipIcon.x = this._nameText.x - this._vipIcon.width;
         this._vipIcon.y = 8;
      }
    initEvent() {
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.enableDoubleClick(this);
         this.addEventListener("click",$.bind(this, "__onMouseClick"));
         this.addEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.addEventListener("rollOver",$.bind(this, "__onMouseRollover"));
         this.addEventListener("rollOut",$.bind(this, "__onMouseRollout"));
      }
    removeEvent() {
         $.C("com.pickgliss.utils.DoubleClickManager").Instance.disableDoubleClick(this);
         this.removeEventListener("click",$.bind(this, "__onMouseClick"));
         this.removeEventListener("interactive_double_click",$.bind(this, "__onDoubleClick"));
         this.removeEventListener("rollOver",$.bind(this, "__onMouseRollover"));
         this.removeEventListener("rollOut",$.bind(this, "__onMouseRollout"));
      }
    __onMouseClick(param1) {
         param1.stopImmediatePropagation();
         $.C("yishi.manager.FrameControllerManager").instance.consortiaGroupChatControler.model.dispatchEvent(new ($.C("events.GroupChatEvent"))("consortiagroupchatitemselected",this._data,this));
      }
    __onDoubleClick(param1) {
         var _loc2_ = "";
         if(!this._data)
         {
            return;
         }
         if(this._data.userId == $.C("yishi.manager.ArmyManager").instance.thane.userId)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMManager.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("managers.IMManager").instance.createIMFrame(this._data);
      }
    __onMouseRollover(param1) {
         this._back.visible = true;
      }
    __onMouseRollout(param1) {
         this._back.visible = false;
      }
    set autoSelect(param1) {
      }
    get selected() {
         return this._selected;
      }
    set selected(param1) {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
      }
    setListCellStatus(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         this.selected = param2;
      }
    getCellValue() {
         return this._data;
      }
    setCellValue(param1) {
         if(this._data)
         {
            this._icon.filters = null;
            this._nameText.filters = null;
            this._iconMaster.visible = false;
            this._vipIcon.filters = null;
            this._vipIcon.visible = false;
            this._vipText.filters = null;
            this._vipText.visible = false;
            if(this._back.parent)
            {
               this._back.parent.removeChild(this._back);
            }
            if(this._iconMaster.parent)
            {
               this._iconMaster.parent.removeChild(this._iconMaster);
            }
            if(this._icon.parent)
            {
               this._icon.parent.removeChild(this._icon);
            }
            if(this._nameText.parent)
            {
               this._nameText.parent.removeChild(this._nameText);
            }
            if(this._vipIcon.parent)
            {
               this._vipIcon.parent.removeChild(this._vipIcon);
            }
            if(this._vipText.parent)
            {
               this._vipText.parent.removeChild(this._vipText);
            }
         }
         this._data = $.as(param1, $.C("yishi.datas.playerinfo.ThaneInfo"));
         if(!this._data)
         {
            return;
         }
         if(this._data.dutyId == 1)
         {
            this._iconMaster.x = 1;
            this._iconMaster.setFrame(2);
            this._iconMaster.visible = true;
         }
         else if(this._data.dutyId == 2)
         {
            this._iconMaster.x = 3;
            this._iconMaster.setFrame(1);
            this._iconMaster.visible = true;
         }
         if(this._icon.headId != this._data.headId)
         {
            this._icon.headId = this._data.headId;
         }
         this._nameText.text = this._data.nickName || "";
         if(this._data.IsVipAndNoExpirt)
         {
            if(this._data.vipType == 1)
            {
               this._vipIcon.setFrame(1);
            }
            else
            {
               this._vipIcon.setFrame(2);
            }
            this._vipIcon.visible = true;
            this._vipText.visible = true;
            this._nameText.visible = false;
            this._vipText.text = this._nameText.text;
         }
         else
         {
            this._nameText.visible = true;
         }
         if(!this._data.isOnline)
         {
            this._icon.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._nameText.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._vipIcon.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
            this._vipText.filters = [$.C("yishi.filter.UIFilter").getGrayFilter()];
         }
         this.addChild(this._back);
         this.addChild(this._iconMaster);
         this.addChild(this._icon);
         this.addChild(this._nameText);
         this.addChild(this._vipIcon);
         this.addChild(this._vipText);
      }
    asDisplayObject() {
         return this;
      }
    dispose() {
         this.removeEvent();
         if(this._back)
         {
            this._back.dispose();
         }
         this._back = null;
         if(this._iconMaster)
         {
            this._iconMaster.dispose();
         }
         this._iconMaster = null;
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._nameText)
         {
            this._nameText.dispose();
         }
         this._nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vipIcon);
         this._vipIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vipText);
         this._vipText = null;
         if(this._data)
         {
            this._data = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get autoSelect() { return super.autoSelect; }
  }
  $.meta(__ConsortiaGroupChatPlayerItem, "groupchat.view.ConsortiaGroupChatPlayerItem", ["Disposeable", "IListCell", "ISelectable"]);
  return __ConsortiaGroupChatPlayerItem;
}
deps["groupchat.view.ConsortiaGroupChatPlayerItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.DoubleClickManager", "com.pickgliss.utils.ObjectUtils", "events.GroupChatEvent", "flash.display.Sprite", "manager.LanguageMgr", "managers.IMManager", "yishi.datas.playerinfo.ThaneInfo", "yishi.filter.UIFilter", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["im.IMFrame"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __IMFrame extends __Base {
    static $fields(self) {
    self.needDispose = false;
    self._scaleFrameBg = null;
    self._friendInfoView = null;
    self._chatInfoView = null;
    self._chatInputView = null;
    self._expressionList = null;
    self._expressionBtn = null;
    self._presentBtn = null;
    self._consortiaBtn = null;
    self._marryBtn = null;
    self._addFriendBtn = null;
    self._delFriendBtn = null;
    self._shieldBtn = null;
    self._copyBtn = null;
    self._cleanBtn = null;
    self._inviteBtn = null;
    self._checkHistoryBtn = null;
    self._btnContainer = null;
    self._sendMsgBtn = null;
    self._closeBtn = null;
    self._miniBtn = null;
    self._data = null;
    self._isMini = false;
    self._timeLimit = false;
    self._timerID = 0;
    self._isRobot = false;
    self._timeId = 0;
    self._historyView = null;
    self.reg = /\r/g;
    self.reg1 = /\n/g;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._scaleFrameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFrameScaleBg");
         this._friendInfoView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.IMFriendInfoView");
         this._chatInfoView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.IMChatInfoView");
         this._chatInputView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.IMChatInputView");
         this._expressionBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMExpressionBtn");
         this._presentBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMPresentBtn");
         this._consortiaBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMConsortiaBtn");
         this._marryBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMMarryBtn");
         this._addFriendBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMAddFriendBtn");
         this._delFriendBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMDelFriendBtn");
         this._shieldBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMShieldBtn");
         this._copyBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMCopyBtn");
         this._cleanBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMCleanBtn");
         this._inviteBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMInviteBtn");
         this._checkHistoryBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMCheckHistoryBtn");
         this._checkHistoryBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.checkHistory");
         this._sendMsgBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMSendMsgBtn");
         this._sendMsgBtn.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.sendMsg");
         this._sendMsgBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.send");
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMCloseBtn");
         this._closeBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.close");
         this._miniBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMMiniBtn");
         this._presentBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.present");
         this._consortiaBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.consortia");
         this._marryBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("chatII.view.ChatItemMenu.propose");
         this._addFriendBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.addFriend");
         this._delFriendBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.delFriend");
         this._shieldBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.shield");
         this._copyBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.copy");
         this._cleanBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.clean");
         this._inviteBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.invite");
         this.addToContent(this._scaleFrameBg);
         this.addToContent(this._friendInfoView);
         this.addToContent(this._chatInfoView);
         this.addToContent(this._chatInputView);
         this.addToContent(this._expressionBtn);
         this.addToContent(this._presentBtn);
         this.addToContent(this._consortiaBtn);
         this.addToContent(this._marryBtn);
         this.addToContent(this._addFriendBtn);
         this.addToContent(this._delFriendBtn);
         this.addToContent(this._shieldBtn);
         this.addToContent(this._inviteBtn);
         this.addToContent(this._copyBtn);
         this.addToContent(this._cleanBtn);
         this.addToContent(this._checkHistoryBtn);
         this.addToContent(this._miniBtn);
         this.addToContent(this._closeBtn);
         this.addToContent(this._sendMsgBtn);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._checkHistoryBtn.addEventListener("click",$.bind(this, "__onCheckHistoryClick"));
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseBtnClick"));
         this._miniBtn.addEventListener("click",$.bind(this, "__onMiniClick"));
         this._sendMsgBtn.addEventListener("click",$.bind(this, "__onSendMsgBtnClick"));
         this._expressionBtn.addEventListener("mouseDown",$.bind(this, "___expressionBtnDownHandler"));
         this._expressionBtn.addEventListener("click",$.bind(this, "___expressionBtnClickHandler"));
         this._expressionBtn.addEventListener("rollOver",$.bind(this, "___expressionBtnRollOverHandler"));
         this._presentBtn.addEventListener("click",$.bind(this, "__presentBtnClickHandler"));
         this._consortiaBtn.addEventListener("click",$.bind(this, "__consortiaBtnClickHandler"));
         this._marryBtn.addEventListener("click",$.bind(this, "__marryBtnClickHandler"));
         this._addFriendBtn.addEventListener("click",$.bind(this, "__addFriendBtnClickHandler"));
         this._delFriendBtn.addEventListener("click",$.bind(this, "__delFriendBtnClickHandler"));
         this._shieldBtn.addEventListener("click",$.bind(this, "__shieldBtnClickHandler"));
         this._copyBtn.addEventListener("click",$.bind(this, "__copyBtnClickHandler"));
         this._cleanBtn.addEventListener("click",$.bind(this, "__cleanBtnClickHandler"));
         this._inviteBtn.addEventListener("click",$.bind(this, "__inviteBtnClickHandler"));
         this._chatInputView.addEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         this.friendManager.addEventListener("FRIEND_UPDATE",$.bind(this, "__friendUpdateHandler"));
         this.friendManager.addEventListener("REMOVE_FRIEND",$.bind(this, "__removeFriendHandler"));
         this.playerManager.addEventListener("REQUEST_SIMPLEANDSNS_INFO",$.bind(this, "__requestPlayerInfoHandler"));
         $.C("yishi.utils.MsgMan").addObserver("CROSS_FRIENDS_UPDATE",this,$.bind(this, "__updateCrossState"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._checkHistoryBtn.removeEventListener("click",$.bind(this, "__onCheckHistoryClick"));
         this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseBtnClick"));
         this._miniBtn.removeEventListener("click",$.bind(this, "__onMiniClick"));
         this._sendMsgBtn.removeEventListener("click",$.bind(this, "__onSendMsgBtnClick"));
         this._expressionBtn.removeEventListener("mouseDown",$.bind(this, "___expressionBtnDownHandler"));
         this._expressionBtn.removeEventListener("click",$.bind(this, "___expressionBtnClickHandler"));
         this._expressionBtn.removeEventListener("rollOver",$.bind(this, "___expressionBtnRollOverHandler"));
         this._presentBtn.removeEventListener("click",$.bind(this, "__presentBtnClickHandler"));
         this._consortiaBtn.removeEventListener("click",$.bind(this, "__consortiaBtnClickHandler"));
         this._marryBtn.removeEventListener("click",$.bind(this, "__marryBtnClickHandler"));
         this._addFriendBtn.removeEventListener("click",$.bind(this, "__addFriendBtnClickHandler"));
         this._delFriendBtn.removeEventListener("click",$.bind(this, "__delFriendBtnClickHandler"));
         this._shieldBtn.removeEventListener("click",$.bind(this, "__shieldBtnClickHandler"));
         this._copyBtn.removeEventListener("click",$.bind(this, "__copyBtnClickHandler"));
         this._cleanBtn.removeEventListener("click",$.bind(this, "__cleanBtnClickHandler"));
         this._inviteBtn.removeEventListener("click",$.bind(this, "__inviteBtnClickHandler"));
         this._chatInputView.removeEventListener("keyDown",$.bind(this, "__keyDownHandler"));
         this.friendManager.removeEventListener("FRIEND_UPDATE",$.bind(this, "__friendUpdateHandler"));
         this.friendManager.removeEventListener("REMOVE_FRIEND",$.bind(this, "__removeFriendHandler"));
         this.playerManager.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",$.bind(this, "__requestPlayerInfoHandler"));
         $.C("yishi.utils.MsgMan").removeObserver("CROSS_FRIENDS_UPDATE",this,$.bind(this, "__updateCrossState"));
      }
    __updateCrossState(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._data && this.isCross)
         {
            this._data = this.friendManager.getCrossThaneInfoByUuid(this._data.uuid);
            if(this._data)
            {
               this.refreshView();
            }
         }
      }
    __inviteBtnClickHandler(param1) {
         if(this._data)
         {
            $.C("managers.FreedomTeamManager").instance.inviteMember(this._data.userId);
         }
      }
    __requestPlayerInfoHandler(param1) {
         var _loc2_ = null;
         if(this._data && param1.data && !this.isCross && this._data.userId == param1.data.userId)
         {
            _loc2_ = this.imManager.getFriendInfo(this._data.userId);
            if(_loc2_)
            {
               this._data = _loc2_;
            }
            else
            {
               this._data = param1.data;
            }
            this.refreshView();
         }
         else if(param1.data && param1.data.userId == 0)
         {
            if(!this._data)
            {
               this.dispose();
               return;
            }
            _loc2_ = $.C("yishi.manager.FriendManager").getInstance().getCrossThaneInfoByUuid(this._data.uuid);
            if(!_loc2_)
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("chat.view.ChatItemMenu.addFriend.alert"));
               this.dispose();
               return;
            }
         }
      }
    __removeFriendHandler(param1) {
         var _loc2_ = $.int(param1.object);
         if(!this.data || _loc2_ == this.data.userId)
         {
            this.dispose();
         }
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.needDispose = true;
               this.dispose();
         }
      }
    ___expressionBtnDownHandler(param1) {
         param1.stopPropagation();
      }
    ___expressionBtnClickHandler(param1) {
         if(this._expressionList)
         {
            this._expressionList.dispose();
            return;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.clearGameMenuLayer();
         if(!this._expressionList)
         {
            this._expressionList = new ($.C("chat.view.ExpressionList"))();
         }
         this._expressionList.addEventListener("dispose",$.bind(this, "__onExpressionListDispose"));
         var _loc2_ = new ($.C("flash.geom.Point"))(this._expressionBtn.x,this._expressionBtn.y);
         this._expressionList.x = this.localToGlobal(_loc2_).x - this._expressionList.width / 2 + 50;
         this._expressionList.y = this.localToGlobal(_loc2_).y - this._expressionList.height + 55;
         this._expressionList.input = this._chatInputView.textField;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._expressionList,7);
      }
    ___expressionBtnRollOverHandler(param1) {
         if(this._expressionList)
         {
            return;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.clearGameMenuLayer();
         if(!this._expressionList)
         {
            this._expressionList = new ($.C("chat.view.ExpressionList"))();
         }
         this._expressionList.addEventListener("dispose",$.bind(this, "__onExpressionListDispose"));
         var _loc2_ = new ($.C("flash.geom.Point"))(this._expressionBtn.x,this._expressionBtn.y);
         this._expressionList.x = this.localToGlobal(_loc2_).x - this._expressionList.width / 2 + 50;
         this._expressionList.y = this.localToGlobal(_loc2_).y - this._expressionList.height + 55;
         this._expressionList.input = this._chatInputView.textField;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this._expressionList,7);
      }
    __onExpressionListDispose(param1) {
         this._expressionList.removeEventListener("dispose",$.bind(this, "__onExpressionListDispose"));
         this._expressionList = null;
      }
    __presentBtnClickHandler(param1) {
         var _loc2_ = null;
         if(this._data)
         {
            if(this._isRobot)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.present.NotFriends");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if($.C("simplegame.roses.IMQuickRosePresentView").getFriendInfoByName(this._data.nickName) == null)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.present.NotFriends");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if($.C("simplegame.roses.IMQuickRosePresentView").getHaveRoseNumber() == 0)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.present.TipTxt");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            $.C("yishi.manager.FrameControllerManager").instance.friendControler.startFrameByType(6,[this._data.nickName]);
         }
      }
    __marryBtnClickHandler(param1) {
         if($.C("yishi.manager.ArmyManager").instance.thane.grades < 36)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("dayGuide.DayGuideManager.command02",36));
         }
         else if(!$.C("managers.MarryManager").instance.model.isSingle)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.hasLover"));
         }
         else if(this._data)
         {
            $.C("managers.MarryManager").instance.creatProposeQuestFrame(this._data.userId);
         }
      }
    __consortiaBtnClickHandler(param1) {
         var _loc2_ = null;
         if(this._data)
         {
            if(this._isRobot)
            {
               return;
            }
            if(!$.C("yishi.manager.FrameControllerManager").instance.consortiaController.getRightsByIndex(9))
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.consortia.TipTxt1");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if(this.playerManager.currentPlayerModel.playerInfo.consortiaID <= 0)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.consortia.TipTxt2");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            $.C("yishi.manager.FrameControllerManager").instance.consortiaController.sendConsortiaInvitePlayer(this._data.userId);
         }
      }
    __addFriendBtnClickHandler(param1) {
         var _loc2_ = null;
         if(this._data)
         {
            if(this._isRobot)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("chat.view.ChatItemMenu.RobotTips01");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if(this.isCross)
            {
               if(this.friendManager.crossFriendList[this._data.uuid] || this.friendManager.crossStrangerList[this._data.uuid])
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.manager.FriendManager.command05"));
                  return;
               }
               $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(0,this._data.uuid);
            }
            else
            {
               this.friendManager.sendAddFriendRequest(this._data.nickName,1);
            }
         }
      }
    __delFriendBtnClickHandler(param1) {
         var _loc2_ = null;
         var _loc7_ = 0;
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = null;
         if(this._data)
         {
            if(this._isRobot)
            {
               return;
            }
            _loc7_ = 0;
            if(this.isCross && Boolean(this._data.hasOwnProperty("uuid")) && this._data["uuid"])
            {
               if($.C("yishi.manager.FriendManager").getInstance().crossFriendList[this._data.uuid])
               {
                  _loc7_ = 1;
               }
               else if($.C("yishi.manager.FriendManager").getInstance().crossBlackList[this._data.uuid])
               {
                  _loc7_ = 2;
               }
               else if($.C("yishi.manager.FriendManager").getInstance().crossStrangerList[this._data.uuid])
               {
                  _loc7_ = 3;
               }
            }
            else
            {
               _loc5_ = $.C("managers.IMManager").instance.getFriendInfo(this._data.userId);
               if(_loc5_)
               {
                  _loc7_ = $.int(_loc5_.relation);
               }
            }
            switch(_loc7_ - 2)
            {
               case 0:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str02");
                  break;
               case 1:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
                  break;
               case 2:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str01");
                  break;
               default:
                  _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.str03");
            }
            if(_loc7_ == 0)
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.view.IMFrame.delAlert"));
               return;
            }
            $.C("yishi.utils.SimpleAlertHelper").instance.data = [$.bind(this, "_delFriendResponse"),_loc5_,_loc7_];
            _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
            _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.prompt");
            $.C("yishi.utils.SimpleAlertHelper").instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc4_,true,false,false);
         }
      }
    _delFriendResponse(param1, param2, param3, param4) {
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         if(param1)
         {
            if(this.isCross)
            {
               if(param4 == 2)
               {
                  $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(3,this._data.uuid);
               }
               else
               {
                  $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(1,this._data.uuid);
               }
            }
            else if(param3)
            {
               if(param3.relation == 4)
               {
                  $.C("yishi.manager.FriendManager").getInstance().removePrivatePerson(param3.userId);
               }
               else
               {
                  $.C("yishi.manager.FriendManager").getInstance().sendRemoveFriendRequest(param3.userId);
               }
            }
            this.dispose();
         }
      }
    __shieldBtnClickHandler(param1) {
         var _loc2_ = null;
         if(this._data)
         {
            if(this._isRobot)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("chat.view.ChatItemMenu.RobotTips02");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
               return;
            }
            if(this.isCross)
            {
               if(this.friendManager.crossBlackList[this._data.uuid])
               {
                  $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("yishi.manager.FriendManager.command05"));
                  return;
               }
               $.C("yishi.manager.FriendManager").getInstance().sendCrossFriendRequest(2,this._data.uuid);
            }
            else
            {
               $.C("yishi.manager.FriendManager").getInstance().sendAddFriendRequest(this._data.nickName,2);
            }
         }
      }
    __copyBtnClickHandler(param1) {
         if(this._data)
         {
            $.C("flash.system.System").setClipboard(this._data.nickName);
         }
      }
    __cleanBtnClickHandler(param1) {
         if(this._data)
         {
            this._chatInfoView.cleanView();
         }
      }
    __friendUpdateHandler(param1) {
         if(!this._data)
         {
         }
      }
    __keyDownHandler(param1) {
         if(param1.keyCode == 13)
         {
            this.__onSendMsgBtnClick(null);
            if(this._timeId > 0)
            {
               $.C("flash.utils.clearInterval")(this._timeId);
            }
            this._timeId = 0;
            this._timeId = $.C("flash.utils.setInterval")($.bind(this, "clear"),30);
         }
         param1.stopPropagation();
      }
    clear() {
         if(this._timeId > 0)
         {
            $.C("flash.utils.clearInterval")(this._timeId);
         }
         this._timeId = 0;
         if(this._chatInputView)
         {
            this._chatInputView.clear();
            this._chatInputView.setFocus();
         }
      }
    __onCheckHistoryClick(param1) {
         if(!this._historyView)
         {
            this._historyView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryView");
            this._historyView.addEventListener("dispose",$.bind(this, "__disposeHandler"));
            this._historyView.data = this._data;
            this._historyView.show(this);
         }
         else
         {
            this._historyView.dispose();
         }
      }
    __disposeHandler(param1) {
         param1.currentTarget.removeEventListener("dispose",$.bind(this, "__disposeHandler"));
         this._historyView = null;
      }
    __onCloseBtnClick(param1) {
         this.needDispose = true;
         this.dispose();
      }
    __onMiniClick(param1) {
         var _loc2_ = null;
         this._isMini = true;
         if(this._historyView)
         {
            this._historyView.dispose();
         }
         if(this._friendInfoView && this._friendInfoView.moodTxt)
         {
            this._friendInfoView.moodTxt.visible = false;
         }
         if($.C("yishi.scene.SceneManager").instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = new ($.C("flash.geom.Point"))($.C("com.pickgliss.toplevel.StageReferance").stageWidth / 2 + 188,$.C("com.pickgliss.toplevel.StageReferance").stageHeight - 108);
         }
         else
         {
            _loc2_ = new ($.C("flash.geom.Point"))($.C("ui.maintoolbar.MainToolBar").instance.x + $.C("ui.maintoolbar.MainToolBar").instance.getFriendsBtnX(),$.C("com.pickgliss.toplevel.StageReferance").stageHeight - 40);
         }
         $.C("com.greensock.TweenMax").to(this,1,{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "scaleX":0,
            "scaleY":0,
            "onComplete":$.bind(this, "miniCompleteHandler")
         });
      }
    miniCompleteHandler() {
         if(this.parent)
         {
            this.parent.removeChild(this);
            this.imManager.dispatchFrameRemoveEvent();
         }
      }
    __onSendMsgBtnClick(param1) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc2_ = this._chatInputView.text;
         if(this._data)
         {
            _loc2_ = _loc2_.replace(this.reg,"");
            _loc2_ = _loc2_.replace(this.reg1,"");
            _loc3_ = "";
            if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc2_))
            {
               if(param1)
               {
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.command01");
                  $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
               }
               return;
            }
            if(!this._isRobot && !this._data.isOnline)
            {
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.command02");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
               _loc4_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
               _loc4_.channel = 3;
               _loc4_.msg = _loc3_;
               _loc4_.commit();
               $.C("yishi.manager.NotificationManager").instance.sendNotification("ADD_CHAT",_loc4_);
               return;
            }
            if(this._timeLimit)
            {
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.IMFrame.command03");
               $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
               return;
            }
            _loc2_ = $.C("manager.FilterWordManager").filterWrod(_loc2_);
            if(this._isRobot)
            {
               _loc5_ = new ($.C("mvc.module.friends.BaseIMInfo"))();
               _loc5_.userId = this.playerManager.currentPlayerModel.playerInfo.userId;
               _loc5_.nickName = this.playerManager.currentPlayerModel.playerInfo.nickName;
               _loc5_.toId = this._data.userId;
               _loc5_.msg = _loc2_;
               _loc5_.date = new Date();
               _loc5_.sendResult = 0;
               this.imManager.saveMsgCache(_loc5_);
               this.imManager.dispatchEvent(new ($.C("mvc.module.friends.IMEvent"))("MSG_SEND_RESPONSE",_loc5_));
               _loc6_ = this.friendManager.checkIsExistFriendInfo(_loc5_.toId);
               if(!_loc6_)
               {
                  this.playerManager.sendRequestSimpleAndSnsInfo(_loc5_.toId,0);
               }
               else
               {
                  this.friendManager.addPrivatePerson(_loc6_);
               }
            }
            else if(this.isCross)
            {
               $.C("managers.FriendSocketOutManager").requestCrossFriendMsg(5,this._data.uuid,_loc2_);
            }
            else
            {
               this.imManager.sendIMMsg(this._data.userId,_loc2_);
            }
            this._timeLimit = true;
            this._timerID = $.C("flash.utils.setTimeout")($.bind(this, "limitTimeOutHandler"),1000);
            this._chatInputView.clear();
            this._chatInputView.setFocus();
         }
      }
    limitTimeOutHandler() {
         $.C("flash.utils.clearTimeout")(this._timerID);
         this._timeLimit = false;
      }
    get imManager() {
         return $.C("managers.IMManager").instance;
      }
    get friendManager() {
         return $.C("yishi.manager.FriendManager").getInstance();
      }
    get playerManager() {
         return $.C("yishi.manager.PlayerManager").instance;
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(this._data)
         {
            this._isRobot = this._data.isRobot;
            this.playerManager.sendRequestSimpleAndSnsInfo(this._data.userId,2);
            this.refreshView();
         }
      }
    refreshView() {
         var _loc1_ = null;
         if(this._isRobot)
         {
            _loc1_ = $.C("yishi.manager.SpaceTemplateManager").instance.getRobotInfo(this._data.userId);
            this._data.nickName = _loc1_.nickName;
            this._data.state = _loc1_.state;
            this._data.isRobot = this._isRobot;
         }
         this._presentBtn.enable = this._consortiaBtn.enable = this._marryBtn.enable = this._inviteBtn.enable = !this.isCross;
         this._friendInfoView.data = this._data;
         this._chatInfoView.data = this._data;
      }
    show() {
         this._isMini = false;
         this.scaleX = this.scaleY = 1;
         if(this._friendInfoView && this._friendInfoView.moodTxt)
         {
            this._friendInfoView.moodTxt.visible = true;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,true,false);
         if(this._chatInputView)
         {
            this._chatInputView.setFocus();
         }
         if(this._historyView && this._historyView.parent)
         {
            this._historyView.show(this);
         }
      }
    get groups() {
         return [$.C("yishi.datas.ComponentGroupType").NONE];
      }
    get chatInputView() {
         return this._chatInputView;
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,475,505);
      }
    get isCross() {
         return this._data.serviceName != null && this._data.serviceName != "" && this._data.serviceName != this.playerManager.currentPlayerModel.playerInfo.serviceName;
      }
    dispose() {
         if(this.needDispose)
         {
            this.removeEvent();
            $.C("flash.utils.clearTimeout")(this._timerID);
            $.C("com.greensock.TweenMax").killTweensOf(this,false);
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
            if(this._historyView)
            {
               this._historyView.dispose();
            }
            if(this._scaleFrameBg)
            {
               this._scaleFrameBg.dispose();
            }
            this._scaleFrameBg = null;
            if(this._friendInfoView)
            {
               this._friendInfoView.dispose();
            }
            this._friendInfoView = null;
            if(this._chatInfoView)
            {
               this._chatInfoView.dispose();
            }
            this._chatInfoView = null;
            if(this._chatInputView)
            {
               this._chatInputView.dispose();
            }
            this._chatInputView = null;
            if(this._addFriendBtn)
            {
               this._addFriendBtn.dispose();
            }
            this._addFriendBtn = null;
            if(this._checkHistoryBtn)
            {
               this._checkHistoryBtn.dispose();
            }
            this._checkHistoryBtn = null;
            if(this._miniBtn)
            {
               this._miniBtn.dispose();
            }
            this._miniBtn = null;
            if(this._closeBtn)
            {
               this._closeBtn.dispose();
            }
            this._closeBtn = null;
            if(this._sendMsgBtn)
            {
               this._sendMsgBtn.dispose();
            }
            this._sendMsgBtn = null;
            if(this._cleanBtn)
            {
               this._cleanBtn.dispose();
            }
            this._cleanBtn = null;
            if(this._inviteBtn)
            {
               this._inviteBtn.dispose();
            }
            this._inviteBtn = null;
            super.dispose();
            this.dispatchEvent(new ($.C("mvc.module.friends.IMFrameEvent"))("IMFRAME_DISPOSE",this._data));
            this._data = null;
            this.reg = null;
            this.reg1 = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
         this.imManager.dispatchFrameRemoveEvent();
      }
    set imManager(v) { super.imManager = v; }
    set friendManager(v) { super.friendManager = v; }
    set playerManager(v) { super.playerManager = v; }
    set groups(v) { super.groups = v; }
    set chatInputView(v) { super.chatInputView = v; }
    set viewRectangle(v) { super.viewRectangle = v; }
    set isCross(v) { super.isCross = v; }
  }
  $.meta(__IMFrame, "im.IMFrame", ["IManualSize"]);
  return __IMFrame;
}
deps["im.IMFrame"] = ["chat.datas.ChatData", "chat.view.ExpressionList", "com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "flash.geom.Point", "flash.geom.Rectangle", "flash.system.System", "flash.utils.clearInterval", "flash.utils.clearTimeout", "flash.utils.setInterval", "flash.utils.setTimeout", "manager.FilterWordManager", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.FriendSocketOutManager", "managers.IMManager", "managers.MarryManager", "mvc.module.friends.BaseIMInfo", "mvc.module.friends.IMEvent", "mvc.module.friends.IMFrameEvent", "simplegame.roses.IMQuickRosePresentView", "ui.maintoolbar.MainToolBar", "yishi.datas.ComponentGroupType", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.FriendManager", "yishi.manager.NotificationManager", "yishi.manager.PlayerManager", "yishi.manager.SpaceTemplateManager", "yishi.scene.SceneManager", "yishi.utils.MsgMan", "yishi.utils.SimpleAlertHelper", "yishi.utils.StringHelper", "yishi.view.tips.MessageTipManager"];

defs["im.view.IMChatInfoItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __IMChatInfoItem extends __Base {
    static $fields(self) {
    self._bg = null;
    self._timeTxt = null;
    self._type = 0;
    self._msg = null;
    self._chatNotic = null;
    self._chatType = 0;
    }
    constructor(param1, param2) {
         $.pre(new.target, (__s) => {
         __s._type = param1;
         __s._msg = param2;
         });
         super();
         $.preFlush(this, new.target);
         this.initView();
      }
    initView() {
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatTimeTxt");
         this._chatNotic = new ($.C("chat.view.ExpressionChatNotic"))();
         this._chatNotic.y = 7;
         switch(this._type - 1)
         {
            case 0:
               this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMSelfMsgBg");
               this._chatNotic.x = 10;
               this._chatNotic.needFilters = true;
               this._chatType = 105;
               break;
            case 1:
               this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMTargetMsgBg");
               this._chatNotic.x = 21;
               this._chatNotic.needFilters = false;
               this._chatType = 106;
         }
         if(this._bg)
         {
            this.addChild(this._bg);
         }
         this.addChild(this._timeTxt);
         this.addChild(this._chatNotic);
         this.refreshView();
      }
    refreshView() {
         var _loc1_ = null;
         if(this._msg)
         {
            this._timeTxt.text = $.C("yishi.utils.DateFormatter").format(this._msg.date,"hh:mm");
            _loc1_ = $.as($.C("com.pickgliss.utils.ObjectPool").getObject($.C("chat.datas.ChatData")), $.C("chat.datas.ChatData"));
            _loc1_.channel = this._chatType;
            _loc1_.msg = this._msg.msg;
            _loc1_.commit();
            _loc1_.msg = $.C("chat.ChatManager").instance.analyzeExpressionForIMChat(_loc1_.msg);
            _loc1_.chatItemData.cellVector = $.C("chat.utils.ChatFormat").getContentCellData(_loc1_);
            this._chatNotic.data = _loc1_;
         }
         if(this._bg)
         {
            this._bg.beginChanges();
            this._bg.width = this._chatNotic.firstLineWidth + 35 < 59 ? 59 : this._chatNotic.firstLineWidth + 35;
            this._bg.height = this._chatNotic.height + 20;
            this._bg.commitChanges();
            this._timeTxt.y = (this._bg.height - this._timeTxt.height) / 2;
            switch(this._type - 1)
            {
               case 0:
                  this._timeTxt.x = this._bg.x - this._timeTxt.width - 5;
                  break;
               case 1:
                  this._timeTxt.x = this._bg.x + this._bg.width + 5;
            }
         }
      }
    get width() {
         return this._bg.width;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._bg)
         {
            this._bg.dispose();
         }
         this._bg = null;
         if(this._chatNotic)
         {
            this._chatNotic.dispose();
         }
         this._chatNotic = null;
         if(this._timeTxt)
         {
            this._timeTxt.dispose();
         }
         this._timeTxt = null;
         this._msg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set width(v) { super.width = v; }
  }
  $.meta(__IMChatInfoItem, "im.view.IMChatInfoItem", ["Disposeable"]);
  return __IMChatInfoItem;
}
deps["im.view.IMChatInfoItem"] = ["chat.ChatManager", "chat.datas.ChatData", "chat.utils.ChatFormat", "chat.view.ExpressionChatNotic", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectPool", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.utils.DateFormatter"];

defs["im.view.IMChatInfoView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __IMChatInfoView extends __Base {
    static $fields(self) {
    self._scaleFrameBg = null;
    self._bg = null;
    self._noticeImg = null;
    self._notice = null;
    self._scrollPanel = null;
    self._msgVBox = null;
    self._data = null;
    self._contain = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._scaleFrameBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatInfoScaleBg");
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.IMChatInfoBg");
         this._noticeImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.IMChatInfoNoticeImg");
         this._notice = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatInfoNotice");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatInfoScrollPanel");
         this._msgVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatMsgVBox");
         this._contain = new ($.C("flash.display.Sprite"))();
         this._contain.addChild(this._noticeImg);
         this._contain.addChild(this._notice);
         this._msgVBox.addChild(this._contain);
         this._scrollPanel.setView(this._msgVBox);
         this.addChild(this._scaleFrameBg);
         this.addChild(this._bg);
         this.addChild(this._scrollPanel);
         this._notice.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMChatInfoView.Notice");
      }
    addEvent() {
         this.imManager.addEventListener("MSG_SEND_RESPONSE",$.bind(this, "__sendMsgResponseHandler"));
         this.imManager.addEventListener("RECEIVE_MSG",$.bind(this, "__receiveMsgHandler"));
      }
    removeEvent() {
         this.imManager.removeEventListener("MSG_SEND_RESPONSE",$.bind(this, "__sendMsgResponseHandler"));
         this.imManager.removeEventListener("RECEIVE_MSG",$.bind(this, "__receiveMsgHandler"));
      }
    __sendMsgResponseHandler(param1) {
         var _loc2_ = param1.msg;
         if(_loc2_ && this._data && _loc2_.sendResult == 0)
         {
            if(this.isCross)
            {
               if(_loc2_.imThane && this._data.userId == _loc2_.toId)
               {
                  this.addMsgItem(this.createMsgItem(_loc2_));
               }
            }
            else if(!_loc2_.imThane && this._data.userId == _loc2_.toId)
            {
               this.addMsgItem(this.createMsgItem(_loc2_));
            }
         }
      }
    __receiveMsgHandler(param1) {
         var _loc2_ = param1.msg;
         if(_loc2_ && this._data)
         {
            if(this.isCross)
            {
               if(_loc2_.imThane && this._data.userId == _loc2_.userId && this._data.serviceName == _loc2_.imThane.serviceName)
               {
                  this.addMsgItem(this.createMsgItem(_loc2_));
               }
            }
            else if(!_loc2_.imThane && this._data.userId == _loc2_.userId)
            {
               this.addMsgItem(this.createMsgItem(_loc2_));
            }
         }
      }
    refreshView() {
         var _loc3_ = undefined;
         var _loc2_ = this._data.serviceName != "" && this._data.serviceName != null && this._data.serviceName != this.playerInfo.serviceName;
         var _loc4_ = _loc2_ ? this._data.serviceName + "_" + this._data.userId : this._data.userId + "";
         if(this._data && this.imManager.model.unreadMsgDic[_loc4_])
         {
            _loc3_ = this.imManager.model.unreadMsgDic[_loc4_];
            for (var _loc1_ of $.values(_loc3_))
            {
               this.addMsgItem(this.createMsgItem(_loc1_));
            }
         }
      }
    createMsgItem(param1) {
         var _loc2_ = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_ = false;
         if(this.isCross)
         {
            if(param1.imThane && param1.userId == this.playerInfo.userId && param1.imThane.serviceName == this.playerInfo.serviceName)
            {
               _loc3_ = true;
            }
         }
         else if(!param1.imThane && param1.userId == this.playerInfo.userId)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc2_ = new ($.C("im.view.IMChatInfoItem"))(1,param1);
            _loc2_.x = this._bg.width - _loc2_.width - 12;
         }
         else
         {
            _loc2_ = new ($.C("im.view.IMChatInfoItem"))(2,param1);
         }
         return _loc2_;
      }
    addMsgItem(param1) {
         this._msgVBox.addChild(param1);
         this._scrollPanel.invalidateViewport(true);
      }
    cleanView() {
         this.cleanData();
         this._msgVBox.addChild(this._contain);
         this._scrollPanel.invalidateViewport(true);
      }
    cleanData() {
         var _loc1_ = null;
         while(this._msgVBox.numChildren > 0)
         {
            _loc1_ = this._msgVBox.getChildAt(0);
            this._msgVBox.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
    get imManager() {
         return $.C("managers.IMManager").instance;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
      }
    get isCross() {
         return this._data.serviceName != "" && this._data.serviceName != null && this._data.serviceName != this.playerInfo.serviceName;
      }
    dispose() {
         this.removeEvent();
         this.cleanData();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._scaleFrameBg)
         {
            this._scaleFrameBg.dispose();
         }
         this._scaleFrameBg = null;
         if(this._scrollPanel)
         {
            this._scrollPanel.dispose();
         }
         this._scrollPanel = null;
         if(this._msgVBox)
         {
            this._msgVBox.dispose();
         }
         this._msgVBox = null;
         this._bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set imManager(v) { super.imManager = v; }
    set playerInfo(v) { super.playerInfo = v; }
    get data() { return super.data; }
    set isCross(v) { super.isCross = v; }
  }
  $.meta(__IMChatInfoView, "im.view.IMChatInfoView", ["Disposeable"]);
  return __IMChatInfoView;
}
deps["im.view.IMChatInfoView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "im.view.IMChatInfoItem", "manager.LanguageMgr", "managers.IMManager", "yishi.manager.PlayerManager"];

defs["im.view.IMChatInputView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __IMChatInputView extends __Base {
    static $fields(self) {
    self._bg = null;
    self._textArea = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatInputBg");
         this._textArea = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMChatInputArea");
         this._textArea.textField.maxChars = 84;
         this.addChild(this._bg);
         this.addChild(this._textArea);
      }
    addEvent() {
      }
    removeEvent() {
      }
    clear() {
         this._textArea.text = "";
      }
    setFocus() {
         this._textArea.textField.setFocus();
      }
    get textField() {
         return this._textArea.textField;
      }
    get text() {
         return this._textArea.text;
      }
    dispose() {
         this.removeEvent();
         if(this._bg)
         {
            this._bg.dispose();
         }
         this._bg = null;
         if(this._textArea)
         {
            this._textArea.dispose();
         }
         this._textArea = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set textField(v) { super.textField = v; }
    set text(v) { super.text = v; }
  }
  $.meta(__IMChatInputView, "im.view.IMChatInputView", ["Disposeable"]);
  return __IMChatInputView;
}
deps["im.view.IMChatInputView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["im.view.IMFriendInfoView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __IMFriendInfoView extends __Base {
    static $fields(self) {
    self._gmIcon = null;
    self._headCell = null;
    self._stateImg = null;
    self._nickName = null;
    self._level = null;
    self._serverName = null;
    self._mood = null;
    self._filter = null;
    self._vocationIcon = null;
    self._data = null;
    self._tipButton = null;
    self._uninitList = [];
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._gmIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.ItemGmIcon");
         this._headCell = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("core.IMFriendHeadIcon");
         this._stateImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFriendInfoStateImg");
         this._nickName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFriendNickNameTxt");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFriendLevelTxt");
         this._serverName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.serverNameText");
         this._mood = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFriendMoodTxt");
         this._vocationIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMFriend.VocationIcon");
         this._filter = new ($.C("yishi.filter.UIFilter"))();
         this._headCell.buttonMode = true;
         this._mood.isAutoFitLength = true;
         this._stateImg.setFrame(7);
         this._vocationIcon.visible = false;
         this.addChild(this._gmIcon);
         this.addChild(this._headCell);
         this.addChild(this._stateImg);
         this.addChild(this._nickName);
         this.addChild(this._level);
         this.addChild(this._serverName);
         this.addChild(this._mood);
         this.addChild(this._vocationIcon);
      }
    set data(param1) {
         this._data = param1;
         this.refreshView();
         this.refreshVocation();
      }
    refreshVocation() {
         var _loc1_ = 0;
         if(this._data && this._data.vocationGrades > 0)
         {
            _loc1_ = $.int(this.isCross || !this._data.templateInfo ? this._data.job : $.int(this._data.templateInfo.Job));
            this._vocationIcon.tipData = $.C("yishi.manager.PlayerManager").instance.getVocationName(_loc1_,this._data.vocationStep,this._data.vocationLevel);
            this._vocationIcon.setFrame(this._data.vocationLevel);
            this._vocationIcon.visible = true;
            this._level.x = this._vocationIcon.x + this._vocationIcon.width;
         }
         else
         {
            this._vocationIcon.visible = false;
            this._level.x = this._vocationIcon.x;
         }
      }
    addEvent() {
         this._headCell.addEventListener("click",$.bind(this, "__onHeadCellClick"));
         this._nickName.addEventListener("link",$.bind(this, "__onHeadCellClick"));
         if(this._data)
         {
            this._data.addEventListener("PLAYER_STATE_CHANGE",$.bind(this, "refreshBaseView"));
         }
      }
    removeEvent() {
         this._headCell.removeEventListener("click",$.bind(this, "__onHeadCellClick"));
         this._nickName.removeEventListener("link",$.bind(this, "__onHeadCellClick"));
         if(this._data)
         {
            this._data.removeEventListener("PLAYER_STATE_CHANGE",$.bind(this, "refreshBaseView"));
         }
      }
    __onHeadCellClick(param1) {
         if(this.isCross)
         {
            return;
         }
         if(this._data)
         {
            $.C("yishi.manager.PlayerInfoManager").instance.show(this._data);
         }
      }
    _onHeadClick(param1) {
         if(this.isCross)
         {
            return;
         }
         if(this._data)
         {
            $.C("yishi.manager.PlayerInfoManager").instance.show(this._data);
         }
      }
    refreshBaseView(param1) {
         if(this._data)
         {
            this._stateImg.setFrame(this._data.state);
            this._data.isOnline ? (this._headCell.filters = null) : this._filter.setGrayFilter(this._headCell);
         }
      }
    refreshView() {
         var _loc2_ = 0;
         var _loc1_ = null;
         if(this._data)
         {
            this.addEvent();
            if(this.isCross)
            {
               this._headCell.headId = this._data.pics;
            }
            else
            {
               this._headCell.headId = this._data.snsInfo ? this._data.snsInfo.headId : $.int(this._data.templateId);
            }
            if(this._data.right == 2)
            {
               this._gmIcon.visible = true;
               this._nickName.x = this._gmIcon.x + this._gmIcon.width;
            }
            else
            {
               this._gmIcon.visible = false;
               this._nickName.x = 50;
            }
            this._nickName.text = this._data.nickName;
            this._serverName.text = "" + this._data.serviceName;
            if(this._tipButton)
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._tipButton);
               this._tipButton.removeEventListener("click",$.bind(this, "_onHeadClick"));
               this._tipButton = null;
            }
            if(this._nickName.textWidth + 3 > this._nickName.width)
            {
               _loc2_ = $.int(this._nickName.getCharIndexAtPoint(this._nickName.width - 22,5));
               _loc1_ = this._nickName.text.substring(0,_loc2_) + "...";
               this._nickName.htmlText = "<a href=\'event:#\'>" + _loc1_ + "</a>";
               this._tipButton = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.CloseBtn");
               this._tipButton.x = this._nickName.x;
               this._tipButton.y = this._nickName.y;
               this._tipButton.width = this._nickName.width;
               this._tipButton.height = this._nickName.height;
               this._tipButton.alpha = 1;
               this._tipButton.tipData = this._data.nickName;
               this.addChild(this._tipButton);
               this._tipButton.tipGapH = 0;
               this._tipButton.tipGapV = 0;
               this._tipButton.addEventListener("click",$.bind(this, "_onHeadClick"));
               this._uninitList.push(this._tipButton);
            }
            else
            {
               this._nickName.htmlText = "<a href=\'event:#\'>" + this._data.nickName + "</a>";
            }
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.grades);
            this._level.x = this._nickName.x + this._nickName.textWidth + 15;
            this._mood.text = this._data.snsInfo.sign;
            this.refreshBaseView(null);
         }
      }
    get isCross() {
         return this._data.serviceName != null && this._data.serviceName != "" && this._data.serviceName != this.playerInfo.serviceName;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get moodTxt() {
         return this._mood;
      }
    dispose() {
         this.removeEvent();
         if(this._headCell)
         {
            this._headCell.filters = null;
         }
         if(this._gmIcon)
         {
            this._gmIcon.dispose();
         }
         this._gmIcon = null;
         if(this._nickName)
         {
            this._nickName.dispose();
         }
         this._nickName = null;
         if(this._level)
         {
            this._level.dispose();
         }
         this._level = null;
         if(this._mood)
         {
            this._mood.dispose();
         }
         this._mood = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headCell);
         this._headCell = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._filter);
         this._filter = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vocationIcon);
         this._vocationIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._serverName);
         this._serverName = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set isCross(v) { super.isCross = v; }
    set playerInfo(v) { super.playerInfo = v; }
    set moodTxt(v) { super.moodTxt = v; }
  }
  $.meta(__IMFriendInfoView, "im.view.IMFriendInfoView", ["Disposeable"]);
  return __IMFriendInfoView;
}
deps["im.view.IMFriendInfoView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.filter.UIFilter", "yishi.manager.PlayerInfoManager", "yishi.manager.PlayerManager"];

defs["im.view.IMHistoryCell"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __IMHistoryCell extends __Base {
    static $fields(self) {
    self._dateBg = null;
    self._dateTxt = null;
    self._nameTxt = null;
    self._timeTxt = null;
    self._msgTxt = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._dateBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.describeBackground_style017");
         this._dateTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryCellDateTxt");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryCellNameTxt");
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryCellTimeTxt");
         this._msgTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryCellMsgTxt");
      }
    set data(param1) {
         if(this._data)
         {
            this._data = null;
            if(this._dateBg.parent)
            {
               this._dateBg.parent.removeChild(this._dateBg);
            }
            if(this._dateTxt.parent)
            {
               this._dateTxt.parent.removeChild(this._dateTxt);
            }
            if(this._nameTxt.parent)
            {
               this._nameTxt.parent.removeChild(this._nameTxt);
            }
            if(this._timeTxt.parent)
            {
               this._timeTxt.parent.removeChild(this._timeTxt);
            }
            if(this._msgTxt.parent)
            {
               this._msgTxt.parent.removeChild(this._msgTxt);
            }
         }
         this._data = param1;
         if(!this._data)
         {
            return;
         }
         if($.is(this._data, "Date"))
         {
            this._dateTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMHistoryCell.date") + $.C("yishi.utils.DateFormatter").format($.as(this._data, "Date"),"YYYY-MM-DD");
            this.addChild(this._dateBg);
            this.addChild(this._dateTxt);
         }
         else if($.is(this._data, $.C("mvc.module.friends.BaseIMInfo")))
         {
            this._nameTxt.text = this._data.nickName;
            this._timeTxt.text = $.C("yishi.utils.DateFormatter").format(this._data.date,"hh:mm:ss");
            this._timeTxt.x = this._nameTxt.x + this._nameTxt.width + 20;
            this._msgTxt.text = this._data.msg;
            if(this.playerInfo.userId == this._data.userId)
            {
               this._nameTxt.setFrame(1);
               this._timeTxt.setFrame(1);
            }
            else
            {
               this._nameTxt.setFrame(2);
               this._timeTxt.setFrame(2);
            }
            this.addChild(this._nameTxt);
            this.addChild(this._timeTxt);
            this.addChild(this._msgTxt);
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    getCellHeight() {
         if(this._data)
         {
            if($.is(this._data, "Date"))
            {
               return this._dateBg.height;
            }
            if($.is(this._data, $.C("mvc.module.friends.BaseIMInfo")))
            {
               return this._msgTxt.y + this._msgTxt.height;
            }
         }
         return 0;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._dateBg = null;
         if(this._dateTxt)
         {
            this._dateTxt.dispose();
         }
         this._dateTxt = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._timeTxt)
         {
            this._timeTxt.dispose();
         }
         this._timeTxt = null;
         if(this._msgTxt)
         {
            this._msgTxt.dispose();
         }
         this._msgTxt = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__IMHistoryCell, "im.view.IMHistoryCell", ["Disposeable", "INotSameHeightListCellData"]);
  return __IMHistoryCell;
}
deps["im.view.IMHistoryCell"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.friends.BaseIMInfo", "yishi.manager.PlayerManager", "yishi.utils.DateFormatter"];

defs["im.view.IMHistoryView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __IMHistoryView extends __Base {
    static $fields(self) {
    self._scrollBg = null;
    self._scrollPanel = null;
    self._cellVBox = null;
    self._closeBtn = null;
    self._firstPageBtn = null;
    self._lastPageBtn = null;
    self._prePageBtn = null;
    self._nextPageBtn = null;
    self._pageBg = null;
    self._pageTxt = null;
    self._curPage = 0;
    self._preDate = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
         this.setPageBtnEnable();
      }
    initView() {
         this.titleText = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMHistoryView.title");
         this._scrollBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewScrollBg");
         this._scrollPanel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewScrollPanel");
         this._cellVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewCellVBox");
         this._scrollPanel.setView(this._cellVBox);
         this._closeBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewCloseBtn");
         this._closeBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.close");
         this._firstPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewFirstPageBtn");
         this._lastPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewLastPageBtn");
         this._prePageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewPrePageBtn");
         this._nextPageBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewNextPageBtn");
         this._firstPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.firstPage");
         this._lastPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.lastPage");
         this._prePageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.prePage");
         this._nextPageBtn.tipData = $.C("manager.LanguageMgr").GetTranslation("public.nextPage");
         this._pageBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewPageBg");
         this._pageTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.IMHistoryViewPageTxt");
         this._pageTxt.text = "1 / 1";
         this.addToContent(this._scrollBg);
         this.addToContent(this._scrollPanel);
         this.addToContent(this._cellVBox);
         this.addToContent(this._closeBtn);
         this.addToContent(this._firstPageBtn);
         this.addToContent(this._lastPageBtn);
         this.addToContent(this._prePageBtn);
         this.addToContent(this._nextPageBtn);
         this.addToContent(this._pageBg);
         this.addToContent(this._pageTxt);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._closeBtn.addEventListener("click",$.bind(this, "__onCloseBtnClick"));
         this._firstPageBtn.addEventListener("click",$.bind(this, "__onFirstPageClick"));
         this._lastPageBtn.addEventListener("click",$.bind(this, "__onLastPageClick"));
         this._prePageBtn.addEventListener("click",$.bind(this, "__onPrePageClick"));
         this._nextPageBtn.addEventListener("click",$.bind(this, "__onNextPageClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._closeBtn.removeEventListener("click",$.bind(this, "__onCloseBtnClick"));
         this._firstPageBtn.removeEventListener("click",$.bind(this, "__onFirstPageClick"));
         this._lastPageBtn.removeEventListener("click",$.bind(this, "__onLastPageClick"));
         this._prePageBtn.removeEventListener("click",$.bind(this, "__onPrePageClick"));
         this._nextPageBtn.removeEventListener("click",$.bind(this, "__onNextPageClick"));
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
    __onCloseBtnClick(param1) {
         this.dispose();
      }
    __onFirstPageClick(param1) {
         this.curPage = 1;
      }
    __onLastPageClick(param1) {
         if(this._data)
         {
            this.curPage = this.imManager.getIMHistoryTotalPages(this._data.userId);
         }
      }
    __onPrePageClick(param1) {
         if(this._curPage > 1)
         {
            this.curPage = this._curPage - 1;
         }
      }
    __onNextPageClick(param1) {
         if(this._data && this._curPage < this.imManager.getIMHistoryTotalPages(this._data.userId))
         {
            this.curPage = this._curPage + 1;
         }
      }
    refreshView() {
         var _loc4_ = undefined;
         var _loc3_ = null;
         var _loc2_ = null;
         this._preDate = null;
         this.clean();
         if(this._data)
         {
            _loc4_ = this.imManager.getCurPageIMHistoryList(this._data.userId,this._curPage);
            if(!_loc4_)
            {
               return;
            }
            for (var _loc1_ of $.values(_loc4_))
            {
               if(!this._preDate)
               {
                  this._preDate = _loc1_.date;
               }
               else if(this._preDate.fullYear != _loc1_.date.fullYear || this._preDate.month != _loc1_.date.month || this._preDate.date != _loc1_.date.date)
               {
                  _loc3_ = new ($.C("im.view.IMHistoryCell"))();
                  _loc3_.data = _loc1_.date;
                  this._cellVBox.addChild(_loc3_);
                  this._preDate = null;
               }
               _loc2_ = new ($.C("im.view.IMHistoryCell"))();
               _loc2_.data = _loc1_;
               this._cellVBox.addChild(_loc2_);
            }
            this._cellVBox.refreshChildPos();
            this._scrollPanel.invalidateViewport(true);
         }
         this._pageTxt.text = this._curPage + " / " + this.imManager.getIMHistoryTotalPages(this._data.userId);
         this.setPageBtnEnable();
      }
    setPageBtnEnable() {
         this._firstPageBtn.enable = this._prePageBtn.enable = this._curPage > 1;
         if(this._data)
         {
            this._lastPageBtn.enable = this._nextPageBtn.enable = this._curPage < this.imManager.getIMHistoryTotalPages(this._data.userId);
         }
         else
         {
            this._lastPageBtn.enable = this._nextPageBtn.enable = false;
         }
      }
    set curPage(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._curPage == param1)
         {
            return;
         }
         this._curPage = param1;
         this.refreshView();
      }
    set data(param1) {
         this._data = param1;
         this.__onLastPageClick(null);
      }
    show(param1) {
         $.C("com.pickgliss.ui.LayerManager").Instance.addTolayerRelated(param1,this,3,true,false);
         this.x -= 28;
         this.y += 32;
      }
    get imManager() {
         return $.C("managers.IMManager").instance;
      }
    clean() {
         var _loc1_ = null;
         while(this._cellVBox.numChildren > 0)
         {
            _loc1_ = this._cellVBox.getChildAt(0);
            this._cellVBox.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
      }
    dispose() {
         this.removeEvent();
         this.clean();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._scrollBg)
         {
            this._scrollBg.dispose();
         }
         this._scrollBg = null;
         if(this._scrollPanel)
         {
            this._scrollPanel.dispose();
         }
         this._scrollPanel = null;
         if(this._cellVBox)
         {
            this._cellVBox.dispose();
         }
         this._cellVBox = null;
         if(this._closeBtn)
         {
            this._closeBtn.dispose();
         }
         this._closeBtn = null;
         if(this._firstPageBtn)
         {
            this._firstPageBtn.dispose();
         }
         this._firstPageBtn = null;
         if(this._lastPageBtn)
         {
            this._lastPageBtn.dispose();
         }
         this._lastPageBtn = null;
         if(this._prePageBtn)
         {
            this._prePageBtn.dispose();
         }
         this._prePageBtn = null;
         if(this._nextPageBtn)
         {
            this._nextPageBtn.dispose();
         }
         this._nextPageBtn = null;
         if(this._pageBg)
         {
            this._pageBg.dispose();
         }
         this._pageBg = null;
         if(this._pageTxt)
         {
            this._pageTxt.dispose();
         }
         this._pageTxt = null;
         this._preDate = null;
         this._data = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get curPage() { return super.curPage; }
    get data() { return super.data; }
    set imManager(v) { super.imManager = v; }
  }
  $.meta(__IMHistoryView, "im.view.IMHistoryView", []);
  return __IMHistoryView;
}
deps["im.view.IMHistoryView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "im.view.IMHistoryCell", "manager.LanguageMgr", "managers.IMManager"];

defs["im.view.IMStateComBox"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.ComboBox");
  class __IMStateComBox extends __Base {
    static $fields(self) {
    self._frameImageStyle = null;
    self._frameImage = null;
    }
    constructor() {
         super();
         this.addEvent();
      }
    addEvent() {
         $.C("yishi.manager.NotificationManager").instance.addEventListener("IMSTATE_CHANGE",$.bind(this, "__imStateChangeHandler"));
      }
    removeEvent() {
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("IMSTATE_CHANGE",$.bind(this, "__imStateChangeHandler"));
      }
    setTipData(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         switch(param1 - 4)
         {
            case 0:
               this.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateComBox.leaveState");
               break;
            case 1:
               this.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateComBox.noDisturb");
               break;
            case 2:
               this.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateComBox.busyState");
               break;
            case 3:
               this.tipData = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateComBox.onlineState");
         }
      }
    __imStateChangeHandler(param1) {
         var _loc2_ = $.as(param1.data, $.C("mvc.module.friends.IMStateInfo"));
         if(_loc2_)
         {
            this._currentSelectedCellValue = _loc2_;
            this._currentSelectedItem = this._listPanel.list.getItemByValue(_loc2_);
            this._currentSelectedIndex = this._listPanel.vectorListModel.indexOf(_loc2_);
            if(this._frameImage)
            {
               this._frameImage.setFrame(_loc2_.id);
            }
            this.setTipData(_loc2_.id);
            this.dispatchEvent(new ($.C("com.pickgliss.events.InteractiveEvent"))("stateChange"));
         }
      }
    setData() {
         this.listPanel.vectorListModel.appendAll(this.imModel.stateList.getList());
         this._frameImage.setFrame(this.imModel.curState);
         this.setTipData(this.imModel.curState);
      }
    set frameImageStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._frameImageStyle == param1)
         {
            return;
         }
         this._frameImageStyle = param1;
         this._frameImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat(this._frameImageStyle);
         this._frameImage.mouseEnabled = this._frameImage.mouseChildren = false;
         this._frameImage.setFrame(1);
      }
    get frameImage() {
         return this._frameImage;
      }
    get imModel() {
         return $.C("managers.IMManager").instance.model;
      }
    __onItemChanged(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc4_ = $.as(param1.cellValue, $.C("mvc.module.friends.IMStateInfo"));
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.id == 7)
         {
            if(this.imModel.curState == 7)
            {
               return;
            }
            $.C("managers.IMManager").instance.sendChangeIMState(_loc4_.id,"");
         }
         else
         {
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputView");
            _loc2_ = new ($.C("flash.geom.Point"))(this.x,this.y);
            _loc2_ = this.localToGlobal(_loc2_);
            _loc3_.x = _loc2_.x - _loc3_.width;
            _loc3_.y = _loc2_.y + 50;
            _loc3_.data = _loc4_;
            _loc3_.show();
         }
      }
    addChildren() {
         super.addChildren();
         if(this._frameImage)
         {
            this.addChild(this._frameImage);
         }
      }
    __onStageClick(param1) {
         var _loc2_ = $.as(param1.target, $.C("flash.display.DisplayObject"));
         if(!$.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this) && !$.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._listPanel))
         {
            return;
         }
         if($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._button))
         {
            this.doShow();
         }
         if($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._listPanel.list) || Boolean($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._textField)) || Boolean($.C("com.pickgliss.utils.DisplayUtils").isTargetOrContain(_loc2_,this._frameImage)))
         {
            if(this._state == $.C("com.pickgliss.ui.controls.ComboBox").HIDE)
            {
               this.doShow();
            }
            else
            {
               this.doHide();
            }
         }
      }
    doShow() {
         if(this._listPanel.vectorListModel.getSize() == 0)
         {
            return;
         }
         this.onPosChanged();
         this._defaultShowState = 1;
         if(this._listPanel)
         {
            $.C("com.pickgliss.ui.ComponentSetting").COMBOX_LIST_LAYER.addChild(this._listPanel.asDisplayObject());
         }
         $.C("com.pickgliss.ui.ComponentSetting").COMBOX_LIST_LAYER.addChild(this._maskShape);
         $.C("com.greensock.TweenLite").killTweensOf(this._listPanel);
         $.C("com.greensock.TweenLite").to(this._listPanel,$.C("com.pickgliss.ui.ComponentSetting").COMBOBOX_SHOW_TIME,{
            "y":this.direction * (this._comboboxZeroPos.y + this._listInnerRect.para2),
            "ease":$.C("com.pickgliss.ui.ComponentSetting").COMBOBOX_SHOW_EASE_FUNCTION
         });
         this._state = $.C("com.pickgliss.ui.controls.ComboBox").SHOW;
      }
    dispose() {
         this.removeEvent();
         if(this._frameImage)
         {
            this._frameImage.dispose();
         }
         this._frameImage = null;
         super.dispose();
      }
    get frameImageStyle() { return super.frameImageStyle; }
    set frameImage(v) { super.frameImage = v; }
    set imModel(v) { super.imModel = v; }
  }
  $.meta(__IMStateComBox, "im.view.IMStateComBox", []);
  return __IMStateComBox;
}
deps["im.view.IMStateComBox"] = ["com.greensock.TweenLite", "com.pickgliss.events.InteractiveEvent", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.ComponentSetting", "com.pickgliss.ui.controls.ComboBox", "com.pickgliss.utils.DisplayUtils", "flash.display.DisplayObject", "flash.geom.Point", "manager.LanguageMgr", "managers.IMManager", "mvc.module.friends.IMStateInfo", "yishi.manager.NotificationManager"];

defs["im.view.IMStateComBoxCell"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.AbstractTextButton");
  class __IMStateComBoxCell extends __Base {
    static $fields(self) {
    self._frameImage = null;
    self._frameImageStyle = null;
    self._data = null;
    }
    constructor() {
         super();
      }
    set frameImageStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._frameImageStyle == param1)
         {
            return;
         }
         this._frameImageStyle = param1;
         this._frameImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat(this._frameImageStyle);
      }
    get frameImage() {
         return this._frameImage;
      }
    get stateId() {
         if(this._data)
         {
            return this._data.id;
         }
         return 1;
      }
    setListCellStatus(param1, param2, param3) {
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
      }
    getCellValue() {
         return this._data;
      }
    setCellValue(param1) {
         if(this._data == param1)
         {
            return;
         }
         this._data = $.as(param1, $.C("mvc.module.friends.IMStateInfo"));
         if(this._data)
         {
            this.text = this._data.name;
            if(this._frameImage)
            {
               this._frameImage.setFrame(this._data.id);
            }
            this.tipData = this._data.name;
         }
      }
    addChildren() {
         super.addChildren();
         if(this._frameImage)
         {
            this.addChild(this._frameImage);
         }
      }
    dispose() {
         if(this._frameImage)
         {
            this._frameImage.dispose();
         }
         this._frameImage = null;
         this._data = null;
         super.dispose();
      }
    get frameImageStyle() { return super.frameImageStyle; }
    set frameImage(v) { super.frameImage = v; }
    set stateId(v) { super.stateId = v; }
  }
  $.meta(__IMStateComBoxCell, "im.view.IMStateComBoxCell", ["IListCell"]);
  return __IMStateComBoxCell;
}
deps["im.view.IMStateComBoxCell"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.AbstractTextButton", "mvc.module.friends.IMStateInfo"];

defs["im.view.IMStateReplyInputView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.controls.Frame");
  class __IMStateReplyInputView extends __Base {
    static $fields(self) {
    self._tipTxt = null;
    self._inputTxt = null;
    self._inputBg = null;
    self._confirmBtn = null;
    self._cancleBtn = null;
    self._data = null;
    self._tempStr = "";
    }
    constructor() {
         super();
         this.initView();
         this.addEvent();
      }
    initView() {
         this._tipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputTipTxt");
         this._inputTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputTxt");
         this._inputBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputBg");
         this._confirmBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputConfirmBtn");
         this._cancleBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("friends.IMStateReplyInputCancleBtn");
         this._tipTxt.text = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateReplyInputView.inputTip");
         this._confirmBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         this._cancleBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.cancel");
         this.addToContent(this._tipTxt);
         this.addToContent(this._inputBg);
         this.addToContent(this._inputTxt);
         this.addToContent(this._confirmBtn);
         this.addToContent(this._cancleBtn);
      }
    addEvent() {
         this.addEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._inputTxt.addEventListener("change",$.bind(this, "__inputNameHandler"));
         this._confirmBtn.addEventListener("click",$.bind(this, "__onConfirmClick"));
         this._cancleBtn.addEventListener("click",$.bind(this, "__onCloseClick"));
      }
    removeEvent() {
         this.removeEventListener("response",$.bind(this, "__frameResponseHandler"));
         this._inputTxt.removeEventListener("change",$.bind(this, "__inputNameHandler"));
         this._confirmBtn.removeEventListener("click",$.bind(this, "__onConfirmClick"));
         this._cancleBtn.removeEventListener("click",$.bind(this, "__onCloseClick"));
      }
    __inputNameHandler(param1) {
         if($.C("yishi.utils.StringHelper").checkStringLength(this._inputTxt.text) > 60)
         {
            this._inputTxt.text = this._tempStr;
         }
         this._tempStr = this._inputTxt.text;
      }
    __onConfirmClick(param1) {
         var _loc2_ = null;
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         if(this._data && this._inputTxt)
         {
            _loc2_ = $.C("yishi.utils.StringHelper").trimRight(this._inputTxt.text);
            if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc2_))
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateComBox.leaveReply");
            }
            if(_loc2_ != $.C("manager.FilterWordManager").filterWrod(_loc2_))
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
               return;
            }
            if(this._data.id != this.imModel.curState || this._data.replyContent != _loc2_)
            {
               $.C("managers.IMManager").instance.sendChangeIMState(this._data.id,_loc2_);
            }
         }
         this.dispose();
      }
    __frameResponseHandler(param1) {
         switch($.int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               this.dispose();
               break;
            case 2:
            case 3:
               this.__onConfirmClick(null);
         }
      }
    refreshView() {
         if(this._data)
         {
            this._inputTxt.text = this._data.replyContent;
            this._inputTxt.setSelection(0,this._inputTxt.length);
            this._inputTxt.setFocus();
         }
      }
    set data(param1) {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         this.refreshView();
      }
    show() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,3,false,false,1);
      }
    get imModel() {
         return $.C("managers.IMManager").instance.model;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         if(this._tipTxt)
         {
            this._tipTxt.dispose();
         }
         this._tipTxt = null;
         if(this._inputTxt)
         {
            this._inputTxt.dispose();
         }
         this._inputTxt = null;
         if(this._inputBg)
         {
            this._inputBg.dispose();
         }
         this._inputBg = null;
         if(this._confirmBtn)
         {
            this._confirmBtn.dispose();
         }
         this._confirmBtn = null;
         if(this._cancleBtn)
         {
            this._cancleBtn.dispose();
         }
         this._cancleBtn = null;
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set imModel(v) { super.imModel = v; }
  }
  $.meta(__IMStateReplyInputView, "im.view.IMStateReplyInputView", []);
  return __IMStateReplyInputView;
}
deps["im.view.IMStateReplyInputView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.controls.Frame", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.FilterWordManager", "manager.LanguageMgr", "managers.IMManager", "yishi.keyboard.KeyBoardRegister", "yishi.utils.StringHelper", "yishi.view.tips.MessageTipManager"];
