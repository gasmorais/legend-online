package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class MultipleDictionaryTip extends BaseTip
   {
      
      protected var _maxLeftTxtWidth:Number = 0;
      
      protected var _maxWidth:Number = 200;
      
      protected var _dictionX:Number = 8;
      
      protected var _dictionY:Number = 5;
      
      protected var _enableHtml:Boolean = false;
      
      protected var _leftTxtStyle:String;
      
      protected var _rightTxtStyle:String;
      
      protected var _leftTxtList:Array;
      
      protected var _rightTxtList:Array;
      
      protected var _tempLeftTxtList:Array;
      
      protected var _tempRightTxtList:Array;
      
      public function MultipleDictionaryTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _leftTxtList = [];
         _rightTxtList = [];
         _tempLeftTxtList = [];
         _tempRightTxtList = [];
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:* = undefined;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc3_:FilterFrameText = null;
         if(_data is MultipleDictionaryInfo)
         {
            removeAllItem();
            _loc2_ = (_data as MultipleDictionaryInfo).data;
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               for(var _loc6_:String in _loc2_[_loc5_])
               {
                  _loc1_ = getTextItem(_loc6_,_leftTxtStyle);
                  _maxLeftTxtWidth = _loc1_.textWidth > _maxLeftTxtWidth ? _loc1_.textWidth : _maxLeftTxtWidth;
                  _leftTxtList.push(_loc1_);
                  _loc3_ = getTextItem(_loc2_[_loc5_][_loc6_],_rightTxtStyle,false);
                  if(_loc3_)
                  {
                     _loc4_ = Number(_loc3_.textWidth > _loc4_ ? _loc3_.textWidth : _loc4_);
                  }
                  _rightTxtList.push(_loc3_);
               }
               _loc5_++;
            }
            _maxWidth = _maxWidth > _maxLeftTxtWidth + _loc4_ ? _maxWidth : _maxLeftTxtWidth + _loc4_;
            sortList();
         }
      }
      
      protected function removeAllItem() : void
      {
         removeListByArray(_leftTxtList,_tempLeftTxtList);
         removeListByArray(_rightTxtList,_tempRightTxtList);
      }
      
      private function removeListByArray(param1:Array, param2:Array) : void
      {
         var _loc3_:DisplayObject = null;
         while(param1.length > 0)
         {
            _loc3_ = param1.pop();
            if(_loc3_ is FilterFrameText)
            {
               param2.push(_loc3_);
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
            }
            else
            {
               ObjectUtils.disposeObject(_loc3_);
               _loc3_ = null;
            }
         }
      }
      
      protected function getTextItem(param1:String, param2:String, param3:Boolean = true) : FilterFrameText
      {
         var _loc4_:FilterFrameText = null;
         if(param1 == null)
         {
            return null;
         }
         if(param3)
         {
            _loc4_ = _tempLeftTxtList.pop();
         }
         else
         {
            _loc4_ = _tempRightTxtList.pop();
         }
         if(!_loc4_)
         {
            _loc4_ = createTxt(param2);
         }
         _enableHtml ? (_loc4_.htmlText = param1) : (_loc4_.text = param1);
         addChild(_loc4_);
         return _loc4_;
      }
      
      protected function sortList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Number = dictionY;
         var _loc2_:Number = dictionX;
         _loc3_ = 0;
         while(_loc3_ < _leftTxtList.length)
         {
            _leftTxtList[_loc3_].x = _loc1_;
            _leftTxtList[_loc3_].y = _loc2_;
            if(_rightTxtList[_loc3_])
            {
               _rightTxtList[_loc3_].x = _maxLeftTxtWidth + _leftTxtList[_loc3_].x;
               _rightTxtList[_loc3_].y = _loc2_;
            }
            _loc2_ += _leftTxtList[_loc3_].textHeight + 5;
            _loc3_++;
         }
         _bg.width = _maxWidth + 16;
         _bg.height = _loc2_ + 8;
      }
      
      protected function clear() : void
      {
         clearTxtList(_leftTxtList);
         clearTxtList(_rightTxtList);
         clearTxtList(_tempLeftTxtList);
         clearTxtList(_tempRightTxtList);
      }
      
      private function clearTxtList(param1:Array) : void
      {
         for each(var _loc2_:Object in param1)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         param1.splice(0,param1.length);
      }
      
      protected function createTxt(param1:String) : FilterFrameText
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      public function get enableHtml() : Boolean
      {
         return _enableHtml;
      }
      
      public function set enableHtml(param1:Boolean) : void
      {
         if(_enableHtml == param1)
         {
            return;
         }
         _enableHtml = param1;
      }
      
      public function get leftTxtStyle() : String
      {
         return _leftTxtStyle;
      }
      
      public function set leftTxtStyle(param1:String) : void
      {
         if(_leftTxtStyle == param1)
         {
            return;
         }
         _leftTxtStyle = param1;
      }
      
      public function get rightTxtStyle() : String
      {
         return _rightTxtStyle;
      }
      
      public function set rightTxtStyle(param1:String) : void
      {
         if(_rightTxtStyle == param1)
         {
            return;
         }
         _rightTxtStyle = param1;
      }
      
      public function get dictionX() : Number
      {
         return _dictionX;
      }
      
      public function set dictionX(param1:Number) : void
      {
         if(_dictionX == param1)
         {
            return;
         }
         _dictionX = param1;
      }
      
      public function get dictionY() : Number
      {
         return _dictionY;
      }
      
      public function set dictionY(param1:Number) : void
      {
         if(_dictionY == param1)
         {
            return;
         }
         _dictionY = param1;
      }
      
      override public function dispose() : void
      {
         clear();
         _leftTxtList = _leftTxtList = _tempLeftTxtList = _tempRightTxtList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

