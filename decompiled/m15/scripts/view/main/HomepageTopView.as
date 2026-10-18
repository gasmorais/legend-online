package view.main
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import managers.ShopManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class HomepageTopView extends Sprite
   {
      
      private var _loaderCount:int = 0;
      
      private var _aryPath:Array;
      
      private var _aryImage:Array;
      
      private var _content:Sprite;
      
      private var _menu:Sprite;
      
      private var _time:Timer;
      
      private var _timeCount:int = 0;
      
      private var _loadeing:MovieClip;
      
      public function HomepageTopView()
      {
         super();
         showList();
         initEvent();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         removeTimeEvent();
         if(_content && _content.parent)
         {
            _content.parent.removeChild(_content);
         }
         ObjectUtils.disposeObject(_loadeing);
         _aryPath = null;
         _aryImage = null;
         showList();
      }
      
      private function showList() : void
      {
         _aryImage = [];
         _timeCount = _loaderCount = 0;
         _loadeing = ComponentFactory.Instance.creatCustomObject("homepageTop.Loading");
         addChild(_loadeing);
         _loadeing.play();
         _aryPath = ShopManager.Instance.model.mainUrlList;
         if(!_aryPath || _aryPath.length < 1)
         {
            return;
         }
         loaderImage(_loaderCount);
      }
      
      public function updateView() : void
      {
         if(_timeCount != 0)
         {
            _timeCount = 0;
         }
         if(_time)
         {
            _time.stop();
            _time.start();
         }
      }
      
      private function loaderImage(param1:int) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["m"] = ShopManager.Instance.model.randomCount;
         var _loc3_:String = PathManager.info.REQUEST_PATH + _aryPath[param1].url;
         LoaderManagerII.instance.load(_loc3_,2,8,onLoadComplete,null,null,null,_loc2_);
      }
      
      private function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_aryImage)
         {
            return;
         }
         _loaderCount = _loaderCount + 1;
         var _loc3_:DisplayObject = param2 as DisplayObject;
         if(_loc3_)
         {
            _loc3_.width = 677;
            _loc3_.height = 185;
            _loc3_.x = 0;
            _loc3_.y = 0;
            _aryImage.push(_loc3_);
         }
         if(_loaderCount < _aryPath.length)
         {
            loaderImage(_loaderCount);
         }
         else
         {
            handleComplete();
         }
      }
      
      private function handleComplete() : void
      {
         if(!_aryImage || _aryImage.length <= 0)
         {
            return;
         }
         _loadeing.stop();
         _loadeing.parent.removeChild(_loadeing);
         _loadeing = null;
         _content = new Sprite();
         _content.mouseEnabled = false;
         _content.mouseChildren = false;
         _content.x = 22;
         _content.y = 31;
         addChild(_content);
         _menu = new Sprite();
         addChild(_menu);
         _menu.y = 185;
         menuView();
         _time = new Timer(4000);
         _time.addEventListener("timer",_onTime);
         _time.start();
         _onTime(null);
      }
      
      private function menuView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < _aryImage.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("shop.homepageTop.MuneItem");
            _loc1_.name = _loc2_ + "";
            _loc1_.txt_txt.text = _loc2_ + 1;
            _loc1_.txt_txt2.text = _loc2_ + 1;
            _loc1_.x = _loc2_ * (_loc1_.width + 5);
            _loc1_.mouseChildren = false;
            _loc1_.mouseEnabled = true;
            _loc1_.buttonMode = true;
            _menu.addChild(_loc1_);
            _loc1_.addEventListener("click",__menuImgeClick);
            _loc2_++;
         }
         _menu.x = 693 - _menu.width;
      }
      
      private function __menuImgeClick(param1:MouseEvent) : void
      {
         _timeCount = int(param1.currentTarget.name);
         _onTime(null);
         _time.stop();
         _time.start();
      }
      
      private function _onTime(param1:TimerEvent) : void
      {
         if(_content.numChildren > 0)
         {
            _content.removeChildAt(0);
         }
         updateMenu();
         (_menu.getChildAt(_timeCount) as MovieClip).gotoAndStop(2);
         _content.addChild(_aryImage[_timeCount]);
         _timeCount = _timeCount + 1;
         if(_timeCount >= _aryImage.length)
         {
            _timeCount = 0;
         }
      }
      
      private function updateMenu() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _menu.numChildren)
         {
            (_menu.getChildAt(_loc1_) as MovieClip).gotoAndStop(1);
            (_menu.getChildAt(_loc1_) as MovieClip).txt_txt.text = _loc1_ + 1;
            (_menu.getChildAt(_loc1_) as MovieClip).txt_txt2.text = _loc1_ + 1;
            _loc1_++;
         }
      }
      
      private function removeTimeEvent() : void
      {
         if(_time)
         {
            _time.stop();
            _time.removeEventListener("timer",_onTime);
            _time = null;
         }
         if(_menu)
         {
            while(_menu.numChildren > 0)
            {
               _menu.getChildAt(0).removeEventListener("click",__menuImgeClick);
               _menu.removeChildAt(0);
            }
            if(_menu && _menu.parent)
            {
               _menu.parent.removeChild(_menu);
            }
            _menu = null;
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadComplete);
         removeEvent();
         removeTimeEvent();
         if(_content && _content.parent)
         {
            _content.parent.removeChild(_content);
         }
         ObjectUtils.disposeObject(_loadeing);
         _aryPath = null;
         _aryImage = null;
      }
   }
}

