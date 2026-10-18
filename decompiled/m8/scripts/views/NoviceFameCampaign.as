package views
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import mainBar.effects.MainToolBtnGlowEffect;
   
   public class NoviceFameCampaign extends Component
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _arrow:MovieClip;
      
      private var _contentText:FilterFrameText;
      
      private var _callback:Function;
      
      private var _continueBtn:MovieClip;
      
      private var _container:Sprite;
      
      private var _fixedW:Number;
      
      private var _fixedH:Number;
      
      private var _appointTxtPt:Point;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      public function NoviceFameCampaign()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         mouseChildren = mouseEnabled = false;
         _container = new Sprite();
         this.addChild(_container);
         _bg = ComponentFactory.Instance.creatComponentByStylename("novice.FrameBack01");
         _container.addChild(_bg);
         _arrow = ComponentFactory.Instance.creatCustomObject("novice.GuildFrameArrow");
         _container.addChild(_arrow);
         _contentText = ComponentFactory.Instance.creatComponentByStylename("core.novice.ContentText3");
         _container.addChild(_contentText);
         _continueBtn = ComponentFactory.Instance.creatCustomObject("core.novice.ContinueBtnMc");
         _continueBtn.visible = false;
         _container.addChild(_continueBtn);
         _fixedW = _container.width;
         _fixedH = _bg.displayHeight;
         initState();
      }
      
      private function initState() : void
      {
         var _loc1_:Number = 0.1;
         _bg.scaleX = _bg.scaleY = _loc1_;
         _bg.alpha = 0;
         _contentText.alpha = 0;
         _continueBtn.alpha = 0;
      }
      
      public function setText(param1:String, param2:int = 0) : void
      {
         _contentText.text = "      " + param1;
         _bg.height = int(_contentText.textHeight) + 60;
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
         switch(param2 - 2)
         {
            case 0:
               _arrow.x = _bg.x + (_bg.width + _arrow.width) / 2;
               _arrow.y = _bg.y + _bg.height + _arrow.height - 4;
               break;
            case 2:
               _arrow.scaleY = -1;
               _arrow.x = _bg.x + (_bg.width + _arrow.width) / 2;
               _arrow.y = _bg.y - _arrow.height + 4;
               break;
            default:
               _arrow.rotation = -90;
               _arrow.x = _bg.x + _bg.width + 57;
               _arrow.y = _bg.y + (_bg.height - _arrow.height) / 2;
         }
      }
      
      public function btnEffect(param1:DisplayObject) : void
      {
         _disEffect = new MainToolBtnGlowEffect(param1);
         _disEffect.play();
      }
      
      public function set continueBoo(param1:Boolean) : void
      {
         if(param1)
         {
            _continueBtn.visible = true;
            _continueBtn.x = _bg.width - 130;
            _continueBtn.y = _bg.height - 45;
            StageReferance.stage.addEventListener("click",__onStageClick);
         }
      }
      
      public function setTextFormat(param1:String = "left", param2:int = 10) : void
      {
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.align = param1;
         _loc3_.leading = param2;
         _contentText.setTextFormat(_loc3_);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",__onStageClick);
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function showTween(... rest) : void
      {
         if(rest.length > 0)
         {
            showObjs(rest[0]);
         }
         else
         {
            showObjs(0.3);
         }
      }
      
      private function showObjs(param1:Number) : void
      {
         TweenMax.to(_bg,param1,{
            "x":0,
            "y":0,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         TweenMax.to(_contentText,param1,{
            "alpha":1,
            "delay":0.3
         });
         TweenMax.to(_continueBtn,param1,{
            "alpha":1,
            "delay":0.3
         });
      }
      
      protected function __onStageClick(param1:Event) : void
      {
         if(_callback != null)
         {
            _callback();
            _callback = null;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_disEffect)
         {
            _disEffect.dispose();
         }
         _disEffect = null;
         ObjectUtils.disposeViolentMc(_container);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_contentText);
         _contentText = null;
         ObjectUtils.disposeViolentMc(_continueBtn);
         _continueBtn = null;
         _callback = null;
         _container = null;
      }
   }
}

