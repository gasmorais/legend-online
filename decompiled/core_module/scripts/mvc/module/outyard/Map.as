package mvc.module.outyard
{
   import flash.utils.Dictionary;
   
   public class Map
   {
      
      public var dataDic:Dictionary = new Dictionary();
      
      public var landDic:Dictionary = new Dictionary();
      
      public var routeDic:Dictionary = new Dictionary();
      
      public function Map()
      {
         super();
         initData();
         initLand();
         initRoute();
      }
      
      private function initData() : void
      {
      }
      
      private function initLand() : void
      {
      }
      
      private function initRoute() : void
      {
         var _loc8_:RoutePoint = new RoutePoint();
         _loc8_.id = 1;
         var _loc9_:RoutePoint = new RoutePoint();
         _loc9_.id = 2;
         var _loc10_:RoutePoint = new RoutePoint();
         _loc10_.id = 3;
         var _loc4_:RoutePoint = new RoutePoint();
         _loc4_.id = 4;
         var _loc5_:RoutePoint = new RoutePoint();
         _loc5_.id = 5;
         var _loc6_:RoutePoint = new RoutePoint();
         _loc6_.id = 6;
         var _loc7_:RoutePoint = new RoutePoint();
         _loc7_.id = 7;
         var _loc2_:RoutePoint = new RoutePoint();
         _loc2_.id = 8;
         var _loc3_:RoutePoint = new RoutePoint();
         _loc3_.id = 9;
         var _loc1_:RoutePoint = new RoutePoint();
         _loc1_.id = 10;
         var _loc11_:RoutePoint = new RoutePoint();
         _loc11_.id = 11;
         routeDic[_loc8_.id] = _loc8_;
         routeDic[_loc9_.id] = _loc9_;
         routeDic[_loc10_.id] = _loc10_;
         routeDic[_loc4_.id] = _loc4_;
         routeDic[_loc5_.id] = _loc5_;
         routeDic[_loc6_.id] = _loc6_;
         routeDic[_loc7_.id] = _loc7_;
         routeDic[_loc2_.id] = _loc2_;
         routeDic[_loc3_.id] = _loc3_;
         routeDic[_loc1_.id] = _loc1_;
         routeDic[_loc11_.id] = _loc11_;
      }
   }
}

