package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class TiroRightView extends Sprite implements Disposeable
   {
      
      private var _titleImg:Bitmap;
      
      private var _gridSplitLine:Bitmap;
      
      private var _bottonImg:Bitmap;
      
      private var _gridBg:Bitmap;
      
      private var _funnyPanel:ScrollPanel;
      
      private var _funnyBox:VBox;
      
      private var _itemList:Array;
      
      private var _remainTimeTxt:FilterFrameText;
      
      private var _starRemainTimeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _currItem:FunnyData;
      
      public function TiroRightView()
      {
         super();
         initView();
         initEvent();
         initData(null);
      }
      
      private function initView() : void
      {
         _titleImg = new Bitmap();
         _gridSplitLine = ComponentFactory.Instance.creatBitmap("asset.funny.gridSplitLine2");
         _bottonImg = ComponentFactory.Instance.creatBitmap("asset.funny.tiroFunnyBotton");
         _gridBg = ComponentFactory.Instance.creatBitmap("asset.funny.tiroFunnyGridBg");
         _funnyPanel = ComponentFactory.Instance.creatComponentByStylename("funny.TiroFunnyScrollPanel");
         _funnyBox = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.itemVbox");
         _funnyBox.spacing = -25;
         _remainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.remainTimeText");
         _starRemainTimeTxt = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.startRemainTimeText");
         addChild(_gridBg);
         addChild(_titleImg);
         _titleImg.x = 3;
         addChild(_gridSplitLine);
         addChild(_bottonImg);
         _funnyPanel.setView(_funnyBox);
         addChild(_funnyPanel);
         addChild(_remainTimeTxt);
         addChild(_starRemainTimeTxt);
      }
      
      private function initEvent() : void
      {
         FunnyManager.instance.addEventListener("TIROITEM_CHANGE",initData);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         FunnyManager.instance.removeEventListener("TIROITEM_CHANGE",initData);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         setRemainTime();
      }
      
      private function initData(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:TiroFunnyItem = null;
         var _loc5_:int = 0;
         _currItem = FunnyManager.instance.getTiroFunnyDataByActivityId();
         if(!_currItem)
         {
            return;
         }
         _titleImg.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.funny.tiroFunnyTitle" + _currItem.type);
         if(!_itemList)
         {
            _itemList = [];
         }
         else
         {
            clearArr(_itemList);
         }
         _funnyBox.removeAllChild();
         var _loc3_:Boolean = true;
         if(_currItem.endTime < playerModel.nowDate)
         {
            _loc3_ = false;
         }
         var _loc6_:Vector.<FunnyBagData> = _currItem.bagList;
         var _loc7_:int = int(_loc6_.length >= 4 ? _loc6_.length : 4);
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("funny.TiroFunnyItem");
            _funnyBox.addChild(_loc2_);
            _loc2_.setfilterstate(_loc3_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _itemList[_loc5_].data = _loc6_[_loc5_];
            _loc5_++;
         }
         _funnyPanel.invalidateViewport();
         if(_loc6_.length > 4)
         {
            _funnyPanel.vScrollbar.visible = true;
         }
         else
         {
            _funnyPanel.vScrollbar.visible = false;
         }
      }
      
      private function clearArr(param1:Array) : void
      {
         while(param1 && param1.length > 0)
         {
            ObjectUtils.disposeObject(param1.shift());
         }
      }
      
      private function setRemainTime() : void
      {
         var _loc5_:TiroFunnyItem = null;
         var _loc7_:int = 0;
         var _loc2_:TiroFunnyItem = null;
         var _loc8_:int = 0;
         var _loc1_:TiroFunnyItem = null;
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         if(!_currItem)
         {
            return;
         }
         var _loc4_:Number = _currItem.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc4_ >= 60)
         {
            _remainTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc4_));
            _loc7_ = 0;
            while(_loc7_ < _currItem.bagList.length)
            {
               _loc5_ = _itemList[_loc7_];
               _loc5_.setfilterstate(true);
               _loc7_++;
            }
         }
         else if(_loc4_ > 0)
         {
            _remainTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc4_));
            _loc8_ = 0;
            while(_loc8_ < _currItem.bagList.length)
            {
               _loc2_ = _itemList[_loc8_];
               _loc2_.setfilterstate(true);
               _loc8_++;
            }
         }
         else
         {
            _remainTimeTxt.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
            _loc3_ = 0;
            while(_loc3_ < _currItem.bagList.length)
            {
               _loc1_ = _itemList[_loc3_];
               _loc1_.setfilterstate(false);
               _loc3_++;
            }
         }
         if(_currItem.startTime > playerModel.nowDate)
         {
            _remainTimeTxt.visible = false;
            _starRemainTimeTxt.visible = true;
            _loc6_ = _currItem.startTime / 1000 - playerModel.sysCurTimeBySecond;
            if(_loc6_ >= 60)
            {
               _starRemainTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime02",DateFormatter.getFullTimeString(_loc6_));
            }
            else if(_loc6_ > 0)
            {
               _starRemainTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime02",DateFormatter.getFullDateString(_loc6_));
            }
         }
         else
         {
            _remainTimeTxt.visible = true;
            _starRemainTimeTxt.visible = false;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_gridSplitLine);
         _gridSplitLine = null;
         ObjectUtils.disposeObject(_bottonImg);
         _bottonImg = null;
         ObjectUtils.disposeObject(_gridBg);
         _gridBg = null;
         ObjectUtils.disposeObject(_funnyBox);
         _funnyBox = null;
         ObjectUtils.disposeObject(_funnyPanel);
         _funnyPanel = null;
         ObjectUtils.disposeObject(_remainTimeTxt);
         _remainTimeTxt = null;
         ObjectUtils.disposeObject(_starRemainTimeTxt);
         _starRemainTimeTxt = null;
      }
   }
}

