package funny.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import funny.activity.ActivityCodeView;
   import funny.datas.FunnyData;
   import funny.regression.RegressChargeView;
   import mvc.controler.FunnyControler;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class FunnyRightView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _codeView:ActivityCodeView;
      
      private var _bagView:FunnyBagView;
      
      private var _hotView:FunnyHotBuyView;
      
      private var _regressChargeView:RegressChargeView;
      
      private var _goddessDoubleForgeView:GoddessDoubleForgeActivityView;
      
      private var _firstPage:DisplayObject;
      
      private var _data:FunnyData;
      
      private var _timer:Timer;
      
      public function FunnyRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      private function initView() : void
      {
         _codeView = new ActivityCodeView();
         _bagView = new FunnyBagView();
         _hotView = new FunnyHotBuyView();
         _regressChargeView = new RegressChargeView();
         _goddessDoubleForgeView = new GoddessDoubleForgeActivityView();
         addChild(_codeView);
         _codeView.visible = false;
         addChild(_bagView);
         _bagView.visible = false;
         addChild(_hotView);
         _hotView.visible = false;
         addChild(_goddessDoubleForgeView);
         _goddessDoubleForgeView.visible = false;
         addChild(_regressChargeView);
         _regressChargeView.visible = false;
         loadPage();
      }
      
      public function set data(param1:FunnyData) : void
      {
         _data = param1;
         ObjectUtils.disposeObject(_firstPage);
         _firstPage = null;
         _goddessDoubleForgeView.visible = false;
         if(_data.type == 1001)
         {
            _codeView.visible = true;
            _bagView.visible = false;
            _hotView.visible = false;
            _regressChargeView.visible = false;
         }
         else if(_data.type == 1002 || _data.type == 1004)
         {
            _codeView.visible = false;
            _bagView.visible = false;
            _hotView.visible = true;
            _regressChargeView.visible = false;
            _hotView.isVIP = _data.type == 1004;
            _hotView.setHotBuy();
         }
         else if(_data.type == 1007)
         {
            _codeView.visible = false;
            _bagView.visible = false;
            _hotView.visible = false;
            _regressChargeView.visible = true;
            _regressChargeView.data = param1;
         }
         else if(_data.type == 232)
         {
            _codeView.visible = false;
            _bagView.visible = false;
            _hotView.visible = false;
            _regressChargeView.visible = false;
            _goddessDoubleForgeView.visible = true;
            _goddessDoubleForgeView.data = param1;
         }
         else
         {
            _codeView.visible = false;
            _bagView.visible = true;
            _hotView.visible = false;
            _regressChargeView.visible = false;
            _bagView.data = param1;
         }
      }
      
      private function initEvent() : void
      {
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_bagView.data)
         {
            _bagView.setRemainTime();
         }
         if(_hotView)
         {
            _hotView.setRemainTime();
         }
      }
      
      private function loadPage() : void
      {
         LoaderManagerII.instance.load(pageResource,2,8,__loadCompleteHandler);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_data)
         {
            return;
         }
         _firstPage = param2 as DisplayObject;
         if(!_firstPage)
         {
            return;
         }
         addChild(_firstPage);
         _firstPage.width = 527;
         _firstPage.height = 417;
      }
      
      private function get pageResource() : String
      {
         var _loc1_:* = null;
         var _loc2_:String = control.funnyName;
         return PathManager.getTimeStoryResPath(_loc2_);
      }
      
      private function get control() : FunnyControler
      {
         return FrameControllerManager.instance.funnyControler;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _timer = null;
         _data = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadCompleteHandler);
         if(_codeView)
         {
            _codeView.dispose();
         }
         _codeView = null;
         if(_bagView)
         {
            _bagView.dispose();
         }
         _bagView = null;
         if(_hotView)
         {
            _hotView.dispose();
         }
         _hotView = null;
         if(_goddessDoubleForgeView)
         {
            _goddessDoubleForgeView.dispose();
         }
         _goddessDoubleForgeView = null;
         ObjectUtils.disposeObject(_firstPage);
         _firstPage = null;
         if(_regressChargeView)
         {
            _regressChargeView.dispose();
         }
         _regressChargeView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

