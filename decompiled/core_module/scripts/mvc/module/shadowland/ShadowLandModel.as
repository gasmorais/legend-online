package mvc.module.shadowland
{
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class ShadowLandModel
   {
      
      public var openMaxAreaId:int;
      
      public var tempAreaId:int;
      
      public var tempDiff:int;
      
      public var curNum:int = 200;
      
      public var boxDic:SimpleDictionary;
      
      public var areaInfoDic:SimpleDictionary;
      
      public var maxNum:int = 200;
      
      public var consume:int = 10;
      
      public function ShadowLandModel()
      {
         super();
         boxDic = new SimpleDictionary();
         areaInfoDic = new SimpleDictionary();
         refreshData();
      }
      
      public function getChapterInfoByAreaId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:ShadowLandChapterInfo in areaInfoDic.getList())
         {
            if(_loc3_.areaId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("difficulty",16);
         return _loc2_;
      }
      
      public function getChapterInfoByAreaIdDiff(param1:int, param2:int) : ShadowLandChapterInfo
      {
         for each(var _loc3_:ShadowLandChapterInfo in areaInfoDic.getList())
         {
            if(_loc3_.areaId == param1 && _loc3_.difficulty == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function set boxStates(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = param1.split(",");
         var _loc3_:Array = [];
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_].split("|");
            _loc5_ = _loc3_[0] + "_" + _loc3_[1];
            boxDic.add(_loc5_,_loc3_[2]);
            _loc4_++;
         }
      }
      
      public function getBoxStateByIDDiff(param1:int, param2:int) : int
      {
         var _loc4_:String = param1 + "_" + param2;
         var _loc3_:int = 0;
         if(boxDic[_loc4_])
         {
            _loc3_ = int(boxDic[_loc4_]);
         }
         return _loc3_;
      }
      
      public function refreshData() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("shadow_land_config");
         if(_loc3_)
         {
            _loc1_ = _loc3_.ConfigValue;
            _loc2_ = _loc1_.split(",");
            if(_loc2_.length >= 3)
            {
               maxNum = _loc2_[0];
               consume = _loc2_[2];
            }
         }
      }
   }
}

