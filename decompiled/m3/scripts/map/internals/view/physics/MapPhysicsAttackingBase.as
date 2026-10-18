package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MapPhysicsAttackingBase extends MapPhysicsBase
   {
      
      protected var _attacking:MovieClip;
      
      public function MapPhysicsAttackingBase(param1:int = 0)
      {
         super();
         if(param1 == 0)
         {
            tipStyle = "tips.MapPhysicsTip";
            tipDirctions = "4,6,5,7";
            isFollowMouse = false;
         }
      }
      
      override protected function setFireView() : void
      {
         super.setFireView();
         setFireViewImp();
      }
      
      private function setFireViewImp() : void
      {
         if(!_attacking)
         {
            _attacking = ComponentFactory.Instance.creatCustomObject("asset.outercity.AttackingAsset");
         }
         if(_isPlaying)
         {
            addChild(_attacking);
         }
         _attacking.y = -70;
         _attacking.play();
      }
      
      override protected function setNomalView() : void
      {
         super.setNomalView();
         if(_attacking)
         {
            _attacking.stop();
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            ObjectUtils.disposeViolentMc(_attacking);
         }
         _attacking = null;
      }
      
      private function clearAttackMovie() : void
      {
         if(_attacking)
         {
            _attacking.stop();
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            ObjectUtils.disposeViolentMc(_attacking);
         }
         _attacking = null;
      }
      
      override public function dispose() : void
      {
         if(qtree)
         {
            qtree.remove(this,this.x,this.y);
            qtree = null;
         }
         clearAttackMovie();
         ShowTipManager.Instance.removeTip(this);
         super.dispose();
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(!_attacking)
         {
            return;
         }
         if(param1)
         {
            addChild(_attacking);
            _attacking.play();
         }
         else
         {
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            _attacking.stop();
         }
      }
      
      public function mouseHitTest() : Boolean
      {
         if(!mouseEnabled)
         {
            return false;
         }
         if(!parent)
         {
            return false;
         }
         var _loc1_:Sprite = this;
         if(_movie)
         {
            _loc1_ = _movie;
         }
         var _loc2_:Point = _loc1_.localToGlobal(new Point(_loc1_.mouseX,_loc1_.mouseY));
         return _loc1_.hitTestPoint(_loc2_.x,_loc2_.y,true);
      }
   }
}

