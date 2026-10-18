package map.internals3D
{
   import com.pickgliss.toplevel.StageReferance;
   import com.speedEngine.game.Director;
   
   public class Stage3DManager
   {
      
      private static var _instance:Stage3DManager = null;
      
      private var _isInit:Boolean = false;
      
      private var _complete:Function;
      
      public function Stage3DManager()
      {
         super();
      }
      
      public static function get instance() : Stage3DManager
      {
         if(!_instance)
         {
            _instance = new Stage3DManager();
         }
         return _instance;
      }
      
      public function create(param1:Function) : void
      {
         _complete = param1;
         if(!_isInit)
         {
            Director.instance.frameInitComplete = _complete;
            Director.instance.init(StageReferance.stage);
            Director.instance.initLayer3D(["aad"]);
            Director.instance.initLayer2D(["aad2d"]);
            _isInit = true;
         }
         else
         {
            _complete();
         }
      }
   }
}

