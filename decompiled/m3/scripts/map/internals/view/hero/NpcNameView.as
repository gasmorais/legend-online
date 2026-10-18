package map.internals.view.hero
{
   import avatar.view.SimpleAvatarView;
   import com.pickgliss.ui.core.Component;
   import map.internals.data.MapPhysics;
   import map.internals.data.SpaceNode;
   
   public class NpcNameView extends BaseNameView
   {
      
      private var _nodeInfo:MapPhysics;
      
      private var _chatPopView:Component;
      
      private var _attackView:SimpleAvatarView;
      
      public function NpcNameView()
      {
         super();
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         _npcName.y = getPosYById(nodeInfo.info.id);
      }
      
      public function getPosYById(param1:int) : int
      {
         var _loc2_:int = -130;
         switch(param1 - 3)
         {
            case 0:
               _loc2_ = -190;
               break;
            default:
               _loc2_ = -130;
         }
         return _loc2_;
      }
      
      public function set nodeInfo(param1:MapPhysics) : void
      {
         _nodeInfo = param1;
         var _loc2_:SpaceNode = _nodeInfo as SpaceNode;
         showName(_loc2_.info.names,_loc2_.info.grade,_loc2_.info.state,_loc2_.info.types,_loc2_.nameColor);
      }
      
      public function get nodeInfo() : MapPhysics
      {
         return _nodeInfo;
      }
   }
}

