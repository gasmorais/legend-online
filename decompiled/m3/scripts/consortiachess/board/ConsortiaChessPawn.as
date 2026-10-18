package consortiachess.board
{
   import com.pickgliss.ui.ComponentFactory;
   import consortiachess.util.ChesspvpConst;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaChessPawn extends ConsortiaChessBasePiece
   {
      
      private var _selfInfo:ChesspvpRoleInfo;
      
      private var _lastType:int = -1;
      
      private var _needDoUpRole:Boolean = false;
      
      public function ConsortiaChessPawn(param1:ConsortiaChessBoard)
      {
         super(param1);
         _selfInfo = ChessPvpManager.Instance.model.selfInfo;
      }
      
      override protected function updateDirectionPaths() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = null;
         super.updateDirectionPaths();
         _loc2_ = ChesspvpConst.PAWN_RULES_MOVE_1;
         for each(_loc1_ in _loc2_)
         {
            if(!(_loc1_.y == -2 && Boolean(_data.firstMove)))
            {
               _directPathDic[_loc1_] = getLines(_loc1_,1);
            }
         }
         _loc2_ = ChesspvpConst.PAWN_RULES_KILL_1;
         for each(_loc1_ in _loc2_)
         {
            _directPathDic[_loc1_] = getLines(_loc1_,1);
         }
      }
      
      override public function set type(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc2_:BitmapData = null;
         if(_type == param1)
         {
            return;
         }
         if(_lastType != param1 && _lastType != -1)
         {
            _lastType = -1;
            _board.changeRoleUp(_data.livingID,param1);
            return;
         }
         _type = param1;
         _lastType = _type;
         switch(int(_data.team) - 1)
         {
            case 0:
               _loc3_ = ChesspvpResourceUtil.ins.whiteRoleDataList[_type];
               break;
            case 1:
               _loc3_ = ChesspvpResourceUtil.ins.blackRoleDataList[_type];
         }
         if(_data.color == 1)
         {
            _loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.chesspvp.myselfImg").bitmapData;
            _loc4_.copyPixels(_loc3_,new Rectangle(0,0,_loc3_.width,_loc3_.height),new Point(0,0),null,null,true);
            _loc4_.copyPixels(_loc2_,new Rectangle(0,0,_loc2_.width,_loc2_.height),new Point(36,1),null,null,true);
            _loc3_ = _loc4_;
         }
         this.bitmapData = _loc3_;
      }
      
      override public function set pos(param1:int) : void
      {
         if(_pos == param1)
         {
            return;
         }
         _pos = param1;
         updateDirectionPaths();
         checkChangeType();
      }
      
      protected function checkChangeType() : void
      {
         var _loc1_:Array = null;
         if(_data && _data == _selfInfo)
         {
            _loc1_ = [];
            if(_data.team == 1)
            {
               _loc1_ = [1,2,3,4,5,6,7,8];
            }
            else
            {
               _loc1_ = [57,58,59,60,61,62,63,64];
            }
            if(_loc1_.indexOf(_data.currPos) != -1)
            {
               _needDoUpRole = true;
            }
         }
      }
      
      override protected function doSomeThing() : void
      {
         if(_needDoUpRole)
         {
            FrameControllerManager.instance.openControllerByInfo("chesspvp",2);
            _needDoUpRole = false;
         }
      }
   }
}

