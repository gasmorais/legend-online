package year2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.YearActiveManager;
   import mvc.module.year2023.YearActiveModel;
   import year2023.ui.item.YearActiveBoxItemUI;
   import year2023.ui.view.YearActiveLookViewUI;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class YearActiveLookView extends YearActiveLookViewUI
   {
      
      private var _prePanelList:SimpleTileList;
      
      private var _boxPanelList:SimpleTileList;
      
      private var _preItemList:Vector.<BaseItemView>;
      
      private var _boxItemList:Vector.<YearActiveBoxItemUI>;
      
      private var _allTempList:Array;
      
      private var _hasKeyNum:int = 0;
      
      public function YearActiveLookView()
      {
         super();
         addView();
         initEvent();
         __updateKeyNums();
         updateDataView(true);
      }
      
      private function addView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:YearActiveBoxItemUI = null;
         var _loc3_:int = 0;
         _lookRdwTitle.text = LanguageMgr.GetTranslation("mainBar.TopToolsBar.dayGuideBtnTipData");
         var _loc5_:String = YearActiveManager.ins.openTime;
         var _loc4_:String = YearActiveManager.ins.stopTime;
         _lookTimeTxt.text = LanguageMgr.GetTranslation("SevenYear.time",_loc5_,_loc4_);
         _lookTitle.text = LanguageMgr.GetTranslation("yearactivity.box.clicktip");
         _allTempList = TempleteManager.instance.theseusPvpRewardCate.getListByType(3);
         _prePanelList = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookpre.SimpleTileList",[3]);
         _boxPanelList = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookBox.SimpleTileList",[3]);
         addChild(_prePanelList);
         addChild(_boxPanelList);
         addChild(_lookTitle);
         _preItemList = new Vector.<BaseItemView>();
         _boxItemList = new Vector.<YearActiveBoxItemUI>();
         _prePanelList.beginChanges();
         _boxPanelList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookLeftPreIcon");
            _prePanelList.addChild(_loc1_);
            _preItemList.push(_loc1_);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.year2023.ui.item.YearActiveBoxItemUI");
            _loc2_.pos = _loc3_ + 1;
            _boxPanelList.addChild(_loc2_);
            _boxItemList.push(_loc2_);
            _loc3_++;
         }
         _boxPanelList.commitChanges();
         _prePanelList.commitChanges();
      }
      
      private function updateDataView(param1:Boolean) : void
      {
         var _loc19_:Array = null;
         var _loc14_:Dictionary = null;
         var _loc12_:int = 0;
         var _loc16_:Array = null;
         var _loc17_:Boolean = false;
         _lookxLv.text = "" + model.boxLevel;
         var _loc8_:int = model.boxLevel / 5;
         var _loc2_:int = (_loc8_ + 1) * 5;
         var _loc4_:SpeicalRewardTempInfo = _allTempList[_allTempList.length - 1];
         if(_loc4_.Gear <= model.boxLevel)
         {
            _lookNextBtn.visible = false;
            _loc2_ = int(_loc4_.Gear);
         }
         else
         {
            _lookPassbg.visible = false;
            _lookPassFt.visible = false;
            _lookNextBtn.visible = true;
            _lookNextBtn.enable = model.boxNext;
         }
         _lookxFt.text = LanguageMgr.GetTranslation("yearactivity.box.prenext",_loc2_);
         var _loc13_:SpeicalRewardTempInfo = _allTempList[_loc2_ - 1];
         var _loc7_:Array = _loc13_.PayReward.split(",");
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = int(_loc7_[0]);
         _loc3_.count = int(_loc7_[1]);
         _lookPreIcon.data = _loc3_;
         var _loc6_:SpeicalRewardTempInfo = _allTempList[model.boxLevel - 1];
         var _loc9_:Array = [];
         var _loc11_:Array = _loc6_.PayReward.split(",");
         var _loc15_:GoodsInfo = new GoodsInfo();
         _loc15_.templateId = int(_loc11_[0]);
         _loc15_.count = int(_loc11_[1]);
         _loc9_.push(_loc15_);
         var _loc18_:Array = _loc6_.RandReward.split("|");
         var _loc10_:int = int(_loc18_.length);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc11_ = _loc18_[_loc5_].split(",");
            _loc15_ = new GoodsInfo();
            _loc15_.templateId = int(_loc11_[0]);
            _loc15_.count = int(_loc11_[1]);
            _loc9_.push(_loc15_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _preItemList[_loc5_].data = _loc9_[_loc5_];
            _boxItemList[_loc5_].init();
            _loc5_++;
         }
         if(model.boxInfo != null && model.boxInfo.length > 0)
         {
            _loc19_ = model.boxInfo.split("|");
            _loc14_ = new Dictionary();
            if(model.showInfo != null && model.showInfo.length > 0)
            {
               _loc16_ = model.showInfo.split(",");
               _loc10_ = int(_loc16_.length);
               _loc5_ = 0;
               while(_loc5_ < _loc10_)
               {
                  _loc12_ = int(_loc16_[_loc5_]);
                  _loc14_[_loc12_] = _loc12_;
                  _loc5_++;
               }
            }
            _loc10_ = int(_loc19_.length);
            if(_loc10_ == 9)
            {
               _xKeyBtnBg.enable = false;
            }
            else
            {
               _xKeyBtnBg.enable = true;
            }
            _lookkeynum.text = "" + (9 - _loc10_);
            if(_loc4_.Gear <= model.boxLevel)
            {
               if(_loc10_ == 9)
               {
                  _lookxFt.text = "";
                  _boxPreBg.visible = false;
                  _lookPreIcon.visible = false;
                  _lookPassbg.visible = true;
                  _lookPassFt.visible = true;
                  _lookPassFt.text = LanguageMgr.GetTranslation("yearactivity.box.pass");
               }
            }
            _loc5_ = 0;
            while(_loc5_ < _loc10_)
            {
               _loc11_ = _loc19_[_loc5_].split(",");
               _loc12_ = int(_loc11_[0]);
               _loc17_ = _loc14_[_loc12_] != null && !param1;
               _boxItemList[_loc12_ - 1].playOrShow(_loc11_,_loc17_);
               _loc5_++;
            }
         }
         else
         {
            _xKeyBtnBg.enable = true;
            _lookkeynum.text = "9";
         }
      }
      
      private function get model() : YearActiveModel
      {
         return YearActiveManager.ins.model;
      }
      
      private function initEvent() : void
      {
         _lookNextBtn.addEventListener("click",nextHandler);
         _xKeyBtnBg.addEventListener("click",xClickHandler);
         _lookbuyBtn.addEventListener("click",buyHandler);
         NotificationManager.instance.addEventListener("EVENT_YEARACTIVITY_OP",updateInfoHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateKeyNums);
      }
      
      private function removeEvent() : void
      {
         _lookNextBtn.removeEventListener("click",nextHandler);
         _xKeyBtnBg.removeEventListener("click",xClickHandler);
         _lookbuyBtn.removeEventListener("click",buyHandler);
         NotificationManager.instance.removeEventListener("EVENT_YEARACTIVITY_OP",updateInfoHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateKeyNums);
      }
      
      private function __updateKeyNums(param1:NotificationEvent = null) : void
      {
         if(PlayerCurrencyManager.instance.currencyInfo.yearGold)
         {
            _hasKeyNum = PlayerCurrencyManager.instance.currencyInfo.yearBoxKey.amount;
            _lookBuykeynum.text = "" + _hasKeyNum;
         }
         else
         {
            _lookBuykeynum.text = "0";
         }
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("yearactive","Shop");
         FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Enter");
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         updateDataView(false);
      }
      
      private function nextHandler(param1:MouseEvent) : void
      {
         YearActiveManager.ins.doSomething(9);
      }
      
      private function xClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = int(_lookkeynum.text);
         if(_hasKeyNum < _loc4_)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("yearactive.look.noKeytoBuy");
            SimpleAlertHelper.instance.data = [__alertResponse];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,true);
            return;
         }
         YearActiveManager.ins.doSomething(8);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("yearactive","Shop");
            FrameControllerManager.instance.yearactiveContrl.setPreFrame("yearactive","Look");
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:BaseItemView in _preItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _preItemList = null;
         for each(var _loc2_:YearActiveBoxItemUI in _boxItemList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _boxItemList = null;
         _allTempList = null;
         ObjectUtils.disposeObject(_prePanelList);
         _prePanelList = null;
         ObjectUtils.disposeObject(_boxPanelList);
         _boxPanelList = null;
         super.dispose();
      }
   }
}

