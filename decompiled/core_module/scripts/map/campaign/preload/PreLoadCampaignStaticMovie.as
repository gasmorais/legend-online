package map.campaign.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.utils.Dictionary;
   
   public class PreLoadCampaignStaticMovie
   {
      
      private var _dict:Dictionary = new Dictionary(true);
      
      private var _total:int;
      
      private var _current:int;
      
      private var _callBack:Function;
      
      public function PreLoadCampaignStaticMovie()
      {
         super();
      }
      
      public function loadMoveByData(param1:Object, param2:Function) : void
      {
         var _loc5_:int = 0;
         _callBack = param2;
         var _loc4_:Boolean = true;
         for each(var _loc3_:Array in param1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _dict[_loc3_[_loc5_].url] = _loc3_[_loc5_].url;
               _loc5_++;
            }
         }
         for each(var _loc6_:String in _dict)
         {
            _total = _total + 1;
            _loc4_ = false;
         }
         for each(_loc6_ in _dict)
         {
            LoaderManagerII.instance.load(_loc6_,2,8,addNetMovieClip);
         }
         if(_loc4_)
         {
            _callBack(true,1,1);
            _callBack = null;
         }
      }
      
      private function addNetMovieClip(param1:LoaderInfo) : void
      {
         _current = _current + 1;
         if(_current == _total)
         {
            _callBack(true,_current,_total);
            _callBack = null;
         }
         else
         {
            _callBack(false,_current,_total);
         }
      }
   }
}

