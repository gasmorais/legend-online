package managers
{
   import flash.utils.setTimeout;
   import mvc.module.secretary.acts.ILitteAction;
   import yishi.utils.MsgMan;
   
   public class LitteActionManager
   {
      
      private static var _ins:LitteActionManager;
      
      private static var _instance:LitteActionManager;
      
      private var _list:Array = [];
      
      private var _currAct:ILitteAction;
      
      public var isOpen:Boolean = false;
      
      public function LitteActionManager()
      {
         super();
      }
      
      public static function get Instance() : LitteActionManager
      {
         if(_instance == null)
         {
            _instance = new LitteActionManager();
         }
         return _instance;
      }
      
      public function get currAct() : ILitteAction
      {
         return _currAct;
      }
      
      public function set currAct(param1:ILitteAction) : void
      {
         _currAct = param1;
      }
      
      public function get list() : Array
      {
         return _list;
      }
      
      public function set list(param1:Array) : void
      {
         _list = param1;
      }
      
      public function addAction(param1:ILitteAction) : void
      {
         _list.push(param1);
      }
      
      public function exc() : void
      {
         if(_list.length <= 0)
         {
            if(_currAct)
            {
               if(_currAct.isFinish)
               {
                  _currAct.dispose();
                  _currAct = null;
               }
               else
               {
                  _currAct.exc();
               }
               return;
            }
            if(SecretaryManager.instance.isFinish && !_currAct)
            {
               setTimeout(function():void
               {
                  MsgMan.notifyObserver("LitteActionManager",true);
               },2000);
            }
            return;
         }
         if(!_currAct)
         {
            _currAct = _list.shift();
         }
         if(_currAct.isFinish)
         {
            _currAct.dispose();
            _currAct = null;
         }
         else
         {
            _currAct.exc();
         }
      }
      
      public function dipose() : void
      {
         if(_currAct)
         {
            _currAct.dispose();
            _currAct = null;
         }
         for each(var _loc1_:ILitteAction in _list)
         {
            _loc1_.dispose();
         }
         _list.length = 0;
      }
   }
}

