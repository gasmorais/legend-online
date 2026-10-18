package mvc.module.secret
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import yishi.events.NotificationEvent;
   import yishi.utils.SimpleDictionary;
   
   public class SecretAdventureModel extends EventDispatcher
   {
      
      public var armyView:DisplayObject;
      
      public var isTest:Boolean;
      
      public var resetForceRefresh:Boolean;
      
      private var _pinfo:SecretPlayerInfo;
      
      private var _sonMapNodeDic:SimpleDictionary;
      
      private var _sonMapDic:SimpleDictionary;
      
      private var _selectItem:Sprite;
      
      private var _frameInfo:SecretFrameInfo;
      
      private var _secenInfo:SecretSecenInfo;
      
      public function SecretAdventureModel()
      {
         super();
         _sonMapNodeDic = new SimpleDictionary();
         _sonMapDic = new SimpleDictionary();
         _frameInfo = new SecretFrameInfo();
         _pinfo = new SecretPlayerInfo();
         _secenInfo = new SecretSecenInfo();
      }
      
      public function putMap(param1:int, param2:Sprite) : void
      {
         _sonMapDic.add(param1,param2);
      }
      
      public function getMap(param1:int) : Sprite
      {
         return _sonMapDic[param1];
      }
      
      public function putMapNodes(param1:int, param2:SimpleDictionary) : void
      {
         _sonMapNodeDic.add(param1,param2);
      }
      
      public function getNode(param1:int, param2:int) : DisplayObject
      {
         var _loc3_:SimpleDictionary = _sonMapNodeDic[param1];
         if(_loc3_)
         {
            return _loc3_[param2];
         }
         return null;
      }
      
      public function reset() : void
      {
         _sonMapNodeDic.clear();
         _secenInfo.clear();
      }
      
      public function get selectItem() : Sprite
      {
         return _selectItem;
      }
      
      public function set selectItem(param1:Sprite) : void
      {
         if(_selectItem == param1 && !resetForceRefresh)
         {
            return;
         }
         _selectItem = param1;
         dispatchEvent(new NotificationEvent("SecretAdEvent.selectItem",_selectItem));
         resetForceRefresh = false;
      }
      
      public function get frameInfo() : SecretFrameInfo
      {
         return _frameInfo;
      }
      
      public function get pinfo() : SecretPlayerInfo
      {
         return _pinfo;
      }
      
      public function get secenInfo() : SecretSecenInfo
      {
         return _secenInfo;
      }
   }
}

