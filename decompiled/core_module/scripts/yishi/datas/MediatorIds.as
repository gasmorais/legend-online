package yishi.datas
{
   public class MediatorIds
   {
      
      private static var ids:int;
      
      public function MediatorIds()
      {
         super();
      }
      
      public static function get id() : int
      {
         return ids++;
      }
   }
}

