package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import yishi.view.community.TimeDownView;
   
   public class MapPhysicsTip extends MultipleDictionaryTip
   {
      
      private var _titleTxtStyle:String;
      
      public function MapPhysicsTip()
      {
         super();
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:FilterFrameText = null;
         var _loc6_:Bitmap = null;
         var _loc5_:int = 0;
         var _loc2_:FilterFrameText = null;
         var _loc4_:FilterFrameText = null;
         if(_data is MultipleDictionaryInfo)
         {
            removeAllItem();
            _loc3_ = (_data as MultipleDictionaryInfo).data;
            for(var _loc7_:String in _loc3_[0])
            {
               _loc1_ = getTextItem(_loc7_,titleTxtStyle);
               _leftTxtList.push(_loc1_);
               _rightTxtList.push(null);
               _maxWidth = _loc1_.textWidth;
            }
            if(_loc3_.length > 1)
            {
               _loc6_ = ComponentFactory.Instance.creatBitmap("asset.core.tipsLineImg");
               _leftTxtList.push(_loc6_);
               _rightTxtList.push(null);
            }
            _loc5_ = 1;
            while(_loc5_ < _loc3_.length)
            {
               for(var _loc8_:String in _loc3_[_loc5_])
               {
                  if(_loc8_.split("|")[0] == "downTime")
                  {
                     creatDownTime(_loc8_.split("|")[1],int(_loc3_[_loc5_][_loc8_]));
                  }
                  else
                  {
                     _loc2_ = getTextItem(_loc8_,_leftTxtStyle);
                     _maxLeftTxtWidth = _loc2_.textWidth > _maxLeftTxtWidth ? _loc2_.textWidth : _maxLeftTxtWidth;
                     _leftTxtList.push(_loc2_);
                     _loc4_ = getTextItem(_loc3_[_loc5_][_loc8_],_rightTxtStyle,false);
                     if(_loc4_ is FilterFrameText)
                     {
                        _maxWidth = _maxLeftTxtWidth + _loc4_.textWidth + 20 > _maxWidth ? _maxLeftTxtWidth + _loc4_.textWidth + 20 : _maxWidth;
                     }
                     _rightTxtList.push(_loc4_);
                  }
               }
               _loc5_++;
            }
            sortList();
         }
      }
      
      protected function creatDownTime(param1:String, param2:int) : void
      {
         var _loc3_:FilterFrameText = getTextItem(param1,_leftTxtStyle);
         _maxLeftTxtWidth = _loc3_.textWidth > _maxLeftTxtWidth ? _loc3_.textWidth : _maxLeftTxtWidth;
         _leftTxtList.push(_loc3_);
         var _loc4_:TimeDownView = ComponentFactory.Instance.creatComponentByStylename("Tips.TimeDownView");
         _loc4_.timeCount = param2;
         _maxWidth = _maxLeftTxtWidth + _loc4_.width + 20 > _maxWidth ? _maxLeftTxtWidth + _loc4_.width + 20 : _maxWidth;
         addChild(_loc4_);
         _rightTxtList.push(_loc4_);
      }
      
      override protected function sortList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Number = dictionY;
         var _loc2_:Number = dictionX;
         _loc3_ = 0;
         while(_loc3_ < _leftTxtList.length)
         {
            if(_loc3_ == 1)
            {
               _leftTxtList[_loc3_].x = _loc1_ - 5;
               _leftTxtList[_loc3_].y = _loc2_;
               _loc2_ += 10;
               addChild(_leftTxtList[_loc3_]);
            }
            else
            {
               _leftTxtList[_loc3_].x = _loc1_;
               _leftTxtList[_loc3_].y = _loc2_;
               if(_rightTxtList[_loc3_])
               {
                  _rightTxtList[_loc3_].x = _maxLeftTxtWidth + _leftTxtList[_loc3_].x + 20;
                  _rightTxtList[_loc3_].y = _loc2_;
               }
               _loc2_ += _leftTxtList[_loc3_].textHeight + 10;
            }
            _loc3_++;
         }
         _bg.width = _maxWidth + 32;
         _bg.height = _loc2_;
         if(_leftTxtList[1])
         {
            _leftTxtList[1].width = _bg.width;
         }
      }
      
      public function set titleTxtStyle(param1:String) : void
      {
         if(_titleTxtStyle == param1)
         {
            return;
         }
         _titleTxtStyle = param1;
      }
      
      public function get titleTxtStyle() : String
      {
         return _titleTxtStyle;
      }
   }
}

