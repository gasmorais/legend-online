package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.utils.NumberViewUtils;
   
   public class CountDownView extends Sprite implements Disposeable
   {
      
      public static const TYPE_DEFAULT:int = 1;
      
      public static const TYPE_PVP:int = 2;
      
      public static const TYPE_GVG:int = 3;
      
      private var _bg:MutipleImage;
      
      private var _numAsset:BitmapData;
      
      private var _countMc:MovieClip;
      
      private var _downTimeTxt:GradientText;
      
      private var _totalTime:int;
      
      private var _changeStyleTime:int;
      
      private var _callFunc:Function;
      
      private var _timer:Timer;
      
      private var _type:int;
      
      public function CountDownView(param1:int = 1)
      {
         _type = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = this.mouseChildren = false;
         _downTimeTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.PvpMapTimeDownTxt");
         _numAsset = ComponentFactory.Instance.creatBitmapData("asset.core.LevelUpNumber");
         _countMc = ComponentFactory.Instance.creatCustomObject("campaign.CountDownViewCountMc");
         _timer = new Timer(1000);
         switch(_type - 1)
         {
            case 0:
               _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.CountDownViewBg");
               break;
            case 1:
               _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.PvpMapCountDownViewBg");
               break;
            case 2:
               _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.GvgCountDownViewBg");
               _downTimeTxt.x = 550;
         }
         _countMc.gotoAndStop(1);
         addChild(_bg);
         addChild(_downTimeTxt);
      }
      
      public function setData(param1:int = 60, param2:int = 10, param3:Function = null) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeUpdateHandler);
            _timer.reset();
         }
         _totalTime = param1;
         _changeStyleTime = param2;
         _callFunc = param3;
         refreshView();
         if(_timer)
         {
            _timer.addEventListener("timer",__timeUpdateHandler);
            _timer.start();
         }
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         _totalTime = _totalTime - 1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_totalTime <= 0)
         {
            if(_callFunc != null)
            {
               _callFunc();
            }
            dispose();
            return;
         }
         refreshTime(_totalTime);
         if(_totalTime < _changeStyleTime)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            if(_downTimeTxt.parent)
            {
               _downTimeTxt.parent.removeChild(_downTimeTxt);
            }
            addChild(_countMc);
            _countMc.gotoAndStop("start");
            NumberViewUtils.refreshValue(_totalTime,_countMc["num"],_numAsset,56,64,50,56,"0123456789");
            _countMc.play();
         }
      }
      
      private function refreshTime(param1:int) : void
      {
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:String = null;
         var _loc9_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc10_:String = null;
         if(param1 >= 3600)
         {
            _loc3_ = param1 / 3600;
         }
         if(param1 >= 60)
         {
            _loc8_ = param1 % 3600 / 60;
         }
         _loc7_ = param1 % 3600 % 60;
         if(_loc3_)
         {
            _loc5_ = _loc3_ >= 10 ? _loc3_.toString() : "0" + _loc3_;
            _loc9_ = _loc8_ >= 10 ? _loc8_.toString() : "0" + _loc8_;
            _loc2_ = _loc7_ >= 10 ? _loc7_.toString() : "0" + _loc7_;
            _loc6_ = _loc5_ + ":" + _loc9_ + ":" + _loc2_;
         }
         else
         {
            _loc4_ = _loc8_ >= 10 ? _loc8_.toString() : "0" + _loc8_;
            _loc10_ = _loc7_ >= 10 ? _loc7_.toString() : "0" + _loc7_;
            _loc6_ = _loc4_ + ":" + _loc10_;
         }
         _downTimeTxt.text = _loc6_;
      }
      
      public function show() : void
      {
         if(_type == 2 || _type == 3)
         {
            LayerManager.Instance.addToLayer(this,4,true,true);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeUpdateHandler);
            _timer.stop();
            _timer = null;
         }
         _callFunc = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_numAsset)
         {
            _numAsset.dispose();
         }
         _numAsset = null;
         ObjectUtils.disposeViolentMc(_countMc);
         _countMc = null;
         if(_downTimeTxt)
         {
            _downTimeTxt.dispose();
         }
         _downTimeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

