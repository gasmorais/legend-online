package mvc.module.chess
{
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class SelfChessModel
   {
      
      public var playerNum:int;
      
      public var roomUuid:String;
      
      public var round:int;
      
      public var state:int;
      
      public var playerList:SimpleDictionary;
      
      public var classDefineDic:Dictionary;
      
      public var shapePool:Dictionary;
      
      private var _selfInfo:SelfChessPlayerInfo;
      
      private var _jobNumDic:Dictionary;
      
      public function SelfChessModel()
      {
         super();
         playerList = new SimpleDictionary();
         classDefineDic = new Dictionary(true);
         shapePool = new Dictionary(true);
         _jobNumDic = new Dictionary();
      }
      
      public function clear() : void
      {
         clearJobNumDic();
         playerList.clear();
         for(var _loc1_:String in shapePool)
         {
            shapePool[_loc1_] = null;
            delete shapePool[_loc1_];
         }
         _selfInfo = null;
         playerNum = 0;
      }
      
      public function get selfInfo() : SelfChessPlayerInfo
      {
         if(_selfInfo != null)
         {
            return _selfInfo;
         }
         var _loc1_:Array = playerList.getList();
         for each(var _loc2_:SelfChessPlayerInfo in _loc1_)
         {
            if(_loc2_.isSelf)
            {
               _selfInfo = _loc2_;
               break;
            }
         }
         return _selfInfo;
      }
      
      public function getShape(param1:int) : Shape
      {
         var _loc3_:Shape = null;
         var _loc2_:Array = shapePool[param1] as Array;
         if(!_loc2_)
         {
            _loc2_ = [];
            shapePool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_.pop();
         }
         return _loc3_;
      }
      
      public function saveShape(param1:int, param2:Shape) : void
      {
         if(!param2)
         {
            return;
         }
         if(param2.parent)
         {
            param2.parent.removeChild(param2);
         }
         var _loc3_:Array = shapePool[param1] as Array;
         if(!_loc3_)
         {
            _loc3_ = [];
            shapePool[param1] = _loc3_;
         }
         if(_loc3_.indexOf(param2) < 0)
         {
            _loc3_.push(param2);
         }
      }
      
      private function clearJobNumDic() : void
      {
         for(var _loc1_ in _jobNumDic)
         {
            delete _jobNumDic[_loc1_];
         }
      }
      
      public function resetSelfJobNum() : void
      {
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:SelfChessTempInfo = null;
         var _loc10_:Array = null;
         var _loc2_:String = null;
         var _loc11_:int = 0;
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         clearJobNumDic();
         if(_selfInfo != null)
         {
            _loc1_ = _selfInfo.battleAry;
            _loc4_ = int(_loc1_.length);
            _loc3_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc7_ = int(_loc1_[_loc8_]);
               if(_loc7_ != 0)
               {
                  _loc5_ = TempleteManager.instance.selfChessTempCate.getTempById(_loc7_);
                  if(_loc5_)
                  {
                     if(_loc3_.indexOf(_loc5_.MasterType) == -1)
                     {
                        _loc3_.push(_loc5_.MasterType);
                        _loc10_ = _loc5_.Job.split(",");
                        _loc6_ = int(_loc10_.length);
                        _loc9_ = 0;
                        while(_loc9_ < _loc6_)
                        {
                           _loc2_ = _loc10_[_loc9_];
                           _loc11_ = int(_jobNumDic[_loc2_]);
                           _loc11_++;
                           _jobNumDic[_loc2_] = _loc11_;
                           _loc9_++;
                        }
                     }
                  }
               }
               _loc8_++;
            }
         }
      }
      
      public function getJobNum(param1:int) : int
      {
         return int(_jobNumDic["" + param1]);
      }
      
      public function get selfJobNumDic() : Dictionary
      {
         return _jobNumDic;
      }
   }
}

