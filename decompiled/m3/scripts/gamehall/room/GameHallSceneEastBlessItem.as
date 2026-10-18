package gamehall.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.gamehall.GameHallUserInfo;
   
   public class GameHallSceneEastBlessItem extends Sprite
   {
      
      private var _userName:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _data:GameHallUserInfo;
      
      private var _tipsType:int;
      
      public function GameHallSceneEastBlessItem()
      {
         super();
         initView();
      }
      
      public function set tipsType(param1:int) : void
      {
         _tipsType = param1;
      }
      
      public function get data() : GameHallUserInfo
      {
         return _data;
      }
      
      public function set data(param1:GameHallUserInfo) : void
      {
         _data = param1;
         if(_data)
         {
            refreshView();
         }
         else
         {
            _userName.text = "";
            if(_hbox)
            {
               _hbox.removeAllChild();
            }
         }
      }
      
      private function initView() : void
      {
         _userName = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessItem.userName");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("gamehall.room.GameHallSceneEastBlessItem.hbox");
         addChild(_userName);
         addChild(_hbox);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_userName);
         _userName = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
      }
      
      private function refreshView() : void
      {
         var _loc1_:GameHallSceneEastBlessBaseItemView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _userName.text = _data.nickName;
         if(_hbox)
         {
            _hbox.removeAllChild();
         }
         if(_data.buffs)
         {
            _loc2_ = int(_data.buffs.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = new GameHallSceneEastBlessBaseItemView();
               _loc1_.tipsType = _tipsType;
               _loc1_.data = _data.buffs[_loc3_];
               _hbox.addChild(_loc1_);
               _loc3_++;
            }
         }
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

