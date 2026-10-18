package map.campaign.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.view.tools.SimpleMovie;
   
   public class GroupfbTrapMovie extends Sprite implements Disposeable
   {
      
      private var _currentAttackType:int;
      
      private var _attMcList:Vector.<MovieClip>;
      
      private var _delayAttack:uint;
      
      public function GroupfbTrapMovie(param1:int)
      {
         _currentAttackType = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         cleanAttackMc();
         creatAttackMc();
      }
      
      private function creatAttackMc() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:SimpleMovie = null;
         if(_attMcList == null)
         {
            _attMcList = new Vector.<MovieClip>();
         }
         if(_attMcList.length > 0)
         {
            cleanAttackMc();
         }
         if(_currentAttackType == 15)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.poison_1");
         }
         else if(_currentAttackType == 16)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.ice_1");
         }
         else if(_currentAttackType == 17)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.fire_1");
         }
         if(_loc2_)
         {
            _loc1_ = new SimpleMovie(_loc2_,loopMc);
            addChild(_loc1_);
         }
      }
      
      private function loopMc() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:SimpleMovie = null;
         if(_attMcList)
         {
            if(_currentAttackType == 15)
            {
               _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.poison_2");
               _attMcList.push(_loc2_);
               addChild(_loc2_);
               _delayAttack = setTimeout(disappear,1500);
            }
            else if(_currentAttackType == 16)
            {
               _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.ice_2");
               _loc1_ = new SimpleMovie(_loc2_,iceBoom);
               addChild(_loc1_);
            }
            else if(_currentAttackType == 17)
            {
               _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.fire_2");
               _attMcList.push(_loc2_);
               addChild(_loc2_);
               _delayAttack = setTimeout(disappear,1500);
            }
         }
      }
      
      private function iceBoom() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:SimpleMovie = null;
         if(_currentAttackType == 16 && _attMcList)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.ice_3");
            _loc1_ = new SimpleMovie(_loc2_,disappear);
            addChild(_loc1_);
         }
      }
      
      private function disappear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:SimpleMovie = null;
         clearTimeout(_delayAttack);
         cleanAttackMc();
         if(_currentAttackType == 15)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.poison_3");
         }
         else if(_currentAttackType == 16)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.ice_4");
         }
         else if(_currentAttackType == 17)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.groupfbmovie.fire_3");
         }
         if(_loc2_)
         {
            _loc1_ = new SimpleMovie(_loc2_,dispose);
            addChild(_loc1_);
         }
      }
      
      private function cleanAttackMc() : void
      {
         if(_attMcList)
         {
            while(_attMcList.length > 0)
            {
               ObjectUtils.disposeViolentMc(_attMcList.pop());
            }
         }
      }
      
      public function dispose() : void
      {
         clearTimeout(_delayAttack);
         cleanAttackMc();
         _attMcList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

