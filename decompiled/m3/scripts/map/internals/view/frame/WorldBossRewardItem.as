package map.internals.view.frame
{
   import com.greensock.TweenLite;
   import com.pickgliss.effect.ColorMatrix;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.Timer;
   import mvc.module.worldboss.WorldRewardVO;
   
   public class WorldBossRewardItem extends Sprite implements Disposeable
   {
      
      private var _data:WorldRewardVO;
      
      private var _image:Image;
      
      private var _flyImage:Image;
      
      private var _tweener:TweenLite;
      
      private var _flyContainer:Sprite;
      
      private var _delayTime:Timer;
      
      private var _reachMC:MovieClip;
      
      public function WorldBossRewardItem(param1:Sprite)
      {
         _flyContainer = param1;
         super();
      }
      
      public function setData(param1:WorldRewardVO) : void
      {
         _data = param1;
         _image = ComponentFactory.Instance.creatComponentByStylename("core.WorldBossReward" + param1.rewardid);
         addChild(_image);
         _image.tipData = param1.woundmsg + "\n" + param1.rewardmsg;
         _reachMC = ClassUtils.CreatInstance("asset.core.WorldBossRewardFlagMC");
         _reachMC.stop();
         _reachMC.mouseChildren = _reachMC.mouseEnabled = false;
         if(_data.state == 1)
         {
            if(_data.needEffect)
            {
               delayFly();
            }
            else
            {
               _reachMC.gotoAndStop(_reachMC.totalFrames);
               addChild(_reachMC);
            }
         }
      }
      
      private function setBrightness(param1:Number) : void
      {
         var _loc2_:ColorMatrix = new ColorMatrix();
         _loc2_.SetBrightnessMatrix(param1);
         _image.filters = [new ColorMatrixFilter(_loc2_.GetFlatArray())];
      }
      
      private function delayFly() : void
      {
         removeTimer();
         _delayTime = new Timer(1000,1);
         _delayTime.addEventListener("timerComplete",reachEffect);
         _delayTime.start();
      }
      
      private function removeTimer() : void
      {
         if(_delayTime)
         {
            _delayTime.stop();
            _delayTime.removeEventListener("timerComplete",reachEffect);
            _delayTime = null;
         }
      }
      
      private function reachEffect(param1:TimerEvent) : void
      {
         removeTimer();
         _flyImage = ComponentFactory.Instance.creatComponentByStylename("core.WorldBossReward" + _data.rewardid);
         _flyContainer.addChild(_flyImage);
         var _loc2_:Point = new Point(StageReferance.stageWidth * 0.5,StageReferance.stageHeight * 0.5);
         _loc2_ = _flyContainer.globalToLocal(_loc2_);
         _flyImage.x = _loc2_.x;
         _flyImage.y = _loc2_.y;
         _loc2_ = _image.parent.localToGlobal(new Point(_image.x,_image.y));
         _loc2_ = _flyContainer.globalToLocal(_loc2_);
         _tweener = TweenLite.to(_flyImage,0.5,{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "onComplete":onFlyComplete
         });
      }
      
      private function onFlyComplete() : void
      {
         if(_tweener)
         {
            _tweener.kill();
            _tweener = null;
         }
         if(_flyImage || _delayTime)
         {
            if(_flyImage.parent)
            {
               _flyImage.parent.removeChild(_flyImage);
            }
            if(_reachMC)
            {
               _reachMC.gotoAndPlay(1);
               addChild(_reachMC);
            }
            _flyImage.dispose();
            _flyImage = null;
            _data.needEffect = false;
         }
         removeTimer();
      }
      
      public function getData() : WorldRewardVO
      {
         return _data;
      }
      
      public function dispose() : void
      {
         onFlyComplete();
         if(_reachMC)
         {
            _reachMC.stop();
            if(_reachMC.parent)
            {
               _reachMC.parent.removeChild(_reachMC);
            }
            _reachMC = null;
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

