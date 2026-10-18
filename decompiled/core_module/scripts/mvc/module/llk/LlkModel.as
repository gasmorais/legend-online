package mvc.module.llk
{
   public class LlkModel
   {
      
      public static var LLK_INFO:String = "LlkModel.LLK_INFO";
      
      public static var LLK_SORT:String = "LlkModel.LLK_SORT";
      
      public static var ROW:int = 8;
      
      public static var COLUMN:int = 14;
      
      private var _list:Vector.<LlkNodeData>;
      
      private var _info:LlkInfo;
      
      public function LlkModel()
      {
         super();
         _list = new Vector.<LlkNodeData>();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LlkNodeData = null;
         _loc2_ = 0;
         while(_loc2_ < ROW * COLUMN)
         {
            _loc1_ = new LlkNodeData();
            _loc1_.row = Math.floor(_loc2_ / COLUMN);
            _loc1_.col = _loc2_ % COLUMN;
            _list[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      public function get info() : LlkInfo
      {
         if(_info == null)
         {
            _info = new LlkInfo();
         }
         return _info;
      }
      
      public function get list() : Vector.<LlkNodeData>
      {
         return _list;
      }
      
      public function checkByPos(param1:LlkNodeData, param2:LlkNodeData, param3:Boolean = false) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param3 == false && (param1.val <= 0 || param1.val <= 0))
         {
            return false;
         }
         if(param1.row == param2.row && param1.col == param2.col)
         {
            return false;
         }
         if(param1.val != param2.val)
         {
            return false;
         }
         if(param1.row == param2.row && connectRow(param1,param2))
         {
            connectRow(param1,param2,param3);
            return true;
         }
         if(param1.col == param2.col && connectCol(param1,param2))
         {
            connectCol(param1,param2,param3);
            return true;
         }
         if(oneCorner(param1,param2,param3))
         {
            return true;
         }
         if(twoCorner(param1,param2,param3))
         {
            return true;
         }
         return false;
      }
      
      private function twoCorner(param1:LlkNodeData, param2:LlkNodeData, param3:Boolean = false) : Boolean
      {
         var _loc4_:LlkNodeData = null;
         var _loc5_:LlkNodeData = null;
         var _loc6_:int = 0;
         if(param1.val != param2.val)
         {
            return false;
         }
         _loc6_ = 0;
         while(_loc6_ < ROW)
         {
            _loc4_ = _list[_loc6_ * COLUMN + param1.col];
            _loc5_ = _list[_loc6_ * COLUMN + param2.col];
            if(!(_loc4_.val > 0 || _loc5_.val > 0))
            {
               if(connectRow(_loc4_,_loc5_) != false)
               {
                  if(connectCol(_loc4_,param1) && connectCol(_loc5_,param2))
                  {
                     _loc4_.mcType = direction(param1,_loc4_,_loc5_);
                     _loc5_.mcType = direction(_loc4_,_loc5_,param2);
                     connectRow(_loc4_,_loc5_,param3);
                     connectCol(_loc4_,param1,param3);
                     connectCol(_loc5_,param2,param3);
                     return true;
                  }
               }
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < COLUMN)
         {
            _loc4_ = _list[param1.row * COLUMN + _loc6_];
            _loc5_ = _list[param2.row * COLUMN + _loc6_];
            if(!(_loc4_.val > 0 || _loc5_.val > 0))
            {
               if(connectCol(_loc4_,_loc5_) != false)
               {
                  if(connectRow(_loc4_,param1) && connectRow(_loc5_,param2))
                  {
                     _loc4_.mcType = direction(param1,_loc4_,_loc5_);
                     _loc5_.mcType = direction(_loc4_,_loc5_,param2);
                     connectCol(_loc4_,_loc5_,param3);
                     connectRow(_loc4_,param1,param3);
                     connectRow(_loc5_,param2,param3);
                     return true;
                  }
               }
            }
            _loc6_++;
         }
         return false;
      }
      
      private function oneCorner(param1:LlkNodeData, param2:LlkNodeData, param3:Boolean = false) : Boolean
      {
         var _loc4_:LlkNodeData = _list[param1.row * COLUMN + param2.col];
         if(_loc4_.val == 0)
         {
            if(connectRow(_loc4_,param1) && connectCol(_loc4_,param2))
            {
               _loc4_.mcType = direction(param1,_loc4_,param2);
               connectRow(_loc4_,param1,param3);
               connectCol(_loc4_,param2,param3);
               return true;
            }
         }
         _loc4_ = _list[param2.row * COLUMN + param1.col];
         if(_loc4_.val == 0)
         {
            if(connectRow(_loc4_,param2) && connectCol(_loc4_,param1))
            {
               _loc4_.mcType = direction(param1,_loc4_,param2);
               connectRow(_loc4_,param2,param3);
               connectCol(_loc4_,param1,param3);
               return true;
            }
         }
         return false;
      }
      
      private function direction(param1:LlkNodeData, param2:LlkNodeData, param3:LlkNodeData) : int
      {
         var _loc4_:LlkNodeData = null;
         var _loc5_:LlkNodeData = null;
         var _loc6_:int = 5;
         if(param2.row == param1.row)
         {
            _loc4_ = param1;
            _loc5_ = param3;
         }
         else if(param2.row == param3.row)
         {
            _loc4_ = param3;
            _loc5_ = param1;
         }
         if(param2.col > _loc4_.col)
         {
            if(param2.row > _loc5_.row)
            {
               _loc6_ = 8;
            }
            else if(param2.row < _loc5_.row)
            {
               _loc6_ = 7;
            }
         }
         else if(param2.col < _loc4_.col)
         {
            if(param2.row > _loc5_.row)
            {
               _loc6_ = 5;
            }
            else if(param2.row < _loc5_.row)
            {
               _loc6_ = 6;
            }
         }
         return _loc6_;
      }
      
      private function connectCol(param1:LlkNodeData, param2:LlkNodeData, param3:Boolean = false) : Boolean
      {
         var _loc6_:int = 0;
         if(param1.col != param2.col)
         {
            return false;
         }
         var _loc4_:int = Math.min(param1.row,param2.row);
         var _loc5_:int = Math.max(param1.row,param2.row);
         _loc6_ = _loc4_ + 1;
         while(_loc6_ < _loc5_)
         {
            if(_list[_loc6_ * COLUMN + param1.col] && _list[_loc6_ * COLUMN + param1.col].val > 0)
            {
               return false;
            }
            if(param3)
            {
               _list[_loc6_ * COLUMN + param1.col].mcType = 2;
            }
            _loc6_++;
         }
         return true;
      }
      
      private function connectRow(param1:LlkNodeData, param2:LlkNodeData, param3:Boolean = false) : Boolean
      {
         var _loc6_:int = 0;
         if(param1.row != param2.row)
         {
            return false;
         }
         var _loc4_:int = Math.min(param1.col,param2.col);
         var _loc5_:int = Math.max(param1.col,param2.col);
         _loc6_ = _loc4_ + 1;
         while(_loc6_ < _loc5_)
         {
            if(_list[param1.row * COLUMN + _loc6_] && _list[param1.row * COLUMN + _loc6_].val > 0)
            {
               return false;
            }
            if(param3)
            {
               _list[param1.row * COLUMN + _loc6_].mcType = 1;
            }
            _loc6_++;
         }
         return true;
      }
      
      public function clear() : void
      {
         init();
      }
   }
}

