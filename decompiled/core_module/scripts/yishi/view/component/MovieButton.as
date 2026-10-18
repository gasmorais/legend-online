package yishi.view.component
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.TheseussoulManager;
   import yishi.datas.VersionSwitch;
   
   public class MovieButton extends Component implements IManualSize
   {
      
      private var _manualWidth:int = 0;
      
      private var _manualHeight:int = 0;
      
      protected var _enable:Boolean = true;
      
      private var _backMovie:MovieImage;
      
      private var _button:MovieImage;
      
      private var _buttonStyleName:String;
      
      private var _frameFilter:Array;
      
      private var _displacementEnable:Boolean = true;
      
      public var isPlaying:Boolean;
      
      public var isVisible:Boolean;
      
      public var checkRedType:int;
      
      private var _clickHandle:Function;
      
      private var _supportTipsWhenGray:Boolean = false;
      
      public function MovieButton()
      {
         super();
         addEvent();
         this.buttonMode = true;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,_manualWidth,_manualHeight);
      }
      
      public function set manualWidth(param1:int) : void
      {
         _manualWidth = param1;
      }
      
      public function set manualHeight(param1:int) : void
      {
         _manualHeight = param1;
      }
      
      public function playEffect() : void
      {
         if(_button && _button.movie)
         {
            try
            {
               _button.movie.gotoAndPlay(1);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function stopEffect() : void
      {
         if(_button && _button.movie)
         {
            try
            {
               _button.movie.gotoAndStop(1);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function set back(param1:String) : void
      {
         _backMovie = ComponentFactory.Instance.creatComponentByStylename(param1);
         addChild(_backMovie);
      }
      
      public function set button(param1:String) : void
      {
         if(_button != null)
         {
            _button.dispose();
            _button = null;
         }
         _button = ComponentFactory.Instance.creatComponentByStylename(param1);
         _buttonStyleName = param1;
         playEffect();
         addChild(_button);
      }
      
      public function get displacementEnable() : Boolean
      {
         return _displacementEnable;
      }
      
      public function set displacementEnable(param1:Boolean) : void
      {
         _displacementEnable = param1;
      }
      
      public function set filterString(param1:String) : void
      {
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(param1);
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_supportTipsWhenGray)
         {
            mouseEnabled = true;
            if(!_enable)
            {
               addEventListener("click",__onMouseClick);
               removeEventListener("mouseDown",__onMouseDown);
               if(_clickHandle != null)
               {
                  addEventListener("click",_clickHandle);
               }
            }
            else
            {
               removeEventListener("click",__onMouseClick);
               addEventListener("mouseDown",__onMouseDown);
               if(_clickHandle != null)
               {
                  removeEventListener("click",_clickHandle);
               }
            }
         }
         else
         {
            mouseEnabled = _enable;
            if(_enable)
            {
               addEventListener("mouseDown",__onMouseDown);
            }
            else
            {
               removeEventListener("mouseDown",__onMouseDown);
            }
         }
         if(_enable)
         {
            buttonMode = true;
            if(_button)
            {
               setFrame(1);
            }
            if(isPlaying)
            {
               playEffect();
            }
         }
         else
         {
            buttonMode = false;
            if(_button)
            {
               setFrame(4);
               stopEffect();
            }
         }
      }
      
      public function set supportTipsWhenGray(param1:Boolean) : void
      {
         _supportTipsWhenGray = param1;
      }
      
      public function get supportTipsWhenGray() : Boolean
      {
         return _supportTipsWhenGray;
      }
      
      public function setClickHandle(param1:Function) : void
      {
         _clickHandle = param1;
         if(_enable)
         {
            addEventListener("click",_clickHandle);
         }
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         if(!_enable)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
         addEventListener("mouseDown",__onMouseDown);
         addEventListener("removedFromStage",__removeFromStage);
         addEventListener("addedToStage",__addtoStageHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
         removeEventListener("mouseDown",__onMouseDown);
         removeEventListener("removedFromStage",__removeFromStage);
         removeEventListener("addedToStage",__addtoStageHandler);
      }
      
      private function __onMouseRollover(param1:MouseEvent) : void
      {
         if(_enable)
         {
            setFrame(2);
         }
      }
      
      private function __onMouseRollout(param1:MouseEvent) : void
      {
         if(_enable)
         {
            setFrame(1);
         }
      }
      
      private function __onMouseDown(param1:MouseEvent) : void
      {
         if(enable)
         {
            setFrame(3);
         }
         if(_displacementEnable)
         {
            x += ComponentSetting.DISPLACEMENT_OFFSET;
            y += ComponentSetting.DISPLACEMENT_OFFSET;
            StageReferance.stage.addEventListener("mouseUp",__onMouseUp);
         }
      }
      
      private function __removeFromStage(param1:Event) : void
      {
         stopEffect();
      }
      
      private function __addtoStageHandler(param1:Event) : void
      {
         if(isPlaying)
         {
            playEffect();
         }
      }
      
      private function __onMouseUp(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUp);
         x -= ComponentSetting.DISPLACEMENT_OFFSET;
         y -= ComponentSetting.DISPLACEMENT_OFFSET;
         if(!(param1.target is DisplayObject))
         {
            setFrame(1);
         }
         if(param1.target == this)
         {
            setFrame(2);
         }
         else
         {
            setFrame(1);
         }
      }
      
      private function setFrame(param1:int) : void
      {
         if(_button && _frameFilter)
         {
            _button.filters = _frameFilter[param1 - 1];
         }
      }
      
      public function get movie() : MovieImage
      {
         return _button;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         super.visible = param1;
         if(param1)
         {
            if(checkRedType == 1 && movie.movie["red"])
            {
               _loc2_ = TheseussoulManager.Instance.model.isAllRed();
               if(VersionSwitch.TREASURECANGPING)
               {
                  _loc2_ = TheseussoulManager.Instance.model.isAllRed() || TheseussoulManager.Instance.modelCollenTion.checkAllcollectionRed() || TheseussoulManager.Instance.modelCollenTion.checkAllboxRed() || TheseussoulManager.Instance.modelCollenTion.allred;
               }
               movie.movie["red"].visible = _loc2_;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backMovie);
         ObjectUtils.disposeObject(_button);
         _backMovie = null;
         _button = null;
         _frameFilter = null;
         super.dispose();
      }
      
      override public function get width() : Number
      {
         return displayWidth;
      }
      
      override public function get height() : Number
      {
         return displayHeight;
      }
      
      public function get buttonStyleName() : String
      {
         return _buttonStyleName;
      }
   }
}

