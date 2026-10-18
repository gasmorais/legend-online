package yishi.manager
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import yishi.datas.MediatorIds;
   import yishi.interfaces.IMediator;
   
   public class MediatorMananger
   {
      
      private static var _instance:MediatorMananger;
      
      private var _allMediators:Dictionary;
      
      public function MediatorMananger()
      {
         super();
         _allMediators = new Dictionary(true);
      }
      
      public static function get instance() : MediatorMananger
      {
         if(!_instance)
         {
            _instance = new MediatorMananger();
         }
         return _instance;
      }
      
      public function registerMediatorList(param1:Array, param2:Object, param3:String) : String
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            param1[_loc4_] = new param1[_loc4_]();
            (param1[_loc4_] as IMediator).register(param2);
            _loc4_++;
         }
         var _loc5_:String = param3 + MediatorIds.id;
         _allMediators[_loc5_] = param1;
         return _loc5_;
      }
      
      public function addRegisterMediator(param1:Class, param2:Object, param3:String) : void
      {
         removeRegisterMediator(param1,param2,param3);
         var _loc5_:IMediator = new param1() as IMediator;
         _loc5_.register(param2);
         var _loc4_:Array = _allMediators[param3];
         if(!_loc4_)
         {
            _loc4_ = [];
         }
         _loc4_.push(_loc5_);
         _allMediators[param3] = _loc4_;
      }
      
      public function removeRegisterMediator(param1:Class, param2:Object, param3:String) : void
      {
         var _loc6_:int = 0;
         var _loc5_:IMediator = null;
         var _loc4_:Array = _allMediators[param3];
         if(!_loc4_)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_] as IMediator;
            if(_loc5_ is param1)
            {
               _loc5_.unregister(param2);
               _loc4_.splice(_loc6_,1);
               break;
            }
            _loc6_++;
         }
      }
      
      public function unregisterMediatorList(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = _allMediators[param1];
         if(!_loc3_)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            (_loc3_[_loc4_] as IMediator).unregister(param2);
            _loc4_++;
         }
         delete _allMediators[param1];
      }
   }
}

