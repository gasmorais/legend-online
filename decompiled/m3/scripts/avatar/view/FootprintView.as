package avatar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class FootprintView implements Disposeable
   {
      
      private var _avatar:Avatar;
      
      private var _footPrintLayer:Sprite;
      
      private var _type:int;
      
      private var _footPrints:Array = [];
      
      private var _footRect:Rectangle = new Rectangle(0,0,178,200);
      
      private var _lFootPrints1:Array = [];
      
      private var _lFootPrints2:Array = [];
      
      private var _lFootPrints3:Array = [];
      
      private var _lFootPrints4:Array = [];
      
      private var _lFootPrints5:Array = [];
      
      private var _rFootPrints1:Array = [];
      
      private var _rFootPrints2:Array = [];
      
      private var _rFootPrints3:Array = [];
      
      private var _rFootPrints4:Array = [];
      
      private var _rFootPrints5:Array = [];
      
      private var _clFootPrints:Array;
      
      private var _crFootPrints:Array;
      
      public function FootprintView(param1:Avatar)
      {
         super();
         _avatar = param1;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get footPrintLayer() : Sprite
      {
         return _footPrintLayer;
      }
      
      public function set footPrintLayer(param1:Sprite) : void
      {
         _footPrintLayer = param1;
      }
      
      public function createFoots() : void
      {
         createFootPrints(_lFootPrints1,"asset.map.FootFireAssetL1");
         createFootPrints(_lFootPrints2,"asset.map.FootFireAssetL2");
         createFootPrints(_lFootPrints3,"asset.map.FootFireAssetL3");
         createFootPrints(_lFootPrints4,"asset.map.FootFireAssetL4");
         createFootPrints(_lFootPrints5,"asset.map.FootFireAssetL5");
         createFootPrints(_rFootPrints1,"asset.map.FootFireAssetR1");
         createFootPrints(_rFootPrints2,"asset.map.FootFireAssetR2");
         createFootPrints(_rFootPrints3,"asset.map.FootFireAssetR3");
         createFootPrints(_rFootPrints4,"asset.map.FootFireAssetR4");
         createFootPrints(_rFootPrints5,"asset.map.FootFireAssetR5");
      }
      
      public function clearFoots() : void
      {
         clearFootPrints(_lFootPrints1);
         clearFootPrints(_lFootPrints2);
         clearFootPrints(_lFootPrints3);
         clearFootPrints(_lFootPrints4);
         clearFootPrints(_lFootPrints5);
         clearFootPrints(_rFootPrints1);
         clearFootPrints(_rFootPrints2);
         clearFootPrints(_rFootPrints3);
         clearFootPrints(_rFootPrints4);
         clearFootPrints(_rFootPrints5);
      }
      
      private function createFootPrints(param1:Array, param2:String) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc3_:int = 2;
         if(param1.length == 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject(param2);
               param1.push(_loc4_);
               _loc5_++;
            }
         }
      }
      
      private function clearFootPrints(param1:Array) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in param1)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         param1 = [];
      }
      
      private function resetFootPrints(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
               _loc2_.scaleX = 1;
               _loc2_.x = 0;
               _loc2_.y = 0;
               _loc2_.stop();
            }
         }
      }
      
      private function getIndex(param1:int, param2:Number) : int
      {
         var _loc3_:int = 1;
         switch(param1)
         {
            case 0:
               _loc3_ = 5;
               break;
            case 1:
               _loc3_ = 4;
               break;
            case 2:
               _loc3_ = 3;
               break;
            case 3:
               _loc3_ = 2;
               break;
            case 4:
               _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function drawFootPrints(param1:int, param2:int = 0) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(_type == 2)
         {
            return;
         }
         if(footPrintLayer && _avatar.parent && (param1 == 0 || param1 == 4))
         {
            _loc3_ = Number(_avatar.contentBitmap.scaleX);
            _loc5_ = getIndex(param2,_loc3_);
            if(this["_lFootPrints" + _loc5_] != _clFootPrints)
            {
               resetFootPrints(_clFootPrints);
            }
            if(this["_rFootPrints" + _loc5_] != _crFootPrints)
            {
               resetFootPrints(_crFootPrints);
            }
            _clFootPrints = this["_lFootPrints" + _loc5_];
            _crFootPrints = this["_rFootPrints" + _loc5_];
            _loc6_ = _clFootPrints.pop();
            _loc4_ = _crFootPrints.pop();
            if(_avatar.state == 4)
            {
               _loc6_.scaleX = _loc3_;
               _loc6_.x = _avatar.parent.x;
               _loc6_.y = _avatar.parent.y;
               _loc6_.gotoAndPlay(1);
               footPrintLayer.addChild(_loc6_);
               _loc4_.scaleX = _loc3_;
               _loc4_.x = _avatar.parent.x;
               _loc4_.y = _avatar.parent.y;
               _loc4_.gotoAndPlay(1);
               footPrintLayer.addChild(_loc4_);
            }
            else
            {
               if(_loc6_.parent)
               {
                  _loc6_.parent.removeChild(_loc6_);
                  _loc6_.scaleX = 1;
                  _loc6_.x = 0;
                  _loc6_.y = 0;
                  _loc6_.stop();
               }
               if(_loc4_.parent)
               {
                  _loc4_.parent.removeChild(_loc4_);
                  _loc4_.scaleX = 1;
                  _loc4_.x = 0;
                  _loc4_.y = 0;
                  _loc4_.stop();
               }
            }
            _clFootPrints.unshift(_loc6_);
            _crFootPrints.unshift(_loc4_);
         }
      }
      
      public function dispose() : void
      {
         clearFoots();
         _footPrintLayer = null;
         _footPrints = null;
         _avatar = null;
      }
   }
}

