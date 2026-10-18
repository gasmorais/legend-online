package battle.view.ui
{
   import battle.utils.DelayCalling;
   import battle.utils.Helpers;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class ResistUIView extends Sprite
   {
      
      private static const EXIT_DISTANCE:Number = 96;
      
      private var _damageNum:Sprite;
      
      private var _damageDestX:Number;
      
      private var _damageMatrix:Matrix;
      
      private var _resistMc:MovieClip;
      
      private var _signMc:ScaleFrameImage;
      
      private var _percentMc:ScaleFrameImage;
      
      private var _damageMc:ScaleFrameImage;
      
      private var _exiting:Boolean;
      
      private var _delay:DelayCalling;
      
      private var _side:int;
      
      private var _frame:int;
      
      private var _totalDamageBitData:BitmapData;
      
      private var _totalDamageBitData1:BitmapData;
      
      private var _totalDamageBitData2:BitmapData;
      
      public function ResistUIView(param1:int)
      {
         super();
         _side = param1;
         init();
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SET_RESIST_TOTAL_DAMAGE",__setTotalDamage);
      }
      
      private function init() : void
      {
         _resistMc = ClassUtils.CreatInstance("asset.battle.DamageUIAsset");
         _signMc = ComponentFactory.Instance.creatComponentByStylename("battle.ResistUIView.sign");
         _percentMc = ComponentFactory.Instance.creatComponentByStylename("battle.ResistUIView.percent");
         _damageMc = ComponentFactory.Instance.creatComponentByStylename("battle.ResistUIView.damage");
         _damageDestX = _resistMc.x;
         addChild(_resistMc);
         _damageNum = new Sprite();
         _damageNum.mouseChildren = _damageNum.mouseEnabled = false;
         _resistMc.total_num_pos.addChild(_damageNum);
         _resistMc.sign_pos.addChild(_signMc);
         _resistMc.percent_pos.addChild(_percentMc);
         _resistMc.damage_pos.addChild(_damageMc);
         _damageMatrix = _resistMc.transform.matrix;
         _totalDamageBitData1 = (ComponentFactory.Instance.creat("asset.battle.numberRedLow") as Bitmap).bitmapData;
         _totalDamageBitData2 = (ComponentFactory.Instance.creat("asset.battle.numberGreenLow") as Bitmap).bitmapData;
      }
      
      private function __setTotalDamage(param1:NotificationEvent) : void
      {
         if(!_resistMc)
         {
            return;
         }
         if(param1.data.side != _side)
         {
            return;
         }
         if(param1.data.value > 0)
         {
            _totalDamageBitData = _totalDamageBitData2;
            _frame = 2;
            _signMc.setFrame(_frame);
            _percentMc.setFrame(_frame);
            _damageMc.setFrame(_frame);
            NumberViewUtils.getNumberView(param1.data.value,_damageNum,_totalDamageBitData,42,42,35,42,"0123456789.",1);
         }
         else
         {
            if(param1.data.value >= 0)
            {
               hide();
               return;
            }
            _totalDamageBitData = _totalDamageBitData1;
            _frame = 1;
            _signMc.setFrame(_frame);
            _percentMc.setFrame(_frame);
            _damageMc.setFrame(_frame);
            NumberViewUtils.getNumberView(Math.abs(param1.data.value),_damageNum,_totalDamageBitData,42,42,35,42,"0123456789.",1);
         }
         _percentMc.x = _damageNum.width - 18;
      }
      
      public function show() : void
      {
         reset();
         _resistMc.transform.matrix = _damageMatrix;
         _resistMc.alpha = 1;
         TweenLite.from(_resistMc,0.7,{
            "alpha":0,
            "x":"-100"
         });
         if(_delay)
         {
            _delay.cancel();
         }
         _delay = Helpers.delayCall(function():void
         {
            hide();
         },60);
      }
      
      public function hide() : void
      {
         TweenLite.to(_resistMc,0.4,{
            "alpha":0,
            "x":_damageDestX - 96,
            "onComplete":onExitComplete
         });
         _exiting = true;
      }
      
      private function reset() : void
      {
         _resistMc.alpha = 1;
         _resistMc.x = _damageDestX;
         TweenLite.killTweensOf(_resistMc);
         _exiting = false;
      }
      
      private function onExitComplete() : void
      {
         _exiting = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_resistMc)
         {
            TweenLite.killTweensOf(_resistMc);
         }
         ObjectUtils.disposeViolentMc(_damageNum);
         _damageNum = null;
         ObjectUtils.disposeViolentMc(_resistMc);
         _resistMc = null;
         ObjectUtils.disposeObject(_totalDamageBitData1);
         _totalDamageBitData1 = null;
         ObjectUtils.disposeObject(_totalDamageBitData2);
         _totalDamageBitData2 = null;
         ObjectUtils.disposeObject(_signMc);
         _signMc = null;
         ObjectUtils.disposeObject(_percentMc);
         _percentMc = null;
         ObjectUtils.disposeObject(_damageMc);
         _damageMc = null;
         if(_delay)
         {
            _delay.cancel();
         }
         _delay = null;
         _totalDamageBitData = null;
         _damageMatrix = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SET_RESIST_TOTAL_DAMAGE",__setTotalDamage);
      }
   }
}

