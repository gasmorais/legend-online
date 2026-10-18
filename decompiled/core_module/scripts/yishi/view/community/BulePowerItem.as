package yishi.view.community
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quart;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import yishi.filter.UIFilter;
   
   public class BulePowerItem extends Component implements Disposeable
   {
      
      private var _showEffect:Boolean = false;
      
      private var _lightEffectContainer:Sprite;
      
      private var _lightRectContainer:Sprite;
      
      private var _progress:ScaleBitmapImage;
      
      private var _mask:ScaleBitmapImage;
      
      private var _back:ScaleBitmapImage;
      
      private var _text:FilterFrameText;
      
      private var _current:int;
      
      private var _max:int;
      
      public function BulePowerItem(param1:Boolean = false)
      {
         super();
         _back = ComponentFactory.Instance.creatComponentByStylename("core.ProgressBack1");
         _progress = ComponentFactory.Instance.creatComponentByStylename("core.Progressasset1");
         _text = ComponentFactory.Instance.creatComponentByStylename("core.ProgressValueText1");
         _mask = ComponentFactory.Instance.creatComponentByStylename("core.Progressasset1");
         addChild(_back);
         addChild(_mask);
         addChild(_progress);
         addChild(_text);
         _mask.filters = [UIFilter.getGrayFilter()];
         _mask.visible = param1;
      }
      
      public function get progress() : ScaleBitmapImage
      {
         return _progress;
      }
      
      public function get max() : int
      {
         return _max;
      }
      
      public function get current() : int
      {
         return _current;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         _back.beginChanges();
         _back.width = param1;
         _back.commitChanges();
         _progress.beginChanges();
         _mask.beginChanges();
         _mask.width = _progress.width = _back.width - 10;
         _mask.commitChanges();
         _progress.commitChanges();
         _text.width = _back.width - 10;
         _mask.x = _progress.x = 5;
         _mask.y = _progress.y = 6;
         _text.x = 5;
         _text.y = 4;
      }
      
      private function refresh() : void
      {
         _text.text = _current + " / " + _max;
         _progress.scaleX = _current / _max;
         playEffect();
      }
      
      public function set max(param1:int) : void
      {
         _max = param1;
      }
      
      public function set current(param1:int) : void
      {
         _current = param1;
         refresh();
      }
      
      public function set full(param1:Boolean) : void
      {
         if(param1)
         {
            _text.text = "";
            _progress.scaleX = 1;
         }
      }
      
      public function setText(param1:String) : void
      {
         _text.text = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _text = null;
         _progress = null;
         _back = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
      
      private function playEffect() : void
      {
         if(_showEffect)
         {
            TweenLite.killTweensOf(_lightRectContainer);
            _lightRectContainer.x = 0;
            _progress.addChild(_lightEffectContainer);
            TweenLite.to(_lightRectContainer,0.3,{
               "x":_progress.displayWidth,
               "ease":Quart.easeIn,
               "onComplete":function():void
               {
                  if(_lightEffectContainer != null && _lightEffectContainer.parent != null)
                  {
                     _lightEffectContainer.parent.removeChild(_lightEffectContainer);
                  }
               }
            });
         }
      }
      
      public function set showEffect(param1:Boolean) : void
      {
         var _loc2_:Shape = null;
         var _loc3_:Shape = null;
         var _loc4_:Shape = null;
         _showEffect = param1;
         if(param1)
         {
            if(_lightEffectContainer == null)
            {
               _lightEffectContainer = new Sprite();
               _lightRectContainer = new Sprite();
               _loc2_ = new Shape();
               _loc2_.graphics.beginFill(16777215);
               _loc2_.graphics.drawRect(0,0,10,30);
               _loc2_.alpha = 0.5;
               _loc3_ = new Shape();
               _loc3_.graphics.beginFill(16777215);
               _loc3_.graphics.drawRect(0,0,12,30);
               _loc3_.x = -35;
               _loc2_.y = _loc3_.y = -10;
               _loc2_.rotation = _loc3_.rotation = 30;
               _loc4_ = new Shape();
               _loc4_.graphics.beginFill(16711680);
               _loc4_.graphics.drawRect(0,0,280,15);
               _lightRectContainer.addChild(_loc2_);
               _lightRectContainer.addChild(_loc3_);
               _lightEffectContainer.addChild(_lightRectContainer);
               _lightEffectContainer.addChild(_loc4_);
               _lightEffectContainer.filters = [new BlurFilter()];
               _lightEffectContainer.mask = _loc4_;
               _lightEffectContainer.blendMode = "overlay";
            }
         }
         else
         {
            ObjectUtils.disposeAllChildren(_lightEffectContainer);
         }
      }
   }
}

