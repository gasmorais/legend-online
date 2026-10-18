package yishi.view.guild
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NoviceArrowView extends Sprite implements Disposeable
   {
      
      public static const RIGHT:int = 1;
      
      public static const DOWN:int = 2;
      
      public static const LEFT:int = 3;
      
      public static const UP:int = 4;
      
      private var _arrowMc:MovieClip;
      
      private var _container:Sprite;
      
      private var _direction:int;
      
      private var _tip:String;
      
      private var _callFun:Function;
      
      private var _fixedW:Number;
      
      private var _fixedH:Number;
      
      public function NoviceArrowView(param1:int = 1, param2:String = "", param3:Boolean = true, param4:Function = null)
      {
         super();
         _direction = param1;
         _tip = param2;
         _callFun = param4;
         initView();
      }
      
      public function set tip(param1:String) : void
      {
         _tip = param1;
         _arrowMc["content"]["txt"].text = _tip;
      }
      
      private function initView() : void
      {
         this.mouseEnabled = this.mouseChildren = false;
         _arrowMc = ComponentFactory.Instance.creatCustomObject("core.NoviceArrowGuide");
         _container = new Sprite();
         _arrowMc.gotoAndStop(1);
         _arrowMc["content"].gotoAndStop(_direction);
         _arrowMc["content"]["txt"].text = _tip;
         _arrowMc.play();
         _container.addChild(_arrowMc);
         addChild(_container);
         _fixedW = _container.width;
         _fixedH = _arrowMc.height;
      }
      
      private function initState() : void
      {
         _arrowMc.scaleX = _arrowMc.scaleY = 0.1;
         _arrowMc.alpha = 0;
      }
      
      public function showTween(param1:Number = 0.3) : void
      {
         initState();
         TweenMax.to(_arrowMc,param1,{
            "x":0,
            "y":0,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
      }
      
      public function playEffect() : void
      {
         if(_arrowMc)
         {
            _arrowMc.gotoAndPlay(1);
         }
      }
      
      public function stopEffect() : void
      {
         if(_arrowMc)
         {
            _arrowMc.gotoAndStop(1);
         }
      }
      
      public function dispose() : void
      {
         if(_arrowMc)
         {
            TweenMax.killTweensOf(_arrowMc);
         }
         ObjectUtils.disposeViolentMc(_arrowMc);
         _arrowMc = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         _callFun = null;
         _tip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

