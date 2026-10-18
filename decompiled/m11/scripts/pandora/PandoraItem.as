package pandora
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class PandoraItem extends Component
   {
      
      private var _boxItem:ScaleFrameImage;
      
      private var _selectBg:Bitmap;
      
      private var _index:int;
      
      private var _count:int;
      
      private var _numberAsset:BitmapData;
      
      private var _pointImg:Bitmap;
      
      private var _container:Component;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _movieImg:MovieImage;
      
      private var _flickerEffct:MovieClip;
      
      public function PandoraItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _boxItem = ComponentFactory.Instance.creatComponentByStylename("pandora.itemIcon");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.pandora.vipBoxItemSelect");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("pandora.goodsFlickerEffctMC");
         _movieImg = ComponentFactory.Instance.creatComponentByStylename("artifact.altarGoodsEffctMC");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.pandora.smallNum");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.pandora.pointImg");
         _container = new Component();
         _container.x = 0;
         _container.y = 76;
         addChild(_boxItem);
         addChild(_container);
         addChild(_pointImg);
         addChild(_selectBg);
         addChild(_flickerEffct);
         _selectBg.visible = false;
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
         _flickerEffct.mouseChildren = _flickerEffct.mouseEnabled = false;
         _container.mouseEnabled = false;
         _movieImg.mouseChildren = _movieImg.mouseEnabled = false;
         _movieImg.movie.addFrameScript(_movieImg.movie.totalFrames - 1,onFrameEnd);
         _movieImg.movie.gotoAndStop(1);
      }
      
      private function onFrameEnd() : void
      {
         _movieImg.movie.stop();
         _movieImg.movie.gotoAndStop(1);
         NotificationManager.instance.sendNotification("ARTIFACT_BOX_FLICHER");
      }
      
      public function set Index(param1:int) : void
      {
         _index = param1;
         _boxItem.setFrame(_index);
      }
      
      public function get Index() : int
      {
         return _index;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         NumberViewUtils.refreshValue(_count,_container,_numberAsset,14,18,9,14,"0123456789.");
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selected)
         {
            _selectBg.alpha = 1;
            _selectBg.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectBg.visible = false;
         }
      }
      
      public function flicker() : void
      {
         if(!_movieImg.parent)
         {
            addChild(_movieImg);
         }
         _movieImg.movie.play();
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
      }
      
      public function clearFlicker() : void
      {
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
         _selectBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         TweenLite.killTweensOf(_selectBg);
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         TweenLite.to(_selectBg,param1,{
            "alpha":0,
            "onComplete":removeHideMoveBgTween
         });
      }
      
      private function removeHideMoveBgTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
      }
      
      private function get model() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         _movieImg.movie.addFrameScript(_movieImg.movie.totalFrames - 1,null);
         TweenLite.killTweensOf(_selectBg);
         ObjectUtils.disposeObject(_boxItem);
         _boxItem = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_movieImg);
         _movieImg = null;
         ObjectUtils.disposeViolentMc(_flickerEffct);
         _flickerEffct = null;
         super.dispose();
      }
   }
}

