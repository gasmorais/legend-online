package kingback.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kingback.item.KingbackDayItem;
   import kingback.item.KingbackDayRewardItem;
   import manager.LanguageMgr;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.base.NumberBitmap;
   
   public class KingbackDayPage extends Sprite
   {
      
      public static const EVENT_CHOOSE_DAY:String = "kingback.chooseDay";
      
      public var _dayReward:KingbackDayRewardItem;
      
      public var _any:Bitmap;
      
      public var _dayChargeBtn:BaseButton;
      
      private var _rollPane:HRollItemPanel;
      
      private var _numBit:NumberBitmap;
      
      private var _dayItems:Array = [];
      
      private var _topArr:Array;
      
      private var _dataArr:Array;
      
      private var _pdt:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function KingbackDayPage()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _dayReward = ComponentFactory.Instance.creatCustomObject("ui.kingback.dayReward");
         _any = ComponentFactory.Instance.creatBitmap("asset.kingback.any");
         _dayChargeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.dayChargeBtn");
         _rollPane = ComponentFactory.Instance.creatCustomObject("kingback.day.HRollItemPanel");
         _numBit = ComponentFactory.Instance.creatCustomObject("kingback.day.NumberBitmap");
         _pdt = ComponentFactory.Instance.creatBitmap("asset.kingback.pdt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("kingback.day.txt");
         addChild(_dayReward);
         addChild(_any);
         addChild(_dayChargeBtn);
         addChild(_rollPane);
         addChild(_numBit);
         addChild(_pdt);
         addChild(_txt);
         _rollPane.initParams("ui.kingback.dayItemBox","ui.kingback.dayLeftBtn","ui.kingback.dayRightBtn",4,120,150,0);
         _numBit.initParams(null,"asset.kingback.redNumData",24,31,22,24,"0123456789");
      }
      
      private function initData() : void
      {
         var _loc9_:KingbackDayItem = null;
         var _loc8_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:KingbackInfo = null;
         var _loc2_:KingbackInfo = null;
         var _loc6_:int = 0;
         _dataArr = model.getInfoListByType(1);
         _topArr = getTopics(_dataArr);
         var _loc3_:int = int(_topArr == null ? 0 : _topArr.length);
         var _loc1_:int = getCurrDayIdx();
         var _loc7_:int = -1;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc8_ = _topArr[_loc6_];
            _loc4_ = _loc8_[0];
            _loc2_ = _loc8_[1];
            _loc5_ = int(_loc4_.tempInfo.Topic);
            _loc9_ = new KingbackDayItem(_loc5_,_loc6_);
            _loc9_.dayInfos = _loc8_;
            _loc9_.currDayIdx = _loc1_;
            if(_loc1_ == _loc5_)
            {
               _loc7_ = _loc6_;
               if(_loc4_.rewardState == 2)
               {
                  dayChangeView(_loc2_);
               }
               else
               {
                  dayChangeView(_loc4_);
               }
               _loc9_.selected = true;
            }
            _dayItems.push(_loc9_);
            _loc6_++;
         }
         _rollPane.updateList(_dayItems);
         if(_loc3_ > 0)
         {
            if(_loc7_ == -1)
            {
               _loc7_ = _loc3_ - 1;
               if(_loc4_.rewardState == 2)
               {
                  dayChangeView(_loc2_);
               }
               else
               {
                  dayChangeView(_loc4_);
               }
               _loc9_.selected = true;
            }
            if(_loc7_ > 0)
            {
               _rollPane.skip(_loc7_);
            }
         }
         _txt.htmlText = LanguageMgr.GetTranslation("KingBackDayPage.txt.text",model.chargeTotalCount);
      }
      
      private function getCurrDayIdx() : int
      {
         var _loc4_:Array = null;
         var _loc2_:KingbackInfo = null;
         var _loc5_:int = 0;
         _loc5_ = 99999;
         var _loc3_:int = 0;
         var _loc1_:int = int(_topArr == null ? 0 : _topArr.length);
         var _loc6_:int = 99999;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _topArr[_loc3_];
            sortDayInfo(_loc4_);
            _loc2_ = _loc4_[0];
            if(_loc2_.rewardState != 0)
            {
               _loc6_ = int(_loc2_.tempInfo.Topic);
               if(_loc3_ == _loc1_ - 1 && _loc2_.rewardState == 2)
               {
                  _loc6_ = 99999;
               }
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      private function getTopics(param1:Array) : Array
      {
         var _loc7_:KingbackInfo = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = int(param1 == null ? 0 : param1.length);
         if(_loc3_ > 0)
         {
            param1.sort(sortFun);
            _loc7_ = param1[0];
            _loc6_ = int(_loc7_.tempInfo.Topic);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = param1[_loc5_];
               if(_loc6_ == _loc7_.tempInfo.Topic)
               {
                  if(_loc4_ == null)
                  {
                     _loc4_ = [];
                  }
                  _loc4_.push(_loc7_);
               }
               else
               {
                  _loc2_.push(_loc4_);
                  _loc6_ = int(_loc7_.tempInfo.Topic);
                  _loc4_ = [];
                  _loc4_.push(_loc7_);
               }
               _loc5_++;
            }
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function sortFun(param1:KingbackInfo, param2:KingbackInfo) : int
      {
         var _loc3_:int = int(param1.tempInfo.Topic);
         var _loc4_:int = int(param2.tempInfo.Topic);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      private function sortDayInfo(param1:Array) : void
      {
         var _loc2_:KingbackInfo = null;
         var _loc3_:KingbackInfo = null;
         var _loc4_:Boolean = false;
         if(param1 && param1.length == 2)
         {
            _loc2_ = param1[0];
            _loc3_ = param1[1];
            _loc4_ = _loc2_.tempInfo.ConditionType == 2;
            if(_loc4_ > 0)
            {
               param1[1] = _loc2_;
               param1[0] = _loc3_;
            }
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:KingbackDayItem = null;
         var _loc3_:int = 0;
         var _loc1_:int = getCurrDayIdx();
         var _loc2_:int = int(_dayItems.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _dayItems[_loc3_];
            _loc4_.refreshState();
            _loc4_.currDayIdx = _loc1_;
            _loc3_++;
         }
         _txt.htmlText = LanguageMgr.GetTranslation("KingBackDayPage.txt.text",model.chargeTotalCount);
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("kingback.chooseDay",chooseDayHandler);
         _dayChargeBtn.addEventListener("click",clickChargeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("kingback.chooseDay",chooseDayHandler);
         _dayChargeBtn.removeEventListener("click",clickChargeHandler);
      }
      
      private function chooseDayHandler(param1:NotificationEvent) : void
      {
         var _loc2_:KingbackInfo = param1.data as KingbackInfo;
         dayChangeView(_loc2_);
      }
      
      private function dayChangeView(param1:KingbackInfo) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _dayReward.data = param1;
            if(param1.tempInfo.ConditionType == 2)
            {
               _numBit.num = int(param1.tempInfo.Param1);
            }
            else
            {
               _loc3_ = int(param1.tempInfo.Topic);
               for each(var _loc2_:KingbackInfo in _dataArr)
               {
                  if(_loc2_.tempInfo.Topic == _loc3_ && _loc2_.tempInfo.ConditionType == 2)
                  {
                     _numBit.num = int(_loc2_.tempInfo.Param1);
                     break;
                  }
               }
            }
            _pdt.x = _numBit.x + _numBit.displayWidth + 5;
         }
      }
      
      private function clickChargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:KingbackDayItem in _dayItems)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _dayItems = null;
         ObjectUtils.disposeObject(_dayReward);
         _dayReward = null;
         ObjectUtils.disposeObject(_any);
         _any = null;
         ObjectUtils.disposeObject(_dayChargeBtn);
         _dayChargeBtn = null;
         ObjectUtils.disposeObject(_rollPane);
         _rollPane = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_pdt);
         _pdt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _topArr = null;
         _dataArr = null;
      }
   }
}

