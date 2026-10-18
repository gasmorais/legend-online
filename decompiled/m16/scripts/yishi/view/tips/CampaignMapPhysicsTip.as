package yishi.view.tips
{
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.utils.Dictionary;
   
   public class CampaignMapPhysicsTip extends MultipleDictionaryTip
   {
      
      private var _titleTxtStyle:String;
      
      public function CampaignMapPhysicsTip()
      {
         super();
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:FilterFrameText = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
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
            _loc5_ = 0;
            _loc6_ = 1;
            while(_loc6_ < _loc3_.length)
            {
               for(var _loc8_:String in _loc3_[_loc6_])
               {
                  _loc2_ = getTextItem(_loc8_,_leftTxtStyle);
                  _maxLeftTxtWidth = _loc2_.textWidth > _maxLeftTxtWidth ? _loc2_.textWidth : _maxLeftTxtWidth;
                  _leftTxtList.push(_loc2_);
                  _loc4_ = getTextItem(_loc3_[_loc6_][_loc8_],_rightTxtStyle,false);
                  if(_loc4_)
                  {
                     _loc5_ = Number(_loc4_.textWidth > _loc5_ ? _loc4_.textWidth : _loc5_);
                  }
                  _rightTxtList.push(_loc4_);
               }
               _loc6_++;
            }
            _maxWidth = Math.max(_maxLeftTxtWidth + _loc5_,_maxWidth);
            sortList();
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

