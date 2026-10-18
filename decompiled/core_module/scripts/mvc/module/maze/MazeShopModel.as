package mvc.module.maze
{
   public class MazeShopModel
   {
      
      private static var _instance:MazeShopModel;
      
      public function MazeShopModel()
      {
         super();
      }
      
      public static function getInstance() : MazeShopModel
      {
         if(!_instance)
         {
            _instance = new MazeShopModel();
         }
         return _instance;
      }
   }
}

