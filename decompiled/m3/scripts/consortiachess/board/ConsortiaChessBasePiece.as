package consortiachess.board
{
   import com.pickgliss.ui.ComponentFactory;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   
   public class ConsortiaChessBasePiece extends Bitmap
   {
      
      protected var _board:ConsortiaChessBoard;
      
      protected var _data:ChesspvpRoleInfo;
      
      protected var _directPathDic:Dictionary = new Dictionary();
      
      protected var _pos:int;
      
      protected var _type:int = -1;
      
      private var _startPoint:Point = new Point();
      
      private var _endPoint:Point = new Point();
      
      private var _isMoving:Boolean = false;
      
      private var _state:int = -1;
      
      public function ConsortiaChessBasePiece(param1:ConsortiaChessBoard)
      {
         super(null,"auto",false);
         _board = param1;
      }
      
      protected function getLines(param1:Object, param2:int = 999) : Array
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         var _loc6_:int = 0;
         var _loc4_:int = int(param1.x);
         var _loc5_:int = int(param1.y);
         var _loc10_:Array = [];
         var _loc3_:ChesspvpBoxItem = _board.getPieceByPos(_pos);
         if(_loc3_)
         {
            _loc8_ = _loc3_.posX + _loc4_;
            _loc7_ = _loc3_.posY + _loc5_;
            _loc9_ = _loc8_ + "_" + _loc7_;
            while(_loc8_ >= 0 && _loc8_ <= 7 && _loc7_ >= 0 && _loc7_ <= 7)
            {
               _loc10_.push(_loc9_);
               if(++_loc6_ >= param2)
               {
                  break;
               }
               _loc8_ += _loc4_;
               _loc7_ += _loc5_;
               _loc9_ = _loc8_ + "_" + _loc7_;
            }
         }
         return _loc10_;
      }
      
      public function getPaths(param1:int, param2:int) : Array
      {
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:String = param1 + "_" + param2;
         for(var _loc5_:Object in _directPathDic)
         {
            _loc4_ = _directPathDic[_loc5_];
            _loc6_ = _loc4_.indexOf(_loc3_);
            if(_loc6_ != -1)
            {
               return _loc4_.slice(0,_loc6_ + 1);
            }
         }
         return null;
      }
      
      public function get data() : ChesspvpRoleInfo
      {
         return _data;
      }
      
      public function set data(param1:ChesspvpRoleInfo) : void
      {
         _data = param1;
      }
      
      public function updateView() : void
      {
         if(_data)
         {
            pos = _data.currPos;
            state = _data.state;
            if(_state == 1)
            {
               playMove();
            }
            type = _data.chessType;
         }
      }
      
      protected function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         switch(_state)
         {
            case 0:
               if(_isMoving)
               {
                  stopMove();
               }
               this.visible = true;
               refreshPostion();
               doSomeThing();
               break;
            case 1:
               this.visible = true;
               break;
            case 2:
               if(_isMoving)
               {
                  stopMove();
               }
               this.visible = false;
               break;
            case 3:
               if(_isMoving)
               {
                  stopMove();
               }
               this.visible = false;
         }
      }
      
      protected function doSomeThing() : void
      {
      }
      
      public function updateVisible(param1:Boolean) : void
      {
         if(_isMoving)
         {
            return;
         }
         this.visible = param1;
      }
      
      protected function playMove() : void
      {
         var _loc4_:ChesspvpBoxItem = null;
         var _loc3_:ChesspvpBoxItem = null;
         var _loc2_:Number = NaN;
         var _loc5_:Point = null;
         var _loc1_:Point = null;
         if(_data)
         {
            if(_data.targetPos > 0)
            {
               if(!_isMoving && _data.currPos != _data.targetPos)
               {
                  _isMoving = true;
                  _loc4_ = _board.getPieceByPos(_data.currPos);
                  _loc3_ = _board.getPieceByPos(_data.targetPos);
                  if(_loc4_ && _loc3_)
                  {
                     _startPoint.x = _loc4_.x;
                     _startPoint.y = _loc4_.y;
                     _endPoint.x = _loc3_.x;
                     _endPoint.y = _loc3_.y;
                     this.visible = true;
                     if(_data.hasMoveTime > 0)
                     {
                        _loc2_ = _data.hasMoveTime / _data.needMoveTime;
                        _loc5_ = Point.interpolate(_endPoint,_startPoint,_loc2_);
                        _startPoint.x = _loc5_.x;
                        _startPoint.y = _loc5_.y;
                     }
                     _data.currFrame = 0;
                     _data.totalFrame = (_data.needMoveTime - _data.hasMoveTime) / 40;
                     _board.drawLine(new Point(_loc4_.x + 36.5,_loc4_.y + 36.5),new Point(_loc3_.x + 36.5,_loc3_.y + 36.5),_data.livingID,_data.color);
                     if(this.parent)
                     {
                        this.parent.addChild(this);
                     }
                  }
               }
               _data.currFrame += 1;
               if(_data.totalFrame > _data.currFrame)
               {
                  _loc1_ = Point.interpolate(_endPoint,_startPoint,_data.currFrame / _data.totalFrame);
                  this.x = _loc1_.x;
                  this.y = _loc1_.y;
                  _board.drawLine(new Point(_loc1_.x + 36.5,_loc1_.y + 36.5),new Point(_endPoint.x + 36.5,_endPoint.y + 36.5),_data.livingID,_data.color);
               }
               else
               {
                  stopMove();
               }
            }
         }
      }
      
      public function get isMoving() : Boolean
      {
         return _isMoving;
      }
      
      private function stopMove() : void
      {
         _isMoving = false;
         _data.currFrame = 0;
         _data.totalFrame = 0;
         _board.clearLine(_data.livingID);
         refreshPostion();
      }
      
      private function refreshPostion() : void
      {
         var _loc1_:ChesspvpBoxItem = null;
         if(_data.currPos > 0)
         {
            _loc1_ = _board.getPieceByPos(_data.currPos);
            this.x = _loc1_.x;
            this.y = _loc1_.y;
         }
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set pos(param1:int) : void
      {
         if(_pos == param1)
         {
            return;
         }
         _pos = param1;
         updateDirectionPaths();
      }
      
      protected function updateDirectionPaths() : void
      {
         var _loc1_:ChesspvpBoxItem = null;
         if(ChesspvpResourceUtil.ins.selfChess == this && _pos > 0)
         {
            _loc1_ = _board.getPieceByPos(_pos);
            _loc1_.addChild(ChesspvpResourceUtil.ins.selfBit);
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc2_:BitmapData = null;
         if(_type == param1)
         {
            return;
         }
         _type = param1;
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
      
      public function clean() : void
      {
         _board = null;
         _data = null;
         _directPathDic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

