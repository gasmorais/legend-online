package bingo
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import yishi.utils.NumberViewUtils;
   
   public class BingoBallItem extends Component
   {
      
      private var _bigBallImage:ScaleFrameImage;
      
      private var _numberContain:Component;
      
      private var _numberAsset:BitmapData;
      
      private var _index:int;
      
      private var _data:int;
      
      private var _container:Component;
      
      public function BingoBallItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bigBallImage = ComponentFactory.Instance.creatComponentByStylename("bingo.bigBallImage");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.ballNumberAsset");
         _numberContain = new Component();
         _container = new Component();
         addChild(_container);
         _container.addChild(_bigBallImage);
         _container.addChild(_numberContain);
         this.scaleX = 0.68;
         this.scaleY = 0.68;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         NumberViewUtils.refreshValue(_data,_numberContain,_numberAsset,19,27,15,19,"0123456789");
         _numberContain.x = _data < 10 ? -8 : -17;
         _numberContain.y = 6;
         if(_data <= 15)
         {
            _loc2_ = 1;
         }
         else if(_data <= 30)
         {
            _loc2_ = 2;
         }
         else if(_data <= 45)
         {
            _loc2_ = 3;
         }
         else if(_data <= 60)
         {
            _loc2_ = 4;
         }
         else if(_data <= 75)
         {
            _loc2_ = 5;
         }
         _bigBallImage.setFrame(_loc2_);
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function playMovie(param1:Number, param2:int, param3:int, param4:int) : void
      {
         TweenMax.to(this,param1,{
            "x":param2,
            "y":param3,
            "rotation":param4
         });
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeObject(_bigBallImage);
         _bigBallImage = null;
         ObjectUtils.disposeObject(_numberContain);
         _numberContain = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         super.dispose();
      }
   }
}

