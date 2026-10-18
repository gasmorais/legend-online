package battle.view.ui
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.ShakeCircle;
   
   public class BatterUIView extends Sprite
   {
      
      private static const EXIT_DISTANCE:Number = 96;
      
      private var batterNum:Sprite;
      
      private var damageNum:Sprite;
      
      private var _batterAsset:MovieClip;
      
      private var _damageAsset:MovieClip;
      
      private var _damageMatrix:Matrix;
      
      private var _shake:ShakeCircle;
      
      private var _batterDestX:Number;
      
      private var _damageDestX:Number;
      
      private var _exiting:Boolean;
      
      public function BatterUIView()
      {
         super();
         init();
         addEvent();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SET_BATTER_COUNT_BattleNotic",setBatterCount);
         NotificationManager.instance.addEventListener("SET_TOTAL_DAMAGE_BattleNotic",__setTotalDamage);
      }
      
      private function __setTotalDamage(param1:NotificationEvent) : void
      {
         if(_exiting)
         {
            return;
         }
         var _loc2_:Sprite = ComponentFactory.Instance.creatCustomObject("battle.TotalDamageNumberAssetSp");
         _loc2_["txt"].text = String(param1.data);
         _loc2_["txt"].width = _loc2_["txt"].textWidth + 50;
         damageNum.addChild(_loc2_);
         damageNum.x = -damageNum.width;
      }
      
      private function setBatterCount(param1:NotificationEvent) : void
      {
         if(_exiting)
         {
            return;
         }
         var _loc2_:Sprite = ComponentFactory.Instance.creatCustomObject("battle.TotalDamageNumberAssetSp");
         _loc2_["txt"].text = String(param1.data);
         _loc2_["txt"].width = _loc2_["txt"].textWidth + 50;
         batterNum.addChild(_loc2_);
         batterNum.scaleY = batterNum.scaleX = 1;
         batterNum.x = -batterNum.width;
         batterNum.y = 0;
         TweenLite.from(batterNum,0.2,{
            "scaleX":2,
            "scaleY":2
         });
         _shake.shake();
      }
      
      private function init() : void
      {
         _damageAsset = ClassUtils.CreatInstance("asset.battle.DamageUIAsset");
         _damageDestX = _damageAsset.x;
         addChild(_damageAsset);
         _batterAsset = ClassUtils.CreatInstance("asset.battle.BatterUIAsset");
         _batterDestX = _batterAsset.x;
         addChild(_batterAsset);
         _damageAsset.y = _batterAsset.height + 15;
         batterNum = new Sprite();
         batterNum.mouseChildren = batterNum.mouseEnabled = false;
         damageNum = new Sprite();
         damageNum.mouseChildren = damageNum.mouseEnabled = false;
         _batterAsset.batter_num_pos.addChild(batterNum);
         _damageAsset.total_num_pos.addChild(damageNum);
         _damageMatrix = _damageAsset.transform.matrix;
         _shake = new ShakeCircle(_batterAsset.batterMC,3,5);
      }
      
      public function show() : void
      {
         reset();
         _damageAsset.transform.matrix = _damageMatrix;
         _damageAsset.alpha = 1;
         TweenLite.from(_damageAsset,0.7,{
            "alpha":0,
            "x":"-100"
         });
         _batterAsset.animate.gotoAndPlay(1);
      }
      
      private function reset() : void
      {
         _batterAsset.alpha = 1;
         _batterAsset.x = _batterDestX;
         _damageAsset.alpha = 1;
         _damageAsset.x = _damageDestX;
         TweenLite.killTweensOf(_batterAsset);
         TweenLite.killTweensOf(_damageAsset);
         _exiting = false;
      }
      
      public function hide() : void
      {
         TweenLite.to(_batterAsset,0.4,{
            "alpha":0,
            "x":_batterDestX + 96,
            "onComplete":onExitComplete
         });
         TweenLite.to(_damageAsset,0.4,{
            "alpha":0,
            "x":_damageDestX - 96
         });
         _exiting = true;
      }
      
      private function onExitComplete() : void
      {
         _exiting = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_damageAsset)
         {
            TweenLite.killTweensOf(_damageAsset);
         }
         if(_batterAsset)
         {
            TweenLite.killTweensOf(_batterAsset);
         }
         if(batterNum)
         {
            TweenLite.killTweensOf(batterNum);
         }
         ObjectUtils.disposeViolentMc(batterNum);
         batterNum = null;
         ObjectUtils.disposeViolentMc(damageNum);
         damageNum = null;
         ObjectUtils.disposeViolentMc(_batterAsset);
         _batterAsset = null;
         ObjectUtils.disposeViolentMc(_damageAsset);
         _damageAsset = null;
         if(_shake)
         {
            _shake.stop();
         }
         _shake = null;
         _damageMatrix = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SET_BATTER_COUNT_BattleNotic",setBatterCount);
         NotificationManager.instance.removeEventListener("SET_TOTAL_DAMAGE_BattleNotic",__setTotalDamage);
      }
   }
}

