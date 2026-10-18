package childnswar.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.ChildManager;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import mvc.module.children.ChildData;
   import utils.LogicUtils;
   
   public class ChildNswarTeamUI extends Sprite
   {
      
      protected var _bg:MutipleImage;
      
      private var _avatarList:Vector.<ChildNswarAvater> = new Vector.<ChildNswarAvater>();
      
      public var currOpIdx:int;
      
      private var _fightIds:Array = [-1,-1,-1,-1,-1];
      
      public function ChildNswarTeamUI()
      {
         super();
         initView();
         initData();
      }
      
      protected function initView() : void
      {
         var _loc1_:ChildNswarAvater = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.bg");
         addChild(_bg);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.childnswar.av" + (_loc2_ + 1),[_loc2_]);
            _avatarList[_loc2_] = _loc1_;
            addChild(_loc1_);
            _loc2_++;
         }
         _avatarList[0].visible = _avatarList[2].visible = false;
      }
      
      private function initData() : void
      {
         var _loc1_:ChildNswarUserInfo = ChildNswarManager.Instance.model.selfUserInfo;
         var _loc2_:String = _loc1_.fightInfo;
         refreshTeams(_loc2_);
      }
      
      private function refreshTeams(param1:String) : void
      {
         var _loc2_:ChildNswarAvater = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _fightIds = param1.split(",");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = int(_fightIds[_loc3_]);
            _loc2_ = _avatarList[_loc3_];
            if(_loc4_ > 0)
            {
               _loc2_.chidData = ChildManager.instance.model.getChildById(_loc4_);
            }
            else
            {
               _loc2_.chidData = null;
            }
            _loc3_++;
         }
      }
      
      public function updateAvatar(param1:ChildData) : void
      {
         var _loc2_:int = 0;
         if(_avatarList[currOpIdx].chidData == param1)
         {
            _avatarList[currOpIdx].chidData = null;
            _fightIds[currOpIdx] = -1;
         }
         else
         {
            _avatarList[currOpIdx].chidData = param1;
            _fightIds[currOpIdx] = param1.childId;
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               if(_loc2_ != currOpIdx && _avatarList[_loc2_].chidData == param1)
               {
                  _avatarList[_loc2_].chidData = null;
                  _fightIds[_loc2_] = -1;
               }
               _loc2_++;
            }
         }
      }
      
      public function clearLastFlash(param1:int) : void
      {
         if(param1 >= 0)
         {
            _avatarList[param1].stopFlash();
         }
      }
      
      public function get fightIdsStr() : String
      {
         return _fightIds.join(",");
      }
      
      public function get hasMainPos() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(int(_fightIds[_loc2_]) > 0)
            {
               _loc1_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         LogicUtils.disposeDisplayCollection(_avatarList);
         _avatarList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

