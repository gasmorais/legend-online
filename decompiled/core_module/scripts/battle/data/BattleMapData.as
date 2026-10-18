package battle.data
{
   import battle.BattleManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.filters.BlurFilter;
   
   public class BattleMapData
   {
      
      private static var blurFilter:BlurFilter = new BlurFilter(20,0,3);
      
      private var swf:MovieClip;
      
      private var _bg_back_arr:Vector.<BattleBackGroundData>;
      
      private var _bg_front_arr:Vector.<BattleBackGroundData>;
      
      public function BattleMapData()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = null;
         var _loc3_:BattleBackGroundData = null;
         _bg_back_arr = new Vector.<BattleBackGroundData>();
         _bg_front_arr = new Vector.<BattleBackGroundData>();
         swf = BattleManager.getInstance().resourceModel.battleMap;
         var _loc4_:int = swf.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc1_ = MovieClip(swf.getChildAt(_loc2_));
            _loc3_ = new BattleBackGroundData();
            _loc3_.asset = _loc1_;
            _loc3_.moveCoefficient = _loc1_.moveCoefficient == undefined ? 1 : _loc1_.moveCoefficient;
            _loc3_.repeat = _loc1_.repeat == undefined ? true : _loc1_.repeat;
            _loc3_.moveSpeed = _loc1_.moveSpeed == undefined ? 0 : _loc1_.moveSpeed;
            _loc3_.transparent = _loc1_.transparent == undefined ? true : _loc1_.transparent;
            if(_loc1_.isFront)
            {
               _bg_front_arr.push(_loc3_);
            }
            else
            {
               _bg_back_arr.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function get bg_back_arr() : Vector.<BattleBackGroundData>
      {
         return _bg_back_arr;
      }
      
      public function get bg_front_arr() : Vector.<BattleBackGroundData>
      {
         return _bg_front_arr;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(swf);
         swf = null;
         if(_bg_back_arr)
         {
            _bg_back_arr.length = 0;
         }
         if(_bg_front_arr)
         {
            _bg_front_arr.length = 0;
         }
         _bg_back_arr = null;
         _bg_front_arr = null;
      }
   }
}

