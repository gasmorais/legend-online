package dialog
{
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import dialog.data.DialogMessageInfo;
   import dialog.data.NoviceDialogueXml;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneType;
   import yishi.utils.MaskUtils;
   
   public class DialogModel extends EventDispatcher
   {
      
      private var _nameReplaceReg:RegExp = /%s/g;
      
      private var _leftRoles:Array;
      
      private var _rightRoles:Array;
      
      public var isLoop:Boolean;
      
      public var scene:String;
      
      private var _infos:Array;
      
      private var _index:int;
      
      public function DialogModel(param1:IEventDispatcher = null)
      {
         MaskUtils.instance.maskShow(0);
         super(param1);
         _infos = [];
         _index = 0;
      }
      
      public function hasNextInfo() : Boolean
      {
         return _infos.length > _index;
      }
      
      public function nextInfo() : DialogMessageInfo
      {
         if(_infos.length > _index)
         {
            return _infos[_index++] as DialogMessageInfo;
         }
         return null;
      }
      
      public function preInfo() : DialogMessageInfo
      {
         if(_index > 0)
         {
            if(_infos.length > _index - 1)
            {
               return _infos[--_index];
            }
         }
         return null;
      }
      
      public function addInfo(param1:DialogMessageInfo) : void
      {
         _infos.push(param1);
      }
      
      public function get infos() : Array
      {
         return _infos;
      }
      
      public function get rightRoles() : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary(true);
         for each(var _loc1_:DialogMessageInfo in _infos)
         {
            if(_loc1_.direction == 1 && StringUtils.isEmpty(_loc1_.event))
            {
               _loc2_[_loc1_.roleId] = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function get leftRoles() : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary(true);
         for each(var _loc1_:DialogMessageInfo in _infos)
         {
            if(_loc1_.direction != 1 && StringUtils.isEmpty(_loc1_.event))
            {
               _loc2_[_loc1_.roleId] = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function setXmlResources(param1:String) : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:DialogMessageInfo = null;
         var _loc2_:XMLList = NoviceDialogueXml.xml..story;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length())
         {
            if(param1 == _loc2_[_loc4_].@nameId)
            {
               _loc3_ = _loc2_[_loc4_];
               break;
            }
            _loc4_++;
         }
         var _loc6_:XMLList = _loc3_..item;
         scene = SceneType.getSceneTypeById(_loc3_.@sceneType);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length())
         {
            _loc7_ = new DialogMessageInfo();
            ObjectUtils.copyPorpertiesByXML(_loc7_,_loc6_[_loc5_]);
            if(_loc7_.roleId == 0)
            {
               _loc7_.roleId = PlayerManager.instance.currentPlayerModel.playerInfo.pics;
            }
            if(_loc7_.roleName == "%s")
            {
               _loc7_.roleName = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
            }
            _loc7_.txt = _loc7_.txt.replace(_nameReplaceReg,PlayerManager.instance.currentPlayerModel.playerInfo.nickName);
            addInfo(_loc7_);
            _loc5_++;
         }
      }
   }
}

