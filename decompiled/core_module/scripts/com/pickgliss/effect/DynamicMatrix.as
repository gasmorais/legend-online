package com.pickgliss.effect
{
   public class DynamicMatrix
   {
      
      public static const MATRIX_ORDER_PREPEND:int = 0;
      
      public static const MATRIX_ORDER_APPEND:int = 1;
      
      protected var m_width:int;
      
      protected var m_height:int;
      
      protected var m_matrix:Array;
      
      public function DynamicMatrix(param1:int, param2:int)
      {
         super();
         Create(param1,param2);
      }
      
      protected function Create(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 > 0 && param2 > 0)
         {
            m_width = param1;
            m_height = param2;
            m_matrix = new Array(param2);
            _loc3_ = 0;
            while(_loc3_ < param2)
            {
               m_matrix[_loc3_] = new Array(param1);
               _loc4_ = 0;
               while(_loc4_ < param2)
               {
                  m_matrix[_loc3_][_loc4_] = 0;
                  _loc4_++;
               }
               _loc3_++;
            }
         }
      }
      
      protected function Destroy() : void
      {
         m_matrix = null;
      }
      
      public function GetWidth() : Number
      {
         return m_width;
      }
      
      public function GetHeight() : Number
      {
         return m_height;
      }
      
      public function GetValue(param1:int, param2:int) : Number
      {
         var _loc3_:Number = 0;
         if(param1 >= 0 && param1 < m_height && param2 >= 0 && param2 <= m_width)
         {
            _loc3_ = Number(m_matrix[param1][param2]);
         }
         return _loc3_;
      }
      
      public function SetValue(param1:int, param2:int, param3:Number) : void
      {
         if(param1 >= 0 && param1 < m_height && param2 >= 0 && param2 <= m_width)
         {
            m_matrix[param1][param2] = param3;
         }
      }
      
      public function LoadIdentity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(m_matrix)
         {
            _loc1_ = 0;
            while(_loc1_ < m_height)
            {
               _loc2_ = 0;
               while(_loc2_ < m_width)
               {
                  if(_loc1_ == _loc2_)
                  {
                     m_matrix[_loc1_][_loc2_] = 1;
                  }
                  else
                  {
                     m_matrix[_loc1_][_loc2_] = 0;
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
      }
      
      public function LoadZeros() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(m_matrix)
         {
            _loc1_ = 0;
            while(_loc1_ < m_height)
            {
               _loc2_ = 0;
               while(_loc2_ < m_width)
               {
                  m_matrix[_loc1_][_loc2_] = 0;
                  _loc2_++;
               }
               _loc1_++;
            }
         }
      }
      
      public function Multiply(param1:DynamicMatrix, param2:int = 0) : Boolean
      {
         var _loc3_:DynamicMatrix = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!m_matrix || !param1)
         {
            return false;
         }
         var _loc6_:int = param1.GetHeight();
         var _loc10_:int = param1.GetWidth();
         if(param2 == 1)
         {
            if(m_width != _loc6_)
            {
               return false;
            }
            _loc3_ = new DynamicMatrix(_loc10_,m_height);
            _loc5_ = 0;
            while(_loc5_ < m_height)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc10_)
               {
                  _loc4_ = 0;
                  _loc8_ = 0;
                  _loc9_ = 0;
                  while(_loc8_ < Math.max(m_height,_loc6_) && _loc9_ < Math.max(m_width,_loc10_))
                  {
                     _loc4_ += param1.GetValue(_loc8_,_loc7_) * m_matrix[_loc5_][_loc9_];
                     _loc8_++;
                     _loc9_++;
                  }
                  _loc3_.SetValue(_loc5_,_loc7_,_loc4_);
                  _loc7_++;
               }
               _loc5_++;
            }
            Destroy();
            Create(_loc10_,m_height);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = 0;
               while(_loc7_ < m_width)
               {
                  m_matrix[_loc5_][_loc7_] = _loc3_.GetValue(_loc5_,_loc7_);
                  _loc7_++;
               }
               _loc5_++;
            }
         }
         else
         {
            if(m_height != _loc10_)
            {
               return false;
            }
            _loc3_ = new DynamicMatrix(m_width,_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = 0;
               while(_loc7_ < m_width)
               {
                  _loc4_ = 0;
                  _loc8_ = 0;
                  _loc9_ = 0;
                  while(_loc8_ < Math.max(_loc6_,m_height) && _loc9_ < Math.max(_loc10_,m_width))
                  {
                     _loc4_ += m_matrix[_loc8_][_loc7_] * param1.GetValue(_loc5_,_loc9_);
                     _loc8_++;
                     _loc9_++;
                  }
                  _loc3_.SetValue(_loc5_,_loc7_,_loc4_);
                  _loc7_++;
               }
               _loc5_++;
            }
            Destroy();
            Create(m_width,_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = 0;
               while(_loc7_ < m_width)
               {
                  m_matrix[_loc5_][_loc7_] = _loc3_.GetValue(_loc5_,_loc7_);
                  _loc7_++;
               }
               _loc5_++;
            }
         }
         return true;
      }
      
      public function MultiplyNumber(param1:Number) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         if(!m_matrix)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < m_height)
         {
            _loc4_ = 0;
            while(_loc4_ < m_width)
            {
               _loc2_ = 0;
               _loc2_ = m_matrix[_loc3_][_loc4_] * param1;
               m_matrix[_loc3_][_loc4_] = _loc2_;
               _loc4_++;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function Add(param1:DynamicMatrix) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         if(!m_matrix || !param1)
         {
            return false;
         }
         var _loc4_:int = param1.GetHeight();
         var _loc6_:int = param1.GetWidth();
         if(m_width != _loc6_ || m_height != _loc4_)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < m_height)
         {
            _loc5_ = 0;
            while(_loc5_ < m_width)
            {
               _loc2_ = 0;
               _loc2_ = m_matrix[_loc3_][_loc5_] + param1.GetValue(_loc3_,_loc5_);
               m_matrix[_loc3_][_loc5_] = _loc2_;
               _loc5_++;
            }
            _loc3_++;
         }
         return true;
      }
   }
}

