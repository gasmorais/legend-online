package spacetime.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class SpaceTimeFloorItem extends Sprite
   {
      
      private var _back:DisplayObject;
      
      private var _floorTitle:ScaleFrameImage;
      
      private var _hbox:HBox;
      
      private var _list:Vector.<SpacetimeFtBox> = new Vector.<SpacetimeFtBox>();
      
      private var _floor:int;
      
      private var _configList:Array;
      
      private var _countConfigList:Array;
      
      public function SpaceTimeFloorItem(param1:int)
      {
         super();
         _floor = param1;
         initView();
         mouseEnabled = mouseChildren = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.spacetimefault.floorBack");
         _floorTitle = ComponentFactory.Instance.creatComponentByStylename("xmlui.spacetimefault.fla.floorIdx");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.itemHbox");
         addChild(_back);
         addChild(_floorTitle);
         addChild(_hbox);
         _floorTitle.setFrame(_floor + 1);
      }
      
      public function setInitConfigBox(param1:String, param2:String) : void
      {
         var _loc3_:SpacetimeFtBox = null;
         var _loc5_:int = 0;
         if(param1 == null || param1 == "")
         {
            return;
         }
         _configList = param1.split(",");
         _countConfigList = param2.split(",");
         var _loc4_:int = int(_configList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new SpacetimeFtBox();
            _list[_loc5_] = _loc3_;
            _loc5_++;
         }
         _hbox.beginChanges();
         _loc5_ = _loc4_ - 1;
         while(_loc5_ >= 0)
         {
            _loc3_ = _list[_loc5_];
            _hbox.addChild(_loc3_);
            _loc5_--;
         }
         _hbox.commitChanges();
      }
      
      public function refreshBoxData(param1:int) : void
      {
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc3_:SpacetimeFtBox = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = int(_configList.length);
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:Number = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc10_ = _configList[_loc8_];
            _loc11_ = _loc10_.split(":");
            _loc3_ = _list[_loc8_];
            _loc6_ = int(_loc11_[1]);
            _loc9_ = int(_loc11_[0]);
            if(param1 <= _loc6_)
            {
               _loc7_ = (param1 - _loc2_) / (_loc6_ - _loc2_);
               if(_loc7_ <= 0.25)
               {
                  _loc5_ = 4;
               }
               else if(_loc7_ <= 0.5)
               {
                  _loc5_ = 3;
               }
               else if(_loc7_ <= 0.75)
               {
                  _loc5_ = 2;
               }
               else if(_loc7_ <= 1)
               {
                  _loc5_ = 1;
               }
            }
            else
            {
               _loc5_ = 0;
            }
            _loc2_ = _loc6_;
            _loc3_.count = _countConfigList[_loc8_];
            _loc3_.star = _loc5_;
            _loc3_.boxType = _loc9_;
            _loc8_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_floorTitle);
         _floorTitle = null;
         for each(var _loc1_:SpacetimeFtBox in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

