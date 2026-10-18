package year2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.YearActiveManager;
   import mvc.module.year2023.YearActiveModel;
   import year2023.item.YearActivePointItem;
   import year2023.item.YearActivePrivateCItem;
   import year2023.item.YearActivePrivateItem;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.PageBar;
   
   public class YearActiveDayView extends Sprite
   {
      
      private var _pageBar:PageBar;
      
      private var _hbox:HBox;
      
      private var _onekeyBtn:IconButton;
      
      private var _allTempList:Array = [];
      
      private var _itemList:Array = [];
      
      private var _prc:YearActivePrivateCItem;
      
      private const PAGE_NUM:int = 7;
      
      private var _enterTimeTxt:FilterFrameText;
      
      private var _buqPrice:int;
      
      private var _goldPrice:YearActivePointItem;
      
      public function YearActiveDayView()
      {
         super();
         x = 59;
         y = 27;
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryReward.Pagebar");
         _onekeyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.onekeyBtn");
         _prc = ComponentFactory.Instance.creatCustomObject("ui.yearactive.prc");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.privateHbox");
         _enterTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.enterTimeTxt");
         _goldPrice = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayGoldPrice");
         addChild(_goldPrice);
         addChild(_prc);
         addChild(_hbox);
         addChild(_pageBar);
         addChild(_onekeyBtn);
         addChild(_enterTimeTxt);
         _enterTimeTxt.x -= x;
         _enterTimeTxt.y -= y;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("year_checkin_buy");
         var _loc2_:Array = _loc1_.ConfigValue.split(",");
         _prc.advacePrice = int(_loc2_[0]);
         _buqPrice = int(_loc2_[1]);
         var _loc4_:String = YearActiveManager.ins.openTime;
         var _loc3_:String = YearActiveManager.ins.stopTime;
         _enterTimeTxt.text = LanguageMgr.GetTranslation("SevenYear.time",_loc4_,_loc3_);
      }
      
      public function initData() : void
      {
         var _loc1_:YearActivePrivateItem = null;
         var _loc2_:int = 0;
         _allTempList = TempleteManager.instance.theseusPvpRewardCate.getListByType(2);
         updateParams();
         _hbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new YearActivePrivateItem();
            _loc1_.buqPoint = _buqPrice;
            _itemList[_loc2_] = _loc1_;
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
         _hbox.commitChanges();
         _pageBar.setAutoPagingData(_allTempList,7);
         _pageBar.setCurPage(1);
      }
      
      private function initEvent() : void
      {
         _pageBar.addEventListener("change",changeHandler);
         _onekeyBtn.addEventListener("click",oneKeyHandler);
         NotificationManager.instance.addEventListener("EVENT_YEARACTIVITY_OP",updateUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _pageBar.removeEventListener("change",changeHandler);
         _onekeyBtn.removeEventListener("click",oneKeyHandler);
         NotificationManager.instance.removeEventListener("EVENT_YEARACTIVITY_OP",updateUserInfoHandler);
      }
      
      private function updateUserInfoHandler(param1:NotificationEvent) : void
      {
         updateParams();
         updateItemStates();
      }
      
      private function get model() : YearActiveModel
      {
         return YearActiveManager.ins.model;
      }
      
      private function updateParams() : void
      {
         var _loc3_:Array = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         _prc.updateState(model.buyCheckin);
         var _loc8_:String = model.checkinInfo;
         if(_loc8_ != null && _loc8_.length > 1)
         {
            _loc3_ = _loc8_.split("|");
            _loc7_ = false;
            _loc4_ = int(model.curDay);
            _loc1_ = int(_loc3_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               _loc9_ = _loc3_[_loc5_];
               if(_loc9_.length > 1)
               {
                  _loc10_ = _loc9_.split(",");
                  _loc6_ = int(_loc10_[0]);
                  _loc2_ = int(_loc10_[1]);
                  if(_loc2_ == 1)
                  {
                     _loc7_ = true;
                  }
                  else if(_loc2_ == 2 && Boolean(model.buyCheckin))
                  {
                     _loc7_ = true;
                  }
               }
               _loc5_++;
            }
            _onekeyBtn.enable = _loc7_;
         }
         else
         {
            _onekeyBtn.enable = false;
         }
      }
      
      private function changeHandler(param1:Event) : void
      {
         var _loc3_:YearActivePrivateItem = null;
         var _loc5_:int = 0;
         var _loc6_:Array = _pageBar.getCurPageDatas();
         var _loc4_:int = int(_loc6_.length);
         var _loc2_:int = int(_pageBar.getCurPage());
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc3_ = _itemList[_loc5_];
            if(_loc5_ < _loc4_)
            {
               _loc3_.temp = _loc6_[_loc5_];
            }
            else
            {
               _loc3_.temp = null;
            }
            _loc5_++;
         }
         updateItemStates();
      }
      
      private function updateItemStates() : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:String = model.checkinInfo;
         var _loc8_:Dictionary = new Dictionary();
         if(_loc7_ != null && _loc7_.length > 1)
         {
            _loc4_ = _loc7_.split("|");
            _loc2_ = int(_loc4_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc9_ = _loc4_[_loc5_];
               if(_loc9_.length > 1)
               {
                  _loc10_ = _loc9_.split(",");
                  _loc6_ = int(_loc10_[0]);
                  _loc3_ = int(_loc10_[1]);
                  _loc8_[_loc6_] = _loc3_;
               }
               _loc5_++;
            }
         }
         for each(var _loc1_:YearActivePrivateItem in _itemList)
         {
            _loc1_.updateBtnState(_loc8_,model.curDay,model.buyCheckin);
         }
      }
      
      private function oneKeyHandler(param1:MouseEvent) : void
      {
         YearActiveManager.ins.doSomething(3);
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:YearActivePrivateItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_onekeyBtn);
         _onekeyBtn = null;
         ObjectUtils.disposeObject(_enterTimeTxt);
         _enterTimeTxt = null;
         ObjectUtils.disposeObject(_prc);
         _prc = null;
         ObjectUtils.disposeObject(_goldPrice);
         _goldPrice = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

