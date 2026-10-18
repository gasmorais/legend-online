package views
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import mainBar.effects.MainToolBtnGlowEffect;
   import yishi.keyboard.KeyBoardRegister;
   
   public class NoviceFrame1 extends Component
   {
      
      private var _headIcon:Bitmap;
      
      private var _bg:Scale9CornerImage;
      
      private var _arrow:MovieClip;
      
      private var _contentText:FilterFrameText;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      private var _targetObject:DisplayObject;
      
      private var _arrowDirection:int;
      
      private var _offX:int;
      
      private var _offY:int;
      
      public function NoviceFrame1()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mouseChildren = mouseEnabled = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("novice.FrameBack01");
         _headIcon = ComponentFactory.Instance.creatBitmap("asset.novice.DialogIcon");
         _arrow = ComponentFactory.Instance.creatCustomObject("novice.GuildFrameArrow");
         _contentText = ComponentFactory.Instance.creatComponentByStylename("core.novice.ContentText2");
         addChild(_arrow);
         addChild(_bg);
         addChild(_headIcon);
         addChild(_contentText);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeEventHandler);
      }
      
      private function __resizeEventHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function setContent(param1:String, param2:int = 0, param3:DisplayObject = null, param4:int = 0, param5:int = 0) : void
      {
         _targetObject = param3;
         _arrowDirection = param2;
         _offX = param4;
         _offY = param5;
         _contentText.text = "    " + param1;
         _bg.width = int(_contentText.textWidth + 205);
         _bg.height = int(_contentText.textHeight + 40);
         if(_bg.width < 356)
         {
            _bg.width = 356;
         }
         if(_bg.height < 67)
         {
            _bg.height = 67;
         }
         _bg.x = 0;
         _bg.y = _headIcon.y + _headIcon.height - _bg.height;
         _contentText.x = _headIcon.x + _headIcon.width - 14;
         _contentText.y = _bg.y + 21;
         if(param2 <= 0)
         {
            _arrow.visible = false;
            _arrow.stop();
         }
         else
         {
            _arrow.visible = true;
            _arrow.play();
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:Point = null;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(_targetObject)
         {
            _loc3_ = new Point(_targetObject.x,_targetObject.y);
            _loc3_ = _targetObject.parent.localToGlobal(_loc3_);
            if(_targetObject.hasOwnProperty("displayWidth") && _targetObject.hasOwnProperty("displayHeight"))
            {
               _loc1_ = Number(_targetObject["displayWidth"]);
               _loc2_ = Number(_targetObject["displayHeight"]);
            }
            else
            {
               _loc1_ = Number(_targetObject["width"]);
               _loc2_ = Number(_targetObject["height"]);
            }
            switch(_arrowDirection - 2)
            {
               case 0:
                  _arrow.x = _bg.x + (_bg.width + _arrow.width) / 2;
                  _arrow.y = _bg.y + _bg.height + _arrow.height - 4;
                  this.x = _loc3_.x - (_bg.width - _loc1_) / 2;
                  this.y = _loc3_.y - this.displayHeight;
                  break;
               case 2:
                  _arrow.scaleY = -1;
                  _arrow.x = _bg.x + (_bg.width + _arrow.width) / 2;
                  _arrow.y = _bg.y - _arrow.height + 4;
                  this.x = _loc3_.x - (_bg.width - _loc1_) / 2;
                  this.y = _loc3_.y + _loc2_;
                  break;
               default:
                  _arrow.rotation = -90;
                  _arrow.x = _bg.x + _bg.width + 57;
                  _arrow.y = _bg.y + (_bg.height - _arrow.height) / 2;
                  this.x = _loc3_.x - _bg.width - _arrow.width;
                  this.y = _loc3_.y - this.displayHeight + _loc2_ / 2 + _arrow.height / 2;
            }
            if(this.x + _bg.width > StageReferance.stageWidth)
            {
               this.x = StageReferance.stageWidth - _bg.width;
               _arrow.x = _loc3_.x - this.x + (_arrow.width + _loc1_) / 2;
            }
            if(_offX != 0 || _offY != 0)
            {
               this.x += _offX;
               this.y += _offY;
            }
         }
      }
      
      public function btnEffect(param1:DisplayObject) : void
      {
         if(!_disEffect)
         {
            _disEffect = new MainToolBtnGlowEffect(param1);
         }
         _disEffect.play();
      }
      
      public function show() : void
      {
         alpha = 0;
         scaleX = scaleY = 0.1;
         TweenLite.to(this,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         TweenLite.killTweensOf(this);
         StageReferance.stage.removeEventListener("resize",__resizeEventHandler);
         if(_disEffect)
         {
            _disEffect.dispose();
         }
         _disEffect = null;
         ObjectUtils.disposeViolentMc(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_contentText);
         _contentText = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

