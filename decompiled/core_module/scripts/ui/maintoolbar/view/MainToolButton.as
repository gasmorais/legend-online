package ui.maintoolbar.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.view.component.MovieButton;
   
   public class MainToolButton extends Component
   {
      
      private var _button:MovieButton;
      
      private var _buttonStyleName:String;
      
      private var _childButton:MovieButton;
      
      private var _childButtonStyleName:String;
      
      private var _isTween:Boolean = true;
      
      private var _isChildOpen:Boolean;
      
      private var _backSprite:Sprite;
      
      public var isVisible:Boolean;
      
      public function MainToolButton()
      {
         super();
         _backSprite = new Sprite();
         addChild(_backSprite);
         initEvent();
      }
      
      private function initEvent() : void
      {
         this.addEventListener("rollOut",__btnRollOutHandler);
      }
      
      private function __btnRollOverHandler(param1:MouseEvent) : void
      {
         if(!_button.enable || !_isTween)
         {
            return;
         }
         TweenMax.to(_button.movie.movie,0.2,{
            "y":-10,
            "ease":Linear.easeOut
         });
         if(_childButton && _isChildOpen)
         {
            _childButton.visible = true;
            TweenMax.to(_childButton,0.2,{
               "y":-70,
               "ease":Linear.easeOut
            });
            drawBtn(_button.height + 70);
         }
         else
         {
            drawBtn(_button.height);
         }
      }
      
      private function __btnRollOutHandler(param1:MouseEvent) : void
      {
         if(_childButton && _isChildOpen)
         {
            TweenMax.to(_childButton,0.2,{
               "y":0,
               "ease":Linear.easeOut,
               "onComplete":onComplete
            });
         }
         TweenMax.to(_button.movie.movie,0.2,{
            "y":0,
            "ease":Linear.easeOut
         });
         drawBtn(_button.height);
      }
      
      private function drawBtn(param1:int) : void
      {
         _backSprite.graphics.clear();
         _backSprite.graphics.beginFill(0,0);
         _backSprite.graphics.drawRect(0,_button.height - param1,_button.width,param1);
         _backSprite.graphics.endFill();
      }
      
      private function onComplete() : void
      {
         TweenMax.killChildTweensOf(_childButton);
         _childButton.visible = false;
      }
      
      public function set button(param1:String) : void
      {
         if(_button != null)
         {
            _button.removeEventListener("rollOver",__btnRollOverHandler);
            _button.dispose();
            _button = null;
         }
         _button = ComponentFactory.Instance.creatComponentByStylename(param1);
         _buttonStyleName = param1;
         addChild(_button);
         _button.stopEffect();
         _button.addEventListener("rollOver",__btnRollOverHandler);
      }
      
      public function set childButton(param1:String) : void
      {
         if(_childButton != null)
         {
            _childButton.dispose();
            _childButton = null;
         }
         _childButton = ComponentFactory.Instance.creatComponentByStylename(param1);
         _childButtonStyleName = param1;
         _childButton.visible = false;
         _childButton.stopEffect();
         addChild(_childButton);
      }
      
      public function set isTween(param1:Boolean) : void
      {
         _isTween = param1;
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOut",__btnRollOutHandler);
         if(_button)
         {
            _button.removeEventListener("rollOver",__btnRollOverHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_childButton)
         {
            TweenMax.killChildTweensOf(_childButton);
         }
         ObjectUtils.disposeObject(_button);
         _button = null;
         ObjectUtils.disposeObject(_childButton);
         _childButton = null;
         super.dispose();
      }
      
      public function get buttonBtn() : MovieButton
      {
         return _button;
      }
      
      public function get buttonChildBtn() : MovieButton
      {
         return _childButton;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _button.enable = param1;
      }
      
      public function get childEnable() : Boolean
      {
         return _childButton.enable;
      }
      
      public function set childEnable(param1:Boolean) : void
      {
         _childButton.enable = param1;
      }
      
      public function get enable() : Boolean
      {
         return _button.enable;
      }
      
      public function set buttonTips(param1:*) : void
      {
         _button.tipData = param1;
      }
      
      public function set childButtonTips(param1:*) : void
      {
         if(_childButton)
         {
            _childButton.tipData = param1;
         }
      }
      
      public function set isChildOpen(param1:Boolean) : void
      {
         _isChildOpen = param1;
      }
      
      override public function get width() : Number
      {
         return _button.width;
      }
      
      override public function get height() : Number
      {
         return _button.height;
      }
   }
}

