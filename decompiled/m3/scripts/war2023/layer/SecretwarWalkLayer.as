package war2023.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.item.SecretwarMoveItem;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarWalkLayer extends Sprite
   {
      
      private var _items:Dictionary = new Dictionary();
      
      private var _pList:Dictionary;
      
      public function SecretwarWalkLayer()
      {
         super();
         _pList = SecretWarManager.Instance.model.playerList;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:SecretwarMoveItem = null;
         for each(var _loc2_:SecretwarPlayInfo in _pList)
         {
            if(_loc2_.state == 3)
            {
               _loc1_ = _items[_loc2_.key];
               if(!_loc1_)
               {
                  _loc1_ = new SecretwarMoveItem();
                  _loc1_.data = _loc2_;
                  _items[_loc2_.key] = _loc1_;
                  addChild(_loc1_);
               }
               _loc1_.playMove();
            }
            else if(_loc2_.state == 1)
            {
               _loc1_ = _items[_loc2_.key];
               if(!_loc1_)
               {
                  delete _items[_loc2_.key];
                  ObjectUtils.disposeObject(_loc1_);
               }
            }
            else
            {
               _loc1_ = _items[_loc2_.key];
               if(_loc1_)
               {
                  _loc1_.stopMove();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:SecretwarMoveItem in _items)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _items = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _pList = null;
      }
   }
}

