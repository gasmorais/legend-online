package war2023.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.item.SecretwarFightItem;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarFightLayer extends Sprite
   {
      
      private var _fightItemList:Array = [];
      
      private var _pList:Dictionary;
      
      public function SecretwarFightLayer()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
         _pList = SecretWarManager.Instance.model.playerList;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:SecretwarFightItem = null;
         for each(var _loc2_:SecretwarPlayInfo in _pList)
         {
            if(_loc2_.state == 4)
            {
               _loc1_ = getFightMc(_loc2_.key);
               if(!_loc1_)
               {
                  _loc1_ = fightEmptyMc();
                  _loc1_.updateKey(_loc2_.key,_loc2_.fightKey,_loc2_.x,_loc2_.y);
               }
               if(!_loc1_.parent)
               {
                  _loc1_.play();
                  addChild(_loc1_);
               }
            }
            else
            {
               _loc1_ = getFightMc(_loc2_.key);
               if(_loc1_)
               {
                  _loc1_.hideFight();
               }
            }
         }
      }
      
      private function getFightMc(param1:String) : SecretwarFightItem
      {
         for each(var _loc2_:SecretwarFightItem in _fightItemList)
         {
            if(_loc2_.owerKey == param1 || _loc2_.emeryKey == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function fightEmptyMc() : SecretwarFightItem
      {
         var _loc1_:SecretwarFightItem = null;
         for each(var _loc2_:SecretwarFightItem in _fightItemList)
         {
            if(!_loc2_.parent)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         if(!_loc1_)
         {
            _loc1_ = new SecretwarFightItem();
            _fightItemList.push(_loc1_);
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:SecretwarFightItem in _fightItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _fightItemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _pList = null;
      }
   }
}

