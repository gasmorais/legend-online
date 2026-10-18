package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   
   public class PetHallowsMcView extends Component
   {
      
      private var _hallowsMc:MovieClip;
      
      private var _lightMc:MovieClip;
      
      private var _hallowsType:int;
      
      public function PetHallowsMcView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function get hallowsType() : int
      {
         return _hallowsType;
      }
      
      public function set hallowsType(param1:int) : void
      {
         if(_hallowsType == param1)
         {
            return;
         }
         ObjectUtils.disposeViolentMc(_hallowsMc);
         _hallowsMc = null;
         _hallowsType = param1;
         _hallowsMc = ComponentFactory.Instance.creatCustomObject("pethallows.PetHallowsMcView" + _hallowsType);
         _hallowsMc.mouseChildren = _hallowsMc.mouseEnabled = false;
         if(!_hallowsMc.parent)
         {
            addChild(_hallowsMc);
         }
         stopCurFrame(1);
      }
      
      public function stopCurFrame(param1:int) : void
      {
         if(_hallowsMc)
         {
            _hallowsMc.gotoAndStop(param1);
         }
      }
      
      public function playCurFrame(param1:int) : void
      {
         stopCurFrame(param1);
         if(_hallowsMc)
         {
            _hallowsMc.gotoAndPlay(param1);
         }
      }
      
      public function playLightMc() : void
      {
         ObjectUtils.disposeViolentMc(_lightMc);
         _lightMc = null;
         _lightMc = ComponentFactory.Instance.creatCustomObject("PetHallowsMcView.lightMc");
         addChild(_lightMc);
         _lightMc.mouseChildren = _hallowsMc.mouseEnabled = false;
         _lightMc.gotoAndPlay(1);
      }
      
      public function get hallowsMc() : MovieClip
      {
         return _hallowsMc;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_hallowsMc);
         _hallowsMc = null;
         ObjectUtils.disposeViolentMc(_lightMc);
         _lightMc = null;
         super.dispose();
      }
   }
}

