package map.campaign.preload
{
   import flash.utils.Dictionary;
   import map.internals.library.MapElmsLibrary;
   
   public class PreLoadFloorData
   {
      
      private var _totalCount:int;
      
      private var _curCount:int;
      
      private var _result:Function;
      
      public function PreLoadFloorData(param1:Function)
      {
         super();
         _result = param1;
      }
      
      public function getMapFloorData(param1:Object, param2:int) : Dictionary
      {
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc11_:String = null;
         var _loc10_:Dictionary = new Dictionary(true);
         switch(param2 - 10001)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               _loc8_ = int(param1["row"]);
               _loc4_ = int(param1["column"]);
               _loc5_ = 0;
               while(_loc5_ <= _loc8_)
               {
                  _loc7_ = 0;
                  while(_loc7_ <= _loc4_)
                  {
                     _loc10_["mapmaterial/land/" + param2 + "/tile_" + _loc5_ + "_" + _loc7_ + ".jpg"] = 1;
                     _loc7_++;
                  }
                  _loc5_++;
               }
               break;
            default:
               _loc3_ = "mapmaterial/floor/grassland/a00.jpg";
               _loc11_ = "mapmaterial/floor/greeland/greenland_floor/at01.jpg";
               var _loc18_:int = 0;
               var _loc17_:Object = param1;
               while(§§hasnext(_loc17_,_loc18_))
               {
                  var _loc9_:Object = §§nextvalue(_loc18_,_loc17_);
                  for each(var _loc6_ in _loc9_)
                  {
                     for each(var _loc12_:Object in _loc6_)
                     {
                        if(_loc12_.url == _loc3_)
                        {
                           _loc12_.url = _loc11_;
                        }
                        _loc10_[_loc12_.url] = _loc12_;
                     }
                  }
               }
         }
         return _loc10_;
      }
      
      public function load(param1:Dictionary) : void
      {
         for(var _loc2_:String in param1)
         {
            _totalCount = _totalCount + 1;
         }
         for(_loc2_ in param1)
         {
            delete param1[_loc2_];
            MapElmsLibrary.instance.getElementSource(_loc2_,loadImageResult);
         }
         if(_totalCount == 0)
         {
            loadImageResult(null);
         }
         param1 = null;
      }
      
      private function loadImageResult(param1:Object) : void
      {
         _curCount = _curCount + 1;
         if(_curCount >= _totalCount)
         {
            if(_result != null)
            {
               _result(true,_curCount,_totalCount);
            }
            _result = null;
         }
         else if(_result != null)
         {
            _result(false,_curCount,_totalCount);
         }
      }
   }
}

